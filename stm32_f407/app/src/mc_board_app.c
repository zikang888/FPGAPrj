#include "mc_board_app.h"

#include "main.h"
#include "mc_protocol_runner.h"
#include "mc_stm32f407_hal_port.h"
#include "mc_faults.h"
#include "mc_oled.h"
#include "mc_cli_rx.h"
#include "mc_can_session_hal.h"
#include "mc_can_raw_hal.h"
#include "mc_can_live_hal.h"
#include "mc_build_profile.h"
#include "mc_button.h"
#include "mc_ui_menu.h"
#include "mc_mixed.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern CAN_HandleTypeDef hcan1;
extern I2C_HandleTypeDef hi2c1;
extern SPI_HandleTypeDef hspi1;
extern UART_HandleTypeDef huart1;
extern UART_HandleTypeDef huart3;

#define MC_COMMAND_CAPACITY 64U
#define MC_DEFAULT_ITERATIONS 1U
#define MC_MAX_ITERATIONS 10000U

static mc_stm32f407_context_t g_port_context;
static mc_runner_t g_runner;
static char g_command[MC_COMMAND_CAPACITY];
static size_t g_command_length;
static mc_cli_rx_t g_console_rx;
static uint8_t g_rx_byte;
static volatile uint32_t g_uart_rx_errors;
static uint32_t g_last_dropped;
static int g_discard_line;
static uint8_t g_jedec_id[3];
static int g_jedec_id_valid;
static mc_button_t g_button;
static mc_fault_id_t g_selected_fault;
static int g_last_fault_result = MC_ERR_UNSUPPORTED;
static int g_has_fault_result;
static uint32_t g_fault_runs;
static mc_ui_menu_t g_menu;
static uint32_t g_normal_runs;
static int g_menu_running;
static int g_normal_can_from_menu;
static mc_can_session_t g_can_session;
static mc_can_session_hal_t g_can_hal;
static mc_can_session_t g_raw_session;
static mc_can_raw_hal_t g_raw_hal;
static mc_can_session_t g_live_session;
static mc_can_live_hal_t g_live_hal;
static int g_can_backend; /* 0=bxCAN, 1=RAW, 2=LIVE */
static int g_raw_from_menu;
static int g_live_from_menu;
static int g_can_view;
static uint32_t g_can_display_ms;
static mc_mixed_t g_mixed;
static int g_mix_view;
static uint32_t g_mix_display_ms;
static int g_fault_options;
static unsigned int g_fault_option;
static uint32_t g_mix_first_txn;
static void display_fault_options(void);
static void display_mixed(void);
static void print_can_status(void);
static void run_command(const char *command);

static mc_can_mode_t fault_raw_mode(mc_fault_id_t id)
{
#if MC_BUILD_CAN_LIVE
    if (id == MC_FAULT_CAN_BIT) { return MC_CAN_LIVE_BIT; }
    if (id == MC_FAULT_CAN_BUS_OFF) { return MC_CAN_LIVE_BUSOFF; }
#endif
#if MC_BUILD_CAN_RAW_GPIO
    if (id == MC_FAULT_CAN_STUFF) { return MC_CAN_RAW_STUFF; }
    if (id == MC_FAULT_CAN_CRC) { return MC_CAN_RAW_CRC; }
    if (id == MC_FAULT_CAN_FORM) { return MC_CAN_RAW_FORM; }
#else
    (void)id;
#endif
    return MC_CAN_NORMAL;
}

static mc_can_session_t *visible_can(void)
{
    return g_can_backend == 2 ? &g_live_session : (g_can_backend == 1 ? &g_raw_session : &g_can_session);
}

static const char *can_state_name(const mc_can_session_t *session)
{
    static const char *const names[] = {"IDLE", "RUNNING", "DONE", "STOPPED", "ERROR"};
    return names[(unsigned int)session->state];
}

static void display_can_session(void)
{
    char line[24];
    const mc_can_session_t *session = visible_can();
    mc_oled_clear();
    mc_oled_text(0U, 0U, g_can_backend == 2 ? "CAN LIVE PA2" : (g_can_backend == 1 ? "CAN RAW PD1" : "CAN SESSION"));
    mc_oled_text(0U, 1U, can_state_name(session));
    (void)snprintf(line, sizeof(line), "RUN %lu REQ %lu",
                   (unsigned long)session->run, (unsigned long)session->submitted);
    mc_oled_text(0U, 2U, line);
    (void)snprintf(line, sizeof(line), "DONE %lu/%lu", (unsigned long)session->completed,
                   (unsigned long)session->config.count);
    mc_oled_text(0U, 3U, line);
    (void)snprintf(line, sizeof(line), "PASS %lu FAIL %lu", (unsigned long)session->passed,
                   (unsigned long)session->failed);
    mc_oled_text(0U, 4U, line);
    (void)snprintf(line, sizeof(line), "SLOTS %lu R %d",
                   (unsigned long)session->fault_slots, session->last_result);
    mc_oled_text(0U, 5U, line);
    mc_oled_text(0U, 6U, session->held && session->state != MC_CAN_RUNNING ?
                 "RESTORE FAILED" : (g_can_backend == 2 && g_live_hal.stats.busoff_seen ?
                 (g_live_hal.stats.recovered ? "BOFF SEEN RECOVERED" : "BOFF SEEN") : "PL NOT CONNECTED"));
    mc_oled_text(0U, 7U, session->state == MC_CAN_RUNNING ? "HOLD STOP" :
                 (session->held ? "HOLD RETRY RESTORE" : "TAP BACK"));
    mc_oled_flush();
}

static void console_write(const char *text)
{
    if (text != NULL) {
        (void)HAL_UART_Transmit(&huart1,
                                (uint8_t *)(uintptr_t)text,
                                (uint16_t)strlen(text),
                                1000U);
    }
}

static void print_help(void)
{
    console_write(
        "\r\nCommands:\r\n"
        "  spi jedec [count]    Read W25Q128 JEDEC ID\r\n"
        "  spi probe            Read mounted Flash ID again\r\n"
        "  spi pattern [count]  Send deterministic SPI bytes\r\n"
        "  uart loop [count]    USART3 FPGA echo test\r\n"
        "  i2c eeprom [count]   AT24C256 write/read test at 0x50\r\n"
        "  can loop [count]     CAN1 frame echo test, ID 0x321\r\n"
        "  all                  Run one smoke test per protocol\r\n"
        "  fault list           List selectable fault cases\r\n"
        "  fault select N       Select case index N (0..19)\r\n"
        "  fault run [N]        Trigger selected/indexed case\r\n"
        "  mix start N TOTAL GAP normal|once|every|random VALUE [SEED]\r\n"
        "    N: visible fault index, TOTAL<=10000, GAP=100..60000ms\r\n"
        "    normal VALUE=0; once=position; every=interval; random=count\r\n"
        "  mix status|stop|recover\r\n"
        "  can test start MODE COUNT PERIOD [EVERY]\r\n"
        "    MODE: normal/echo/noack/bitrate, period >=50ms\r\n"
        "    noack/bitrate require MC_ENABLE_CAN_FAULTS\r\n"
        "  can test status|stop|recover\r\n"
        "  can raw start MODE BITRATE COUNT PERIOD [EVERY]\r\n"
        "    MODE: valid/crc/stuff/form; BITRATE: 125000/500000\r\n"
        "    RAW requires CAN_FAULTS + CAN_RAW_GPIO; uses PD1\r\n"
        "  can raw status|stop|recover\r\n"
        "  can live start disturb|bit|busoff COUNT PERIOD [EVERY]\r\n"
        "    LIVE: PD1->PA1 jumper; PA2->separate transceiver TXD\r\n"
        "  can live status|stop|recover\r\n"
        "  help                 Show this help\r\n"
        "USER_KEY: short=next, hold 0.8s=enter/run/back; CAN hold=stop.\r\n> ");
}

static void display_fault_menu(void)
{
    char line[24];
    unsigned int base = (g_menu.item / 4U) * 4U;
    unsigned int i;
    mc_ui_entry_t entry = mc_ui_menu_entry(g_menu.protocol, g_menu.item);
    const mc_fault_info_t *selected = entry.action == MC_UI_FAULT ? mc_fault_get(entry.fault) : NULL;
    if (g_fault_options) { display_fault_options(); return; }
    mc_oled_clear();
    if (!g_menu.in_submenu) {
        mc_oled_text(0U, 0U, "PROTOCOL SELECT");
        for (i = 0U; i < MC_UI_PROTOCOL_COUNT; ++i) {
            (void)snprintf(line, sizeof(line), "%c %s", i == (unsigned int)g_menu.protocol ? '>' : ' ',
                           mc_ui_protocol_name((mc_ui_protocol_t)i));
            mc_oled_text(0U, (uint8_t)(i + 1U), line);
        }
        mc_oled_text(0U, 5U, "TAP NEXT HOLD ENTER");
        mc_oled_text(0U, 6U, "MENU DOES NOT SEND");
        mc_oled_text(0U, 7U, "SELECT A PROTOCOL");
        mc_oled_flush();
        return;
    }
    (void)snprintf(line, sizeof(line), "%s NORMAL / FAULT", mc_ui_protocol_name(g_menu.protocol));
    mc_oled_text(0U, 0U, line);
    for (i = 0U; i < 4U; ++i) {
        mc_ui_entry_t item = mc_ui_menu_entry(g_menu.protocol, base + i);
        if (item.action != MC_UI_NAVIGATE) {
            (void)snprintf(line, sizeof(line), "%c%s",
                           base + i == g_menu.item ? '>' : ' ', item.label);
            mc_oled_text(0U, (uint8_t)(i + 1U), line);
        }
    }
    (void)snprintf(line, sizeof(line), "NORMAL %lu FAULT %lu", (unsigned long)g_normal_runs,
                   (unsigned long)g_fault_runs);
    mc_oled_text(0U, 5U, line);
    if (g_menu_running) {
        strcpy(line, "RUNNING PLEASE WAIT");
    } else if (g_has_fault_result) {
        if (g_last_fault_result == MC_ERR_UNSUPPORTED) {
            strcpy(line, "DISABLED/NEEDS HW");
        } else {
        (void)snprintf(line, sizeof(line), "%s R %d",
                       g_last_fault_result == MC_OK ? "LOCAL OK" : "LOCAL ERROR", g_last_fault_result);
        }
    } else if (selected != NULL) {
        if (fault_raw_mode(entry.fault) >= MC_CAN_RAW_VALID) {
            strcpy(line, fault_raw_mode(entry.fault) >= MC_CAN_LIVE_DISTURB ? "LIVE READY PA1/2" : "RAW READY PD1");
        } else { switch (selected->requirement) {
        case MC_FAULT_LOCAL: strcpy(line, "READY"); break;
        case MC_FAULT_NEEDS_WIRING: strcpy(line, "NEEDS LINK"); break;
        case MC_FAULT_NEEDS_PEER: strcpy(line, "NEEDS PEER"); break;
        case MC_FAULT_EXTERNAL_ONLY: strcpy(line, "EXTERNAL ONLY"); break;
        default: strcpy(line, "NOT BASELINE"); break;
        } }
    } else {
        strcpy(line, entry.action == MC_UI_BACK ? "HOLD RETURN" : "HOLD RUN ONCE");
    }
    mc_oled_text(0U, 6U, line);
    if (selected != NULL) {
        (void)snprintf(line, sizeof(line), "CASE %lu", (unsigned long)selected->case_id);
        mc_oled_text(0U, 7U, line);
    } else {
        mc_oled_text(0U, 7U, entry.action == MC_UI_BACK ? "NO OUTPUT" : "LOCAL TEST NOT PL");
    }
    mc_oled_flush();
}

static void print_fault_list(void)
{
    unsigned int i;
    char line[100];
    for (i = 0U; i < (unsigned int)MC_FAULT_COUNT; ++i) {
        const mc_fault_info_t *item = mc_fault_get((mc_fault_id_t)i);
        (void)snprintf(line, sizeof(line), "%2u case=%lu %-20s requirement=%d backend=%s\r\n",
                       i, (unsigned long)item->case_id, item->label, item->requirement,
                       fault_raw_mode((mc_fault_id_t)i) >= MC_CAN_LIVE_DISTURB ? "live_pa2" :
                       (fault_raw_mode((mc_fault_id_t)i) >= MC_CAN_RAW_VALID ? "raw_pd1" : "legacy"));
        console_write(line);
    }
    console_write("> ");
}

static void trigger_selected_fault(void)
{
    const mc_fault_info_t *item = mc_fault_get(g_selected_fault);
    char line[110];
    if (item == NULL) {
        return;
    }
    if (g_mixed.held || g_can_session.held || g_raw_session.held || g_live_session.held) {
        console_write("CAN session owns peripherals; stop/recover first\r\n> ");
        return;
    }
    ++g_fault_runs;
    (void)snprintf(line, sizeof(line), "\r\nFAULT run=%lu case=%lu %s\r\n",
                   (unsigned long)g_fault_runs, (unsigned long)item->case_id, item->label);
    console_write(line);
    if (fault_raw_mode(g_selected_fault) >= MC_CAN_RAW_VALID) {
        mc_can_config_t config;
        memset(&config, 0, sizeof(config));
        config.mode = fault_raw_mode(g_selected_fault); config.bitrate = 500000U;
        config.count = 1U; config.period_ms = 100U;
        config.timeout_ms = 20U; config.every = 1U;
        if (config.mode >= MC_CAN_LIVE_DISTURB) {
            config.timeout_ms=40U;
            if (config.mode==MC_CAN_LIVE_BUSOFF) { config.count=64U; }
            g_last_fault_result=mc_can_session_start(&g_live_session,&config);
            g_live_from_menu=1; g_can_backend=2;
        } else {
            g_last_fault_result=mc_can_session_start(&g_raw_session,&config);
            g_raw_from_menu=1; g_can_backend=1;
        }
        g_has_fault_result = 1;
        g_can_view = 1;
        console_write("CAN menu uses isolated backend; see CAN state, not PL detection\r\n");
        print_can_status();
        display_can_session();
        return;
    }
    g_last_fault_result = mc_fault_run(&g_runner, g_selected_fault);
    g_has_fault_result = 1;
    (void)snprintf(line, sizeof(line), "FAULT result=%d\r\n> ", g_last_fault_result);
    console_write(line);
    HAL_GPIO_WritePin(USER_LED_GPIO_Port, USER_LED_Pin,
                      g_last_fault_result == MC_OK ? GPIO_PIN_SET : GPIO_PIN_RESET);
    display_fault_menu();
}

static void select_fault(unsigned int index)
{
    if (index >= (unsigned int)MC_FAULT_COUNT) {
        console_write("Invalid fault index\r\n> ");
        return;
    }
    g_selected_fault = (mc_fault_id_t)index;
    (void)mc_ui_menu_select_fault(&g_menu, g_selected_fault);
    g_has_fault_result = 0;
    display_fault_menu();
}

static uint32_t parse_count(const char *command)
{
    const char *cursor = strrchr(command, ' ');
    unsigned long value;

    if (cursor == NULL || cursor[1] == '\0') {
        return MC_DEFAULT_ITERATIONS;
    }
    value = strtoul(cursor + 1, NULL, 10);
    if (value == 0UL || value > MC_MAX_ITERATIONS) {
        return MC_DEFAULT_ITERATIONS;
    }
    return (uint32_t)value;
}

static void print_summary(const char *name, int result, const mc_run_summary_t *summary)
{
    char line[160];

    if (summary == NULL) {
        return;
    }
    (void)snprintf(line,
                   sizeof(line),
                   "SUMMARY protocol=%s result=%d iterations=%lu passed=%lu failed=%lu\r\n> ",
                   name,
                   result,
                   (unsigned long)summary->iterations,
                   (unsigned long)summary->passed,
                   (unsigned long)summary->failed);
    console_write(line);
    if (g_menu_running) {
        g_last_fault_result = result;
        g_has_fault_result = 1;
    }
    HAL_GPIO_WritePin(USER_LED_GPIO_Port,
                      USER_LED_Pin,
                      result == MC_OK ? GPIO_PIN_SET : GPIO_PIN_RESET);
}

static int probe_jedec_id(void)
{
    uint32_t attempt;
    int result = MC_ERR_VERIFY;
    char line[96];
    g_jedec_id_valid = 0;
    for (attempt = 0U; attempt < 3U; ++attempt) {
        result = mc_probe_spi_jedec(&g_runner, 1000U, g_jedec_id);
        if (result == MC_OK) {
            g_jedec_id_valid = 1;
            (void)snprintf(line, sizeof(line),
                           "Mounted JEDEC ID=%02X %02X %02X\r\n> ",
                           g_jedec_id[0], g_jedec_id[1], g_jedec_id[2]);
            console_write(line);
            return MC_OK;
        }
        HAL_Delay(5U);
    }
    (void)snprintf(line, sizeof(line), "JEDEC probe failed after 3 tries, result=%d\r\n> ", result);
    console_write(line);
    HAL_GPIO_WritePin(USER_LED_GPIO_Port, USER_LED_Pin, GPIO_PIN_RESET);
    return result;
}

static void run_spi_jedec(uint32_t iterations)
{
    mc_run_summary_t summary;
    int result;
    if (!g_jedec_id_valid) {
        result = probe_jedec_id();
        if (result != MC_OK) {
            if (g_menu_running) {
                g_last_fault_result = result;
                g_has_fault_result = 1;
            }
            return;
        }
    }
    result = mc_run_spi_jedec(&g_runner, 1001U, iterations, g_jedec_id, &summary);
    print_summary("SPI_JEDEC", result, &summary);
}

static void print_can_status(void)
{
    char line[230];
    const mc_can_session_t *session = visible_can();
    (void)snprintf(line, sizeof(line),
        "%s state=%s run=%lu submitted=%lu completed=%lu pass=%lu fail=%lu "
        "slots=%lu last=%d restore=%d held=%u\r\n> ", g_can_backend == 2 ? "CAN_LIVE" : (g_can_backend == 1 ? "CAN_RAW" : "CAN_SESSION"),
        can_state_name(session), (unsigned long)session->run, (unsigned long)session->submitted,
        (unsigned long)session->completed, (unsigned long)session->passed,
        (unsigned long)session->failed, (unsigned long)session->fault_slots,
        session->last_result, session->restore_result, (unsigned int)session->held);
    console_write(line);
    if (g_can_backend==2) {
        (void)snprintf(line,sizeof(line),"LIVE pulses=%lu bit_errors=%lu BOFF=%u recovered=%u ESR_before=%lu ESR_after=%lu restore=%d\r\n> ",
            (unsigned long)g_live_hal.stats.pulses,(unsigned long)g_live_hal.stats.bit_errors,
            (unsigned int)g_live_hal.stats.busoff_seen,(unsigned int)g_live_hal.stats.recovered,
            (unsigned long)g_live_hal.stats.esr_before_recovery,(unsigned long)g_live_hal.stats.esr_after_recovery,
            g_live_hal.stats.restore_result);
        console_write(line);
    }
}

static void run_can_command(const char *command, int backend)
{
    mc_can_config_t config;
    mc_can_session_t *session = backend==2 ? &g_live_session : (backend==1 ? &g_raw_session : &g_can_session);
    const char *args = command + (backend==1 ? 7U : 8U);
    int result = MC_OK;
    if ((backend!=0 && g_can_session.held) || (backend!=1 && g_raw_session.held) ||
        (backend!=2 && g_live_session.held)) {
        console_write("Other CAN backend owns resources; stop/recover it first\r\n> ");
        return;
    }
    if (strcmp(args, " status") == 0) {
        /* read-only */
    } else if (strcmp(args, " stop") == 0) {
        result = mc_can_session_stop(session);
    } else if (strcmp(args, " recover") == 0) {
        result = mc_can_session_recover(session);
    } else if (strncmp(args, " start ", 7U) == 0) {
        result = backend==2 ? mc_can_live_parse(args+7,&config) :
                 (backend==1 ? mc_can_raw_parse(args+7,&config) : mc_can_session_parse(args+7,&config));
        if (result == MC_OK) { result = mc_can_session_start(session, &config); }
    } else {
        result = MC_ERR_ARGUMENT;
    }
    if (result != MC_OK) {
        char line[64];
        (void)snprintf(line, sizeof(line), "CAN command result=%d\r\n", result);
        console_write(line);
    }
    g_can_view = 1;
    g_can_backend = backend;
    print_can_status();
    display_can_session();
    g_can_display_ms = HAL_GetTick();
}

static const char *mix_state_name(void)
{
    static const char *const names[] = {"IDLE", "RUNNING", "DONE", "STOPPED", "ERROR"};
    return names[(unsigned int)g_mixed.state];
}

static void display_fault_options(void)
{
    static const char *const labels[] = {
        "SINGLE", "ONE IN 100", "ONE IN 1000", "EVERY 100",
        "RANDOM 5 SEED 1", "NORMAL 1000", "BACK"
    };
    unsigned int i, base = (g_fault_option / 4U) * 4U;
    char line[24];
    mc_oled_clear();
    mc_oled_text(0U, 0U, mc_fault_get(g_selected_fault)->label);
    for (i = 0U; i < 4U && base + i < 7U; ++i) {
        (void)snprintf(line, sizeof(line), "%c%s", base + i == g_fault_option ? '>' : ' ', labels[base+i]);
        mc_oled_text(0U, (uint8_t)(i+1U), line);
    }
    mc_oled_text(0U, 5U, "TAP NEXT HOLD RUN");
    (void)snprintf(line, sizeof(line), "LAST R %d", g_last_fault_result);
    mc_oled_text(0U, 6U, g_has_fault_result ? line : "MIX GAP 100MS");
    mc_oled_text(0U, 7U, "LOCAL ONLY NOT PL");
    mc_oled_flush();
}

static void display_mixed(void)
{
    char line[24];
    mc_oled_clear();
    (void)snprintf(line, sizeof(line), "%s MIX %s", mc_fault_get(g_mixed.config.fault)->protocol, mix_state_name());
    mc_oled_text(0U, 0U, line);
    (void)snprintf(line, sizeof(line), "DONE %lu/%lu", (unsigned long)g_mixed.completed, (unsigned long)g_mixed.config.total);
    mc_oled_text(0U, 1U, line);
    (void)snprintf(line, sizeof(line), "INJ TRY %lu/%lu", (unsigned long)g_mixed.fault_attempts, (unsigned long)g_mixed.planned_faults);
    mc_oled_text(0U, 2U, line);
    (void)snprintf(line, sizeof(line), "LOCAL FOK %lu BAD %lu", (unsigned long)g_mixed.fault_ok, (unsigned long)g_mixed.failed);
    mc_oled_text(0U, 3U, line);
    (void)snprintf(line, sizeof(line), "IDX %lu %s", (unsigned long)g_mixed.index, g_mixed.is_fault ? "FAULT" : "NORMAL");
    mc_oled_text(0U, 4U, line);
    (void)snprintf(line, sizeof(line), "RUN %lu R %d", (unsigned long)g_mixed.run, g_mixed.last_result);
    mc_oled_text(0U, 5U, line);
    mc_oled_text(0U, 6U, g_mixed.held && g_mixed.state != MC_MIX_RUNNING ? "RESTORE FAILED" : "PHYSICAL/PL UNVERIFIED");
    mc_oled_text(0U, 7U, g_mixed.state == MC_MIX_RUNNING ? "HOLD STOP" :
                 (g_mixed.held ? "HOLD RETRY RESTORE" : "TAP BACK"));
    mc_oled_flush();
}

static uint32_t mixed_now(void *context) { (void)context; return HAL_GetTick(); }

static int mixed_record(void *context, const mc_mixed_t *s, const char *phase)
{
    /* Foreground only: static storage avoids growing the small MCU stack. */
    static char line[768];
    int length;
    const mc_fault_info_t *fault = mc_fault_get(s->config.fault);
    (void)context;
    if (strcmp(phase, "slot_begin") == 0) { g_mix_first_txn = g_runner.next_transaction_id; }
    length = snprintf(line, sizeof(line),
        "{\"kind\":\"mixed\",\"phase\":\"%s\",\"run\":%lu,\"index\":%lu,\"total\":%lu,"
        "\"protocol\":\"%s\",\"fault_index\":%u,\"fault_case\":%lu,\"mode\":%u,\"value\":%lu,\"seed\":%lu,\"gap_ms\":%lu,"
        "\"planned\":%lu,\"fault_slot\":%u,\"attempts\":%lu,\"fault_ok\":%lu,\"normal_ok\":%lu,\"failed\":%lu,\"cancelled\":%lu,\"state\":%u,\"held\":%u,"
        "\"result\":%d,\"restore\":%d,\"dispatch_ms\":%lu,\"started_ms\":%lu,\"ended_ms\":%lu,\"logged_ms\":%lu,"
        "\"runner_first_txn\":%lu,\"runner_next_txn\":%lu,\"can_child_run\":%lu,\"can_backend\":%d,"
        "\"physical_verified\":false,\"pl_verified\":false}\r\n",
        phase, (unsigned long)s->run, (unsigned long)s->index, (unsigned long)s->config.total,
        fault->protocol, (unsigned int)s->config.fault, (unsigned long)fault->case_id, (unsigned int)s->config.mode,
        (unsigned long)s->config.value, (unsigned long)s->config.seed, (unsigned long)s->config.gap_ms,
        (unsigned long)s->planned_faults, (unsigned int)s->is_fault, (unsigned long)s->fault_attempts,
        (unsigned long)s->fault_ok, (unsigned long)s->normal_ok, (unsigned long)s->failed, (unsigned long)s->cancelled,
        (unsigned int)s->state, (unsigned int)s->held,
        s->last_result, s->restore_result, (unsigned long)s->dispatch_ms, (unsigned long)s->started_ms, (unsigned long)s->ended_ms, (unsigned long)HAL_GetTick(),
        (unsigned long)g_mix_first_txn, (unsigned long)g_runner.next_transaction_id,
        (unsigned long)(s->config.fault >= MC_FAULT_CAN_NO_ACK ? visible_can()->run : 0U), g_can_backend);
    if (length < 0 || (size_t)length >= sizeof(line) || g_runner.platform.write_log == NULL) { return MC_ERR_IO; }
    return g_runner.platform.write_log(g_runner.platform.context, line, (size_t)length);
}

static int mixed_io(const mc_mixed_t *s, const char *operation, const uint8_t *data, size_t count, int result)
{
    char hex[33], line[240];
    static const char digits[] = "0123456789ABCDEF";
    size_t i;
    int length, logged;
    for (i = 0U; i < count; ++i) { hex[i*2U] = digits[data[i] >> 4]; hex[i*2U+1U] = digits[data[i] & 15U]; }
    hex[count*2U] = '\0';
    length = snprintf(line, sizeof(line),
        "{\"kind\":\"mixed_io\",\"run\":%lu,\"index\":%lu,\"operation\":\"%s\",\"data\":\"%s\",\"result\":%d}\r\n",
        (unsigned long)s->run, (unsigned long)s->index, operation, hex, result);
    if (length < 0 || (size_t)length >= sizeof(line) || g_runner.platform.write_log == NULL) { return MC_ERR_IO; }
    logged = g_runner.platform.write_log(g_runner.platform.context, line, (size_t)length);
    return result == MC_OK ? logged : result;
}

static int mixed_cancel(void *context)
{
    mc_can_session_t *sessions[] = {&g_can_session, &g_raw_session, &g_live_session};
    unsigned int i;
    int result = MC_OK;
    (void)context;
    for (i = 0U; i < 3U; ++i) {
        int restored = MC_OK;
        if (sessions[i]->state == MC_CAN_RUNNING) { restored = mc_can_session_stop(sessions[i]); }
        else if (sessions[i]->held) { restored = mc_can_session_recover(sessions[i]); }
        if (restored != MC_OK || sessions[i]->held) { result = restored != MC_OK ? restored : MC_ERR_BUSY; }
    }
    return result;
}

static int mixed_start_slot(void *context, const mc_mixed_t *s)
{
    mc_run_summary_t summary;
    mc_platform_t *p = &g_runner.platform;
    uint8_t data[16] = {0U};
    unsigned int i;
    int result;
    (void)context;
    if (s->config.fault >= MC_FAULT_CAN_NO_ACK) {
        mc_can_config_t config;
        mc_can_session_t *child = s->is_fault ? &g_raw_session : &g_can_session;
        memset(&config, 0, sizeof(config));
        config.mode = s->is_fault ? fault_raw_mode(s->config.fault) : MC_CAN_NORMAL;
        config.count = 1U; config.period_ms = 100U; config.timeout_ms = 40U;
        config.bitrate = 500000U; config.every = 1U;
        g_can_backend = s->is_fault ? 1 : 0;
        result = mc_can_session_start(child, &config);
        return result == MC_OK ? MC_MIX_PENDING : result;
    }
    if (s->is_fault) { return mc_fault_run(&g_runner, s->config.fault); }
    if (s->config.fault <= MC_FAULT_SPI_EXTRA) {
        return mc_run_spi_jedec(&g_runner, 1001U, 1U, g_jedec_id, &summary);
    }
    if (s->config.fault <= MC_FAULT_UART_BREAK) {
        if (p->uart_write == NULL) { return MC_ERR_UNSUPPORTED; }
        result = p->sync_pulse == NULL ? MC_OK : p->sync_pulse(p->context, 2001U);
        for (i = 0U; i < 8U; ++i) { data[i] = (uint8_t)i; }
        if (result == MC_OK) { result = p->uart_write(p->context, data, 8U, 100U); }
        return mixed_io(s, "UART_TX", data, 8U, result);
    }
    if (p->i2c_mem_read == NULL) { return MC_ERR_UNSUPPORTED; }
    result = p->sync_pulse == NULL ? MC_OK : p->sync_pulse(p->context, 3001U);
    if (result == MC_OK) { result = p->i2c_mem_read(p->context, 0x50U, 0x0100U, data, 16U, 100U); }
    return mixed_io(s, "I2C_READ_0100", data, 16U, result);
}

static int mixed_poll_slot(void *context)
{
    mc_can_session_t *child = visible_can();
    (void)context;
    mc_can_session_tick(child, HAL_GetTick());
    if (child->state == MC_CAN_RUNNING) { return MC_MIX_PENDING; }
    if (child->held) { return child->restore_result != MC_OK ? child->restore_result : MC_ERR_BUSY; }
    return child->state == MC_CAN_STOPPED ? MC_ERR_BUSY : child->last_result;
}

static int start_mixed(const mc_mix_config_t *config)
{
    int result = mc_mix_validate(config);
    if (result != MC_OK) { return result; }
    if (g_mixed.held || g_can_session.held || g_raw_session.held || g_live_session.held) { return MC_ERR_BUSY; }
    if (config->fault >= MC_FAULT_CAN_NO_ACK && config->mode != MC_MIX_NORMAL && !MC_BUILD_CAN_RAW_GPIO) {
        return MC_ERR_UNSUPPORTED; /* reject BEFORE the first normal frame */
    }
    if (config->fault <= MC_FAULT_SPI_EXTRA && !g_jedec_id_valid && probe_jedec_id() != MC_OK) { return MC_ERR_VERIFY; }
    g_can_view = 0; g_normal_can_from_menu = 0; g_raw_from_menu = 0; g_live_from_menu = 0;
    g_mix_first_txn = g_runner.next_transaction_id;
    result = mc_mix_start(&g_mixed, config);
    g_mix_view = 1; display_mixed(); g_mix_display_ms = HAL_GetTick();
    HAL_GPIO_WritePin(USER_LED_GPIO_Port, USER_LED_Pin, GPIO_PIN_RESET);
    return result;
}

static void run_mix_command(const char *args)
{
    mc_mix_config_t config;
    int result;
    char line[72];
    if (strncmp(args, "start ", 6U) == 0) {
        result = mc_mix_parse(args+6U, &config);
        if (result == MC_OK) { result = start_mixed(&config); }
    } else if (strcmp(args, "status") == 0) {
        result = g_mixed.port.record(g_mixed.port.context, &g_mixed, "status");
        if (result != MC_OK && g_mixed.state == MC_MIX_RUNNING) {
            (void)mc_mix_stop(&g_mixed);
            g_mixed.last_result = result; g_mixed.state = MC_MIX_ERROR;
        }
    } else if (strcmp(args, "stop") == 0) { result = mc_mix_stop(&g_mixed); }
    else if (strcmp(args, "recover") == 0) { result = mc_mix_recover(&g_mixed); }
    else { result = MC_ERR_ARGUMENT; }
    (void)snprintf(line, sizeof(line), "MIX %s result=%d held=%u\r\n> ", mix_state_name(), result, (unsigned int)g_mixed.held);
    console_write(line);
    if (g_mixed.run != 0U) { g_mix_view = 1; display_mixed(); }
}

static void confirm_fault_option(void)
{
    mc_mix_config_t config;
    int result;
    if (g_fault_option == 6U) { g_fault_options = 0; display_fault_menu(); return; }
    if (g_fault_option == 0U) {
        mc_oled_text(0U, 6U, "RUNNING PLEASE WAIT"); mc_oled_flush();
        trigger_selected_fault(); return;
    }
    memset(&config, 0, sizeof(config)); config.fault = g_selected_fault;
    config.total = g_fault_option == 1U ? 100U : 1000U;
    config.gap_ms = 100U; config.seed = 1U;
    config.mode = g_fault_option <= 2U ? MC_MIX_ONCE :
        (g_fault_option == 3U ? MC_MIX_EVERY : (g_fault_option == 4U ? MC_MIX_RANDOM : MC_MIX_NORMAL));
    config.value = g_fault_option == 1U ? 50U : (g_fault_option == 2U ? 500U :
                   (g_fault_option == 3U ? 100U : (g_fault_option == 4U ? 5U : 0U)));
    result = start_mixed(&config);
    if (result != MC_OK) {
        g_last_fault_result = result; g_has_fault_result = 1;
        if (!g_mix_view) { display_fault_options(); }
    }
}

static void run_command(const char *command)
{
    mc_run_summary_t summary;
    uint32_t iterations = parse_count(command);
    int result;

    if (strncmp(command, "mix ", 4U) == 0) { run_mix_command(command+4U); return; }
    if (g_mixed.held) {
        console_write("Mixed run active/restore pending; use mix status|stop|recover\r\n> ");
        return;
    }
    g_mix_view = 0; g_fault_options = 0;
    if (strncmp(command, "can test", 8U) == 0 &&
        (command[8] == ' ' || command[8] == '\0')) {
        run_can_command(command, 0);
        return;
    }
    if (strncmp(command, "can raw", 7U) == 0 &&
        (command[7] == ' ' || command[7] == '\0')) {
        run_can_command(command, 1);
        return;
    }
    if (strncmp(command,"can live",8U)==0 && (command[8]==' ' || command[8]=='\0')) {
        run_can_command(command,2);
        return;
    }
    if (g_can_session.held || g_raw_session.held || g_live_session.held) {
        console_write("CAN session active/restore pending; use can test stop|status|recover\r\n> ");
        return;
    }
    if (g_can_view) {
        g_can_view = 0;
        display_fault_menu();
    }
    if (strcmp(command, "help") == 0) {
        print_help();
    } else if (strcmp(command, "fault list") == 0) {
        print_fault_list();
    } else if (strncmp(command, "fault select ", 13U) == 0) {
        char *endptr;
        unsigned long index = strtoul(command + 13, &endptr, 10);
        if (endptr == command + 13 || *endptr != '\0') {
            console_write("Invalid fault index\r\n");
        } else {
            select_fault((unsigned int)index);
        }
        console_write("> ");
    } else if (strncmp(command, "fault run", 9U) == 0) {
        if (command[9] == ' ') {
            char *endptr;
            unsigned long index = strtoul(command + 10, &endptr, 10);
            if (endptr == command + 10 || *endptr != '\0' ||
                index >= (unsigned long)MC_FAULT_COUNT) {
                console_write("Invalid fault index\r\n> ");
                return;
            }
            select_fault((unsigned int)index);
        }
        /* A CLI run without N still shows the fault it actually executes. */
        select_fault((unsigned int)g_selected_fault);
        trigger_selected_fault();
    } else if (strcmp(command, "spi probe") == 0) {
        (void)probe_jedec_id();
    } else if (strncmp(command, "spi jedec", 9U) == 0) {
        run_spi_jedec(iterations);
    } else if (strncmp(command, "spi pattern", 11U) == 0) {
        result = mc_run_spi_patterns(&g_runner, 1002U, iterations, &summary);
        print_summary("SPI_PATTERN", result, &summary);
    } else if (strncmp(command, "uart loop", 9U) == 0) {
        result = mc_run_uart_loopback(&g_runner, 2001U, iterations, &summary);
        print_summary("UART", result, &summary);
    } else if (strncmp(command, "i2c eeprom", 10U) == 0) {
        result = mc_run_i2c_eeprom(&g_runner, 3001U, 0x50U, 0x0100U, iterations, &summary);
        print_summary("I2C", result, &summary);
    } else if (strncmp(command, "can loop", 8U) == 0) {
        result = mc_run_can_loopback(&g_runner, 4001U, 0x321U, iterations, &summary);
        print_summary("CAN", result, &summary);
    } else if (strcmp(command, "all") == 0) {
        run_spi_jedec(1U);
        result = mc_run_uart_loopback(&g_runner, 2001U, 1U, &summary);
        print_summary("UART", result, &summary);
        result = mc_run_i2c_eeprom(&g_runner, 3001U, 0x50U, 0x0100U, 1U, &summary);
        print_summary("I2C", result, &summary);
        result = mc_run_can_loopback(&g_runner, 4001U, 0x321U, 1U, &summary);
        print_summary("CAN", result, &summary);
    } else {
        console_write("Unknown command. Type help.\r\n> ");
    }
}

static void confirm_menu(void)
{
    mc_ui_entry_t entry;
    if (g_mixed.held || g_can_session.held || g_raw_session.held || g_live_session.held) {
        console_write("CAN owns resources; stop/recover first\r\n> ");
        return;
    }
    entry = mc_ui_menu_confirm(&g_menu);
    g_has_fault_result = 0;
    if (entry.action == MC_UI_NAVIGATE) {
        display_fault_menu();
        return;
    }
    if (entry.action == MC_UI_FAULT) {
        g_selected_fault = entry.fault;
        g_fault_options = 1; g_fault_option = 0U;
        display_fault_options();
        return;
    }
    ++g_normal_runs;
    g_menu_running = 1;
    HAL_GPIO_WritePin(USER_LED_GPIO_Port, USER_LED_Pin, GPIO_PIN_RESET);
    display_fault_menu();
    console_write("\r\nMENU NORMAL one iteration; local result is not PL detection\r\n");
    switch (entry.action) {
    case MC_UI_SPI_JEDEC: run_command("spi jedec 1"); break;
    case MC_UI_SPI_PATTERN: run_command("spi pattern 1"); break;
    case MC_UI_UART_ECHO: run_command("uart loop 1"); break;
    case MC_UI_I2C_EEPROM: run_command("i2c eeprom 1"); break;
    case MC_UI_CAN_ECHO: run_command("can loop 1"); break;
    case MC_UI_CAN_TX: {
        mc_can_config_t config;
        int result = mc_can_session_parse("normal 1 100", &config);
        if (result == MC_OK) { result = mc_can_session_start(&g_can_session, &config); }
        g_last_fault_result = result;
        g_has_fault_result = 1;
        g_normal_can_from_menu = result == MC_OK;
        g_can_backend = 0;
        g_can_view = 1;
        print_can_status();
        display_can_session();
        break;
    }
    default: break;
    }
    g_menu_running = 0;
    if (!g_can_view) { display_fault_menu(); }
}

static int can_start_accept_all(void)
{
    CAN_FilterTypeDef filter;

    memset(&filter, 0, sizeof(filter));
    filter.FilterBank = 0U;
    filter.FilterMode = CAN_FILTERMODE_IDMASK;
    filter.FilterScale = CAN_FILTERSCALE_32BIT;
    filter.FilterIdHigh = 0U;
    filter.FilterIdLow = 0U;
    filter.FilterMaskIdHigh = 0U;
    filter.FilterMaskIdLow = 0U;
    filter.FilterFIFOAssignment = CAN_RX_FIFO0;
    filter.FilterActivation = ENABLE;
    filter.SlaveStartFilterBank = 14U;
    if (HAL_CAN_ConfigFilter(&hcan1, &filter) != HAL_OK) {
        return MC_ERR_IO;
    }
    return HAL_CAN_Start(&hcan1) == HAL_OK ? MC_OK : MC_ERR_IO;
}

void mc_board_app_init(void)
{
    mc_platform_t platform;
    mc_can_session_port_t can_port;
    mc_mix_port_t mix_port;
    int can_result;

    memset(&g_port_context, 0, sizeof(g_port_context));
    g_port_context.spi = &hspi1;
    g_port_context.test_uart = &huart3;
    g_port_context.debug_uart = &huart1;
    g_port_context.i2c = &hi2c1;
    g_port_context.can = &hcan1;
    g_port_context.spi_cs_port = SPI_FLASH_CS_GPIO_Port;
    g_port_context.spi_cs_pin = SPI_FLASH_CS_Pin;
    g_port_context.sync_port = TEST_SYNC_GPIO_Port;
    g_port_context.sync_pin = TEST_SYNC_Pin;

    platform = mc_stm32f407_make_platform(&g_port_context);
    mc_runner_init(&g_runner, &platform);
    can_port = mc_can_session_hal_port(&g_can_hal, &hcan1, &huart1);
    mc_can_session_init(&g_can_session, &can_port);
    can_port = mc_can_raw_hal_port(&g_raw_hal, &hcan1, &huart1);
    mc_can_session_init(&g_raw_session, &can_port);
    can_port=mc_can_live_hal_port(&g_live_hal,&hcan1,&huart1);
    mc_can_session_init(&g_live_session,&can_port);
    memset(&mix_port, 0, sizeof(mix_port));
    mix_port.now_ms = mixed_now; mix_port.start_slot = mixed_start_slot;
    mix_port.poll_slot = mixed_poll_slot; mix_port.cancel = mixed_cancel; mix_port.record = mixed_record;
    mc_mix_init(&g_mixed, &mix_port);
    g_mix_view = 0; g_mix_display_ms = 0U; g_fault_options = 0; g_fault_option = 0U;
    g_can_backend = 0;
    g_raw_from_menu = 0;
    g_live_from_menu = 0;
    g_can_view = 0;
    g_fault_runs = 0U;
    g_normal_runs = 0U;
    g_menu_running = 0;
    g_normal_can_from_menu = 0;
    mc_ui_menu_init(&g_menu);
    mc_cli_rx_init(&g_console_rx);
    g_command_length = 0U;
    g_discard_line = 0;
    g_last_dropped = 0U;
    g_uart_rx_errors = 0U;
    g_jedec_id_valid = 0;
    mc_button_init(&g_button,
                   HAL_GPIO_ReadPin(USER_KEY_GPIO_Port, USER_KEY_Pin) == GPIO_PIN_SET,
                   HAL_GetTick());
    g_selected_fault = MC_FAULT_SPI_PARTIAL;
    g_has_fault_result = 0;
    can_result = can_start_accept_all();
    mc_oled_init();
    display_fault_menu();

    if (HAL_UART_Receive_IT(&huart1, &g_rx_byte, 1U) != HAL_OK) {
        console_write("USART1 RX interrupt start failed\r\n");
    }

    console_write("\r\nSkyStar STM32F407 protocol truth node\r\n");
    {
        char build[130];
        (void)snprintf(build, sizeof(build), "BUILD rev=%07lX CAN_FAULTS=%u CAN_RAW_GPIO=%u CAN_LIVE=%u RAW_TX=PD1 LIVE_TX=PA2\r\n",
                       (unsigned long)MC_BUILD_REV, MC_BUILD_CAN_FAULTS, MC_BUILD_CAN_RAW_GPIO,MC_BUILD_CAN_LIVE);
        console_write(build);
    }
    console_write("Clock=168MHz SPI1=1.3125MHz I2C1=100k UART1/UART3=115200 CAN1=500k\r\n");
    console_write(can_result == MC_OK ? "CAN started\r\n" : "CAN start failed; check transceiver\r\n");
    (void)probe_jedec_id();
    print_help();
}

void mc_board_app_poll(void)
{
    uint8_t value;
    mc_button_event_t key_event;
    unsigned int processed = 0U;

    if (g_console_rx.dropped != g_last_dropped || g_uart_rx_errors != 0U) {
        g_last_dropped = g_console_rx.dropped;
        g_discard_line = 1;
        g_command_length = 0U;
        g_uart_rx_errors = 0U;
    }
    if (huart1.RxState == HAL_UART_STATE_READY) {
        (void)HAL_UART_Receive_IT(&huart1, &g_rx_byte, 1U);
    }
    while (processed++ < 64U && mc_cli_rx_pop(&g_console_rx, &value)) {
        if (g_discard_line) {
            if (value == '\r' || value == '\n') {
                g_discard_line = 0;
                console_write("\r\nUSART1 RX overflow; line discarded\r\n> ");
            }
            continue;
        }
        if (value == '\r' || value == '\n') {
            if (g_command_length > 0U) {
                g_command[g_command_length] = '\0';
                console_write(g_command);
                console_write("\r\n");
                g_command_length = 0U;
                run_command(g_command);
            }
        } else if (value == 0x08U || value == 0x7FU) {
            if (g_command_length > 0U) {
                --g_command_length;
            }
        } else if (g_command_length + 1U < sizeof(g_command)) {
            g_command[g_command_length++] = (char)value;
        } else {
            g_command_length = 0U;
            g_discard_line = 1;
        }
    }

    key_event = mc_button_poll(&g_button,
                              HAL_GPIO_ReadPin(USER_KEY_GPIO_Port, USER_KEY_Pin) == GPIO_PIN_SET,
                              HAL_GetTick());
    if (key_event == MC_BUTTON_LONG) {
        if (g_mix_view) {
            if (g_mixed.state == MC_MIX_RUNNING) { (void)mc_mix_stop(&g_mixed); }
            else if (g_mixed.held) { (void)mc_mix_recover(&g_mixed); }
            else { g_mix_view = 0; }
            if (g_mix_view) { display_mixed(); } else { display_fault_menu(); }
        } else if (visible_can()->state == MC_CAN_RUNNING) {
            (void)mc_can_session_stop(visible_can());
            print_can_status();
            display_can_session();
        } else if (g_can_view) {
            if (visible_can()->held) {
                (void)mc_can_session_recover(visible_can());
                print_can_status();
                display_can_session();
            } else {
                g_can_view = 0;
                display_fault_menu();
            }
        } else if (g_fault_options) {
            confirm_fault_option();
        } else {
            confirm_menu();
        }
    } else if (key_event == MC_BUTTON_SHORT) {
        if (g_mix_view) {
            if (!g_mixed.held) { g_mix_view = 0; display_fault_menu(); }
        } else if (!g_can_session.held && !g_raw_session.held && !g_live_session.held) {
            if (g_can_view) {
                g_can_view = 0;
                display_fault_menu();
            } else if (g_fault_options) {
                g_fault_option = (g_fault_option + 1U) % 7U;
                g_has_fault_result = 0; display_fault_options();
            } else {
                mc_ui_menu_next(&g_menu);
                g_has_fault_result = 0;
                display_fault_menu();
            }
        }
    }
    if (g_mixed.state == MC_MIX_RUNNING) {
        mc_mix_tick(&g_mixed);
        if (g_mixed.state != MC_MIX_RUNNING ||
            (!g_mixed.waiting && (uint32_t)(HAL_GetTick() - g_mix_display_ms) >= 250U)) {
            display_mixed(); g_mix_display_ms = HAL_GetTick();
        }
        if (g_mixed.state != MC_MIX_RUNNING) {
            HAL_GPIO_WritePin(USER_LED_GPIO_Port, USER_LED_Pin,
                              g_mixed.state == MC_MIX_DONE && g_mixed.last_result == MC_OK ? GPIO_PIN_SET : GPIO_PIN_RESET);
        }
    }
    if (!g_mixed.held && !g_mix_view && visible_can()->state == MC_CAN_RUNNING) {
        mc_can_session_tick(visible_can(), HAL_GetTick());
        if (visible_can()->state != MC_CAN_RUNNING) { print_can_status(); }
        if (visible_can()->state != MC_CAN_RUNNING ||
            (!visible_can()->waiting &&
             (uint32_t)(HAL_GetTick() - g_can_display_ms) >= 250U)) {
            display_can_session();
            g_can_display_ms = HAL_GetTick();
        }
    }
    if (g_raw_from_menu && g_raw_session.state != MC_CAN_RUNNING) {
        g_last_fault_result = g_raw_session.state == MC_CAN_STOPPED ? MC_ERR_BUSY :
                              g_raw_session.last_result;
        g_has_fault_result = 1;
        g_raw_from_menu = 0;
    }
    if (g_normal_can_from_menu && g_can_session.state != MC_CAN_RUNNING) {
        g_last_fault_result = g_can_session.state == MC_CAN_STOPPED ? MC_ERR_BUSY :
                              g_can_session.last_result;
        g_has_fault_result = 1;
        g_normal_can_from_menu = 0;
        HAL_GPIO_WritePin(USER_LED_GPIO_Port, USER_LED_Pin,
                          g_last_fault_result == MC_OK ? GPIO_PIN_SET : GPIO_PIN_RESET);
    }
    if (g_live_from_menu && g_live_session.state!=MC_CAN_RUNNING) {
        g_last_fault_result=g_live_session.state==MC_CAN_STOPPED ? MC_ERR_BUSY : g_live_session.last_result;
        g_has_fault_result=1; g_live_from_menu=0;
    }
}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)
{
    if (huart != NULL && huart->Instance == USART1) {
        (void)mc_cli_rx_push(&g_console_rx, g_rx_byte);
        if (HAL_UART_Receive_IT(&huart1, &g_rx_byte, 1U) != HAL_OK) {
            ++g_uart_rx_errors;
        }
    }
}

void HAL_UART_ErrorCallback(UART_HandleTypeDef *huart)
{
    if (huart != NULL && huart->Instance == USART1) {
        ++g_uart_rx_errors;
        (void)HAL_UART_Receive_IT(&huart1, &g_rx_byte, 1U);
    }
}

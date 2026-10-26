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
static void print_can_status(void);

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
        "USER_KEY: short=next, hold 0.8s=run.\r\n> ");
}

static void display_fault_menu(void)
{
    char line[24];
    unsigned int base = ((unsigned int)g_selected_fault / 4U) * 4U;
    unsigned int i;
    const mc_fault_info_t *selected = mc_fault_get(g_selected_fault);
    mc_oled_clear();
    mc_oled_text(0U, 0U, "FAULT SELECT");
    for (i = 0U; i < 4U; ++i) {
        const mc_fault_info_t *item = mc_fault_get((mc_fault_id_t)(base + i));
        if (item != NULL) {
            (void)snprintf(line, sizeof(line), "%c%02u %s",
                           base + i == (unsigned int)g_selected_fault ? '>' : ' ',
                           base + i, item->label);
            mc_oled_text(0U, (uint8_t)(i + 1U), line);
        }
    }
    (void)snprintf(line, sizeof(line), "RUNS %lu HOLD RUN", (unsigned long)g_fault_runs);
    mc_oled_text(0U, 5U, line);
    if (g_has_fault_result) {
        if (g_last_fault_result == MC_ERR_UNSUPPORTED) {
            strcpy(line, "NEEDS EXTERNAL HW");
        } else {
        (void)snprintf(line, sizeof(line), "RESULT %d", g_last_fault_result);
        }
    } else if (selected != NULL) {
        if (fault_raw_mode(g_selected_fault) >= MC_CAN_RAW_VALID) {
            strcpy(line, fault_raw_mode(g_selected_fault) >= MC_CAN_LIVE_DISTURB ? "LIVE READY PA1/2" : "RAW READY PD1");
        } else { switch (selected->requirement) {
        case MC_FAULT_LOCAL: strcpy(line, "READY"); break;
        case MC_FAULT_NEEDS_WIRING: strcpy(line, "NEEDS LINK"); break;
        case MC_FAULT_NEEDS_PEER: strcpy(line, "NEEDS PEER"); break;
        case MC_FAULT_EXTERNAL_ONLY: strcpy(line, "EXTERNAL ONLY"); break;
        default: strcpy(line, "NOT BASELINE"); break;
        } }
    } else {
        strcpy(line, "INVALID");
    }
    mc_oled_text(0U, 6U, line);
    if (selected != NULL) {
        (void)snprintf(line, sizeof(line), "CASE %lu", (unsigned long)selected->case_id);
        mc_oled_text(0U, 7U, line);
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
    if (g_can_session.held || g_raw_session.held || g_live_session.held) {
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
    if (!g_jedec_id_valid && probe_jedec_id() != MC_OK) {
        return;
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

static void run_command(const char *command)
{
    mc_run_summary_t summary;
    uint32_t iterations = parse_count(command);
    int result;

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
    g_can_backend = 0;
    g_raw_from_menu = 0;
    g_live_from_menu = 0;
    g_can_view = 0;
    g_fault_runs = 0U;
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
        if (visible_can()->state == MC_CAN_RUNNING) {
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
        } else {
            trigger_selected_fault();
        }
    } else if (key_event == MC_BUTTON_SHORT) {
        if (!g_can_session.held && !g_raw_session.held && !g_live_session.held) {
            if (g_can_view) {
                g_can_view = 0;
                display_fault_menu();
            } else {
                select_fault((unsigned int)(g_selected_fault + 1U) % (unsigned int)MC_FAULT_COUNT);
            }
        }
    }
    if (visible_can()->state == MC_CAN_RUNNING) {
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

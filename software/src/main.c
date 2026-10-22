#include "platform_ui.h"
#include "capture_demo.h"
#ifdef SESSION_HOST_TEST
#include "../tests/session_host_stubs.h"
#else
#include "touch.h"
#include "xil_io.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xstatus.h"
#include "xuartps.h"
#include "sleep.h"
#include "string.h"
#include "xtime_l.h"
#endif
#include "string.h"
#include "ui_counter_semantics.h"

#define CORE_BASE       XPAR_MULTI_PROTOCOL_CORE_0_BASEADDR
#define REG_SYS_ID      (CORE_BASE + 0x0000U)
#define REG_VERSION     (CORE_BASE + 0x0004U)
#define REG_CAPABILITIES (CORE_BASE + 0x000CU)
#define REG_SCRATCH     (CORE_BASE + 0x002CU)
#define REG_LED_CTRL    (CORE_BASE + 0x0030U)
#define REG_ARB_STATUS  (CORE_BASE + 0x0034U)
#define REG_EXT_DROPPED (CORE_BASE + 0x0038U)
#define REG_SPI_FRAME_ERRORS (CORE_BASE + 0x004CU)
#define REG_SPI_BOUNDARY_ERRORS (CORE_BASE + 0x0050U)
#define REG_SPI_DUPLICATES (CORE_BASE + 0x0054U)
#define REG_SPI_SEQUENCE_ERRORS (CORE_BASE + 0x0058U)
#define REG_SPI_SHORT_TRANSACTIONS (CORE_BASE + 0x0068U)
#define REG_SPI_EXTRA_BYTES (CORE_BASE + 0x006CU)
#define REG_SPI_RESPONSE_MISMATCHES (CORE_BASE + 0x0070U)
#define REG_UART_EVENT_COUNT (CORE_BASE + 0x0074U)
#define REG_UART_DATA_COUNT (CORE_BASE + 0x0078U)
#define REG_UART_STOP_ERRORS (CORE_BASE + 0x007CU)
#define REG_UART_BREAK_ERRORS (CORE_BASE + 0x0080U)
#define REG_UART_SHORT_TRANSACTIONS (CORE_BASE + 0x0084U)
#define REG_I2C_EVENT_COUNT (CORE_BASE + 0x0094U)
#define REG_I2C_DATA_COUNT (CORE_BASE + 0x0098U)
#define REG_I2C_ADDRESS_NACKS (CORE_BASE + 0x009CU)
#define REG_I2C_BUSY_NACKS (CORE_BASE + 0x00A0U)
#define REG_I2C_SDA_STUCK (CORE_BASE + 0x00A4U)
#define REG_I2C_SCL_STUCK (CORE_BASE + 0x00A8U)
#define REG_I2C_MISSING_STOP (CORE_BASE + 0x00ACU)
#define REG_I2C_STATS_CTRL (CORE_BASE + 0x00B4U)
#define REG_CAN_EVENT_COUNT (CORE_BASE + 0x00B8U)
#define REG_CAN_FRAME_COUNT (CORE_BASE + 0x00BCU)
#define REG_CAN_ACK_ERRORS (CORE_BASE + 0x00C0U)
#define REG_CAN_BIT_ERRORS (CORE_BASE + 0x00C4U)
#define REG_CAN_STUFF_ERRORS (CORE_BASE + 0x00C8U)
#define REG_CAN_CRC_ERRORS (CORE_BASE + 0x00CCU)
#define REG_CAN_FORM_ERRORS (CORE_BASE + 0x00D0U)
#define REG_CAN_BUS_OFF (CORE_BASE + 0x00D4U)
#define REG_CAN_STATS_CTRL (CORE_BASE + 0x00DCU)
#define REG_CORE_REJECTED (CORE_BASE + 0x1014U)
#define COUNTER_POLL_TICKS ((uint64_t)COUNTS_PER_SECOND / 5U)

#define EXPECTED_ID     0x4D505254U
#define SCRATCH_TEST    0xA5A55A5AU

#ifndef SESSION_HOST_TEST
static XUartPs g_uart;
static CaptureDemoCache g_demo_cache;
#endif
static CaptureDemoCache g_live_cache;

#ifndef SESSION_HOST_TEST
static int uart_init(void)
{
    XUartPs_Config *config = XUartPs_LookupConfig(XPAR_XUARTPS_0_DEVICE_ID);
    int status;
    if (config == 0) return XST_FAILURE;
    status = XUartPs_CfgInitialize(&g_uart, config, config->BaseAddress);
    if (status != XST_SUCCESS) return status;
    status = XUartPs_SetBaudRate(&g_uart, 115200U);
    return status;
}
#endif

static TestHistory g_history;
static u32 g_next_test = 1U;
static u32 g_external_base;
static XTime g_test_start;

static void clear_test_display(PlatformUiStatus *s)
{
    s->core_rejected_count = s->external_loss_count = 0U;
    s->spi_frame_errors = s->spi_boundary_errors = s->spi_duplicates = 0U;
    s->spi_sequence_errors = s->spi_short_transactions = s->spi_extra_bytes = 0U;
    s->spi_response_mismatches = 0U;
    s->uart_event_count = s->uart_data_count = s->uart_stop_errors = 0U;
    s->uart_break_errors = s->uart_short_transactions = 0U;
    s->i2c_event_count = s->i2c_data_count = 0U;
    s->i2c_address_nacks = s->i2c_busy_nacks = 0U;
    s->i2c_sda_stuck = s->i2c_scl_stuck = s->i2c_missing_stop = 0U;
    s->can_event_count = s->can_frame_count = 0U;
    s->can_ack_errors = s->can_bit_errors = s->can_stuff_errors = 0U;
    s->can_crc_errors = s->can_form_errors = s->can_bus_off = 0U;
    s->test_id = s->test_events = s->test_errors = 0U;
    s->test_running = s->retained_tail = s->capture_source = 0U;
    s->test_failed = 0U;
    error_model_init(&s->error_model);
}

static void refresh_test(PlatformUiStatus *s)
{
    u32 i;
    s->core_rejected_count = Xil_In32(REG_CORE_REJECTED);
    s->external_loss_count = Xil_In32(REG_EXT_DROPPED) - g_external_base;
    s->test_events = Xil_In32(CORE_BASE + 0x101CU);
    error_model_init(&s->error_model);
    if (s->selected_protocol == UI_PROTOCOL_SPI) {
        s->spi_frame_errors = Xil_In32(REG_SPI_FRAME_ERRORS);
        s->spi_boundary_errors = Xil_In32(REG_SPI_BOUNDARY_ERRORS);
        s->spi_duplicates = Xil_In32(REG_SPI_DUPLICATES);
        s->spi_sequence_errors = Xil_In32(REG_SPI_SEQUENCE_ERRORS);
        s->spi_short_transactions = Xil_In32(REG_SPI_SHORT_TRANSACTIONS);
        s->spi_extra_bytes = Xil_In32(REG_SPI_EXTRA_BYTES);
        s->spi_response_mismatches = Xil_In32(REG_SPI_RESPONSE_MISMATCHES);
        (void)error_model_report(&s->error_model, ERROR_SPI_PARTIAL_BYTE,
                                ERROR_ORIGIN_PL, s->spi_frame_errors);
        (void)error_model_report(&s->error_model, ERROR_SPI_SHORT_TRANSACTION,
                                ERROR_ORIGIN_PL, s->spi_short_transactions);
        (void)error_model_report(&s->error_model, ERROR_SPI_EXTRA_BYTES,
                                ERROR_ORIGIN_PL, s->spi_extra_bytes);
        (void)error_model_report(&s->error_model, ERROR_SPI_RESPONSE_MISMATCH,
                                ERROR_ORIGIN_PL, s->spi_response_mismatches);
    } else if (s->selected_protocol == UI_PROTOCOL_UART) {
        s->uart_event_count = Xil_In32(REG_UART_EVENT_COUNT);
        s->uart_data_count = Xil_In32(REG_UART_DATA_COUNT);
        s->uart_stop_errors = Xil_In32(REG_UART_STOP_ERRORS);
        s->uart_break_errors = Xil_In32(REG_UART_BREAK_ERRORS);
        s->uart_short_transactions = Xil_In32(REG_UART_SHORT_TRANSACTIONS);
        (void)error_model_report(&s->error_model, ERROR_UART_STOP_BIT,
                                ERROR_ORIGIN_PL, s->uart_stop_errors);
        (void)error_model_report(&s->error_model, ERROR_UART_BREAK,
                                ERROR_ORIGIN_PL, s->uart_break_errors);
        (void)error_model_report(&s->error_model, ERROR_UART_SHORT_TRANSACTION,
                                ERROR_ORIGIN_PL, s->uart_short_transactions);
    } else if (s->selected_protocol == UI_PROTOCOL_I2C) {
        s->i2c_event_count = Xil_In32(REG_I2C_EVENT_COUNT);
        s->i2c_data_count = Xil_In32(REG_I2C_DATA_COUNT);
        s->i2c_address_nacks = Xil_In32(REG_I2C_ADDRESS_NACKS);
        s->i2c_busy_nacks = Xil_In32(REG_I2C_BUSY_NACKS);
        s->i2c_sda_stuck = Xil_In32(REG_I2C_SDA_STUCK);
        s->i2c_scl_stuck = Xil_In32(REG_I2C_SCL_STUCK);
        s->i2c_missing_stop = Xil_In32(REG_I2C_MISSING_STOP);
        (void)error_model_report(&s->error_model, ERROR_I2C_ADDRESS_NACK,
                                ERROR_ORIGIN_PL, s->i2c_address_nacks);
        (void)error_model_report(&s->error_model, ERROR_I2C_BUSY_NACK,
                                ERROR_ORIGIN_PL, s->i2c_busy_nacks);
        (void)error_model_report(&s->error_model, ERROR_I2C_SDA_STUCK,
                                ERROR_ORIGIN_PL, s->i2c_sda_stuck);
        (void)error_model_report(&s->error_model, ERROR_I2C_SCL_STUCK,
                                ERROR_ORIGIN_PL, s->i2c_scl_stuck);
        (void)error_model_report(&s->error_model, ERROR_I2C_MISSING_STOP,
                                ERROR_ORIGIN_PL, s->i2c_missing_stop);
    } else if (s->selected_protocol == UI_PROTOCOL_CAN) {
        s->can_event_count = Xil_In32(REG_CAN_EVENT_COUNT);
        s->can_frame_count = Xil_In32(REG_CAN_FRAME_COUNT);
        s->can_ack_errors = Xil_In32(REG_CAN_ACK_ERRORS);
        s->can_bit_errors = Xil_In32(REG_CAN_BIT_ERRORS);
        s->can_stuff_errors = Xil_In32(REG_CAN_STUFF_ERRORS);
        s->can_crc_errors = Xil_In32(REG_CAN_CRC_ERRORS);
        s->can_form_errors = Xil_In32(REG_CAN_FORM_ERRORS);
        s->can_bus_off = Xil_In32(REG_CAN_BUS_OFF);
        (void)error_model_report(&s->error_model, ERROR_CAN_ACK,
                                ERROR_ORIGIN_PL, s->can_ack_errors);
        /* A separate passive transceiver has no local TX intent to compare,
         * so a transmitter bit error is intentionally reported as unknown. */
        (void)error_model_report(&s->error_model, ERROR_CAN_STUFF,
                                ERROR_ORIGIN_PL, s->can_stuff_errors);
        (void)error_model_report(&s->error_model, ERROR_CAN_CRC,
                                ERROR_ORIGIN_PL, s->can_crc_errors);
        (void)error_model_report(&s->error_model, ERROR_CAN_FORM,
                                ERROR_ORIGIN_PL, s->can_form_errors);
        /* Bus-off is controller state and cannot be proven by a passive tap. */
    }
    s->test_errors = s->external_loss_count;
    for (i = 0U; i < ERROR_CODE_COUNT; ++i)
        if (s->error_model.item[i].origin != ERROR_ORIGIN_NONE)
            s->test_errors += s->error_model.item[i].count;
}

static void end_test(PlatformUiStatus *s, CaptureDemoSnapshot *snapshot)
{
    TestHistoryEntry *record;
    XTime now;
    int saved;
    if (s->test_running == 0U) return;
    saved = capture_session_freeze(snapshot) == XST_SUCCESS &&
            capture_demo_cache_snapshot(&g_live_cache, snapshot) == XST_SUCCESS;
    refresh_test(s);
    s->retained_tail = (Xil_In32(CORE_BASE + 0x1004U) & 4U) != 0U;
    s->test_running = 0U;
    s->test_failed = saved == 0;
    s->capture_source = saved ? 2U : 0U;
    platform_ui_set_event_cache(saved ? &g_live_cache : 0);
    record = test_history_append(&g_history);
    XTime_GetTime(&now);
    record->id = s->test_id;
    record->protocol = (u32)s->selected_protocol;
    record->duration_ms = (u32)(((uint64_t)(now - g_test_start) * 1000U) /
                               (uint64_t)COUNTS_PER_SECOND);
    record->total_events = s->test_events;
    record->error_count = s->test_errors;
    record->external_loss = s->external_loss_count;
    record->data_count = s->selected_protocol == UI_PROTOCOL_UART ? s->uart_data_count :
                         s->selected_protocol == UI_PROTOCOL_I2C ? s->i2c_data_count :
                         s->selected_protocol == UI_PROTOCOL_CAN ? s->can_frame_count :
                         Xil_In32(CORE_BASE + 0x44U);
    record->errors = s->error_model;
    record->snapshot_valid = saved != 0;
    record->overwritten = s->retained_tail;
    record->trigger_index = 0xFFFFFFFFU;
    if (saved) {
        record->count = g_live_cache.count;
        memcpy(record->words, g_live_cache.event_word,
               record->count * sizeof(record->words[0]));
    }
    platform_ui_set_history(&g_history);
    xil_printf("TEST SAVED id=%lu protocol=%s events=%lu retained=%lu errors=%lu tail=%u history=%lu\r\n",
               (unsigned long)s->test_id, ui_protocol_name(s->selected_protocol),
               (unsigned long)s->test_events, (unsigned long)record->count,
               (unsigned long)s->test_errors, s->retained_tail,
               (unsigned long)g_history.count);
}

static void begin_test(PlatformUiStatus *s, CaptureDemoSnapshot *snapshot)
{
    if (!ui_protocol_live(s->selected_protocol, s->capabilities)) return;
    if (s->test_running) end_test(s, snapshot);
    clear_test_display(s);
    /* One deliberate reset at the start of a test, never on page switching. */
    Xil_Out32(CORE_BASE + 0x64U, 1U);
    Xil_Out32(CORE_BASE + 0x90U, 1U);
    Xil_Out32(REG_I2C_STATS_CTRL, 1U);
    Xil_Out32(REG_CAN_STATS_CTRL, 1U);
    g_external_base = Xil_In32(REG_EXT_DROPPED);
    s->test_id = g_next_test++;
    XTime_GetTime(&g_test_start);
    if (capture_session_arm(ui_protocol_event_id(s->selected_protocol))
        != XST_SUCCESS) {
        xil_printf("TEST START FAILED: manual capture capability required\r\n");
        s->test_failed = 1U;
        return;
    }
    s->test_running = 1U;
    s->capture_source = 1U;
    platform_ui_set_event_cache(0);
    refresh_test(s);
    xil_printf("TEST START id=%lu protocol=%s errors=%lu\r\n",
               (unsigned long)s->test_id, ui_protocol_name(s->selected_protocol),
               (unsigned long)s->test_errors);
}

/* The USB console invokes the same actions as touch; useful for repeatable
 * board tests and for users sending traffic from a host. LF or CR terminates. */
#ifndef SESSION_HOST_TEST
static PlatformUiAction console_action(const PlatformUiStatus *s)
{
    static char line[48];
    static u32 used;
    u8 ch;
    while (XUartPs_Recv(&g_uart, &ch, 1U) == 1U) {
        if (ch != '\r' && ch != '\n') {
            if (used + 1U < sizeof(line)) line[used++] = (char)ch;
            else used = 0U;
            continue;
        }
        line[used] = '\0'; used = 0U;
        if (!strcmp(line,"test start")) return PLATFORM_UI_ACTION_CAPTURE_LIVE;
        if (!strcmp(line,"test stop")) return PLATFORM_UI_ACTION_END_TEST;
        if (!strcmp(line,"view history")) return PLATFORM_UI_ACTION_HISTORY;
        if (!strcmp(line,"view events")) return PLATFORM_UI_ACTION_EVENTS;
        if (!strcmp(line,"view home")) return PLATFORM_UI_ACTION_HOME;
        if (!strcmp(line,"view errors")) return PLATFORM_UI_ACTION_ERRORS;
        if (!strcmp(line,"protocol uart")) return PLATFORM_UI_ACTION_SELECT_UART;
        if (!strcmp(line,"protocol spi")) return PLATFORM_UI_ACTION_SELECT_SPI;
        if (!strcmp(line,"protocol i2c")) return PLATFORM_UI_ACTION_SELECT_I2C;
        if (!strcmp(line,"protocol can")) return PLATFORM_UI_ACTION_SELECT_CAN;
        if (!strcmp(line,"status"))
            xil_printf("TEST STATUS id=%lu running=%u events=%lu errors=%lu history=%lu\r\n",
                       (unsigned long)s->test_id, s->test_running,
                       (unsigned long)s->test_events, (unsigned long)s->test_errors,
                       (unsigned long)g_history.count);
    }
    return PLATFORM_UI_ACTION_NONE;
}

int main(void)
{
    PlatformUiStatus status;
    CaptureDemoSnapshot demo, live;
    PlatformUiPage page = PLATFORM_UI_PAGE_HOME;
    PlatformUiAction action;
    XTime now, last_poll;
    memset(&status,0,sizeof(status));
    memset(&demo,0,sizeof(demo));
    memset(&live,0,sizeof(live));
    status.selected_protocol = UI_PROTOCOL_SPI;
    if (uart_init() != XST_SUCCESS) while (1) {}
    xil_printf("PS READY: TEST SESSION UI 20261020\r\n");
    status.id = Xil_In32(REG_SYS_ID);
    status.version = Xil_In32(REG_VERSION);
    status.capabilities = Xil_In32(REG_CAPABILITIES);
    Xil_Out32(REG_SCRATCH, SCRATCH_TEST);
    status.scratch = Xil_In32(REG_SCRATCH);
    status.id_ok = status.id == EXPECTED_ID;
    status.version_ok = (status.version & 0xFFFF0000U) == 0x00010000U;
    status.scratch_ok = status.scratch == SCRATCH_TEST;
    if (platform_ui_init() != XST_SUCCESS) while (1) {}
    status.touch_ok = gt911_init() == XST_SUCCESS;
    status.capture_ok = capture_demo_run(&demo) == XST_SUCCESS;
    if (status.capture_ok &&
        capture_demo_cache_snapshot(&g_demo_cache,&demo) == XST_SUCCESS)
        platform_ui_set_event_cache(&g_demo_cache);
    clear_test_display(&status);
    platform_ui_set_history(&g_history);
    Xil_Out32(REG_LED_CTRL,0U);
    platform_ui_render_page(page,&status,status.capture_ok ? &demo : 0);
    XTime_GetTime(&last_poll);
    xil_printf("UI READY. Commands: protocol spi/uart/i2c/can; test start/stop; view events/errors/history/home; status\r\n");
    while (1) {
        XTime_GetTime(&now);
        if (status.test_running &&
            ui_counter_poll_due((uint64_t)now,(uint64_t)last_poll,COUNTER_POLL_TICKS)) {
            last_poll = now;
            refresh_test(&status);
            platform_ui_update_counters(&status);
        }
        action = status.touch_ok ? platform_ui_poll_action() : PLATFORM_UI_ACTION_NONE;
        if (action == PLATFORM_UI_ACTION_NONE) action = console_action(&status);
        if (action == PLATFORM_UI_ACTION_HOME) page = PLATFORM_UI_PAGE_HOME;
        else if (action == PLATFORM_UI_ACTION_SELF_TEST) page = PLATFORM_UI_PAGE_SELF_TEST;
        else if (action == PLATFORM_UI_ACTION_EVENTS) page = PLATFORM_UI_PAGE_EVENTS;
        else if (action == PLATFORM_UI_ACTION_ERRORS) page = PLATFORM_UI_PAGE_ERRORS;
        else if (action == PLATFORM_UI_ACTION_HISTORY) page = PLATFORM_UI_PAGE_HISTORY;
        else if (action == PLATFORM_UI_ACTION_CAPTURE_LIVE) {
            begin_test(&status,&live);
            page = PLATFORM_UI_PAGE_EVENTS;
        } else if (action == PLATFORM_UI_ACTION_END_TEST) {
            end_test(&status,&live);
            page = PLATFORM_UI_PAGE_EVENTS;
        } else if (action >= PLATFORM_UI_ACTION_SELECT_SPI &&
                   action <= PLATFORM_UI_ACTION_SELECT_CAN) {
            UiProtocol selected = (UiProtocol)(action - PLATFORM_UI_ACTION_SELECT_SPI);
            if (selected != status.selected_protocol) {
                end_test(&status,&live);
                clear_test_display(&status);
                status.selected_protocol = selected;
                platform_ui_set_event_cache(&g_demo_cache);
            }
        }
        if (action != PLATFORM_UI_ACTION_NONE)
            platform_ui_render_page(page,&status,status.capture_source == 2U ? &live :
                                    status.capture_source == 1U ? 0 : &demo);
        platform_ui_tick();
        usleep(5000U);
    }
}
#endif

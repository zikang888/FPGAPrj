/* Run the actual foreground app with mock I/O, not a second UI implementation. */
#include "../app/src/mc_board_app.c"

#define CHECK(c) do { if (!(c)) { fprintf(stderr, "FAIL line %d: %s\n", __LINE__, #c); return 1; } } while (0)
CAN_HandleTypeDef hcan1;
I2C_HandleTypeDef hi2c1;
SPI_HandleTypeDef hspi1;
UART_HandleTypeDef huart1, huart3;
GPIO_TypeDef test_board_gpio[3];
static GPIO_PinState key, led;
static uint32_t ticks;
static unsigned int spi_calls, uart_calls, i2c_calls, can_calls, fault_calls, submits;
static uint8_t echo[16], eeprom[16];
static char rows[8][24], console[32768];
static int echo_error, probe_error, restore_error, keep_pending;

uint32_t HAL_GetTick(void) { return ticks; }
void HAL_Delay(uint32_t delay) { ticks += delay; }
GPIO_PinState HAL_GPIO_ReadPin(GPIO_TypeDef *port, uint16_t pin) { (void)port; (void)pin; return key; }
void HAL_GPIO_WritePin(GPIO_TypeDef *port, uint16_t pin, GPIO_PinState state)
{ if (port == USER_LED_GPIO_Port && pin == USER_LED_Pin) { led = state; } }
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *uart, uint8_t *data, uint16_t length, uint32_t timeout)
{
    size_t used = strlen(console);
    (void)uart; (void)timeout;
    if (used + length < sizeof(console)) { memcpy(console + used, data, length); console[used + length] = '\0'; }
    return HAL_OK;
}
HAL_StatusTypeDef HAL_UART_Receive_IT(UART_HandleTypeDef *uart, uint8_t *data, uint16_t length)
{ (void)uart; (void)data; (void)length; return HAL_OK; }
HAL_StatusTypeDef HAL_CAN_ConfigFilter(CAN_HandleTypeDef *can, const CAN_FilterTypeDef *filter)
{ (void)can; (void)filter; return HAL_OK; }
HAL_StatusTypeDef HAL_CAN_Start(CAN_HandleTypeDef *can) { (void)can; return HAL_OK; }
void mc_oled_init(void) { }
void mc_oled_clear(void) { memset(rows, 0, sizeof(rows)); }
void mc_oled_text(uint8_t col, uint8_t row, const char *text)
{ (void)col; if (row < 8U) { (void)snprintf(rows[row], sizeof(rows[row]), "%.21s", text); } }
void mc_oled_flush(void) { }

static int select_spi(void *ctx, int active) { (void)ctx; (void)active; return MC_OK; }
static int transfer_spi(void *ctx, const uint8_t *tx, uint8_t *rx, size_t length, uint32_t timeout)
{
    (void)ctx; (void)timeout; ++spi_calls; memset(rx, 0, length);
    if (tx[0] == 0x9fU && length >= 4U && !probe_error) { rx[1] = 0xefU; rx[2] = 0x40U; rx[3] = 0x18U; }
    return MC_OK;
}
static int uart_write(void *ctx, const uint8_t *data, size_t length, uint32_t timeout)
{ (void)ctx; (void)timeout; ++uart_calls; memcpy(echo, data, length); return MC_OK; }
static int uart_read(void *ctx, uint8_t *data, size_t length, uint32_t timeout)
{ (void)ctx; (void)timeout; memcpy(data, echo, length); return echo_error ? MC_ERR_TIMEOUT : MC_OK; }
static int i2c_write(void *ctx, uint8_t addr, uint16_t mem, const uint8_t *data, size_t length, uint32_t timeout)
{ (void)ctx; (void)addr; (void)mem; (void)timeout; ++i2c_calls; memcpy(eeprom, data, length); return MC_OK; }
static int i2c_read(void *ctx, uint8_t addr, uint16_t mem, uint8_t *data, size_t length, uint32_t timeout)
{ (void)ctx; (void)addr; (void)mem; (void)timeout; memcpy(data, eeprom, length); return MC_OK; }
static int can_send(void *ctx, uint32_t id, const uint8_t *data, size_t length, uint32_t timeout)
{ (void)ctx; (void)id; (void)timeout; ++can_calls; memcpy(echo, data, length); return MC_OK; }
static int can_receive(void *ctx, uint32_t *id, uint8_t *data, size_t *length, uint32_t timeout)
{ (void)ctx; (void)timeout; *id = 0x321U; *length = 8U; memcpy(data, echo, 8U); return MC_OK; }
static int partial(void *ctx, uint8_t value, uint8_t bits)
{ (void)ctx; (void)value; (void)bits; ++fault_calls; return MC_OK; }
static int log_text(void *ctx, const char *text, size_t length)
{ (void)ctx; return HAL_UART_Transmit(&huart1, (uint8_t *)(uintptr_t)text, (uint16_t)length, 100U) == HAL_OK ? MC_OK : MC_ERR_IO; }
mc_platform_t mc_stm32f407_make_platform(mc_stm32f407_context_t *ctx)
{
    mc_platform_t port;
    memset(&port, 0, sizeof(port)); port.context = ctx; port.write_log = log_text;
    port.spi_select = select_spi; port.spi_transfer = transfer_spi;
    port.uart_write = uart_write; port.uart_read = uart_read;
    port.i2c_mem_write = i2c_write; port.i2c_mem_read = i2c_read;
    port.can_send = can_send; port.can_receive = can_receive; port.spi_emit_incomplete = partial;
    return port;
}
static int begin(void *ctx, mc_can_mode_t mode) { (void)ctx; (void)mode; return MC_OK; }
static int submit(void *ctx, mc_can_mode_t mode, uint32_t bitrate, const uint8_t tx[8])
{ (void)ctx; (void)mode; (void)bitrate; (void)tx; ++submits; return MC_OK; }
static int poll_tx(void *ctx, mc_can_evidence_t *evidence)
{ (void)ctx; (void)evidence; return keep_pending ? MC_CAN_PENDING : MC_OK; }
static int restore(void *ctx) { (void)ctx; return restore_error ? MC_ERR_IO : MC_OK; }
static int cancel(void *ctx, mc_can_evidence_t *evidence) { (void)ctx; (void)evidence; return MC_OK; }
static int poll_rx(void *ctx, uint8_t rx[8], mc_can_evidence_t *evidence)
{ (void)ctx; (void)rx; (void)evidence; return MC_CAN_PENDING; }
static int record(void *ctx, const mc_can_frame_t *frame) { (void)ctx; (void)frame; return MC_OK; }
static mc_can_session_port_t session_port(void)
{
    mc_can_session_port_t port;
    memset(&port, 0, sizeof(port)); port.begin = begin; port.submit = submit;
    port.poll_tx = poll_tx; port.poll_rx = poll_rx; port.record = record;
    port.cancel = cancel; port.restore = restore;
    return port;
}
mc_can_session_port_t mc_can_session_hal_port(mc_can_session_hal_t *ctx, CAN_HandleTypeDef *can, UART_HandleTypeDef *uart)
{ (void)ctx; (void)can; (void)uart; return session_port(); }
mc_can_session_port_t mc_can_raw_hal_port(mc_can_raw_hal_t *ctx, CAN_HandleTypeDef *can, UART_HandleTypeDef *uart)
{ (void)ctx; (void)can; (void)uart; return session_port(); }
mc_can_session_port_t mc_can_live_hal_port(mc_can_live_hal_t *ctx, CAN_HandleTypeDef *can, UART_HandleTypeDef *uart)
{ (void)ctx; (void)can; (void)uart; return session_port(); }

static void hold(void)
{
    key = GPIO_PIN_SET; mc_board_app_poll();
    ticks += MC_BUTTON_DEBOUNCE_MS; mc_board_app_poll();
    ticks += 800U; mc_board_app_poll();
    ticks += 3000U; mc_board_app_poll(); /* same hold must not repeat */
    key = GPIO_PIN_RESET; mc_board_app_poll();
    ticks += MC_BUTTON_DEBOUNCE_MS; mc_board_app_poll();
}
static void tap(void)
{
    key = GPIO_PIN_SET; mc_board_app_poll();
    ticks += MC_BUTTON_DEBOUNCE_MS; mc_board_app_poll();
    ticks += 30U; key = GPIO_PIN_RESET; mc_board_app_poll();
    ticks += MC_BUTTON_DEBOUNCE_MS; mc_board_app_poll();
}
static void normal(mc_ui_protocol_t protocol, unsigned int index)
{
    g_menu.protocol = protocol; g_menu.item = index; g_menu.in_submenu = 1U;
    hold();
}

int main(void)
{
    unsigned int baseline;
    mc_board_app_init();
    CHECK(strcmp(rows[0], "PROTOCOL SELECT") == 0);
    baseline = spi_calls; /* startup probe is intentionally unchanged */
    hold(); CHECK(g_menu.in_submenu && spi_calls == baseline && !g_normal_runs);
    hold(); CHECK(spi_calls == baseline + 1U && g_normal_runs == 1U && !g_fault_runs);
    CHECK(strstr(rows[6], "LOCAL OK") != NULL && led == GPIO_PIN_SET);
    normal(MC_UI_SPI, 1U); CHECK(spi_calls == baseline + 2U);
    normal(MC_UI_UART, 0U); CHECK(uart_calls == 1U && g_last_fault_result == MC_OK);
    echo_error = 1; normal(MC_UI_UART, 0U);
    CHECK(uart_calls == 2U && g_last_fault_result == MC_ERR_TIMEOUT && led == GPIO_PIN_RESET);
    CHECK(strstr(rows[6], "LOCAL ERROR") != NULL); echo_error = 0;
    normal(MC_UI_I2C, 0U); CHECK(i2c_calls == 1U && g_last_fault_result == MC_OK);
    normal(MC_UI_CAN, 1U); CHECK(can_calls == 1U && g_last_fault_result == MC_OK);
    normal(MC_UI_CAN, 0U);
    CHECK(submits == 1U && g_can_session.state == MC_CAN_DONE && !g_can_session.held && g_can_view);
    tap(); CHECK(!g_can_view && g_menu.protocol == MC_UI_CAN && g_menu.item == 0U);
    CHECK(g_last_fault_result == MC_OK && g_normal_runs == 7U);
    g_menu.item = mc_ui_menu_count(MC_UI_CAN) - 1U;
    hold(); CHECK(!g_menu.in_submenu && submits == 1U && !g_fault_runs);
    tap(); CHECK(g_menu.protocol == MC_UI_SPI && !g_menu.in_submenu);
    /* Original CLI selection/run must still use frozen index 0, even after normal selection. */
    run_command("fault select 0"); CHECK(g_menu.in_submenu && g_menu.item == 2U);
    g_menu.item = 0U;
    run_command("fault run"); CHECK(fault_calls == 1U && g_fault_runs == 1U && g_menu.item == 2U);
    run_command("fault run 0"); CHECK(fault_calls == 2U && g_fault_runs == 2U);
    /* Whole-line queued CLI input still works, without per-character TX. */
    {
        const char *commands = "spi pattern 1\nuart loop 1\n";
        while (*commands) { (void)mc_cli_rx_push(&g_console_rx, (uint8_t)*commands++); }
        mc_board_app_poll();
        CHECK(spi_calls == baseline + 3U && uart_calls == 3U);
    }
    /* A held CAN session blocks every normal menu action; failed restore stays held. */
    keep_pending = 1;
    g_menu.protocol = MC_UI_CAN; g_menu.item = 0U; g_menu.in_submenu = 1U;
    confirm_menu();
    g_can_session.config.timeout_ms = 10000U; /* keep the mock in flight for stop/retry testing */
    mc_board_app_poll();
    CHECK(g_can_session.state == MC_CAN_RUNNING && submits == 2U);
    g_menu.protocol = MC_UI_SPI; g_menu.item = 1U;
    baseline = spi_calls; confirm_menu(); CHECK(spi_calls == baseline);
    restore_error = 1; hold(); CHECK(g_can_session.held && g_can_session.state != MC_CAN_RUNNING);
    tap(); CHECK(g_can_view && g_can_session.held);
    hold(); CHECK(g_can_session.held); /* failed retry cannot unlock other tests */
    restore_error = 0; hold(); CHECK(!g_can_session.held);
    tap(); CHECK(!g_can_view);
    /* A failed JEDEC re-probe must not show the previous success. */
    g_jedec_id_valid = 0; probe_error = 1; normal(MC_UI_SPI, 0U);
    CHECK(g_last_fault_result != MC_OK && g_has_fault_result && led == GPIO_PIN_RESET);
    keep_pending = 0;
#if MC_BUILD_CAN_RAW_GPIO
    run_command("fault select 16"); hold();
    CHECK(g_can_backend == 1 && g_can_view && g_raw_session.config.mode == MC_CAN_RAW_STUFF);
    CHECK(g_raw_session.state != MC_CAN_RUNNING && !g_raw_session.held);
    tap(); CHECK(!g_can_view && g_menu.protocol == MC_UI_CAN);
#endif
#if MC_BUILD_CAN_LIVE
    run_command("fault select 15"); hold();
    CHECK(g_can_backend == 2 && g_can_view && g_live_session.config.mode == MC_CAN_LIVE_BIT);
    CHECK(g_live_session.state != MC_CAN_RUNNING && !g_live_session.held);
    tap(); CHECK(!g_can_view && g_menu.protocol == MC_UI_CAN);
#endif
    puts("Actual board app: one-shot dispatch, navigation, results, CLI and CAN ownership PASS (mock I/O)");
    return 0;
}

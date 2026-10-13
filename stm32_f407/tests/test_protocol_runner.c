#include "mc_protocol_runner.h"
#include "mc_faults.h"
#include "mc_cli_rx.h"

#include <stdio.h>
#include <string.h>

#define CHECK(expr) do { \
    if (!(expr)) { \
        fprintf(stderr, "check failed: %s:%d: %s\n", __FILE__, __LINE__, #expr); \
        return 1; \
    } \
} while (0)

typedef struct {
    uint32_t tick;
    int spi_selected;
    uint8_t uart_data[16];
    size_t uart_length;
    uint8_t eeprom[512];
    uint32_t can_id;
    uint8_t can_data[8];
    size_t can_length;
    char log[8192];
    size_t log_length;
    size_t last_spi_length;
    size_t last_uart_length;
    uint32_t uart_baudrate;
    uint32_t partial_count;
    uint32_t bad_stop_count;
    uint32_t break_count;
    uint32_t i2c_busy_probes;
    uint8_t jedec_id[3];
    int log_fail;
    int spi_error;
} fake_t;

static uint32_t fake_now(void *opaque)
{
    return ++((fake_t *)opaque)->tick;
}

static int fake_log(void *opaque, const char *text, size_t length)
{
    fake_t *fake = (fake_t *)opaque;
    if (fake->log_fail) {
        return MC_ERR_IO;
    }
    if (fake->log_length + length >= sizeof(fake->log)) {
        return MC_ERR_IO;
    }
    memcpy(fake->log + fake->log_length, text, length);
    fake->log_length += length;
    fake->log[fake->log_length] = '\0';
    return MC_OK;
}

static int fake_spi_select(void *opaque, int selected)
{
    ((fake_t *)opaque)->spi_selected = selected;
    return MC_OK;
}

static int fake_spi_transfer(void *opaque,
                             const uint8_t *tx,
                             uint8_t *rx,
                             size_t length,
                             uint32_t timeout_ms)
{
    fake_t *fake = (fake_t *)opaque;
    (void)timeout_ms;
    if (!fake->spi_selected || tx == NULL || rx == NULL || length == 0U) {
        return MC_ERR_IO;
    }
    if (fake->spi_error != 0) {
        return fake->spi_error;
    }
    memset(rx, 0, length);
    fake->last_spi_length = length;
    if (length == 4U && tx[0] == 0x9FU && tx[1] == 0U && tx[2] == 0U && tx[3] == 0U) {
        memcpy(&rx[1], fake->jedec_id, 3U);
    }
    return MC_OK;
}

static int fake_uart_write(void *opaque,
                           const uint8_t *data,
                           size_t length,
                           uint32_t timeout_ms)
{
    fake_t *fake = (fake_t *)opaque;
    (void)timeout_ms;
    if (length > sizeof(fake->uart_data)) {
        return MC_ERR_ARGUMENT;
    }
    memcpy(fake->uart_data, data, length);
    fake->uart_length = length;
    fake->last_uart_length = length;
    return MC_OK;
}

static int fake_uart_read(void *opaque, uint8_t *data, size_t length, uint32_t timeout_ms)
{
    fake_t *fake = (fake_t *)opaque;
    (void)timeout_ms;
    if (length != fake->uart_length) {
        return MC_ERR_TIMEOUT;
    }
    memcpy(data, fake->uart_data, length);
    return MC_OK;
}

static int fake_i2c_write(void *opaque,
                          uint8_t address,
                          uint16_t memory_address,
                          const uint8_t *data,
                          size_t length,
                          uint32_t timeout_ms)
{
    fake_t *fake = (fake_t *)opaque;
    (void)timeout_ms;
    if (address != 0x50U || memory_address + length > sizeof(fake->eeprom)) {
        return MC_ERR_IO;
    }
    memcpy(&fake->eeprom[memory_address], data, length);
    if (memory_address == 0x0120U) {
        fake->i2c_busy_probes = 2U;
    }
    return MC_OK;
}

static int fake_i2c_read(void *opaque,
                         uint8_t address,
                         uint16_t memory_address,
                         uint8_t *data,
                         size_t length,
                         uint32_t timeout_ms)
{
    fake_t *fake = (fake_t *)opaque;
    (void)timeout_ms;
    if (address != 0x50U || memory_address + length > sizeof(fake->eeprom)) {
        return MC_ERR_IO;
    }
    memcpy(data, &fake->eeprom[memory_address], length);
    return MC_OK;
}

static int fake_i2c_probe(void *opaque, uint8_t address, uint32_t timeout_ms)
{
    fake_t *fake = (fake_t *)opaque;
    (void)timeout_ms;
    if (address == 0x50U && fake->i2c_busy_probes > 0U) {
        --fake->i2c_busy_probes;
        return MC_ERR_TIMEOUT;
    }
    return address == 0x50U ? MC_OK : MC_ERR_TIMEOUT;
}

static int fake_spi_partial(void *opaque, uint8_t value, uint8_t valid_bits)
{
    fake_t *fake = (fake_t *)opaque;
    if (value != 0x9FU || valid_bits != 4U) {
        return MC_ERR_VERIFY;
    }
    fake->partial_count++;
    return MC_OK;
}

static int fake_uart_bad_stop(void *opaque, uint8_t value, uint32_t baudrate)
{
    fake_t *fake = (fake_t *)opaque;
    if (value != 0x55U || baudrate != 115200U) {
        return MC_ERR_VERIFY;
    }
    fake->bad_stop_count++;
    return MC_OK;
}

static int fake_uart_break(void *opaque, uint32_t bits, uint32_t baudrate)
{
    fake_t *fake = (fake_t *)opaque;
    if (bits != 13U || baudrate != 115200U) {
        return MC_ERR_VERIFY;
    }
    fake->break_count++;
    return MC_OK;
}

static int fake_uart_baud(void *opaque, uint32_t baudrate)
{
    ((fake_t *)opaque)->uart_baudrate = baudrate;
    return MC_OK;
}

static int fake_can_ack_probe(void *opaque, uint32_t id, uint32_t timeout_ms)
{
    fake_t *fake = (fake_t *)opaque;
    (void)timeout_ms;
    fake->can_id = id;
    return id == 0x321U ? MC_OK : MC_ERR_VERIFY;
}

static int fake_can_send(void *opaque,
                         uint32_t id,
                         const uint8_t *data,
                         size_t length,
                         uint32_t timeout_ms)
{
    fake_t *fake = (fake_t *)opaque;
    (void)timeout_ms;
    if (length > sizeof(fake->can_data)) {
        return MC_ERR_ARGUMENT;
    }
    fake->can_id = id;
    fake->can_length = length;
    memcpy(fake->can_data, data, length);
    return MC_OK;
}

static int fake_can_receive(void *opaque,
                            uint32_t *id,
                            uint8_t *data,
                            size_t *length,
                            uint32_t timeout_ms)
{
    fake_t *fake = (fake_t *)opaque;
    (void)timeout_ms;
    if (*length < fake->can_length) {
        return MC_ERR_ARGUMENT;
    }
    *id = fake->can_id;
    *length = fake->can_length;
    memcpy(data, fake->can_data, fake->can_length);
    return MC_OK;
}

static mc_platform_t make_platform(fake_t *fake)
{
    mc_platform_t platform;
    memset(&platform, 0, sizeof(platform));
    platform.context = fake;
    platform.now_ms = fake_now;
    platform.write_log = fake_log;
    platform.spi_select = fake_spi_select;
    platform.spi_transfer = fake_spi_transfer;
    platform.uart_write = fake_uart_write;
    platform.uart_read = fake_uart_read;
    platform.i2c_mem_write = fake_i2c_write;
    platform.i2c_mem_read = fake_i2c_read;
    platform.i2c_probe = fake_i2c_probe;
    platform.can_send = fake_can_send;
    platform.can_receive = fake_can_receive;
    platform.spi_emit_incomplete = fake_spi_partial;
    platform.uart_emit_bad_stop = fake_uart_bad_stop;
    platform.uart_emit_break = fake_uart_break;
    platform.uart_set_baudrate = fake_uart_baud;
    platform.can_ack_probe = fake_can_ack_probe;
    return platform;
}

int main(void)
{
    fake_t fake;
    mc_platform_t platform;
    mc_runner_t runner;
    mc_run_summary_t summary;
    const uint8_t actual_jedec_id[3] = {0xEFU, 0x40U, 0x18U};
    uint8_t observed_id[3] = {0U};
    mc_cli_rx_t queue;
    const char *burst = "spi jedec 100\r";
    char recovered[32] = {0};
    size_t i;
    uint8_t value;

    memset(&fake, 0, sizeof(fake));
    memcpy(fake.jedec_id, actual_jedec_id, 3U);
    platform = make_platform(&fake);
    mc_runner_init(&runner, &platform);

    CHECK(mc_probe_spi_jedec(&runner, 1000U, observed_id) == MC_OK);
    CHECK(memcmp(observed_id, actual_jedec_id, 3U) == 0);
    CHECK(strstr(fake.log, "\"tx\":\"9F000000\"") != NULL);
    CHECK(strstr(fake.log, "\"data\":\"00EF4018\"") != NULL);
    CHECK(mc_run_spi_jedec(&runner, 1001U, 3U, actual_jedec_id, &summary) == MC_OK);
    CHECK(summary.passed == 3U && summary.failed == 0U);
    CHECK(mc_run_spi_patterns(&runner, 1002U, 2U, &summary) == MC_OK);
    CHECK(mc_run_uart_loopback(&runner, 2001U, 2U, &summary) == MC_OK);
    CHECK(mc_run_i2c_eeprom(&runner, 3001U, 0x50U, 0x0100U, 2U, &summary) == MC_OK);
    CHECK(mc_run_can_loopback(&runner, 4001U, 0x321U, 2U, &summary) == MC_OK);
    CHECK(mc_fault_get(MC_FAULT_SPI_PARTIAL)->case_id == 1091U);
    CHECK(mc_fault_get(MC_FAULT_CAN_CRC)->requirement == MC_FAULT_EXTERNAL_ONLY);
    CHECK(mc_fault_run(&runner, MC_FAULT_SPI_PARTIAL) == MC_OK);
    CHECK(fake.partial_count == 1U);
    CHECK(mc_fault_run(&runner, MC_FAULT_SPI_SHORT) == MC_OK);
    CHECK(fake.last_spi_length == 2U);
    CHECK(mc_fault_run(&runner, MC_FAULT_SPI_EXTRA) == MC_OK);
    CHECK(fake.last_spi_length == 5U);
    CHECK(mc_fault_run(&runner, MC_FAULT_UART_BAD_STOP) == MC_OK);
    CHECK(fake.bad_stop_count == 1U);
    CHECK(mc_fault_run(&runner, MC_FAULT_UART_BREAK) == MC_OK);
    CHECK(fake.break_count == 1U);
    CHECK(mc_fault_run(&runner, MC_FAULT_UART_BAUD_MISMATCH) == MC_OK);
    CHECK(fake.uart_baudrate == 115200U);
    CHECK(mc_fault_run(&runner, MC_FAULT_UART_MISSING_BYTES) == MC_OK);
    CHECK(fake.last_uart_length == 3U);
    CHECK(mc_fault_run(&runner, MC_FAULT_I2C_ADDRESS_NACK) == MC_OK);
    CHECK(mc_fault_run(&runner, MC_FAULT_I2C_BUSY_NACK) == MC_OK);
    CHECK(mc_fault_run(&runner, MC_FAULT_CAN_NO_ACK) == MC_OK);
    CHECK(fake.can_id == 0x321U);
    CHECK(mc_fault_run(&runner, MC_FAULT_CAN_CRC) == MC_ERR_UNSUPPORTED);
    CHECK(strstr(fake.log, "\"protocol\":\"SPI\"") != NULL);
    CHECK(strstr(fake.log, "\"protocol\":\"CAN\"") != NULL);
    CHECK(strstr(fake.log, "\"result\":0") != NULL);
    CHECK(strstr(fake.log, "\"case\":1091") != NULL);
    CHECK(strstr(fake.log, "\"case\":3092") != NULL);
    CHECK(strstr(fake.log, "\"tx\":\"9F00\"") != NULL);

    mc_cli_rx_init(&queue);
    for (i = 0U; i < strlen(burst); ++i) {
        CHECK(mc_cli_rx_push(&queue, (uint8_t)burst[i]) == 1);
    }
    for (i = 0U; i < strlen(burst); ++i) {
        CHECK(mc_cli_rx_pop(&queue, &value) == 1);
        recovered[i] = (char)value;
    }
    CHECK(strcmp(recovered, burst) == 0);
    CHECK(mc_cli_rx_pop(&queue, &value) == 0);

    memset(fake.jedec_id, 0xFF, 3U);
    CHECK(mc_probe_spi_jedec(&runner, 1000U, observed_id) == MC_ERR_VERIFY);
    memset(fake.jedec_id, 0x00, 3U);
    CHECK(mc_probe_spi_jedec(&runner, 1000U, observed_id) == MC_ERR_VERIFY);
    memcpy(fake.jedec_id, actual_jedec_id, 3U);
    fake.spi_error = MC_ERR_TIMEOUT;
    CHECK(mc_probe_spi_jedec(&runner, 1000U, observed_id) == MC_ERR_TIMEOUT);
    fake.spi_error = MC_OK;
    fake.log_fail = 1;
    CHECK(mc_probe_spi_jedec(&runner, 1000U, observed_id) == MC_ERR_IO);

    puts("STM32F407 protocol runner tests passed");
    return 0;
}

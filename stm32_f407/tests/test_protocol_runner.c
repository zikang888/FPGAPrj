#include "mc_protocol_runner.h"
#include "mc_truth_log.h"

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
    int spi_deselect_count;
    int spi_fail;
    int log_fail;
    uint8_t jedec_id[3];
    uint8_t uart_data[16];
    size_t uart_length;
    uint8_t eeprom[512];
    uint32_t can_id;
    uint8_t can_data[8];
    size_t can_length;
    char log[8192];
    size_t log_length;
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
    fake_t *fake = (fake_t *)opaque;
    fake->spi_selected = selected;
    if (!selected) fake->spi_deselect_count++;
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
    if (fake->spi_fail) return MC_ERR_TIMEOUT;
    memset(rx, 0, length);
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
    (void)opaque;
    (void)timeout_ms;
    return address == 0x50U ? MC_OK : MC_ERR_TIMEOUT;
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
    return platform;
}

int main(void)
{
    fake_t fake;
    mc_platform_t platform;
    mc_runner_t runner;
    mc_run_summary_t summary;
    const uint8_t actual_jedec_id[3] = {0xEFU, 0x40U, 0x18U};
    uint8_t observed_id[3] = {0U, 0U, 0U};

    memset(&fake, 0, sizeof(fake));
    memcpy(fake.jedec_id, actual_jedec_id, 3U);
    platform = make_platform(&fake);
    mc_runner_init(&runner, &platform);

    CHECK(mc_probe_spi_jedec(&runner, 1001U, observed_id) == MC_OK);
    CHECK(memcmp(observed_id, actual_jedec_id, 3U) == 0);
    CHECK(fake.spi_selected == 0 && fake.spi_deselect_count == 1);
    CHECK(strstr(fake.log, "\"tx\":\"9F000000\"") != NULL);
    CHECK(strstr(fake.log, "\"data\":\"00EF4018\"") != NULL);

    memset(fake.jedec_id, 0xFF, 3U);
    CHECK(mc_probe_spi_jedec(&runner, 1001U, observed_id) == MC_ERR_VERIFY);
    CHECK(memcmp(observed_id, actual_jedec_id, 3U) == 0);
    CHECK(fake.spi_selected == 0);
    memset(fake.jedec_id, 0x00, 3U);
    CHECK(mc_probe_spi_jedec(&runner, 1001U, observed_id) == MC_ERR_VERIFY);
    CHECK(memcmp(observed_id, actual_jedec_id, 3U) == 0);
    memcpy(fake.jedec_id, actual_jedec_id, 3U);

    fake.spi_fail = 1;
    CHECK(mc_probe_spi_jedec(&runner, 1001U, observed_id) == MC_ERR_TIMEOUT);
    CHECK(fake.spi_selected == 0);
    fake.spi_fail = 0;

    fake.log_fail = 1;
    CHECK(mc_probe_spi_jedec(&runner, 1001U, observed_id) == MC_ERR_IO);
    CHECK(mc_run_spi_jedec(&runner, 1001U, 1U, actual_jedec_id,
                           &summary) == MC_ERR_IO);
    CHECK(summary.failed == 1U && summary.first_error == MC_ERR_IO);
    fake.log_fail = 0;

    {
        mc_log_record_t invalid_record;
        memset(&invalid_record, 0, sizeof(invalid_record));
        invalid_record.protocol = "SPI";
        invalid_record.operation = "TEST";
        invalid_record.direction = "TXRX";
        invalid_record.detail = "test";
        invalid_record.data_length = 1U;
        CHECK(mc_truth_log_write(&platform, &invalid_record) == MC_ERR_ARGUMENT);
    }

    CHECK(mc_run_spi_jedec(&runner, 1001U, 3U, actual_jedec_id, &summary) == MC_OK);
    CHECK(summary.passed == 3U && summary.failed == 0U);
    fake.jedec_id[2] ^= 0x01U;
    CHECK(mc_run_spi_jedec(&runner, 1001U, 1U, actual_jedec_id,
                           &summary) == MC_ERR_VERIFY);
    CHECK(summary.failed == 1U && summary.first_error == MC_ERR_VERIFY);
    memcpy(fake.jedec_id, actual_jedec_id, 3U);
    CHECK(mc_run_spi_patterns(&runner, 1002U, 2U, &summary) == MC_OK);
    CHECK(mc_run_uart_loopback(&runner, 2001U, 2U, &summary) == MC_OK);
    CHECK(mc_run_i2c_eeprom(&runner, 3001U, 0x50U, 0x0100U, 2U, &summary) == MC_OK);
    CHECK(mc_run_can_loopback(&runner, 4001U, 0x321U, 2U, &summary) == MC_OK);
    CHECK(strstr(fake.log, "\"protocol\":\"SPI\"") != NULL);
    CHECK(strstr(fake.log, "\"protocol\":\"CAN\"") != NULL);
    CHECK(strstr(fake.log, "\"result\":0") != NULL);

    puts("STM32F407 protocol runner tests passed");
    return 0;
}

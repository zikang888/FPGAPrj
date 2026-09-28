#include "mc_protocol_runner.h"
#include "mc_truth_log.h"

#include <string.h>

#define MC_IO_TIMEOUT_MS 100U
#define MC_EEPROM_PAGE_SIZE 64U

static const uint8_t k_patterns[] = {0x00U, 0xFFU, 0x55U, 0xAAU};

static void summary_init(mc_run_summary_t *summary, uint32_t iterations)
{
    if (summary != NULL) {
        memset(summary, 0, sizeof(*summary));
        summary->iterations = iterations;
        summary->first_failed_iteration = UINT32_MAX;
    }
}

static void summary_record(mc_run_summary_t *summary, uint32_t iteration, int result)
{
    if (summary == NULL) {
        return;
    }
    if (result == MC_OK) {
        summary->passed++;
    } else {
        summary->failed++;
        if (summary->first_failed_iteration == UINT32_MAX) {
            summary->first_failed_iteration = iteration;
            summary->first_error = result;
        }
    }
}

static int pulse_sync(mc_runner_t *runner, uint32_t case_id)
{
    if (runner->platform.sync_pulse == NULL) {
        return MC_OK;
    }
    return runner->platform.sync_pulse(runner->platform.context, case_id);
}

static int write_record(mc_runner_t *runner,
                        uint32_t case_id,
                        uint32_t transaction_id,
                        const char *protocol,
                        const char *operation,
                        const char *direction,
                        const uint8_t *data,
                        size_t data_length,
                        int result,
                        const char *detail)
{
    mc_log_record_t record;

    memset(&record, 0, sizeof(record));
    record.sequence = runner->next_sequence++;
    record.case_id = case_id;
    record.transaction_id = transaction_id;
    record.protocol = protocol;
    record.operation = operation;
    record.direction = direction;
    record.data = data;
    record.data_length = data_length;
    record.result = result;
    record.detail = detail;
    return mc_truth_log_write(&runner->platform, &record);
}

static int write_spi_record(mc_runner_t *runner,
                            uint32_t case_id,
                            uint32_t transaction_id,
                            const char *operation,
                            const uint8_t *tx,
                            const uint8_t *rx,
                            size_t length,
                            int result,
                            const char *detail)
{
    mc_log_record_t record;

    memset(&record, 0, sizeof(record));
    record.sequence = runner->next_sequence++;
    record.case_id = case_id;
    record.transaction_id = transaction_id;
    record.protocol = "SPI";
    record.operation = operation;
    record.direction = "TXRX";
    record.data = rx;
    record.data_length = length;
    record.tx_data = tx;
    record.tx_length = length;
    record.result = result;
    record.detail = detail;
    return mc_truth_log_write(&runner->platform, &record);
}

static int spi_transfer_once(mc_runner_t *runner,
                             uint32_t case_id,
                             const uint8_t *tx,
                             uint8_t *rx,
                             size_t length)
{
    int result = pulse_sync(runner, case_id);
    int deselect_result;

    if (result == MC_OK) {
        result = runner->platform.spi_select(runner->platform.context, 1);
    }
    if (result == MC_OK) {
        result = runner->platform.spi_transfer(runner->platform.context,
                                               tx, rx, length,
                                               MC_IO_TIMEOUT_MS);
    }
    deselect_result = runner->platform.spi_select(runner->platform.context, 0);
    if (result == MC_OK && deselect_result != MC_OK) {
        result = deselect_result;
    }
    return result;
}

void mc_runner_init(mc_runner_t *runner, const mc_platform_t *platform)
{
    if (runner == NULL || platform == NULL) {
        return;
    }
    memset(runner, 0, sizeof(*runner));
    runner->platform = *platform;
    runner->next_sequence = 1U;
    runner->next_transaction_id = 1U;
}

int mc_probe_spi_jedec(mc_runner_t *runner,
                       uint32_t case_id,
                       uint8_t id_out[3])
{
    const uint8_t tx[4] = {0x9FU, 0x00U, 0x00U, 0x00U};
    uint8_t rx[4] = {0U, 0U, 0U, 0U};
    uint32_t transaction_id;
    int result;
    int log_result;

    if (runner == NULL || id_out == NULL ||
        runner->platform.spi_select == NULL ||
        runner->platform.spi_transfer == NULL) {
        return MC_ERR_ARGUMENT;
    }
    transaction_id = runner->next_transaction_id++;
    result = spi_transfer_once(runner, case_id, tx, rx, sizeof(tx));
    if (result == MC_OK &&
        ((rx[1] == 0U && rx[2] == 0U && rx[3] == 0U) ||
         (rx[1] == 0xFFU && rx[2] == 0xFFU && rx[3] == 0xFFU))) {
        result = MC_ERR_VERIFY;
    }
    log_result = write_spi_record(runner, case_id, transaction_id,
                                  "JEDEC_PROBE", tx, rx, sizeof(tx), result,
                                  result == MC_OK ? "id_observed" : "check_wiring_or_flash");
    if (result == MC_OK && log_result != MC_OK) {
        result = log_result;
    }
    if (result == MC_OK) {
        memcpy(id_out, &rx[1], 3U);
    }
    return result;
}

int mc_run_spi_jedec(mc_runner_t *runner,
                     uint32_t case_id,
                     uint32_t iterations,
                     const uint8_t expected_id[3],
                     mc_run_summary_t *summary)
{
    uint32_t iteration;
    int overall = MC_OK;

    if (runner == NULL || iterations == 0U || expected_id == NULL ||
        runner->platform.spi_select == NULL || runner->platform.spi_transfer == NULL) {
        return MC_ERR_ARGUMENT;
    }

    summary_init(summary, iterations);
    for (iteration = 0U; iteration < iterations; ++iteration) {
        const uint8_t tx[4] = {0x9FU, 0x00U, 0x00U, 0x00U};
        uint8_t rx[4] = {0U, 0U, 0U, 0U};
        uint32_t transaction_id = runner->next_transaction_id++;
        int result = spi_transfer_once(runner, case_id, tx, rx, sizeof(tx));
        int log_result;
        if (result == MC_OK && memcmp(&rx[1], expected_id, 3U) != 0) {
            result = MC_ERR_VERIFY;
        }

        log_result = write_spi_record(runner, case_id, transaction_id,
                                      "JEDEC_ID", tx, rx, sizeof(tx), result,
                                      result == MC_OK ? "matched" : "io_or_id_mismatch");
        if (result == MC_OK && log_result != MC_OK) result = log_result;
        summary_record(summary, iteration, result);
        if (result != MC_OK) {
            overall = result;
        }
    }
    return overall;
}

int mc_run_spi_patterns(mc_runner_t *runner,
                        uint32_t case_id,
                        uint32_t iterations,
                        mc_run_summary_t *summary)
{
    uint32_t iteration;
    int overall = MC_OK;

    if (runner == NULL || iterations == 0U || runner->platform.spi_select == NULL ||
        runner->platform.spi_transfer == NULL) {
        return MC_ERR_ARGUMENT;
    }

    summary_init(summary, iterations);
    for (iteration = 0U; iteration < iterations; ++iteration) {
        uint8_t tx[sizeof(k_patterns)];
        uint8_t rx[sizeof(k_patterns)] = {0U};
        uint32_t transaction_id = runner->next_transaction_id++;
        size_t index;
        int result;

        for (index = 0U; index < sizeof(tx); ++index) {
            tx[index] = (uint8_t)(k_patterns[index] ^ (uint8_t)iteration);
        }
        result = spi_transfer_once(runner, case_id, tx, rx, sizeof(tx));
        {
            int log_result = write_spi_record(runner, case_id, transaction_id,
                                              "PATTERN", tx, rx, sizeof(tx),
                                              result,
                                              result == MC_OK ? "transferred" : "io_error");
            if (result == MC_OK && log_result != MC_OK) result = log_result;
        }
        summary_record(summary, iteration, result);
        if (result != MC_OK) {
            overall = result;
        }
    }
    return overall;
}

int mc_run_uart_loopback(mc_runner_t *runner,
                         uint32_t case_id,
                         uint32_t iterations,
                         mc_run_summary_t *summary)
{
    uint32_t iteration;
    int overall = MC_OK;

    if (runner == NULL || iterations == 0U || runner->platform.uart_write == NULL ||
        runner->platform.uart_read == NULL) {
        return MC_ERR_ARGUMENT;
    }

    summary_init(summary, iterations);
    for (iteration = 0U; iteration < iterations; ++iteration) {
        uint8_t tx[8];
        uint8_t rx[8] = {0U};
        uint32_t transaction_id = runner->next_transaction_id++;
        size_t index;
        int result = pulse_sync(runner, case_id);

        for (index = 0U; index < sizeof(tx); ++index) {
            tx[index] = (uint8_t)(iteration + (uint32_t)index);
        }
        if (result == MC_OK) {
            result = runner->platform.uart_write(runner->platform.context, tx, sizeof(tx),
                                                 MC_IO_TIMEOUT_MS);
        }
        if (result == MC_OK) {
            result = runner->platform.uart_read(runner->platform.context, rx, sizeof(rx),
                                                MC_IO_TIMEOUT_MS);
        }
        if (result == MC_OK && memcmp(tx, rx, sizeof(tx)) != 0) {
            result = MC_ERR_VERIFY;
        }
        {
            int log_result = write_record(runner, case_id, transaction_id,
                                          "UART", "LOOPBACK", "TXRX", rx,
                                          sizeof(rx), result,
                                          result == MC_OK ? "matched" : "timeout_or_mismatch");
            if (result == MC_OK && log_result != MC_OK) result = log_result;
        }
        summary_record(summary, iteration, result);
        if (result != MC_OK) {
            overall = result;
        }
    }
    return overall;
}

int mc_run_i2c_eeprom(mc_runner_t *runner,
                      uint32_t case_id,
                      uint8_t address_7bit,
                      uint16_t memory_address,
                      uint32_t iterations,
                      mc_run_summary_t *summary)
{
    uint32_t iteration;
    int overall = MC_OK;

    if (runner == NULL || iterations == 0U || address_7bit > 0x7FU ||
        runner->platform.i2c_mem_write == NULL || runner->platform.i2c_mem_read == NULL) {
        return MC_ERR_ARGUMENT;
    }

    summary_init(summary, iterations);
    for (iteration = 0U; iteration < iterations; ++iteration) {
        uint8_t tx[16];
        uint8_t rx[16] = {0U};
        uint16_t address = (uint16_t)(memory_address +
                           (uint16_t)((iteration * sizeof(tx)) % MC_EEPROM_PAGE_SIZE));
        uint32_t transaction_id = runner->next_transaction_id++;
        size_t index;
        int result = pulse_sync(runner, case_id);

        for (index = 0U; index < sizeof(tx); ++index) {
            tx[index] = (uint8_t)(case_id ^ iteration ^ (uint32_t)index);
        }
        if (result == MC_OK) {
            result = runner->platform.i2c_mem_write(runner->platform.context,
                                                    address_7bit,
                                                    address,
                                                    tx,
                                                    sizeof(tx),
                                                    MC_IO_TIMEOUT_MS);
        }
        if (result == MC_OK && runner->platform.i2c_probe != NULL) {
            result = runner->platform.i2c_probe(runner->platform.context,
                                                address_7bit,
                                                MC_IO_TIMEOUT_MS);
        }
        if (result == MC_OK) {
            result = runner->platform.i2c_mem_read(runner->platform.context,
                                                   address_7bit,
                                                   address,
                                                   rx,
                                                   sizeof(rx),
                                                   MC_IO_TIMEOUT_MS);
        }
        if (result == MC_OK && memcmp(tx, rx, sizeof(tx)) != 0) {
            result = MC_ERR_VERIFY;
        }
        {
            int log_result = write_record(runner, case_id, transaction_id,
                                          "I2C", "EEPROM_RW", "TXRX", rx,
                                          sizeof(rx), result,
                                          result == MC_OK ? "matched" : "nack_or_mismatch");
            if (result == MC_OK && log_result != MC_OK) result = log_result;
        }
        summary_record(summary, iteration, result);
        if (result != MC_OK) {
            overall = result;
        }
    }
    return overall;
}

int mc_run_can_loopback(mc_runner_t *runner,
                        uint32_t case_id,
                        uint32_t standard_id,
                        uint32_t iterations,
                        mc_run_summary_t *summary)
{
    uint32_t iteration;
    int overall = MC_OK;

    if (runner == NULL || iterations == 0U || standard_id > 0x7FFU ||
        runner->platform.can_send == NULL || runner->platform.can_receive == NULL) {
        return MC_ERR_ARGUMENT;
    }

    summary_init(summary, iterations);
    for (iteration = 0U; iteration < iterations; ++iteration) {
        uint8_t tx[8];
        uint8_t rx[8] = {0U};
        uint32_t received_id = 0U;
        size_t received_length = sizeof(rx);
        uint32_t transaction_id = runner->next_transaction_id++;
        size_t index;
        int result = pulse_sync(runner, case_id);

        for (index = 0U; index < sizeof(tx); ++index) {
            tx[index] = (uint8_t)((iteration + (uint32_t)index) & 0xFFU);
        }
        if (result == MC_OK) {
            result = runner->platform.can_send(runner->platform.context, standard_id, tx,
                                               sizeof(tx), MC_IO_TIMEOUT_MS);
        }
        if (result == MC_OK) {
            result = runner->platform.can_receive(runner->platform.context, &received_id, rx,
                                                  &received_length, MC_IO_TIMEOUT_MS);
        }
        if (result == MC_OK &&
            (received_id != standard_id || received_length != sizeof(tx) ||
             memcmp(tx, rx, sizeof(tx)) != 0)) {
            result = MC_ERR_VERIFY;
        }
        {
            int log_result = write_record(runner, case_id, transaction_id,
                                          "CAN", "LOOPBACK", "TXRX", rx,
                                          received_length <= sizeof(rx) ? received_length : sizeof(rx),
                                          result,
                                          result == MC_OK ? "matched" : "timeout_or_mismatch");
            if (result == MC_OK && log_result != MC_OK) result = log_result;
        }
        summary_record(summary, iteration, result);
        if (result != MC_OK) {
            overall = result;
        }
    }
    return overall;
}

int mc_run_spi_incomplete_fault(mc_runner_t *runner,
                                uint32_t case_id,
                                uint8_t value,
                                uint8_t valid_bits)
{
    int result;
    uint32_t transaction_id;

    if (runner == NULL || valid_bits == 0U || valid_bits >= 8U ||
        runner->platform.spi_emit_incomplete == NULL) {
        return MC_ERR_ARGUMENT;
    }
    transaction_id = runner->next_transaction_id++;
    result = pulse_sync(runner, case_id);
    if (result == MC_OK) {
        result = runner->platform.spi_emit_incomplete(runner->platform.context, value, valid_bits);
    }
    {
        int log_result = write_record(runner, case_id, transaction_id,
                                      "SPI", "INCOMPLETE_BYTE", "TX", &value,
                                      1U, result,
                                      result == MC_OK ? "fault_emitted" : "fault_hook_failed");
        if (result == MC_OK && log_result != MC_OK) result = log_result;
    }
    return result;
}

int mc_run_uart_bad_stop_fault(mc_runner_t *runner,
                               uint32_t case_id,
                               uint8_t value,
                               uint32_t baudrate)
{
    int result;
    uint32_t transaction_id;

    if (runner == NULL || baudrate == 0U || runner->platform.uart_emit_bad_stop == NULL) {
        return MC_ERR_ARGUMENT;
    }
    transaction_id = runner->next_transaction_id++;
    result = pulse_sync(runner, case_id);
    if (result == MC_OK) {
        result = runner->platform.uart_emit_bad_stop(runner->platform.context, value, baudrate);
    }
    {
        int log_result = write_record(runner, case_id, transaction_id,
                                      "UART", "BAD_STOP", "TX", &value, 1U,
                                      result,
                                      result == MC_OK ? "fault_emitted" : "fault_hook_failed");
        if (result == MC_OK && log_result != MC_OK) result = log_result;
    }
    return result;
}

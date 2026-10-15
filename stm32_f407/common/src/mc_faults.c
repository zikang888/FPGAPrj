#include "mc_faults.h"
#include "mc_truth_log.h"

#include <string.h>

static const mc_fault_info_t k_faults[MC_FAULT_COUNT] = {
    {MC_FAULT_SPI_PARTIAL, 1091U, "SPI PARTIAL BYTE", "SPI", MC_FAULT_LOCAL},
    {MC_FAULT_SPI_SHORT, 1092U, "SPI SHORT TXN", "SPI", MC_FAULT_LOCAL},
    {MC_FAULT_SPI_EXTRA, 1093U, "SPI EXTRA BYTE", "SPI", MC_FAULT_LOCAL},
    {MC_FAULT_SPI_MISO_MISMATCH, 1094U, "SPI MISO CHECK", "SPI", MC_FAULT_NOT_BASELINE},
    {MC_FAULT_UART_BAD_STOP, 2091U, "UART BAD STOP", "UART", MC_FAULT_LOCAL},
    {MC_FAULT_UART_BREAK, 2092U, "UART BREAK", "UART", MC_FAULT_LOCAL},
    {MC_FAULT_UART_BAUD_MISMATCH, 2093U, "UART BAUD OFFSET", "UART", MC_FAULT_LOCAL},
    {MC_FAULT_UART_MISSING_BYTES, 2094U, "UART SHORT TXN", "UART", MC_FAULT_LOCAL},
    {MC_FAULT_UART_PARITY, 2095U, "UART PARITY", "UART", MC_FAULT_NOT_BASELINE},
    {MC_FAULT_I2C_ADDRESS_NACK, 3091U, "I2C ADDR NACK", "I2C", MC_FAULT_LOCAL},
    {MC_FAULT_I2C_BUSY_NACK, 3092U, "I2C BUSY NACK", "I2C", MC_FAULT_LOCAL},
    {MC_FAULT_I2C_SDA_LOW, 3093U, "I2C SDA LOW", "I2C", MC_FAULT_NEEDS_WIRING},
    {MC_FAULT_I2C_SCL_LOW, 3094U, "I2C SCL LOW", "I2C", MC_FAULT_NEEDS_WIRING},
    {MC_FAULT_I2C_NO_STOP, 3095U, "I2C NO STOP", "I2C", MC_FAULT_LOCAL},
    {MC_FAULT_CAN_NO_ACK, 4091U, "CAN NO ACK", "CAN", MC_FAULT_NEEDS_PEER},
    {MC_FAULT_CAN_BIT, 4092U, "CAN BIT ERROR", "CAN", MC_FAULT_EXTERNAL_ONLY},
    {MC_FAULT_CAN_STUFF, 4093U, "CAN STUFF ERROR", "CAN", MC_FAULT_EXTERNAL_ONLY},
    {MC_FAULT_CAN_CRC, 4094U, "CAN CRC ERROR", "CAN", MC_FAULT_EXTERNAL_ONLY},
    {MC_FAULT_CAN_FORM, 4095U, "CAN FORM ERROR", "CAN", MC_FAULT_EXTERNAL_ONLY},
    {MC_FAULT_CAN_BUS_OFF, 4096U, "CAN BUS OFF", "CAN", MC_FAULT_EXTERNAL_ONLY}
};

const mc_fault_info_t *mc_fault_get(mc_fault_id_t id)
{
    if ((unsigned int)id >= (unsigned int)MC_FAULT_COUNT) {
        return NULL;
    }
    return &k_faults[(unsigned int)id];
}

static int log_fault(mc_runner_t *runner, const mc_fault_info_t *info,
                     const uint8_t *data, size_t length,
                     const uint8_t *tx, size_t tx_length, int result,
                     const char *detail)
{
    mc_log_record_t record;
    int log_result;
    if (runner->platform.write_log == NULL) {
        return result;
    }
    memset(&record, 0, sizeof(record));
    record.sequence = runner->next_sequence++;
    record.transaction_id = runner->next_transaction_id++;
    record.case_id = info->case_id;
    record.protocol = info->protocol;
    record.operation = info->label;
    record.direction = tx != NULL ? "TXRX" : "TX";
    record.data = data;
    record.data_length = length;
    record.tx_data = tx;
    record.tx_length = tx_length;
    record.result = result;
    record.detail = detail;
    log_result = mc_truth_log_write(&runner->platform, &record);
    if (result == MC_OK && log_result != MC_OK) {
        return log_result;
    }
    return result;
}

static int spi_bytes(mc_platform_t *p, const uint8_t *tx, uint8_t *rx, size_t length)
{
    int result;
    if (p->spi_select == NULL || p->spi_transfer == NULL || rx == NULL || length > 6U) {
        return MC_ERR_UNSUPPORTED;
    }
    result = p->spi_select(p->context, 1);
    if (result == MC_OK) {
        result = p->spi_transfer(p->context, tx, rx, length, 100U);
    }
    if (p->spi_select(p->context, 0) != MC_OK && result == MC_OK) {
        result = MC_ERR_IO;
    }
    return result;
}

int mc_fault_run(mc_runner_t *runner, mc_fault_id_t id)
{
    const mc_fault_info_t *info = mc_fault_get(id);
    mc_platform_t *p;
    uint8_t data[6] = {0U};
    uint8_t rx[6] = {0U};
    const uint8_t *payload = data;
    const uint8_t *tx_data = NULL;
    size_t payload_length = 0U;
    size_t tx_length = 0U;
    int result = MC_ERR_UNSUPPORTED;
    const char *detail = "unsupported_or_external";

    if (runner == NULL || info == NULL) {
        return MC_ERR_ARGUMENT;
    }
    p = &runner->platform;
    if (p->sync_pulse != NULL) {
        result = p->sync_pulse(p->context, info->case_id);
        if (result != MC_OK) {
            return log_fault(runner, info, data, 0U, NULL, 0U, result, "sync_failed");
        }
    }
    result = MC_ERR_UNSUPPORTED;
    switch (id) {
    case MC_FAULT_SPI_PARTIAL:
        data[0] = 0x9FU;
        payload_length = 1U;
        if (p->spi_emit_incomplete != NULL) {
            result = p->spi_emit_incomplete(p->context, data[0], 4U);
        }
        detail = "4_valid_bits_then_cs_high";
        break;
    case MC_FAULT_SPI_SHORT:
        data[0] = 0x9FU; data[1] = 0x00U;
        payload_length = 2U;
        result = spi_bytes(p, data, rx, 2U);
        payload = rx;
        tx_data = data;
        tx_length = 2U;
        detail = "2_complete_bytes_expected_4";
        break;
    case MC_FAULT_SPI_EXTRA:
        data[0] = 0x9FU;
        payload_length = 5U;
        result = spi_bytes(p, data, rx, 5U);
        payload = rx;
        tx_data = data;
        tx_length = 5U;
        detail = "5_complete_bytes_expected_4";
        break;
    case MC_FAULT_UART_BAD_STOP:
        data[0] = 0x55U;
        payload_length = 1U;
        if (p->uart_emit_bad_stop != NULL) {
            result = p->uart_emit_bad_stop(p->context, data[0], 115200U);
        }
        detail = "stop_bit_low";
        break;
    case MC_FAULT_UART_BREAK:
        if (p->uart_emit_break != NULL) {
            result = p->uart_emit_break(p->context, 13U, 115200U);
        }
        detail = "tx_low_13_bit_times";
        break;
    case MC_FAULT_UART_BAUD_MISMATCH:
        data[0] = 0x55U;
        payload_length = 1U;
        if (p->uart_set_baudrate != NULL && p->uart_write != NULL) {
            result = p->uart_set_baudrate(p->context, 96000U);
            if (result == MC_OK) {
                result = p->uart_write(p->context, data, 1U, 100U);
            }
            if (p->uart_set_baudrate(p->context, 115200U) != MC_OK && result == MC_OK) {
                result = MC_ERR_IO;
            }
        }
        detail = "tx_96000_receiver_115200";
        break;
    case MC_FAULT_UART_MISSING_BYTES:
        data[0] = 0x00U; data[1] = 0x01U; data[2] = 0x02U;
        payload_length = 3U;
        if (p->uart_write != NULL) {
            result = p->uart_write(p->context, data, 3U, 100U);
        }
        detail = "3_bytes_expected_8";
        break;
    case MC_FAULT_I2C_ADDRESS_NACK:
        data[0] = 0x51U;
        payload_length = 1U;
        if (p->i2c_probe != NULL) {
            int baseline = p->i2c_probe(p->context, 0x50U, 5U);
            int absent = p->i2c_probe(p->context, 0x51U, 5U);
            result = (baseline == MC_OK && absent != MC_OK) ? MC_OK : MC_ERR_VERIFY;
        }
        detail = "0x50_ack_0x51_nack";
        break;
    case MC_FAULT_I2C_BUSY_NACK:
        if (p->i2c_mem_write != NULL && p->i2c_probe != NULL) {
            uint32_t attempt;
            data[0] = 0xA5U;
            payload_length = 2U;
            result = p->i2c_mem_write(p->context, 0x50U, 0x0120U, data, 1U, 100U);
            if (result == MC_OK) {
                uint8_t nack_count = 0U;
                for (attempt = 0U; attempt < 20U; ++attempt) {
                    if (p->i2c_probe(p->context, 0x50U, 1U) == MC_OK) {
                        break;
                    }
                    ++nack_count;
                }
                data[1] = nack_count;
                result = attempt >= 20U ? MC_ERR_TIMEOUT :
                         (nack_count == 0U ? MC_ERR_VERIFY : MC_OK);
            }
        }
        detail = "ack_poll_nack_count_in_data_1";
        break;
    case MC_FAULT_I2C_SDA_LOW:
        if (p->i2c_hold_sda_low != NULL) {
            result = p->i2c_hold_sda_low(p->context, 20U);
        }
        detail = "requires_pc7_open_drain_link_to_sda";
        break;
    case MC_FAULT_I2C_SCL_LOW:
        if (p->i2c_hold_scl_low != NULL) {
            result = p->i2c_hold_scl_low(p->context, 20U);
        }
        detail = "requires_pc8_open_drain_link_to_scl";
        break;
    case MC_FAULT_I2C_NO_STOP:
        if (p->i2c_emit_no_stop != NULL) {
            result = p->i2c_emit_no_stop(p->context, 0x50U, 30U);
        }
        detail = "hold_scl_low_30ms_then_recover";
        break;
    case MC_FAULT_CAN_NO_ACK:
        if (p->can_ack_probe != NULL) {
            result = p->can_ack_probe(p->context, 0x321U, 100U);
        }
        detail = "requires_peer_not_acknowledging";
        break;
    default:
        break;
    }
    return log_fault(runner, info, payload, payload_length,
                     tx_data, tx_length, result, detail);
}

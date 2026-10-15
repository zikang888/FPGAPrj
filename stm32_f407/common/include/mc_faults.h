#ifndef MC_FAULTS_H
#define MC_FAULTS_H

#include "mc_protocol_runner.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef enum {
    MC_FAULT_SPI_PARTIAL = 0,
    MC_FAULT_SPI_SHORT,
    MC_FAULT_SPI_EXTRA,
    MC_FAULT_SPI_MISO_MISMATCH,
    MC_FAULT_UART_BAD_STOP,
    MC_FAULT_UART_BREAK,
    MC_FAULT_UART_BAUD_MISMATCH,
    MC_FAULT_UART_MISSING_BYTES,
    MC_FAULT_UART_PARITY,
    MC_FAULT_I2C_ADDRESS_NACK,
    MC_FAULT_I2C_BUSY_NACK,
    MC_FAULT_I2C_SDA_LOW,
    MC_FAULT_I2C_SCL_LOW,
    MC_FAULT_I2C_NO_STOP,
    MC_FAULT_CAN_NO_ACK,
    MC_FAULT_CAN_BIT,
    MC_FAULT_CAN_STUFF,
    MC_FAULT_CAN_CRC,
    MC_FAULT_CAN_FORM,
    MC_FAULT_CAN_BUS_OFF,
    MC_FAULT_COUNT
} mc_fault_id_t;

typedef enum {
    MC_FAULT_LOCAL = 0,
    MC_FAULT_NEEDS_WIRING,
    MC_FAULT_NEEDS_PEER,
    MC_FAULT_EXTERNAL_ONLY,
    MC_FAULT_NOT_BASELINE
} mc_fault_requirement_t;

typedef struct {
    mc_fault_id_t id;
    uint32_t case_id;
    const char *label;
    const char *protocol;
    mc_fault_requirement_t requirement;
} mc_fault_info_t;

const mc_fault_info_t *mc_fault_get(mc_fault_id_t id);
int mc_fault_run(mc_runner_t *runner, mc_fault_id_t id);

#ifdef __cplusplus
}
#endif

#endif

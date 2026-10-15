#ifndef STM32_FAULT_BRIDGE_H_
#define STM32_FAULT_BRIDGE_H_

#include "error_model.h"

/* Match the STM32 fault menu's stable case IDs to the PS presentation model.
 * A matching case ID identifies an attempted test, not a detected bus fault.
 * Do not call error_model_report() solely because a STM32 JSONL record exists;
 * that requires a separately verified detector and cumulative count. */
static inline int stm32_fault_case_to_error(uint32_t case_id, ErrorCode *code)
{
    ErrorCode mapped;
    switch (case_id) {
    case 1091U: mapped = ERROR_SPI_PARTIAL_BYTE; break;
    case 1092U: mapped = ERROR_SPI_SHORT_TRANSACTION; break;
    case 1093U: mapped = ERROR_SPI_EXTRA_BYTES; break;
    case 1094U: mapped = ERROR_SPI_RESPONSE_MISMATCH; break;
    case 2091U: mapped = ERROR_UART_STOP_BIT; break;
    case 2092U: mapped = ERROR_UART_BREAK; break;
    case 2093U: mapped = ERROR_UART_BAUD_MISMATCH; break;
    case 2094U: mapped = ERROR_UART_SHORT_TRANSACTION; break;
    case 2095U: mapped = ERROR_UART_PARITY; break;
    case 3091U: mapped = ERROR_I2C_ADDRESS_NACK; break;
    case 3092U: mapped = ERROR_I2C_BUSY_NACK; break;
    case 3093U: mapped = ERROR_I2C_SDA_STUCK; break;
    case 3094U: mapped = ERROR_I2C_SCL_STUCK; break;
    case 3095U: mapped = ERROR_I2C_MISSING_STOP; break;
    case 4091U: mapped = ERROR_CAN_ACK; break;
    case 4092U: mapped = ERROR_CAN_BIT; break;
    case 4093U: mapped = ERROR_CAN_STUFF; break;
    case 4094U: mapped = ERROR_CAN_CRC; break;
    case 4095U: mapped = ERROR_CAN_FORM; break;
    case 4096U: mapped = ERROR_CAN_BUS_OFF; break;
    default: return 0;
    }
    if (code == 0) return 0;
    *code = mapped;
    return 1;
}

#endif

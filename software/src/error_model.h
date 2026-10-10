#ifndef ERROR_MODEL_H_
#define ERROR_MODEL_H_

#include <stdint.h>

/* Stable software identifiers for the team's fault-case list. Identifiers do
 * not define new PL event types or flags. Unreported cases remain unknown,
 * not clean/zero. */
typedef enum {
    ERROR_SPI_PARTIAL_BYTE = 0,
    ERROR_SPI_SHORT_TRANSACTION,
    ERROR_SPI_EXTRA_BYTES,
    ERROR_SPI_RESPONSE_MISMATCH,
    ERROR_UART_STOP_BIT,
    ERROR_UART_BREAK,
    ERROR_UART_BAUD_MISMATCH,
    ERROR_UART_SHORT_TRANSACTION,
    ERROR_UART_PARITY,
    ERROR_I2C_ADDRESS_NACK,
    ERROR_I2C_BUSY_NACK,
    ERROR_I2C_SDA_STUCK,
    ERROR_I2C_SCL_STUCK,
    ERROR_I2C_MISSING_STOP,
    ERROR_CAN_ACK,
    ERROR_CAN_BIT,
    ERROR_CAN_STUFF,
    ERROR_CAN_CRC,
    ERROR_CAN_FORM,
    ERROR_CAN_BUS_OFF,
    ERROR_CODE_COUNT
} ErrorCode;

typedef enum {
    ERROR_ORIGIN_NONE = 0, /* detector not connected */
    ERROR_ORIGIN_PL,
    ERROR_ORIGIN_PS_RULE,
    ERROR_ORIGIN_STM32_REPORT
} ErrorOrigin;

typedef struct {
    uint32_t count;
    ErrorOrigin origin;
} ErrorObservation;

typedef struct {
    ErrorObservation item[ERROR_CODE_COUNT];
} ErrorModel;

static inline void error_model_init(ErrorModel *model)
{
    unsigned int i;
    if (model == 0) return;
    for (i = 0U; i < ERROR_CODE_COUNT; ++i) {
        model->item[i].count = 0U;
        model->item[i].origin = ERROR_ORIGIN_NONE;
    }
}

/* count is cumulative within the source's current reset epoch. A zero count
 * with a real origin means "measured clean"; NONE means "not measured". */
static inline int error_model_report(ErrorModel *model, ErrorCode code,
                                     ErrorOrigin origin, uint32_t count)
{
    if (model == 0 || (unsigned int)code >= ERROR_CODE_COUNT ||
        origin <= ERROR_ORIGIN_NONE || origin > ERROR_ORIGIN_STM32_REPORT)
        return 0;
    model->item[code].count = count;
    model->item[code].origin = origin;
    return 1;
}

static inline ErrorObservation error_model_get(const ErrorModel *model,
                                               ErrorCode code)
{
    ErrorObservation unknown = {0U, ERROR_ORIGIN_NONE};
    if (model == 0 || (unsigned int)code >= ERROR_CODE_COUNT) return unknown;
    return model->item[code];
}

/* AT24C256's write-cycle NACK is an expected temporary busy indication.
 * A caller must apply a timeout/retry rule before reporting a persistent
 * I2C failure under another code; a busy count alone is informational. */
static inline int error_model_code_is_fault(ErrorCode code)
{
    return code != ERROR_I2C_BUSY_NACK;
}

static inline int error_model_has_fault(const ErrorModel *model)
{
    unsigned int i;
    if (model == 0) return 0;
    for (i = 0U; i < ERROR_CODE_COUNT; ++i) {
        if (error_model_code_is_fault((ErrorCode)i) &&
            model->item[i].origin != ERROR_ORIGIN_NONE &&
            model->item[i].count != 0U) return 1;
    }
    return 0;
}

static inline int error_model_equal(const ErrorModel *left,
                                    const ErrorModel *right)
{
    unsigned int i;
    if (left == right) return 1;
    if (left == 0 || right == 0) return 0;
    for (i = 0U; i < ERROR_CODE_COUNT; ++i) {
        if (left->item[i].count != right->item[i].count ||
            left->item[i].origin != right->item[i].origin) return 0;
    }
    return 1;
}

#endif

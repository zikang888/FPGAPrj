#include <assert.h>
#include "../src/error_model.h"

int main(void)
{
    ErrorModel model;
    ErrorModel copy;
    ErrorObservation reading;
    error_model_init(&model);
    reading = error_model_get(&model, ERROR_SPI_PARTIAL_BYTE);
    assert(reading.origin == ERROR_ORIGIN_NONE && reading.count == 0U);
    assert(!error_model_has_fault(&model));
    assert(error_model_report(&model, ERROR_SPI_PARTIAL_BYTE,
                              ERROR_ORIGIN_PL, 0U));
    reading = error_model_get(&model, ERROR_SPI_PARTIAL_BYTE);
    assert(reading.origin == ERROR_ORIGIN_PL && reading.count == 0U);
    assert(!error_model_has_fault(&model));
    copy = model;
    assert(error_model_equal(&model, &copy));
    assert(error_model_report(&model, ERROR_SPI_PARTIAL_BYTE,
                              ERROR_ORIGIN_PL, 1U));
    assert(error_model_has_fault(&model));
    assert(!error_model_equal(&model, &copy));
    assert(!error_model_report(&model, ERROR_UART_PARITY,
                               ERROR_ORIGIN_NONE, 0U));
    assert(!error_model_report(&model, ERROR_CODE_COUNT,
                               ERROR_ORIGIN_PL, 1U));
    assert(error_model_get(&model, ERROR_CODE_COUNT).origin ==
           ERROR_ORIGIN_NONE);
    assert(error_model_report(&model, ERROR_I2C_BUSY_NACK,
                              ERROR_ORIGIN_PS_RULE, 2U));
    assert(error_model_get(&model, ERROR_I2C_BUSY_NACK).count == 2U);
    assert(!error_model_code_is_fault(ERROR_I2C_BUSY_NACK));
    assert(error_model_code_is_fault(ERROR_I2C_ADDRESS_NACK));
    copy = model;
    error_model_init(&copy);
    assert(error_model_report(&copy, ERROR_I2C_BUSY_NACK,
                              ERROR_ORIGIN_PS_RULE, 2U));
    assert(!error_model_has_fault(&copy));
    return 0;
}

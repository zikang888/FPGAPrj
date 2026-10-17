#include <assert.h>
#include "../src/error_model.h"
#include "../src/stm32_fault_bridge.h"

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
    assert(error_model_report(&model, ERROR_SPI_SHORT_TRANSACTION,
                              ERROR_ORIGIN_PL, 2U));
    assert(error_model_report(&model, ERROR_SPI_EXTRA_BYTES,
                              ERROR_ORIGIN_PL, 3U));
    assert(error_model_report(&model, ERROR_SPI_RESPONSE_MISMATCH,
                              ERROR_ORIGIN_PL, 4U));
    assert(error_model_get(&model, ERROR_SPI_SHORT_TRANSACTION).count == 2U);
    assert(error_model_get(&model, ERROR_SPI_EXTRA_BYTES).count == 3U);
    assert(error_model_get(&model, ERROR_SPI_RESPONSE_MISMATCH).count == 4U);
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
    {
        static const uint32_t case_ids[ERROR_CODE_COUNT] = {
            1091U, 1092U, 1093U, 1094U,
            2091U, 2092U, 2093U, 2094U, 2095U,
            3091U, 3092U, 3093U, 3094U, 3095U,
            4091U, 4092U, 4093U, 4094U, 4095U, 4096U
        };
        unsigned int i;
        ErrorCode code = ERROR_SPI_PARTIAL_BYTE;
        for (i = 0U; i < ERROR_CODE_COUNT; ++i) {
            assert(stm32_fault_case_to_error(case_ids[i], &code));
            assert(code == (ErrorCode)i);
        }
        assert(!stm32_fault_case_to_error(1001U, &code));
        assert(!stm32_fault_case_to_error(1091U, 0));
        assert(code == ERROR_CAN_BUS_OFF);
    }
    return 0;
}

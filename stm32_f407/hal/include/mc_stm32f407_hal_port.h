#ifndef MC_STM32F407_HAL_PORT_H
#define MC_STM32F407_HAL_PORT_H

#include "mc_protocol_platform.h"
#include "stm32f4xx_hal.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    SPI_HandleTypeDef *spi;
    UART_HandleTypeDef *test_uart;
    UART_HandleTypeDef *debug_uart;
    I2C_HandleTypeDef *i2c;
    CAN_HandleTypeDef *can;

    GPIO_TypeDef *spi_cs_port;
    uint16_t spi_cs_pin;
    GPIO_TypeDef *sync_port;
    uint16_t sync_pin;
} mc_stm32f407_context_t;

/* Builds the callback table used by the portable protocol runner. */
mc_platform_t mc_stm32f407_make_platform(mc_stm32f407_context_t *context);

#ifdef __cplusplus
}
#endif

#endif

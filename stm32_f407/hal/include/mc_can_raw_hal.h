#ifndef MC_CAN_RAW_HAL_H
#define MC_CAN_RAW_HAL_H

#include "mc_can_raw.h"
#include "stm32f4xx_hal.h"

#if defined(MC_ENABLE_CAN_RAW_GPIO) && !defined(MC_ENABLE_CAN_FAULTS)
#error MC_ENABLE_CAN_RAW_GPIO requires MC_ENABLE_CAN_FAULTS
#endif

typedef struct {
    CAN_HandleTypeDef *can;
    UART_HandleTypeDef *log_uart;
#ifdef MC_ENABLE_CAN_RAW_GPIO
    CAN_InitTypeDef saved_init;
    DMA_HandleTypeDef dma;
    mc_can_raw_wave_t wave;
    uint32_t words[MC_CAN_RAW_MAX_BITS];
    uint32_t gpio_mode, gpio_type, gpio_speed, gpio_pull, gpio_af, gpio_odr;
    uint32_t irq_priority;
    volatile uint32_t dma_flags;
    volatile int dma_result;
    volatile uint8_t done;
    uint8_t saved_can, clocks_owned, timer_owned, dma_initialized, pin_owned, in_flight;
#endif
} mc_can_raw_hal_t;

mc_can_session_port_t mc_can_raw_hal_port(mc_can_raw_hal_t *context,
                                        CAN_HandleTypeDef *can, UART_HandleTypeDef *uart);
#endif

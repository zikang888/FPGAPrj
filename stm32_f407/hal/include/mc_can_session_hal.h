#ifndef MC_CAN_SESSION_HAL_H
#define MC_CAN_SESSION_HAL_H

#include "mc_can_session.h"
#include "stm32f4xx_hal.h"

typedef struct {
    CAN_HandleTypeDef *can;
    UART_HandleTypeDef *log_uart;
    CAN_InitTypeDef saved_init;
    uint32_t saved_ier;
    uint32_t current_bitrate;
    uint32_t mailbox;
    uint8_t saved;
    uint8_t in_flight;
    uint8_t rx_ready;
    uint8_t rx[8];
    mc_can_evidence_t evidence;
} mc_can_session_hal_t;

mc_can_session_port_t mc_can_session_hal_port(mc_can_session_hal_t *context,
                                            CAN_HandleTypeDef *can,
                                            UART_HandleTypeDef *log_uart);

#endif

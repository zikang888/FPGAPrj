#ifndef MC_CAN_LIVE_HAL_H
#define MC_CAN_LIVE_HAL_H
#include "mc_can_live.h"
#include "stm32f4xx_hal.h"

#if defined(MC_ENABLE_CAN_LIVE) && !defined(MC_ENABLE_CAN_FAULTS)
#error MC_ENABLE_CAN_LIVE requires MC_ENABLE_CAN_FAULTS
#endif

typedef struct {
    uint32_t pulse_slots, pulses, bit_errors;
    uint32_t esr_at_start, esr_before_recovery, esr_after_recovery;
    uint32_t sof_irq_ticks, pulse_gpio;
    uint8_t busoff_seen, recovered;
    int restore_result;
} mc_can_live_stats_t;

typedef struct {
    CAN_HandleTypeDef *can;
    UART_HandleTypeDef *uart;
    volatile mc_can_live_stats_t stats;
#ifdef MC_ENABLE_CAN_LIVE
    CAN_InitTypeDef saved_init;
    mc_can_live_timing_t timing;
    uint32_t gpio_mode, gpio_type, gpio_speed, gpio_pull, gpio_af, gpio_odr;
    uint32_t irq_tim_priority, irq_can_priority, mailbox, run_id;
    volatile uint32_t last_esr, first_lec;
    volatile int pulse_error;
    volatile uint8_t sof_seen, pulse_started, pulse_done, bit_seen;
    uint8_t saved_can, clock_owned, timer_owned, pin_owned, irq_owned;
    uint8_t in_flight, requested, frame_fault;
#endif
} mc_can_live_hal_t;

mc_can_session_port_t mc_can_live_hal_port(mc_can_live_hal_t *context,
                                         CAN_HandleTypeDef *can, UART_HandleTypeDef *uart);
#endif

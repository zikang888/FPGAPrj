#include "mc_can_live_hal.h"
#include <stdio.h>
#include <string.h>

#ifdef MC_ENABLE_CAN_LIVE
static mc_can_live_hal_t * volatile g_live_owner;
#define LIVE_PIN_MASK (GPIO_PIN_1 | GPIO_PIN_2)
#define LIVE_MODE_MASK ((3U << 2) | (3U << 4))
#define LIVE_AF_MASK ((15U << 4) | (15U << 8))

static void release_pulse(mc_can_live_hal_t *c)
{
    if (!c->timer_owned) { return; }
    TIM2->DIER = 0U;
    TIM2->SMCR = 0U;
    CLEAR_BIT(TIM2->CR1, TIM_CR1_CEN);
    MODIFY_REG(TIM2->CCMR2, TIM_CCMR2_OC3M, TIM_CCMR2_OC3M_2); /* forced inactive; inverted => high */
}

static void mark_pulse(mc_can_live_hal_t *c)
{
    c->pulse_started = 1U;
    /* bit0=A TXD high, bit1=actual bus dominant, bit2=I TXD low */
    c->stats.pulse_gpio = ((GPIOD->IDR & GPIO_PIN_1) ? 1U : 0U) |
                         ((GPIOD->IDR & GPIO_PIN_0) ? 0U : 2U) |
                         ((GPIOA->IDR & GPIO_PIN_2) ? 0U : 4U);
}

static void capture_error(mc_can_live_hal_t *c)
{
    uint32_t esr = c->can->Instance->ESR;
    uint32_t lec = (esr & CAN_ESR_LEC) >> CAN_ESR_LEC_Pos;
    c->last_esr = esr;
    if (c->in_flight) {
        if (c->frame_fault && c->timer_owned && (TIM2->SR & TIM_SR_CC3IF)) { mark_pulse(c); }
        if (lec != 0U && lec != 7U && c->first_lec == 0U) { c->first_lec = lec; }
        if (c->frame_fault && c->pulse_started && (lec == 4U || lec == 5U)) { c->bit_seen = 1U; }
        if (c->frame_fault && !c->pulse_started && lec != 0U && lec != 7U) {
            c->pulse_error = MC_ERR_VERIFY; /* frame failed before our selected DATA bit */
            release_pulse(c);
        }
    }
    if ((esr & CAN_ESR_BOFF) != 0U && !c->stats.busoff_seen) {
        c->stats.esr_before_recovery = esr;
        c->stats.busoff_seen = 1U;
    }
}

void CAN1_SCE_IRQHandler(void)
{
    mc_can_live_hal_t *c = g_live_owner;
    if (c != NULL) {
        capture_error(c);
        CLEAR_BIT(c->can->Instance->ESR, CAN_ESR_LEC);
        __HAL_CAN_CLEAR_FLAG(c->can, CAN_FLAG_ERRI);
    }
}

void TIM2_IRQHandler(void)
{
    mc_can_live_hal_t *c = g_live_owner;
    uint32_t flags = TIM2->SR;
    if (c != NULL && c->in_flight && c->frame_fault) {
        if ((flags & TIM_SR_TIF) && !c->sof_seen) {
            c->sof_seen = 1U;
            c->stats.sof_irq_ticks = TIM2->CNT;
            TIM2->SMCR = 0U; /* disarm all later edges while the counter continues */
            CLEAR_BIT(TIM2->DIER, TIM_DIER_TIE);
            if (TIM2->CNT >= 168U || (flags & (TIM_SR_CC3IF | TIM_SR_UIF))) {
                c->pulse_error = MC_ERR_TIMEOUT;
                release_pulse(c);
            } else if (GPIOD->IDR & GPIO_PIN_1) {
                c->pulse_error = MC_ERR_VERIFY; /* PA1 edge did not coincide with A's dominant SOF */
                release_pulse(c);
            }
        }
        if ((flags & TIM_SR_CC3IF) && c->pulse_error == MC_OK) { mark_pulse(c); }
        if ((flags & TIM_SR_UIF) && c->pulse_error == MC_OK) {
            c->pulse_done = c->sof_seen && c->pulse_started;
            release_pulse(c);
        }
    }
    TIM2->SR = 0U;
}

static void evidence(mc_can_live_hal_t *c, mc_can_evidence_t *e)
{
    uint32_t shift = c->mailbox == CAN_TX_MAILBOX0 ? 0U :
                     (c->mailbox == CAN_TX_MAILBOX1 ? 8U : 16U);
    capture_error(c);
    if (e != NULL) {
        memset(e, 0, sizeof(*e));
        e->esr = c->last_esr; e->tsr = c->can->Instance->TSR;
        e->rf0r = c->can->Instance->RF0R; e->observed_ms = HAL_GetTick();
        e->first_lec = (uint8_t)c->first_lec;
        e->injected = c->pulse_done && c->sof_seen && c->pulse_error == MC_OK;
        e->bit_error = c->bit_seen;
        e->tx_error = ((e->tsr >> shift) & CAN_TSR_TERR0) != 0U;
        e->backend_error = c->pulse_error;
    }
}

static int idle_bus(void)
{
    uint32_t start = HAL_GetTick(), high = start;
    while ((uint32_t)(HAL_GetTick() - start) < 10U) {
        uint32_t now = HAL_GetTick();
        if (!(GPIOD->IDR & GPIO_PIN_0)) { high = now; }
        if ((uint32_t)(now - high) >= 2U) { return MC_OK; }
    }
    return MC_ERR_BUSY;
}

static int live_begin(void *opaque, mc_can_mode_t mode)
{
    mc_can_live_hal_t *c = opaque;
    GPIO_InitTypeDef pin = {0};
    if (mode < MC_CAN_LIVE_DISTURB || mode > MC_CAN_LIVE_BUSOFF) { return MC_ERR_ARGUMENT; }
    if (g_live_owner != NULL || c->saved_can) { return MC_ERR_BUSY; }
    memset((void *)&c->stats, 0, sizeof(c->stats));
    c->run_id = 0U;
    if (g_live_owner != NULL || c->saved_can ||
        HAL_CAN_GetState(c->can) != HAL_CAN_STATE_LISTENING ||
        HAL_CAN_GetTxMailboxesFreeLevel(c->can) != 3U ||
        HAL_CAN_GetRxFifoFillLevel(c->can, CAN_RX_FIFO0) != 0U ||
        HAL_CAN_GetRxFifoFillLevel(c->can, CAN_RX_FIFO1) != 0U || c->can->Instance->IER != 0U ||
        (GPIOA->MODER & LIVE_MODE_MASK) || (GPIOA->PUPDR & LIVE_MODE_MASK) ||
        (GPIOA->AFR[0] & LIVE_AF_MASK) ||
        (RCC->APB1ENR & RCC_APB1ENR_TIM2EN) || NVIC_GetEnableIRQ(TIM2_IRQn) ||
        NVIC_GetPendingIRQ(TIM2_IRQn) || NVIC_GetEnableIRQ(CAN1_SCE_IRQn) ||
        NVIC_GetPendingIRQ(CAN1_SCE_IRQn)) { return MC_ERR_BUSY; }
    if (HAL_RCC_GetPCLK1Freq() != 42000000U || HAL_RCC_GetHCLKFreq() != 168000000U ||
        c->can->Init.Mode != CAN_MODE_NORMAL || (c->can->Instance->ESR & CAN_ESR_BOFF)) {
        return MC_ERR_UNSUPPORTED;
    }
    c->stats.esr_at_start = c->can->Instance->ESR;
    if (mode == MC_CAN_LIVE_BUSOFF && (c->stats.esr_at_start & 0xffff0003U)) {
        return MC_ERR_VERIFY; /* require known zero-counter baseline, never fake/reset it */
    }
    c->saved_init = c->can->Init; c->saved_can = 1U;
    if (HAL_CAN_Stop(c->can) != HAL_OK) { return MC_ERR_IO; }
    c->can->Init.Prescaler = 6U; c->can->Init.Mode = CAN_MODE_NORMAL;
    c->can->Init.SyncJumpWidth = CAN_SJW_1TQ;
    c->can->Init.TimeSeg1 = CAN_BS1_11TQ; c->can->Init.TimeSeg2 = CAN_BS2_2TQ;
    c->can->Init.AutoRetransmission = DISABLE; c->can->Init.AutoBusOff = DISABLE;
    if (HAL_CAN_Init(c->can) != HAL_OK || HAL_CAN_Start(c->can) != HAL_OK) { return MC_ERR_IO; }
    __HAL_RCC_TIM2_CLK_ENABLE(); c->clock_owned = 1U;
    if (TIM2->CR1 || TIM2->DIER || TIM2->CCER || TIM2->SMCR || TIM2->PSC) { return MC_ERR_BUSY; }
    c->timer_owned = 1U;
    c->gpio_mode = GPIOA->MODER & LIVE_MODE_MASK;
    c->gpio_type = GPIOA->OTYPER & LIVE_PIN_MASK;
    c->gpio_speed = GPIOA->OSPEEDR & LIVE_MODE_MASK;
    c->gpio_pull = GPIOA->PUPDR & LIVE_MODE_MASK;
    c->gpio_af = GPIOA->AFR[0] & LIVE_AF_MASK;
    c->gpio_odr = GPIOA->ODR & LIVE_PIN_MASK;
    c->pin_owned = 1U;
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_2, GPIO_PIN_SET);
    TIM2->CCMR2 = TIM_CCMR2_OC3M_2;
    TIM2->CCER = TIM_CCER_CC3P | TIM_CCER_CC3E;
    pin.Pin = GPIO_PIN_1; pin.Mode = GPIO_MODE_AF_PP; pin.Pull = GPIO_PULLUP;
    pin.Speed = GPIO_SPEED_FREQ_VERY_HIGH; pin.Alternate = GPIO_AF1_TIM2;
    HAL_GPIO_Init(GPIOA, &pin);
    pin.Pin = GPIO_PIN_2; pin.Pull = GPIO_NOPULL; HAL_GPIO_Init(GPIOA, &pin);
    c->irq_tim_priority = NVIC_GetPriority(TIM2_IRQn);
    c->irq_can_priority = NVIC_GetPriority(CAN1_SCE_IRQn);
    g_live_owner = c; c->irq_owned = 1U;
    NVIC_ClearPendingIRQ(TIM2_IRQn); NVIC_ClearPendingIRQ(CAN1_SCE_IRQn);
    NVIC_SetPriority(TIM2_IRQn, 4U); NVIC_SetPriority(CAN1_SCE_IRQn, 3U);
    NVIC_EnableIRQ(TIM2_IRQn); NVIC_EnableIRQ(CAN1_SCE_IRQn);
    CLEAR_BIT(c->can->Instance->ESR, CAN_ESR_LEC);
    __HAL_CAN_CLEAR_FLAG(c->can, CAN_FLAG_ERRI);
    c->can->Instance->IER = CAN_IT_ERROR | CAN_IT_LAST_ERROR_CODE | CAN_IT_BUSOFF |
                            CAN_IT_ERROR_PASSIVE | CAN_IT_ERROR_WARNING;
    return MC_OK;
}

static int drain(mc_can_live_hal_t *c)
{
    unsigned int i;
    for (i=0U; i<3U && HAL_CAN_GetRxFifoFillLevel(c->can, CAN_RX_FIFO0); ++i) {
        CAN_RxHeaderTypeDef header; uint8_t data[8];
        if (HAL_CAN_GetRxMessage(c->can, CAN_RX_FIFO0, &header, data) != HAL_OK) { return MC_ERR_IO; }
    }
    return MC_OK;
}

static int live_submit(void *opaque, mc_can_mode_t mode, uint32_t bitrate, const uint8_t tx[8])
{
    mc_can_live_hal_t *c = opaque;
    CAN_TxHeaderTypeDef header = {0};
    int result;
    if (!c->timer_owned || c->in_flight || HAL_CAN_GetTxMailboxesFreeLevel(c->can) != 3U) { return MC_ERR_BUSY; }
    if (bitrate != 500000U || (mode != MC_CAN_NORMAL &&
        (mode < MC_CAN_LIVE_DISTURB || mode > MC_CAN_LIVE_BUSOFF))) { return MC_ERR_ARGUMENT; }
    result = idle_bus(); if (result != MC_OK) { return result; }
    if (drain(c) != MC_OK) { return MC_ERR_IO; }
    c->sof_seen = 0U; c->pulse_started = 0U; c->pulse_done = 0U;
    c->bit_seen = 0U; c->first_lec = 0U; c->pulse_error = MC_OK;
    c->frame_fault = mode >= MC_CAN_LIVE_DISTURB;
    c->run_id = ((uint32_t)tx[0]<<24) | ((uint32_t)tx[1]<<16) | ((uint32_t)tx[2]<<8) | tx[3];
    memset(&c->timing,0,sizeof(c->timing));
    c->stats.sof_irq_ticks = 0U; c->stats.pulse_gpio = 0U;
    release_pulse(c);
    CLEAR_BIT(c->can->Instance->ESR, CAN_ESR_LEC);
    __HAL_CAN_CLEAR_FLAG(c->can, CAN_FLAG_ERRI);
    c->can->Instance->TSR = CAN_TSR_RQCP0 | CAN_TSR_RQCP1 | CAN_TSR_RQCP2;
    if (c->frame_fault) {
        result = mc_can_live_timing(tx, &c->timing); if (result != MC_OK) { return result; }
        ++c->stats.pulse_slots;
        TIM2->CR1 = TIM_CR1_OPM | TIM_CR1_ARPE | TIM_CR1_URS;
        TIM2->SMCR = 0U; TIM2->DIER = 0U; TIM2->PSC = 0U;
        TIM2->CCMR1 = TIM_CCMR1_CC2S_0;
        TIM2->CCMR2 = TIM_CCMR2_OC3M_2; /* stay high until all compare values are ready */
        TIM2->CCER = TIM_CCER_CC2E | TIM_CCER_CC2P | TIM_CCER_CC3E | TIM_CCER_CC3P;
        TIM2->CNT = 0U; TIM2->CCR3 = c->timing.start_ticks;
        TIM2->ARR = c->timing.end_ticks - 1U;
        TIM2->EGR = TIM_EGR_UG; TIM2->SR = 0U;
        TIM2->CCMR2 = TIM_CCMR2_OC3M; /* PWM2, CNT=0 < CCR3 => inverted high */
        NVIC_ClearPendingIRQ(TIM2_IRQn);
        TIM2->DIER = TIM_DIER_TIE | TIM_DIER_CC3IE | TIM_DIER_UIE;
        /* TI2FP2=110, trigger mode=110; hardware SOF starts, not software CEN. */
        TIM2->SMCR = TIM_SMCR_TS_2 | TIM_SMCR_TS_1 | TIM_SMCR_SMS_2 | TIM_SMCR_SMS_1;
    }
    c->in_flight = 1U; c->requested = 0U;
    header.StdId=0x321U; header.IDE=CAN_ID_STD; header.RTR=CAN_RTR_DATA; header.DLC=8U;
    if (HAL_CAN_AddTxMessage(c->can, &header, tx, &c->mailbox) != HAL_OK) { return MC_ERR_IO; }
    c->requested = 1U;
    return MC_OK;
}

static int live_poll(void *opaque, mc_can_evidence_t *e)
{
    mc_can_live_hal_t *c = opaque;
    uint32_t shift = c->mailbox == CAN_TX_MAILBOX0 ? 0U : (c->mailbox == CAN_TX_MAILBOX1 ? 8U : 16U);
    uint32_t status;
    evidence(c, e);
    if (e->backend_error || (e->esr & CAN_ESR_BOFF)) { return MC_ERR_IO; }
    status = e->tsr >> shift;
    if (!(status & CAN_TSR_RQCP0)) { return MC_CAN_PENDING; }
    release_pulse(c); c->in_flight = 0U; c->requested = 0U;
    return (status & CAN_TSR_TXOK0) ? MC_OK : MC_ERR_IO;
}

static int live_rx(void *p, uint8_t rx[8], mc_can_evidence_t *e)
{ (void)p; (void)rx; (void)e; return MC_ERR_UNSUPPORTED; }

static int live_cancel(void *opaque, mc_can_evidence_t *e)
{
    mc_can_live_hal_t *c = opaque;
    uint32_t start;
    if (!c->saved_can) { return MC_OK; }
    evidence(c, e); release_pulse(c);
    if (c->requested && HAL_CAN_IsTxMessagePending(c->can, c->mailbox)) {
        if (HAL_CAN_AbortTxRequest(c->can, c->mailbox) != HAL_OK) { return MC_ERR_IO; }
        /* BOFF pending requests are drained during explicit recovery, with abort already requested. */
        if (!(c->can->Instance->ESR & CAN_ESR_BOFF)) {
            start = HAL_GetTick();
            while (HAL_CAN_IsTxMessagePending(c->can, c->mailbox)) {
                if ((uint32_t)(HAL_GetTick()-start) >= 10U) { return MC_ERR_TIMEOUT; }
            }
            c->requested = 0U;
        }
    }
    c->in_flight = 0U;
    return MC_OK;
}

static int restore_inner(void *opaque)
{
    mc_can_live_hal_t *c = opaque;
    uint32_t start;
    if (!c->saved_can) { return MC_OK; }
    c->stats.restore_result = MC_ERR_IO;
    if (live_cancel(c, NULL) != MC_OK) { return MC_ERR_IO; }
    c->can->Instance->IER = 0U;
    if (c->irq_owned) {
        NVIC_DisableIRQ(TIM2_IRQn); NVIC_DisableIRQ(CAN1_SCE_IRQn);
        NVIC_ClearPendingIRQ(TIM2_IRQn); NVIC_ClearPendingIRQ(CAN1_SCE_IRQn);
        NVIC_SetPriority(TIM2_IRQn,c->irq_tim_priority); NVIC_SetPriority(CAN1_SCE_IRQn,c->irq_can_priority);
        g_live_owner = NULL; c->irq_owned=0U;
    }
    if (c->pin_owned) {
        MODIFY_REG(GPIOA->OTYPER,LIVE_PIN_MASK,c->gpio_type);
        MODIFY_REG(GPIOA->OSPEEDR,LIVE_MODE_MASK,c->gpio_speed);
        MODIFY_REG(GPIOA->PUPDR,LIVE_MODE_MASK,c->gpio_pull);
        MODIFY_REG(GPIOA->AFR[0],LIVE_AF_MASK,c->gpio_af);
        MODIFY_REG(GPIOA->MODER,LIVE_MODE_MASK,c->gpio_mode);
        GPIOA->BSRR = c->gpio_odr | ((LIVE_PIN_MASK & ~c->gpio_odr) << 16);
        c->pin_owned=0U;
    }
    if (c->clock_owned) {
        if (c->timer_owned) { __HAL_RCC_TIM2_FORCE_RESET(); __HAL_RCC_TIM2_RELEASE_RESET(); c->timer_owned=0U; }
        __HAL_RCC_TIM2_CLK_DISABLE(); c->clock_owned=0U;
    }
    if (c->can->Instance->ESR & CAN_ESR_BOFF) {
        if (!c->stats.busoff_seen) {
            c->stats.esr_before_recovery = c->can->Instance->ESR;
            c->stats.busoff_seen=1U;
        }
        /* Re-enter/leave initialization with one-shot TX and ABOM, after abort was requested. */
        if (HAL_CAN_GetState(c->can)==HAL_CAN_STATE_LISTENING && HAL_CAN_Stop(c->can)!=HAL_OK) { return MC_ERR_IO; }
        c->can->Init.AutoBusOff=ENABLE; c->can->Init.AutoRetransmission=DISABLE;
        if (HAL_CAN_Init(c->can)!=HAL_OK || HAL_CAN_Start(c->can)!=HAL_OK) { return MC_ERR_IO; }
        start=HAL_GetTick();
        while (c->can->Instance->ESR & CAN_ESR_BOFF) {
            if ((uint32_t)(HAL_GetTick()-start) >= 100U) {
                c->stats.restore_result=MC_ERR_TIMEOUT; return MC_ERR_TIMEOUT;
            }
        }
    }
    if (c->requested && HAL_CAN_IsTxMessagePending(c->can,c->mailbox)) {
        if (HAL_CAN_AbortTxRequest(c->can,c->mailbox) != HAL_OK) { return MC_ERR_IO; }
        start=HAL_GetTick();
        while (HAL_CAN_IsTxMessagePending(c->can,c->mailbox)) {
            if ((uint32_t)(HAL_GetTick()-start) >= 10U) { return MC_ERR_TIMEOUT; }
        }
    }
    c->requested=0U;
    if (drain(c) != MC_OK) { return MC_ERR_IO; }
    if (HAL_CAN_GetState(c->can)==HAL_CAN_STATE_LISTENING && HAL_CAN_Stop(c->can)!=HAL_OK) { return MC_ERR_IO; }
    c->can->Init=c->saved_init;
    if (HAL_CAN_Init(c->can)!=HAL_OK || HAL_CAN_Start(c->can)!=HAL_OK ||
        (c->can->Instance->ESR & CAN_ESR_BOFF)) { return MC_ERR_IO; }
    c->stats.esr_after_recovery=c->can->Instance->ESR;
    c->stats.recovered=c->stats.busoff_seen && !(c->stats.esr_after_recovery & CAN_ESR_BOFF);
    c->stats.restore_result=MC_OK; c->saved_can=0U;
    return MC_OK;
}

static int live_restore(void *opaque)
{
    mc_can_live_hal_t *c=opaque;
    int owned=c->saved_can;
    int result=restore_inner(c);
    c->stats.restore_result=result;
    if (owned) {
        char line[260];
        int n=snprintf(line,sizeof(line),
            "{\"kind\":\"can_live_end\",\"run\":%lu,\"pulses\":%lu,\"bit_errors\":%lu,"
            "\"busoff_seen\":%u,\"esr_before\":%lu,\"esr_after\":%lu,\"recovered\":%u,\"restore\":%d}\r\n",
            (unsigned long)c->run_id,(unsigned long)c->stats.pulses,(unsigned long)c->stats.bit_errors,
            (unsigned int)c->stats.busoff_seen,(unsigned long)c->stats.esr_before_recovery,
            (unsigned long)c->stats.esr_after_recovery,(unsigned int)c->stats.recovered,result);
        if (n<0 || (size_t)n>=sizeof(line) ||
            HAL_UART_Transmit(c->uart,(uint8_t *)line,(uint16_t)n,100U)!=HAL_OK) {
            if (result==MC_OK) { return MC_ERR_IO; }
        }
    }
    return result;
}

static int live_record(void *opaque, const mc_can_frame_t *f)
{
    mc_can_live_hal_t *c=opaque;
    const char *mode=f->mode==MC_CAN_NORMAL ? "baseline" :
                     (f->mode==MC_CAN_LIVE_DISTURB ? "disturb" : (f->mode==MC_CAN_LIVE_BIT ? "bit" : "busoff"));
    char line[560];
    int n;
    c->stats.pulses += f->evidence.injected;
    c->stats.bit_errors += f->evidence.bit_error;
    n=snprintf(line,sizeof(line),
        "{\"kind\":\"can_live\",\"run\":%lu,\"frame\":%lu,\"mode\":\"%s\","
        "\"fault_slot\":%u,\"submitted\":%u,"
        "\"ms\":%lu,\"observed_ms\":%lu,\"wire_bit\":%u,\"start_tick\":%lu,\"end_tick\":%lu,"
        "\"sof\":%u,\"sof_irq_ticks\":%lu,\"gpio\":%lu,\"injected\":%u,\"bit_error\":%u,"
        "\"esr\":%lu,\"tsr\":%lu,\"first_lec\":%u,\"tx_error\":%u,\"busoff\":%u,"
        "\"transport\":%d,\"result\":%d,\"cancel\":%d,\"pl\":\"unwired\"}\r\n",
        (unsigned long)f->run,(unsigned long)f->frame,mode,
        (unsigned int)f->fault_slot,(unsigned int)f->submitted,(unsigned long)f->submitted_ms,
        (unsigned long)f->evidence.observed_ms,(unsigned int)c->timing.wire_bit,
        (unsigned long)c->timing.start_ticks,(unsigned long)c->timing.end_ticks,
        (unsigned int)c->sof_seen,(unsigned long)c->stats.sof_irq_ticks,(unsigned long)c->stats.pulse_gpio,
        (unsigned int)f->evidence.injected,(unsigned int)f->evidence.bit_error,
        (unsigned long)f->evidence.esr,(unsigned long)f->evidence.tsr,
        (unsigned int)f->evidence.first_lec,(unsigned int)f->evidence.tx_error,
        (unsigned int)((f->evidence.esr & CAN_ESR_BOFF)!=0U),f->transport_result,f->result,f->cancel_result);
    if (n<0 || (size_t)n>=sizeof(line)) { return MC_ERR_IO; }
    return HAL_UART_Transmit(c->uart,(uint8_t *)line,(uint16_t)n,100U)==HAL_OK ? MC_OK : MC_ERR_IO;
}
#endif

mc_can_session_port_t mc_can_live_hal_port(mc_can_live_hal_t *c,
                                         CAN_HandleTypeDef *can,UART_HandleTypeDef *uart)
{
    mc_can_session_port_t p;
    memset(c,0,sizeof(*c)); memset(&p,0,sizeof(p)); c->can=can; c->uart=uart; p.context=c;
#ifdef MC_ENABLE_CAN_LIVE
    p.begin=live_begin; p.submit=live_submit; p.poll_tx=live_poll; p.poll_rx=live_rx;
    p.cancel=live_cancel; p.restore=live_restore; p.record=live_record;
#endif
    return p;
}

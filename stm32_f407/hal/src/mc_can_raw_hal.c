#include "mc_can_raw_hal.h"

#include <stdio.h>
#include <string.h>

#ifdef MC_ENABLE_CAN_RAW_GPIO
static mc_can_raw_hal_t * volatile g_raw_irq_owner;

static void finish_irq(mc_can_raw_hal_t *c, int result)
{
    CLEAR_BIT(TIM1->DIER, TIM_DIER_UDE);
    CLEAR_BIT(TIM1->CR1, TIM_CR1_CEN);
    __HAL_DMA_DISABLE(&c->dma);
    GPIOD->BSRR = GPIO_PIN_1; /* release even if logging/main loop is delayed */
    c->dma_result = result;
    __DMB();
    c->done = 1U;
}

static void raw_complete(DMA_HandleTypeDef *dma)
{
    (void)dma;
    if (g_raw_irq_owner != NULL) { finish_irq(g_raw_irq_owner, MC_OK); }
}

static void raw_error(DMA_HandleTypeDef *dma)
{
    (void)dma;
    if (g_raw_irq_owner != NULL) { finish_irq(g_raw_irq_owner, MC_ERR_IO); }
}

void DMA2_Stream5_IRQHandler(void)
{
    mc_can_raw_hal_t *c = g_raw_irq_owner;
    if (c != NULL) {
        c->dma_flags |= DMA2->HISR;
        HAL_DMA_IRQHandler(&c->dma);
    }
}

static int raw_begin(void *opaque, mc_can_mode_t mode)
{
    mc_can_raw_hal_t *c = opaque;
    GPIO_InitTypeDef pin = {0};
    if (mode < MC_CAN_RAW_VALID || mode > MC_CAN_RAW_FORM) { return MC_ERR_UNSUPPORTED; }
    if (c->saved_can || g_raw_irq_owner != NULL ||
        HAL_CAN_GetState(c->can) != HAL_CAN_STATE_LISTENING ||
        HAL_CAN_GetTxMailboxesFreeLevel(c->can) != 3U ||
        HAL_CAN_GetRxFifoFillLevel(c->can, CAN_RX_FIFO0) != 0U ||
        HAL_CAN_GetRxFifoFillLevel(c->can, CAN_RX_FIFO1) != 0U ||
        c->can->Instance->IER != 0U || (c->can->Instance->RF0R & CAN_RF0R_FOVR0) != 0U ||
        (RCC->APB2ENR & RCC_APB2ENR_TIM1EN) != 0U ||
        (RCC->AHB1ENR & RCC_AHB1ENR_DMA2EN) != 0U ||
        NVIC_GetEnableIRQ(DMA2_Stream5_IRQn) || NVIC_GetPendingIRQ(DMA2_Stream5_IRQn) ||
        NVIC_GetEnableIRQ(TIM1_BRK_TIM9_IRQn) || NVIC_GetEnableIRQ(TIM1_UP_TIM10_IRQn) ||
        NVIC_GetEnableIRQ(TIM1_TRG_COM_TIM11_IRQn) || NVIC_GetEnableIRQ(TIM1_CC_IRQn)) {
        return MC_ERR_BUSY;
    }
    if (HAL_RCC_GetHCLKFreq() != 168000000U || HAL_RCC_GetPCLK2Freq() != 84000000U ||
        c->can->Init.Mode != CAN_MODE_NORMAL ||
        (c->can->Instance->ESR & CAN_ESR_BOFF) != 0U ||
        (uintptr_t)c->words < 0x20000000U ||
        (uintptr_t)(c->words + MC_CAN_RAW_MAX_BITS) > 0x20020000U) {
        return MC_ERR_UNSUPPORTED;
    }
    c->saved_init = c->can->Init;
    c->saved_can = 1U;
    if (HAL_CAN_Stop(c->can) != HAL_OK) { return MC_ERR_IO; }
    __HAL_RCC_TIM1_CLK_ENABLE();
    __HAL_RCC_DMA2_CLK_ENABLE();
    c->clocks_owned = 1U;
    /* Reject preconfigured resources even if their clocks were disabled. */
    if (TIM1->CR1 != 0U || TIM1->DIER != 0U || TIM1->CCER != 0U ||
        DMA2_Stream5->CR != 0U || DMA2_Stream5->NDTR != 0U) { return MC_ERR_BUSY; }
    c->timer_owned = 1U;
    c->dma.Instance = DMA2_Stream5;
    c->dma.Init.Channel = DMA_CHANNEL_6;
    c->dma.Init.Direction = DMA_MEMORY_TO_PERIPH;
    c->dma.Init.PeriphInc = DMA_PINC_DISABLE;
    c->dma.Init.MemInc = DMA_MINC_ENABLE;
    c->dma.Init.PeriphDataAlignment = DMA_PDATAALIGN_WORD;
    c->dma.Init.MemDataAlignment = DMA_MDATAALIGN_WORD;
    c->dma.Init.Mode = DMA_NORMAL;
    c->dma.Init.Priority = DMA_PRIORITY_VERY_HIGH;
    c->dma.Init.FIFOMode = DMA_FIFOMODE_DISABLE;
    c->dma.Init.MemBurst = DMA_MBURST_SINGLE;
    c->dma.Init.PeriphBurst = DMA_PBURST_SINGLE;
    c->dma_initialized = 1U;
    if (HAL_DMA_Init(&c->dma) != HAL_OK) { return MC_ERR_IO; }
    c->dma.XferCpltCallback = raw_complete;
    c->dma.XferErrorCallback = raw_error;
    c->gpio_mode = GPIOD->MODER & (3U << 2);
    c->gpio_type = GPIOD->OTYPER & GPIO_PIN_1;
    c->gpio_speed = GPIOD->OSPEEDR & (3U << 2);
    c->gpio_pull = GPIOD->PUPDR & (3U << 2);
    c->gpio_af = GPIOD->AFR[0] & (15U << 4);
    c->gpio_odr = GPIOD->ODR & GPIO_PIN_1;
    c->pin_owned = 1U;
    HAL_GPIO_WritePin(GPIOD, GPIO_PIN_1, GPIO_PIN_SET);
    pin.Pin = GPIO_PIN_1; pin.Mode = GPIO_MODE_OUTPUT_PP;
    pin.Pull = GPIO_NOPULL; pin.Speed = GPIO_SPEED_FREQ_VERY_HIGH;
    HAL_GPIO_Init(GPIOD, &pin);
    c->irq_priority = NVIC_GetPriority(DMA2_Stream5_IRQn);
    g_raw_irq_owner = c;
    NVIC_ClearPendingIRQ(DMA2_Stream5_IRQn);
    NVIC_SetPriority(DMA2_Stream5_IRQn, 6U);
    NVIC_EnableIRQ(DMA2_Stream5_IRQn);
    c->in_flight = 0U;
    return MC_OK;
}

static int raw_idle(mc_can_raw_hal_t *c)
{
    uint32_t started = HAL_GetTick(), high_since = started;
    (void)c;
    do {
        uint32_t now = HAL_GetTick();
        if ((GPIOD->IDR & GPIO_PIN_0) == 0U) { high_since = now; }
        /* >=2 tick changes guarantees at least 1ms continuous high. */
        if ((uint32_t)(now - high_since) >= 2U) { return MC_OK; }
    } while ((uint32_t)(HAL_GetTick() - started) < 10U);
    return MC_ERR_BUSY;
}

static int raw_submit(void *opaque, mc_can_mode_t mode, uint32_t bitrate, const uint8_t tx[8])
{
    mc_can_raw_hal_t *c = opaque;
    uint16_t i;
    int result;
    if (!c->pin_owned || c->in_flight) { return MC_ERR_BUSY; }
    if (bitrate != 125000U && bitrate != 500000U) { return MC_ERR_ARGUMENT; }
    result = mc_can_raw_build(mode, 0x321U, tx, 8U, &c->wave);
    if (result != MC_OK) { return result; }
    result = raw_idle(c);
    if (result != MC_OK) { return result; }
    for (i = 1U; i < c->wave.count; ++i) {
        c->words[i - 1U] = c->wave.bits[i] ? GPIO_PIN_1 : (uint32_t)GPIO_PIN_1 << 16;
    }
    c->done = 0U; c->dma_result = MC_CAN_PENDING; c->dma_flags = 0U;
    TIM1->CR1 = TIM_CR1_ARPE | TIM_CR1_URS;
    TIM1->DIER = 0U; TIM1->PSC = 0U;
    TIM1->ARR = 168000000U / bitrate - 1U;
    TIM1->RCR = 0U; TIM1->CNT = 0U;
    TIM1->EGR = TIM_EGR_UG; TIM1->SR = 0U;
    __DMB();
    if (HAL_DMA_Start_IT(&c->dma, (uint32_t)(uintptr_t)c->words,
                         (uint32_t)(uintptr_t)&GPIOD->BSRR, c->wave.count - 1U) != HAL_OK) {
        return MC_ERR_IO;
    }
    c->in_flight = 1U;
    TIM1->DIER = TIM_DIER_UDE;
    GPIOD->BSRR = c->wave.bits[0] ? GPIO_PIN_1 : (uint32_t)GPIO_PIN_1 << 16;
    TIM1->CR1 |= TIM_CR1_CEN;
    return MC_OK;
}

static int raw_poll(void *opaque, mc_can_evidence_t *e)
{
    mc_can_raw_hal_t *c = opaque;
    memset(e, 0, sizeof(*e));
    e->observed_ms = HAL_GetTick();
    if (!c->in_flight) { e->backend_error = MC_ERR_IO; return MC_ERR_IO; }
    if (!c->done) { return MC_CAN_PENDING; }
    __DMB();
    c->in_flight = 0U;
    if (c->dma_result != MC_OK) { e->backend_error = c->dma_result; }
    return c->dma_result;
}

static int raw_rx(void *opaque, uint8_t rx[8], mc_can_evidence_t *e)
{ (void)opaque; (void)rx; (void)e; return MC_ERR_UNSUPPORTED; }

static int raw_cancel(void *opaque, mc_can_evidence_t *e)
{
    mc_can_raw_hal_t *c = opaque;
    if (e != NULL) { memset(e, 0, sizeof(*e)); e->observed_ms = HAL_GetTick(); }
    if (c->timer_owned) {
        CLEAR_BIT(TIM1->DIER, TIM_DIER_UDE);
        CLEAR_BIT(TIM1->CR1, TIM_CR1_CEN);
    }
    if (c->dma_initialized && (DMA2_Stream5->CR & DMA_SxCR_EN) != 0U) {
        if (HAL_DMA_Abort(&c->dma) != HAL_OK) {
            if (c->pin_owned) { GPIOD->BSRR = GPIO_PIN_1; }
            return MC_ERR_IO;
        }
    }
    if (c->pin_owned) { GPIOD->BSRR = GPIO_PIN_1; }
    c->in_flight = 0U;
    return MC_OK;
}

static int raw_restore(void *opaque)
{
    mc_can_raw_hal_t *c = opaque;
    if (!c->saved_can) { return MC_OK; }
    if (raw_cancel(c, NULL) != MC_OK) { return MC_ERR_IO; }
    if (g_raw_irq_owner == c) {
        NVIC_DisableIRQ(DMA2_Stream5_IRQn);
        NVIC_ClearPendingIRQ(DMA2_Stream5_IRQn);
        NVIC_SetPriority(DMA2_Stream5_IRQn, c->irq_priority);
        g_raw_irq_owner = NULL;
    }
    if (c->dma_initialized) {
        if (HAL_DMA_DeInit(&c->dma) != HAL_OK) { return MC_ERR_IO; }
        c->dma_initialized = 0U;
    }
    if (c->pin_owned) {
        MODIFY_REG(GPIOD->OTYPER, GPIO_PIN_1, c->gpio_type);
        MODIFY_REG(GPIOD->OSPEEDR, 3U << 2, c->gpio_speed);
        MODIFY_REG(GPIOD->PUPDR, 3U << 2, c->gpio_pull);
        MODIFY_REG(GPIOD->AFR[0], 15U << 4, c->gpio_af);
        MODIFY_REG(GPIOD->MODER, 3U << 2, c->gpio_mode);
        GPIOD->BSRR = c->gpio_odr ? GPIO_PIN_1 : (uint32_t)GPIO_PIN_1 << 16;
        c->pin_owned = 0U;
    }
    if (c->clocks_owned) {
        if (c->timer_owned) {
            __HAL_RCC_TIM1_FORCE_RESET(); __HAL_RCC_TIM1_RELEASE_RESET();
            c->timer_owned = 0U;
        }
        __HAL_RCC_TIM1_CLK_DISABLE(); __HAL_RCC_DMA2_CLK_DISABLE();
        c->clocks_owned = 0U;
    }
    c->can->Init = c->saved_init;
    if (HAL_CAN_Init(c->can) != HAL_OK || HAL_CAN_Start(c->can) != HAL_OK ||
        (c->can->Instance->ESR & CAN_ESR_BOFF) != 0U) { return MC_ERR_IO; }
    c->saved_can = 0U;
    return MC_OK;
}

static int raw_record(void *opaque, const mc_can_frame_t *f)
{
    mc_can_raw_hal_t *c = opaque;
    static const char *const modes[] = {"valid", "crc", "stuff", "form"};
    char line[480];
    int n = snprintf(line, sizeof(line),
        "{\"kind\":\"can_raw\",\"run\":%lu,\"frame\":%lu,\"mode\":\"%s\","
        "\"ms\":%lu,\"observed_ms\":%lu,"
        "\"bitrate\":%lu,\"submitted\":%u,\"fault_slot\":%u,\"bits\":%u,\"fault_bit\":%d,"
        "\"tx\":\"%02X%02X%02X%02X%02X%02X%02X%02X\","
        "\"crc15\":%u,\"dma_flags\":%lu,\"dma_result\":%d,\"result\":%d,\"cancel\":%d,"
        "\"rx\":null,\"meaning\":\"output_only\",\"pl\":\"unwired\"}\r\n",
        (unsigned long)f->run, (unsigned long)f->frame,
        modes[(unsigned int)f->mode - MC_CAN_RAW_VALID],
        (unsigned long)f->submitted_ms, (unsigned long)f->evidence.observed_ms,
        (unsigned long)f->bitrate,
        (unsigned int)f->submitted, (unsigned int)f->fault_slot, (unsigned int)c->wave.count,
        c->wave.fault_bit == MC_CAN_RAW_NO_FAULT ? -1 : (int)c->wave.fault_bit,
        (unsigned int)f->tx[0], (unsigned int)f->tx[1], (unsigned int)f->tx[2], (unsigned int)f->tx[3],
        (unsigned int)f->tx[4], (unsigned int)f->tx[5], (unsigned int)f->tx[6], (unsigned int)f->tx[7],
        (unsigned int)c->wave.crc, (unsigned long)c->dma_flags, c->dma_result, f->result, f->cancel_result);
    if (n < 0 || (size_t)n >= sizeof(line)) { return MC_ERR_IO; }
    return HAL_UART_Transmit(c->log_uart, (uint8_t *)line, (uint16_t)n, 100U) == HAL_OK ?
           MC_OK : MC_ERR_IO;
}
#endif

mc_can_session_port_t mc_can_raw_hal_port(mc_can_raw_hal_t *c,
                                        CAN_HandleTypeDef *can, UART_HandleTypeDef *uart)
{
    mc_can_session_port_t port;
    memset(c, 0, sizeof(*c));
    memset(&port, 0, sizeof(port));
    c->can = can; c->log_uart = uart; port.context = c;
#ifdef MC_ENABLE_CAN_RAW_GPIO
    port.begin = raw_begin; port.submit = raw_submit; port.poll_tx = raw_poll;
    port.poll_rx = raw_rx; port.cancel = raw_cancel; port.restore = raw_restore;
    port.record = raw_record;
#endif
    return port;
}

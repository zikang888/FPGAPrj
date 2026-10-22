#include "mc_can_session_hal.h"

#include <stdio.h>
#include <string.h>

static void sample_status(mc_can_session_hal_t *c, mc_can_evidence_t *out)
{
    uint32_t lec;
    c->evidence.esr = c->can->Instance->ESR;
    c->evidence.tsr = c->can->Instance->TSR;
    c->evidence.rf0r = c->can->Instance->RF0R;
    if ((c->evidence.rf0r & CAN_RF0R_FOVR0) != 0U) { c->evidence.fifo_overrun = 1U; }
    c->evidence.observed_ms = HAL_GetTick();
    lec = (c->evidence.esr & CAN_ESR_LEC) >> CAN_ESR_LEC_Pos;
    if (c->evidence.first_lec == 0U && lec != 0U && lec != 7U) {
        c->evidence.first_lec = (uint8_t)lec;
    }
    if (out != NULL) { *out = c->evidence; }
}

static int drain_rx(mc_can_session_hal_t *c)
{
    unsigned int i;
    for (i = 0U; i < 3U && HAL_CAN_GetRxFifoFillLevel(c->can, CAN_RX_FIFO0) != 0U; ++i) {
        CAN_RxHeaderTypeDef header;
        uint8_t bytes[8];
        if (HAL_CAN_GetRxMessage(c->can, CAN_RX_FIFO0, &header, bytes) != HAL_OK) {
            c->evidence.backend_error = MC_ERR_IO;
            return MC_ERR_IO;
        }
        if (header.IDE == CAN_ID_STD && header.RTR == CAN_RTR_DATA &&
            header.StdId == 0x321U && header.DLC == 8U) {
            memcpy(c->rx, bytes, 8U);
            c->rx_ready = 1U;
        }
    }
    return MC_OK;
}

static int set_bitrate(mc_can_session_hal_t *c, uint32_t bitrate)
{
    if (c->current_bitrate == bitrate) { return MC_OK; }
    if (bitrate != 500000U && bitrate != 250000U) { return MC_ERR_ARGUMENT; }
    if (HAL_CAN_Stop(c->can) != HAL_OK) { return MC_ERR_IO; }
    c->can->Init.Prescaler = bitrate == 500000U ? 6U : 12U;
    c->can->Init.Mode = CAN_MODE_NORMAL;
    c->can->Init.SyncJumpWidth = CAN_SJW_1TQ;
    c->can->Init.TimeSeg1 = CAN_BS1_11TQ;
    c->can->Init.TimeSeg2 = CAN_BS2_2TQ;
    c->can->Init.AutoRetransmission = DISABLE;
    c->can->Init.AutoBusOff = DISABLE;
    if (HAL_CAN_Init(c->can) != HAL_OK || HAL_CAN_Start(c->can) != HAL_OK) {
        return MC_ERR_IO;
    }
    c->current_bitrate = bitrate;
    return MC_OK;
}

static int session_begin(void *opaque, mc_can_mode_t mode)
{
    mc_can_session_hal_t *c = (mc_can_session_hal_t *)opaque;
#ifndef MC_ENABLE_CAN_FAULTS
    if (mode == MC_CAN_NO_ACK || mode == MC_CAN_BITRATE) { return MC_ERR_UNSUPPORTED; }
#else
    (void)mode;
#endif
    if (c == NULL || c->can == NULL || c->log_uart == NULL) { return MC_ERR_ARGUMENT; }
    /* No ownership transfer while legacy traffic, FIFO data or CAN IRQ users exist. */
    if (c->saved || HAL_CAN_GetState(c->can) != HAL_CAN_STATE_LISTENING ||
        HAL_CAN_GetTxMailboxesFreeLevel(c->can) != 3U ||
        HAL_CAN_GetRxFifoFillLevel(c->can, CAN_RX_FIFO0) != 0U ||
        HAL_CAN_GetRxFifoFillLevel(c->can, CAN_RX_FIFO1) != 0U ||
        c->can->Instance->IER != 0U ||
        (c->can->Instance->RF0R & CAN_RF0R_FOVR0) != 0U) { return MC_ERR_BUSY; }
    if (HAL_RCC_GetPCLK1Freq() != 42000000U || c->can->Init.Mode != CAN_MODE_NORMAL ||
        (c->can->Instance->ESR & CAN_ESR_BOFF) != 0U) { return MC_ERR_UNSUPPORTED; }
    c->saved_init = c->can->Init;
    c->saved_ier = c->can->Instance->IER;
    c->saved = 1U;
    c->in_flight = 0U;
    c->current_bitrate = 0U;
    memset(&c->evidence, 0, sizeof(c->evidence));
    return set_bitrate(c, 500000U);
}

static int session_submit(void *opaque, uint32_t bitrate, const uint8_t tx[8])
{
    mc_can_session_hal_t *c = (mc_can_session_hal_t *)opaque;
    CAN_TxHeaderTypeDef header;
    int result;
    if (!c->saved || c->in_flight) { return MC_ERR_BUSY; }
#ifndef MC_ENABLE_CAN_FAULTS
    if (bitrate != 500000U) { return MC_ERR_UNSUPPORTED; }
#endif
    /* Polling sessions own FIFO0; stale echoes cannot satisfy this frame. */
    if (drain_rx(c) != MC_OK) { return MC_ERR_IO; }
    c->rx_ready = 0U;
    memset(&c->evidence, 0, sizeof(c->evidence));
    result = set_bitrate(c, bitrate);
    if (result != MC_OK) { return result; }
    CLEAR_BIT(c->can->Instance->ESR, CAN_ESR_LEC);
    c->can->Instance->TSR = CAN_TSR_RQCP0 | CAN_TSR_RQCP1 | CAN_TSR_RQCP2;
    memset(&header, 0, sizeof(header));
    header.StdId = 0x321U;
    header.IDE = CAN_ID_STD;
    header.RTR = CAN_RTR_DATA;
    header.DLC = 8U;
    if (HAL_CAN_AddTxMessage(c->can, &header, tx, &c->mailbox) != HAL_OK) {
        return MC_ERR_IO;
    }
    c->in_flight = 1U;
    return MC_OK;
}

static int session_poll_tx(void *opaque, mc_can_evidence_t *evidence)
{
    mc_can_session_hal_t *c = (mc_can_session_hal_t *)opaque;
    uint32_t shift = c->mailbox == CAN_TX_MAILBOX0 ? 0U :
                     (c->mailbox == CAN_TX_MAILBOX1 ? 8U : 16U);
    uint32_t status;
    if (!c->in_flight) { return MC_ERR_IO; }
    sample_status(c, evidence);
    if (drain_rx(c) != MC_OK) { sample_status(c, evidence); return MC_ERR_IO; }
    status = c->evidence.tsr >> shift;
    if ((status & CAN_TSR_RQCP0) == 0U) {
        if ((c->evidence.esr & CAN_ESR_BOFF) != 0U) { return MC_ERR_IO; }
        return MC_CAN_PENDING;
    }
    c->in_flight = 0U;
    return (status & CAN_TSR_TXOK0) != 0U ? MC_OK : MC_ERR_IO;
}

static int session_poll_rx(void *opaque, uint8_t rx[8], mc_can_evidence_t *evidence)
{
    mc_can_session_hal_t *c = (mc_can_session_hal_t *)opaque;
    sample_status(c, evidence);
    if (drain_rx(c) != MC_OK) { sample_status(c, evidence); return MC_ERR_IO; }
    if ((c->evidence.esr & CAN_ESR_BOFF) != 0U) { return MC_ERR_IO; }
    if (!c->rx_ready) { return MC_CAN_PENDING; }
    memcpy(rx, c->rx, 8U);
    c->rx_ready = 0U;
    return MC_OK;
}

static int session_cancel(void *opaque, mc_can_evidence_t *evidence)
{
    mc_can_session_hal_t *c = (mc_can_session_hal_t *)opaque;
    uint32_t start;
    if (!c->saved) { return MC_OK; }
    sample_status(c, evidence);
    if (!c->in_flight) { return MC_OK; }
    if (HAL_CAN_AbortTxRequest(c->can, c->mailbox) != HAL_OK) { return MC_ERR_IO; }
    start = HAL_GetTick();
    while (HAL_CAN_IsTxMessagePending(c->can, c->mailbox) != 0U) {
        if ((uint32_t)(HAL_GetTick() - start) >= 10U) { return MC_ERR_TIMEOUT; }
    }
    c->in_flight = 0U;
    return MC_OK;
}

static int session_restore(void *opaque)
{
    mc_can_session_hal_t *c = (mc_can_session_hal_t *)opaque;
    if (!c->saved) { return MC_OK; }
    /* Leave ownership held if cancellation/config restoration cannot be confirmed. */
    if (session_cancel(c, NULL) != MC_OK || drain_rx(c) != MC_OK) { return MC_ERR_IO; }
    if (HAL_CAN_GetState(c->can) == HAL_CAN_STATE_LISTENING &&
        HAL_CAN_Stop(c->can) != HAL_OK) { return MC_ERR_IO; }
    c->can->Init = c->saved_init;
    if (HAL_CAN_Init(c->can) != HAL_OK || HAL_CAN_Start(c->can) != HAL_OK) {
        return MC_ERR_IO;
    }
    c->can->Instance->IER = c->saved_ier;
    if ((c->can->Instance->ESR & CAN_ESR_BOFF) != 0U) { return MC_ERR_IO; }
    c->saved = 0U;
    c->current_bitrate = 0U;
    return MC_OK;
}

static int session_record(void *opaque, const mc_can_frame_t *f)
{
    mc_can_session_hal_t *c = (mc_can_session_hal_t *)opaque;
    char tx[17], rx[17], line[480];
    static const char *const modes[] = {"normal", "noack", "bitrate", "echo"};
    static const char hex[] = "0123456789ABCDEF";
    unsigned int i;
    int count;
    for (i = 0U; i < 8U; ++i) {
        tx[2U * i] = hex[f->tx[i] >> 4]; tx[2U * i + 1U] = hex[f->tx[i] & 15U];
        rx[2U * i] = hex[f->rx[i] >> 4]; rx[2U * i + 1U] = hex[f->rx[i] & 15U];
    }
    tx[16] = '\0'; rx[f->rx_valid ? 16U : 0U] = '\0';
    count = snprintf(line, sizeof(line),
        "{\"kind\":\"can_session\",\"mode\":\"%s\",\"run\":%lu,\"frame\":%lu,\"ms\":%lu,"
        "\"observed_ms\":%lu,\"bitrate\":%lu,\"fault_slot\":%u,\"submitted\":%u,"
        "\"tx\":\"%s\",\"rx\":\"%s\",\"transport\":%d,\"result\":%d,\"cancel\":%d,"
        "\"esr\":%lu,\"tsr\":%lu,\"rf0r\":%lu,\"first_lec\":%u,"
        "\"fifo_overrun\":%u,\"backend\":%d,\"pl\":\"unwired\"}\r\n",
        modes[(unsigned int)f->mode], (unsigned long)f->run,
        (unsigned long)f->frame, (unsigned long)f->submitted_ms,
        (unsigned long)f->evidence.observed_ms, (unsigned long)f->bitrate,
        (unsigned int)f->fault_slot, (unsigned int)f->submitted, tx, rx,
        f->transport_result, f->result, f->cancel_result, (unsigned long)f->evidence.esr,
        (unsigned long)f->evidence.tsr, (unsigned long)f->evidence.rf0r,
        (unsigned int)f->evidence.first_lec, (unsigned int)f->evidence.fifo_overrun,
        f->evidence.backend_error);
    if (count < 0 || (size_t)count >= sizeof(line)) { return MC_ERR_IO; }
    return HAL_UART_Transmit(c->log_uart, (uint8_t *)line, (uint16_t)count, 100U) == HAL_OK ?
           MC_OK : MC_ERR_IO;
}

mc_can_session_port_t mc_can_session_hal_port(mc_can_session_hal_t *c,
                                            CAN_HandleTypeDef *can,
                                            UART_HandleTypeDef *log_uart)
{
    mc_can_session_port_t port;
    memset(c, 0, sizeof(*c));
    c->can = can;
    c->log_uart = log_uart;
    memset(&port, 0, sizeof(port));
    port.context = c;
    port.begin = session_begin;
    port.submit = session_submit;
    port.poll_tx = session_poll_tx;
    port.poll_rx = session_poll_rx;
    port.cancel = session_cancel;
    port.restore = session_restore;
    port.record = session_record;
    return port;
}

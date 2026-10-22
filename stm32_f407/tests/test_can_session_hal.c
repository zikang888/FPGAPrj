#include "mc_can_session_hal.h"

#include <stdio.h>
#include <string.h>

#define CHECK(x) do { if (!(x)) { \
    fprintf(stderr, "check failed: %s:%d: %s\n", __FILE__, __LINE__, #x); return 1; \
} } while (0)

static uint32_t tick, pending, rx_count, mailbox_index, free_level;
static int fail_init, fail_abort, fail_log, stuck_abort;
static unsigned int stops, inits, starts, sends, aborts;
static char output[512];
static uint8_t last_tx[8];

uint32_t HAL_GetTick(void) { return tick++; }
uint32_t HAL_RCC_GetPCLK1Freq(void) { return 42000000U; }
HAL_CAN_StateTypeDef HAL_CAN_GetState(CAN_HandleTypeDef *c) { return c->State; }
uint32_t HAL_CAN_GetTxMailboxesFreeLevel(CAN_HandleTypeDef *c) { (void)c; return free_level; }
uint32_t HAL_CAN_GetRxFifoFillLevel(CAN_HandleTypeDef *c, uint32_t fifo)
{ (void)c; return fifo == CAN_RX_FIFO0 ? rx_count : 0U; }
uint32_t HAL_CAN_IsTxMessagePending(CAN_HandleTypeDef *c, uint32_t box)
{ (void)c; (void)box; return pending; }
HAL_StatusTypeDef HAL_CAN_Stop(CAN_HandleTypeDef *c)
{ ++stops; c->State = HAL_CAN_STATE_READY; return HAL_OK; }
HAL_StatusTypeDef HAL_CAN_Init(CAN_HandleTypeDef *c)
{ ++inits; c->State = fail_init ? HAL_CAN_STATE_ERROR : HAL_CAN_STATE_READY; return fail_init ? HAL_ERROR : HAL_OK; }
HAL_StatusTypeDef HAL_CAN_Start(CAN_HandleTypeDef *c)
{ ++starts; c->State = HAL_CAN_STATE_LISTENING; return HAL_OK; }
HAL_StatusTypeDef HAL_CAN_AddTxMessage(CAN_HandleTypeDef *c,
    const CAN_TxHeaderTypeDef *h, const uint8_t *tx, uint32_t *box)
{
    (void)h;
    ++sends; pending = 1U; c->Instance->TSR = 0U;
    memcpy(last_tx, tx, 8U); *box = 1U << mailbox_index; return HAL_OK;
}
HAL_StatusTypeDef HAL_CAN_GetRxMessage(CAN_HandleTypeDef *c, uint32_t fifo,
    CAN_RxHeaderTypeDef *h, uint8_t *rx)
{
    (void)c; (void)fifo;
    if (!rx_count) { return HAL_ERROR; }
    --rx_count; h->StdId = 0x321U; h->IDE = CAN_ID_STD; h->RTR = CAN_RTR_DATA; h->DLC = 8U;
    memcpy(rx, last_tx, 8U); return HAL_OK;
}
HAL_StatusTypeDef HAL_CAN_AbortTxRequest(CAN_HandleTypeDef *c, uint32_t box)
{
    (void)c; (void)box; ++aborts;
    if (fail_abort) { return HAL_ERROR; }
    if (!stuck_abort) { pending = 0U; }
    return HAL_OK;
}
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *u, uint8_t *bytes,
                                   uint16_t size, uint32_t timeout)
{
    (void)u; (void)timeout;
    if (size >= sizeof(output)) { return HAL_ERROR; }
    memcpy(output, bytes, size); output[size] = '\0';
    return fail_log ? HAL_ERROR : HAL_OK;
}

static void setup(CAN_HandleTypeDef *h, CAN_TypeDef *regs,
                  mc_can_session_hal_t *context, mc_can_session_port_t *port)
{
    static UART_HandleTypeDef uart;
    memset(h, 0, sizeof(*h)); memset(regs, 0, sizeof(*regs));
    tick = 0U; pending = 0U; rx_count = 0U; mailbox_index = 0U; free_level = 3U;
    fail_init = 0; fail_abort = 0; fail_log = 0; stuck_abort = 0;
    stops = 0U; inits = 0U; starts = 0U; sends = 0U; aborts = 0U;
    h->Instance = regs; h->State = HAL_CAN_STATE_LISTENING;
    h->Init.Prescaler = 6U; h->Init.TimeSeg1 = CAN_BS1_11TQ;
    h->Init.TimeSeg2 = CAN_BS2_2TQ;
    h->Init.AutoBusOff = ENABLE; h->Init.AutoRetransmission = ENABLE;
    *port = mc_can_session_hal_port(context, h, &uart);
}

int main(void)
{
    CAN_HandleTypeDef h;
    CAN_TypeDef regs;
    mc_can_session_hal_t context;
    mc_can_session_port_t p;
    mc_can_evidence_t evidence;
    mc_can_frame_t frame;
    uint8_t tx[8] = {1U, 2U}, rx[8];
    unsigned int i;
    setup(&h, &regs, &context, &p);
    regs.IER = 1U;
    CHECK(p.begin(p.context, MC_CAN_NORMAL) == MC_ERR_BUSY && !context.saved && stops == 0U);
    regs.IER = 0U; rx_count = 1U;
    CHECK(p.begin(p.context, MC_CAN_NORMAL) == MC_ERR_BUSY && stops == 0U);
    rx_count = 0U; free_level = 2U;
    CHECK(p.begin(p.context, MC_CAN_NORMAL) == MC_ERR_BUSY && stops == 0U);
    free_level = 3U;
    regs.RF0R = CAN_RF0R_FOVR0;
    CHECK(p.begin(p.context, MC_CAN_NORMAL) == MC_ERR_BUSY && stops == 0U);
    regs.RF0R = 0U;
#ifdef MC_ENABLE_CAN_FAULTS
    CHECK(p.begin(p.context, MC_CAN_NO_ACK) == MC_OK);
    CHECK(p.restore(p.context) == MC_OK);
#else
    CHECK(p.begin(p.context, MC_CAN_NO_ACK) == MC_ERR_UNSUPPORTED && stops == 0U);
    CHECK(p.begin(p.context, MC_CAN_BITRATE) == MC_ERR_UNSUPPORTED && stops == 0U);
#endif
    CHECK(p.begin(p.context, MC_CAN_NORMAL) == MC_OK && context.saved);
    CHECK(h.Init.AutoRetransmission == DISABLE && h.Init.AutoBusOff == DISABLE);
    for (i = 0U; i < 3U; ++i) {
        mailbox_index = i;
        CHECK(p.submit(p.context, 500000U, tx) == MC_OK);
        CHECK(p.poll_tx(p.context, &evidence) == MC_CAN_PENDING);
        regs.TSR = (CAN_TSR_RQCP0 | CAN_TSR_TXOK0) << (8U * i); pending = 0U;
        CHECK(p.poll_tx(p.context, &evidence) == MC_OK);
    }
#ifdef MC_ENABLE_CAN_FAULTS
    CHECK(p.submit(p.context, 250000U, tx) == MC_OK && h.Init.Prescaler == 12U);
#else
    CHECK(p.submit(p.context, 250000U, tx) == MC_ERR_UNSUPPORTED && h.Init.Prescaler == 6U);
    CHECK(p.submit(p.context, 500000U, tx) == MC_OK);
#endif
    regs.ESR = 3U << CAN_ESR_LEC_Pos;
    regs.TSR = CAN_TSR_RQCP2; pending = 0U;
    CHECK(p.poll_tx(p.context, &evidence) == MC_ERR_IO && evidence.first_lec == 3U);
    rx_count = 1U;
    CHECK(p.poll_rx(p.context, rx, &evidence) == MC_OK && memcmp(rx, tx, 8U) == 0);
    CHECK(p.restore(p.context) == MC_OK && !context.saved);
    CHECK(h.Init.Prescaler == 6U && h.Init.AutoBusOff == ENABLE &&
          h.Init.AutoRetransmission == ENABLE && h.State == HAL_CAN_STATE_LISTENING);
    setup(&h, &regs, &context, &p); fail_init = 1;
    CHECK(p.begin(p.context, MC_CAN_NORMAL) == MC_ERR_IO && context.saved);
    CHECK(p.restore(p.context) == MC_ERR_IO && context.saved);
    fail_init = 0;
    CHECK(p.restore(p.context) == MC_OK && !context.saved);
    setup(&h, &regs, &context, &p);
    CHECK(p.begin(p.context, MC_CAN_NORMAL) == MC_OK);
    CHECK(p.submit(p.context, 500000U, tx) == MC_OK);
    fail_abort = 1;
    CHECK(p.restore(p.context) == MC_ERR_IO && context.saved && pending);
    fail_abort = 0;
    CHECK(p.restore(p.context) == MC_OK && !context.saved && !pending);
    setup(&h, &regs, &context, &p);
    CHECK(p.begin(p.context, MC_CAN_NORMAL) == MC_OK);
    CHECK(p.submit(p.context, 500000U, tx) == MC_OK);
    stuck_abort = 1;
    CHECK(p.cancel(p.context, &evidence) == MC_ERR_TIMEOUT && tick < 20U);
    CHECK(context.saved && context.in_flight);
    stuck_abort = 0;
    CHECK(p.restore(p.context) == MC_OK);
    setup(&h, &regs, &context, &p);
    CHECK(p.begin(p.context, MC_CAN_NORMAL) == MC_OK);
    regs.ESR = CAN_ESR_BOFF;
    CHECK(p.restore(p.context) == MC_ERR_IO && context.saved);
    regs.ESR = 0U;
    CHECK(p.restore(p.context) == MC_OK && !context.saved);
    memset(&frame, 0, sizeof(frame));
    frame.mode = MC_CAN_NO_ACK; frame.transport_result = MC_ERR_IO; frame.submitted = 1U;
    frame.evidence.first_lec = 3U;
    CHECK(p.record(p.context, &frame) == MC_OK);
    CHECK(strstr(output, "\"mode\":\"noack\"") != NULL &&
          strstr(output, "\"pl\":\"unwired\"") != NULL);
    frame.run = 0xffffffffU; frame.frame = 0xffffffffU;
    frame.submitted_ms = 0xffffffffU; frame.evidence.observed_ms = 0xffffffffU;
    frame.bitrate = 500000U; frame.evidence.esr = 0xffffffffU;
    frame.evidence.tsr = 0xffffffffU; frame.evidence.rf0r = 0xffffffffU;
    CHECK(p.record(p.context, &frame) == MC_OK); /* worst-case JSON fits the buffer */
    fail_log = 1;
    CHECK(p.record(p.context, &frame) == MC_ERR_IO);
    puts("CAN HAL ownership, mailbox, evidence and restore tests passed");
    return 0;
}

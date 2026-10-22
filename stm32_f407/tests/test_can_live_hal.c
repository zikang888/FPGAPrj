#include "mc_can_live_hal.h"
#include <stdio.h>
#include <string.h>
#define CHECK(x) do { if(!(x)) { fprintf(stderr,"failed %d: %s\n",__LINE__,#x); return 1; } } while(0)
GPIO_TypeDef test_gpioa,test_gpiod;
TIM_TypeDef test_tim2;
RCC_TypeDef test_rcc;
static uint32_t ticks,pending,irq[2],priority[2],recover_ticks;
static int stuck_recovery,fail_abort,fail_init;
static CAN_HandleTypeDef *active;
static char output[1024];
void TIM2_IRQHandler(void);
void CAN1_SCE_IRQHandler(void);
uint32_t HAL_GetTick(void)
{
    if(active && (active->Instance->ESR & CAN_ESR_BOFF) &&
       active->Init.AutoBusOff==ENABLE && active->State==HAL_CAN_STATE_LISTENING && !stuck_recovery) {
        if(++recover_ticks>=3U) { active->Instance->ESR=0U; pending=0U; }
    }
    return ticks++;
}
uint32_t HAL_RCC_GetPCLK1Freq(void) { return 42000000U; }
uint32_t HAL_RCC_GetHCLKFreq(void) { return 168000000U; }
HAL_CAN_StateTypeDef HAL_CAN_GetState(CAN_HandleTypeDef *c) { return c->State; }
uint32_t HAL_CAN_GetTxMailboxesFreeLevel(CAN_HandleTypeDef *c) { (void)c; return pending?2U:3U; }
uint32_t HAL_CAN_GetRxFifoFillLevel(CAN_HandleTypeDef *c,uint32_t fifo) { (void)c; (void)fifo; return 0U; }
uint32_t HAL_CAN_IsTxMessagePending(CAN_HandleTypeDef *c,uint32_t box) { (void)c; (void)box; return pending; }
HAL_StatusTypeDef HAL_CAN_Stop(CAN_HandleTypeDef *c) { c->State=HAL_CAN_STATE_READY; return HAL_OK; }
HAL_StatusTypeDef HAL_CAN_Init(CAN_HandleTypeDef *c)
{ c->State=fail_init?HAL_CAN_STATE_ERROR:HAL_CAN_STATE_READY; return fail_init?HAL_ERROR:HAL_OK; }
HAL_StatusTypeDef HAL_CAN_Start(CAN_HandleTypeDef *c) { c->State=HAL_CAN_STATE_LISTENING; return HAL_OK; }
HAL_StatusTypeDef HAL_CAN_AddTxMessage(CAN_HandleTypeDef *c,const CAN_TxHeaderTypeDef *h,const uint8_t *data,uint32_t *box)
{ (void)h; (void)data; *box=1U; pending=1U; c->Instance->TSR=0U; return HAL_OK; }
HAL_StatusTypeDef HAL_CAN_AbortTxRequest(CAN_HandleTypeDef *c,uint32_t box)
{ (void)c; (void)box; if(fail_abort) return HAL_ERROR; pending=0U; return HAL_OK; }
HAL_StatusTypeDef HAL_CAN_GetRxMessage(CAN_HandleTypeDef *c,uint32_t fifo,CAN_RxHeaderTypeDef *h,uint8_t *data)
{ (void)c; (void)fifo; (void)h; (void)data; return HAL_ERROR; }
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *u,uint8_t *data,uint16_t n,uint32_t timeout)
{ (void)u; (void)timeout; if(n>=sizeof(output))return HAL_ERROR; memcpy(output,data,n);output[n]='\0';return HAL_OK; }
uint32_t NVIC_GetEnableIRQ(int n) { return irq[n]; }
uint32_t NVIC_GetPendingIRQ(int n) { (void)n; return 0U; }
uint32_t NVIC_GetPriority(int n) { return priority[n]; }
void NVIC_SetPriority(int n,uint32_t p) { priority[n]=p; }
void NVIC_EnableIRQ(int n) { irq[n]=1U; }
void NVIC_DisableIRQ(int n) { irq[n]=0U; }
void NVIC_ClearPendingIRQ(int n) { (void)n; }
void test_tim2_reset(void) { memset(&test_tim2,0,sizeof(test_tim2)); }
void HAL_GPIO_WritePin(GPIO_TypeDef *p,uint16_t pin,uint32_t state)
{ if(state) p->ODR|=pin; else p->ODR&=~pin; }
void HAL_GPIO_Init(GPIO_TypeDef *p,const GPIO_InitTypeDef *g)
{
    unsigned int i;
    for(i=0U;i<16U;++i) if(g->Pin & (1U<<i)) {
        MODIFY_REG(p->MODER,3U<<(i*2U),g->Mode<<(i*2U));
        MODIFY_REG(p->PUPDR,3U<<(i*2U),g->Pull<<(i*2U));
        MODIFY_REG(p->OSPEEDR,3U<<(i*2U),g->Speed<<(i*2U));
        MODIFY_REG(p->AFR[i/8U],15U<<((i%8U)*4U),g->Alternate<<((i%8U)*4U));
    }
}
static void setup(mc_can_live_hal_t *c,CAN_HandleTypeDef *can,CAN_TypeDef *regs,mc_can_session_port_t *p)
{
    static UART_HandleTypeDef uart;
    memset(can,0,sizeof(*can));memset(regs,0,sizeof(*regs));
    memset(&test_gpioa,0,sizeof(test_gpioa));memset(&test_gpiod,0,sizeof(test_gpiod));
    memset(&test_tim2,0,sizeof(test_tim2));memset(&test_rcc,0,sizeof(test_rcc));
    memset(irq,0,sizeof(irq));priority[0]=priority[1]=15U;
    ticks=0U;pending=0U;recover_ticks=0U;stuck_recovery=fail_abort=fail_init=0;
    can->Instance=regs;can->State=HAL_CAN_STATE_LISTENING;
    can->Init.Prescaler=6U;can->Init.AutoBusOff=ENABLE;can->Init.AutoRetransmission=ENABLE;
    test_gpiod.IDR=GPIO_PIN_0|GPIO_PIN_1;
    test_gpioa.MODER=0xa0000U;test_gpioa.AFR[0]=0x12000000U;
    active=can;*p=mc_can_live_hal_port(c,can,&uart);
}
static void pulse(mc_can_live_hal_t *c)
{
    test_gpiod.IDR=0U;
    TIM2->CNT=10U;TIM2->SR=TIM_SR_TIF;TIM2->CR1|=TIM_CR1_CEN;TIM2_IRQHandler();
    test_gpioa.IDR=0U;test_gpiod.IDR=GPIO_PIN_1;
    TIM2->CNT=c->timing.start_ticks+10U;TIM2->SR=TIM_SR_CC3IF;TIM2_IRQHandler();
    active->Instance->ESR=(4U<<CAN_ESR_LEC_Pos)|(8U<<16);CAN1_SCE_IRQHandler();
    TIM2->CNT=0U;TIM2->SR=TIM_SR_UIF;TIM2_IRQHandler();
}
int main(void)
{
    mc_can_live_hal_t c; CAN_HandleTypeDef can; CAN_TypeDef regs;
    mc_can_session_port_t p;mc_can_evidence_t e;uint8_t tx[8]={0,0,0,1,0,0,0,1};
    setup(&c,&can,&regs,&p);
    RCC->APB1ENR=1U;
    CHECK(p.begin(p.context,MC_CAN_LIVE_BIT)==MC_ERR_BUSY && !c.saved_can);
    RCC->APB1ENR=0U;regs.IER=1U;
    CHECK(p.begin(p.context,MC_CAN_LIVE_BIT)==MC_ERR_BUSY);
    regs.IER=0U;regs.ESR=8U<<16;
    CHECK(p.begin(p.context,MC_CAN_LIVE_BUSOFF)==MC_ERR_VERIFY && c.stats.esr_at_start==(8U<<16));
    regs.ESR=0U;
    GPIOA->MODER|=2U<<4;
    CHECK(p.begin(p.context,MC_CAN_LIVE_BIT)==MC_ERR_BUSY && !c.saved_can);
    GPIOA->MODER&=~(3U<<4);
    CHECK(p.begin(p.context,MC_CAN_LIVE_BIT)==MC_OK && c.saved_can);
    CHECK(can.Init.AutoBusOff==DISABLE && can.Init.AutoRetransmission==DISABLE && irq[0] && irq[1]);
    CHECK(p.submit(p.context,MC_CAN_LIVE_BIT,500000U,tx)==MC_OK);
    CHECK(!(TIM2->CR1 & TIM_CR1_CEN) && TIM2->SMCR!=0U); /* not software-started */
    pulse(&c);
    CHECK(c.sof_seen && c.pulse_done && c.bit_seen && TIM2->SMCR==0U && TIM2->DIER==0U);
    regs.TSR=CAN_TSR_RQCP0|CAN_TSR_TERR0;pending=0U;
    CHECK(p.poll_tx(p.context,&e)==MC_ERR_IO && e.injected && e.bit_error && e.tx_error && e.first_lec==4U);
    {
        mc_can_frame_t frame;
        memset(&frame,0,sizeof(frame));frame.mode=MC_CAN_LIVE_BIT;frame.evidence=e;
        frame.submitted=1U;frame.fault_slot=1U;frame.transport_result=MC_ERR_IO;
        CHECK(p.record(p.context,&frame)==MC_OK);
        CHECK(strstr(output,"\"bit_error\":1") && strstr(output,"\"submitted\":1"));
    }
    CHECK(p.restore(p.context)==MC_OK && !c.saved_can);
    CHECK(can.Init.AutoBusOff==ENABLE && can.Init.AutoRetransmission==ENABLE && !irq[0] && !irq[1]);
    CHECK(GPIOA->MODER==0xa0000U && GPIOA->AFR[0]==0x12000000U && RCC->APB1ENR==0U);
    setup(&c,&can,&regs,&p);
    CHECK(p.begin(p.context,MC_CAN_LIVE_BIT)==MC_OK);
    CHECK(p.submit(p.context,MC_CAN_LIVE_BIT,500000U,tx)==MC_OK);
    regs.TSR=CAN_TSR_RQCP0|CAN_TSR_TXOK0;pending=0U; /* disconnected SOF jumper: valid frame, no injection */
    CHECK(p.poll_tx(p.context,&e)==MC_OK && !e.injected && !e.bit_error);
    CHECK(p.restore(p.context)==MC_OK);
    setup(&c,&can,&regs,&p);
    CHECK(p.begin(p.context,MC_CAN_LIVE_BIT)==MC_OK);
    CHECK(p.submit(p.context,MC_CAN_LIVE_BIT,500000U,tx)==MC_OK);
    TIM2->CNT=10U;TIM2->SR=TIM_SR_TIF;TIM2_IRQHandler(); /* PA1 noise while A TXD stays high */
    CHECK(c.pulse_error==MC_ERR_VERIFY && !c.pulse_done);
    CHECK(p.restore(p.context)==MC_OK);
    setup(&c,&can,&regs,&p);
    CHECK(p.begin(p.context,MC_CAN_LIVE_BIT)==MC_OK);
    CHECK(p.submit(p.context,MC_CAN_LIVE_BIT,500000U,tx)==MC_OK);
    TIM2->CNT=0U;TIM2->SR=TIM_SR_TIF|TIM_SR_UIF|TIM_SR_CC3IF;TIM2_IRQHandler();
    CHECK(c.pulse_error==MC_ERR_TIMEOUT && !c.pulse_done); /* late ISR even after CNT wrapped to zero */
    CHECK(p.restore(p.context)==MC_OK);
    setup(&c,&can,&regs,&p);
    CHECK(p.begin(p.context,MC_CAN_LIVE_BUSOFF)==MC_OK);
    CHECK(p.submit(p.context,MC_CAN_LIVE_BUSOFF,500000U,tx)==MC_OK);pulse(&c);
    regs.ESR=CAN_ESR_BOFF|(255U<<16);CAN1_SCE_IRQHandler();
    CHECK(p.poll_tx(p.context,&e)==MC_ERR_IO && (e.esr & CAN_ESR_BOFF));
    stuck_recovery=1;
    CHECK(p.restore(p.context)==MC_ERR_TIMEOUT && c.saved_can && c.stats.busoff_seen && !c.stats.recovered);
    CHECK(!irq[0] && !irq[1] && RCC->APB1ENR==0U);
    stuck_recovery=0;
    CHECK(p.restore(p.context)==MC_OK && !c.saved_can && c.stats.recovered);
    CHECK(c.stats.esr_before_recovery & CAN_ESR_BOFF);
    CHECK(strstr(output,"\"recovered\":1")!=NULL);
    setup(&c,&can,&regs,&p);fail_init=1;
    CHECK(p.begin(p.context,MC_CAN_LIVE_BIT)==MC_ERR_IO && c.saved_can);
    CHECK(p.restore(p.context)==MC_ERR_IO && c.saved_can);
    fail_init=0;CHECK(p.restore(p.context)==MC_OK);
    puts("LIVE real adapter model: SOF, pulse, evidence, late IRQ, BOFF and recovery PASS");
    return 0;
}

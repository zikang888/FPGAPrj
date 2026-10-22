#ifndef TEST_STM32F4_HAL_H
#define TEST_STM32F4_HAL_H
#include <stdint.h>

typedef enum { HAL_OK, HAL_ERROR } HAL_StatusTypeDef;
typedef enum { HAL_CAN_STATE_RESET, HAL_CAN_STATE_READY, HAL_CAN_STATE_LISTENING,
               HAL_CAN_STATE_ERROR } HAL_CAN_StateTypeDef;
typedef enum { DISABLE, ENABLE } FunctionalState;
typedef struct { uint32_t ESR, TSR, RF0R, IER, MCR, MSR; } CAN_TypeDef;
typedef struct {
    uint32_t Prescaler, Mode, SyncJumpWidth, TimeSeg1, TimeSeg2;
    FunctionalState AutoRetransmission, AutoBusOff;
} CAN_InitTypeDef;
typedef struct { CAN_TypeDef *Instance; CAN_InitTypeDef Init; HAL_CAN_StateTypeDef State; } CAN_HandleTypeDef;
typedef struct { int unused; } UART_HandleTypeDef;
typedef struct { uint32_t StdId, IDE, RTR, DLC; } CAN_TxHeaderTypeDef;
typedef CAN_TxHeaderTypeDef CAN_RxHeaderTypeDef;

#define CAN_ESR_LEC 0x70U
#define CAN_ESR_LEC_Pos 4U
#define CAN_ESR_BOFF 4U
#define CAN_RF0R_FOVR0 0x10U
#define CAN_TSR_RQCP0 1U
#define CAN_TSR_RQCP1 0x100U
#define CAN_TSR_RQCP2 0x10000U
#define CAN_TSR_TXOK0 2U
#define CAN_TSR_TERR0 8U
#define CAN_TX_MAILBOX0 1U
#define CAN_TX_MAILBOX1 2U
#define CAN_TX_MAILBOX2 4U
#define CAN_RX_FIFO0 0U
#define CAN_RX_FIFO1 1U
#define CAN_MODE_NORMAL 0U
#define CAN_SJW_1TQ 0U
#define CAN_BS1_11TQ 0x000a0000U
#define CAN_BS2_2TQ 0x00100000U
#define CAN_ID_STD 0U
#define CAN_RTR_DATA 0U
#define CLEAR_BIT(reg, bits) ((reg) &= ~(bits))

uint32_t HAL_GetTick(void);
uint32_t HAL_RCC_GetPCLK1Freq(void);
HAL_CAN_StateTypeDef HAL_CAN_GetState(CAN_HandleTypeDef *can);
uint32_t HAL_CAN_GetTxMailboxesFreeLevel(CAN_HandleTypeDef *can);
uint32_t HAL_CAN_GetRxFifoFillLevel(CAN_HandleTypeDef *can, uint32_t fifo);
uint32_t HAL_CAN_IsTxMessagePending(CAN_HandleTypeDef *can, uint32_t mailbox);
HAL_StatusTypeDef HAL_CAN_Stop(CAN_HandleTypeDef *can);
HAL_StatusTypeDef HAL_CAN_Init(CAN_HandleTypeDef *can);
HAL_StatusTypeDef HAL_CAN_Start(CAN_HandleTypeDef *can);
HAL_StatusTypeDef HAL_CAN_AddTxMessage(CAN_HandleTypeDef *can,
    const CAN_TxHeaderTypeDef *header, const uint8_t *tx, uint32_t *mailbox);
HAL_StatusTypeDef HAL_CAN_GetRxMessage(CAN_HandleTypeDef *can, uint32_t fifo,
    CAN_RxHeaderTypeDef *header, uint8_t *rx);
HAL_StatusTypeDef HAL_CAN_AbortTxRequest(CAN_HandleTypeDef *can, uint32_t mailbox);
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *uart, uint8_t *bytes,
                                   uint16_t size, uint32_t timeout);

/* TIM2/CAN-SCE live adapter model. No production hardware addresses are used. */
typedef struct { uint32_t MODER, OTYPER, OSPEEDR, PUPDR, AFR[2], ODR, IDR, BSRR; } GPIO_TypeDef;
typedef struct { uint32_t CR1, DIER, CCER, CCMR1, CCMR2, SMCR, CNT, PSC, ARR, CCR3, SR, EGR; } TIM_TypeDef;
typedef struct { uint32_t APB1ENR; } RCC_TypeDef;
extern GPIO_TypeDef test_gpioa, test_gpiod;
extern TIM_TypeDef test_tim2;
extern RCC_TypeDef test_rcc;
#define GPIOA (&test_gpioa)
#define GPIOD (&test_gpiod)
#define TIM2 (&test_tim2)
#define RCC (&test_rcc)
#define GPIO_PIN_0 1U
#define GPIO_PIN_1 2U
#define GPIO_PIN_2 4U
#define GPIO_MODE_AF_PP 2U
#define GPIO_PULLUP 1U
#define GPIO_NOPULL 0U
#define GPIO_SPEED_FREQ_VERY_HIGH 3U
#define GPIO_AF1_TIM2 1U
#define GPIO_PIN_SET 1U
typedef struct { uint32_t Pin, Mode, Pull, Speed, Alternate; } GPIO_InitTypeDef;
void HAL_GPIO_Init(GPIO_TypeDef *port, const GPIO_InitTypeDef *pin);
void HAL_GPIO_WritePin(GPIO_TypeDef *port, uint16_t pin, uint32_t state);
#define TIM2_IRQn 0
#define CAN1_SCE_IRQn 1
uint32_t NVIC_GetEnableIRQ(int irq);
uint32_t NVIC_GetPendingIRQ(int irq);
uint32_t NVIC_GetPriority(int irq);
void NVIC_SetPriority(int irq, uint32_t priority);
void NVIC_EnableIRQ(int irq);
void NVIC_DisableIRQ(int irq);
void NVIC_ClearPendingIRQ(int irq);
uint32_t HAL_RCC_GetHCLKFreq(void);
void test_tim2_reset(void);
#define RCC_APB1ENR_TIM2EN 1U
#define __HAL_RCC_TIM2_CLK_ENABLE() (test_rcc.APB1ENR |= 1U)
#define __HAL_RCC_TIM2_CLK_DISABLE() (test_rcc.APB1ENR &= ~1U)
#define __HAL_RCC_TIM2_FORCE_RESET() test_tim2_reset()
#define __HAL_RCC_TIM2_RELEASE_RESET() ((void)0)
#define TIM_CR1_CEN 1U
#define TIM_CR1_URS 4U
#define TIM_CR1_OPM 8U
#define TIM_CR1_ARPE 128U
#define TIM_DIER_UIE 1U
#define TIM_DIER_CC3IE 8U
#define TIM_DIER_TIE 64U
#define TIM_SR_UIF 1U
#define TIM_SR_CC3IF 8U
#define TIM_SR_TIF 64U
#define TIM_SMCR_TS_2 64U
#define TIM_SMCR_TS_1 32U
#define TIM_SMCR_SMS_2 4U
#define TIM_SMCR_SMS_1 2U
#define TIM_CCMR1_CC2S_0 0x100U
#define TIM_CCMR2_OC3M 0x70U
#define TIM_CCMR2_OC3M_2 0x40U
#define TIM_CCER_CC2E 0x10U
#define TIM_CCER_CC2P 0x20U
#define TIM_CCER_CC3E 0x100U
#define TIM_CCER_CC3P 0x200U
#define TIM_EGR_UG 1U
#define CAN_IT_ERROR 0x8000U
#define CAN_IT_LAST_ERROR_CODE 0x800U
#define CAN_IT_BUSOFF 0x400U
#define CAN_IT_ERROR_PASSIVE 0x200U
#define CAN_IT_ERROR_WARNING 0x100U
#define CAN_FLAG_ERRI 1U
#define __HAL_CAN_CLEAR_FLAG(can,flag) ((void)(flag), (can)->Instance->MSR = 0U)
#define MODIFY_REG(reg,clear,set) ((reg) = (((reg) & ~(clear)) | (set)))
#endif

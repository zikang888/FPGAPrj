#ifndef TEST_STM32F4_HAL_H
#define TEST_STM32F4_HAL_H
#include <stdint.h>

typedef enum { HAL_OK, HAL_ERROR } HAL_StatusTypeDef;
typedef enum { HAL_CAN_STATE_RESET, HAL_CAN_STATE_READY, HAL_CAN_STATE_LISTENING,
               HAL_CAN_STATE_ERROR } HAL_CAN_StateTypeDef;
typedef enum { DISABLE, ENABLE } FunctionalState;
typedef struct { uint32_t ESR, TSR, RF0R, IER; } CAN_TypeDef;
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
#endif

#ifndef TEST_BOARD_HAL_H
#define TEST_BOARD_HAL_H
#include <stdint.h>
typedef enum { HAL_OK, HAL_ERROR } HAL_StatusTypeDef;
typedef enum { GPIO_PIN_RESET, GPIO_PIN_SET } GPIO_PinState;
typedef struct { int unused; } GPIO_TypeDef;
typedef struct { int unused; } SPI_HandleTypeDef;
typedef struct { int unused; } I2C_HandleTypeDef;
typedef struct { uint32_t RxState; void *Instance; } UART_HandleTypeDef;
typedef struct { int unused; } CAN_InitTypeDef;
typedef struct { CAN_InitTypeDef Init; } CAN_HandleTypeDef;
typedef struct { int unused; } DMA_HandleTypeDef;
typedef struct {
    uint32_t FilterBank, FilterMode, FilterScale, FilterIdHigh, FilterIdLow;
    uint32_t FilterMaskIdHigh, FilterMaskIdLow, FilterFIFOAssignment;
    uint32_t FilterActivation, SlaveStartFilterBank;
} CAN_FilterTypeDef;
extern GPIO_TypeDef test_board_gpio[3];
#define GPIOA (&test_board_gpio[0])
#define GPIOB (&test_board_gpio[1])
#define GPIOC (&test_board_gpio[2])
#define GPIO_PIN_0 1U
#define GPIO_PIN_2 4U
#define GPIO_PIN_4 16U
#define GPIO_PIN_6 64U
#define HAL_UART_STATE_READY 0U
#define USART1 ((void *)(uintptr_t)1U)
#define CAN_FILTERMODE_IDMASK 0U
#define CAN_FILTERSCALE_32BIT 0U
#define CAN_RX_FIFO0 0U
#define ENABLE 1U
uint32_t HAL_GetTick(void);
void HAL_Delay(uint32_t delay);
GPIO_PinState HAL_GPIO_ReadPin(GPIO_TypeDef *port, uint16_t pin);
void HAL_GPIO_WritePin(GPIO_TypeDef *port, uint16_t pin, GPIO_PinState state);
HAL_StatusTypeDef HAL_UART_Transmit(UART_HandleTypeDef *uart, uint8_t *data, uint16_t length, uint32_t timeout);
HAL_StatusTypeDef HAL_UART_Receive_IT(UART_HandleTypeDef *uart, uint8_t *data, uint16_t length);
HAL_StatusTypeDef HAL_CAN_ConfigFilter(CAN_HandleTypeDef *can, const CAN_FilterTypeDef *filter);
HAL_StatusTypeDef HAL_CAN_Start(CAN_HandleTypeDef *can);
#endif

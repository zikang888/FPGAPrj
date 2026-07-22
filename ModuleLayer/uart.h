#ifndef __UART_H__
#define __UART_H__

#include "main.h"

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart);

void uart_work(void const * argument);

#endif
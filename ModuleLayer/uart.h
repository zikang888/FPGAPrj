#ifndef __UART_H__
#define __UART_H__

#include "main.h"

/* 发送参数数据到 ZYNQ (带CRC校验) */
void UART_SendParams(void);

/* FreeRTOS work function - 覆盖 freertos.c 中的 __weak 函数 */
void uart_work(void const * argument);

#endif

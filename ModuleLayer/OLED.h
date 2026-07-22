#ifndef __OLED_H__
#define __OLED_H__

#include "main.h"

/* OLED API */
void OLED_Init(void);
void OLED_Clear(void);
void OLED_ShowChar(uint8_t Line, uint8_t Column, char Char);
void OLED_ShowString(uint8_t Line, uint8_t Column, char *String);
void OLED_ShowNum(uint8_t Line, uint8_t Column, uint32_t Number, uint8_t Length);

/* FreeRTOS work function - ¸²¸Ç freertos.c ÖÐµÄ __weak º¯Êý */
void oled_work(void const * argument);

#endif

#ifndef __KEY_H__
#define __KEY_H__

#include "main.h"
#include "cmsis_os.h"

typedef struct {
    uint8_t  freq;              /* 载波频率: 30~40 MHz */
    uint16_t amplitude;         /* 直达信号幅度有效值: 100~1000 mV */
    uint8_t  modulation;        /* AM调制度: 30~90 % */
    uint8_t  delay;             /* 多径信号时延 index: 0~5 */
    uint8_t  phase;             /* 多径信号初相位差 index: 0~6 */
    uint8_t  attenuation;       /* 多径信号幅度衰减 index: 0~10 */
    uint8_t  signal_type;       /* 信号类型: 0=CW, 1=AM */
    uint8_t  final_out;         /* 最终输出选择: 0=SD, 1=SM, 2=Sout */
} MenuParams;

typedef struct {
    uint8_t  in_submenu;        /* 0=主菜单 */
    uint8_t  current_index;     /* 当前显示起始项 */
    uint8_t  edit_mode;         /* 0=浏览 */
    volatile uint8_t params_changed; /* 参数有变化 */
    volatile uint8_t display_dirty;  /* 1=需要刷新OLED显示 */
    MenuParams params;
} MenuState;

extern MenuState g_menu;

void Menu_DisplayUpdate(void);

void key_work(void const * argument);

void uart_work(void const * argument);

#endif
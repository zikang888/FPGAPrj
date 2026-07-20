#ifndef __KEY_H__
#define __KEY_H__

#include "main.h"
#include "cmsis_os.h"

/* 按键事件枚举 */
typedef enum {
    KEY_EVENT_NONE,
    KEY_EVENT_UP,
    KEY_EVENT_DOWN,
    KEY_EVENT_OK_SINGLE,    /* 确认键按一次 */
    KEY_EVENT_OK_DOUBLE,    /* 确认键连续按两次 */
} KeyEvent;

/* ========== 菜单参数结构体 ========== */
typedef struct {
    /* 当前参数值 */
    uint8_t  freq;              /* 载波频率: 30~40 MHz */
    uint16_t amplitude;         /* 直达信号幅度有效值: 100~1000 mV */
    uint8_t  modulation;        /* AM调制度: 30~90 % */
    uint8_t  delay;             /* 多径信号时延 index: 0~5 (映射50~200ns, 步进30) */
    uint8_t  phase;             /* 多径信号初相位差 index: 0~6 (映射0~180度, 步进30) */
    uint8_t  attenuation;       /* 多径信号幅度衰减 index: 0~10 (映射0~20dB, 步进2) */
    uint8_t  signal_type;       /* 信号类型: 0=CW, 1=AM */
    uint8_t  final_out;         /* 最终输出选择: 0=SD(直达), 1=SM(多径), 2=Sout(输出) */
} MenuParams;

/* 菜单状态 */
typedef struct {
    uint8_t  in_submenu;        /* 0=主菜单, 1=子菜单 */
    uint8_t  current_index;     /* 当前选中项 (0~7) */
    uint8_t  edit_mode;         /* 0=浏览, 1=编辑中 */
    volatile uint8_t params_changed; /* 参数有变化, UART需发送 */
    volatile uint8_t display_dirty;  /* 1=需要刷新OLED显示 */
    MenuParams params;
} MenuState;

/* 暴露给其他模块 */
extern MenuState g_menu;

/* KEY API */
void KEY_Scan(KeyEvent *event);

/* 菜单 API — 由 key_work 驱动 */
void Menu_ProcessEvent(KeyEvent event);
void Menu_DisplayUpdate(void);

/* FreeRTOS work function - 覆盖 freertos.c 中的 __weak 函数 */
void key_work(void const * argument);

/* FreeRTOS work function - 覆盖 freertos.c 中的 __weak 函数 */
void uart_work(void const * argument);

#endif

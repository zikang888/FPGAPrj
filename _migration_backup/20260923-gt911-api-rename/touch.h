/**
 * touch.h — Goodix GT9147 触摸驱动
 *
 * I2C0 (MIO 50-51), 7-bit address 0x14
 * TP_INT: MIO 0 (地址选择期间输出，运行期间中断输入)
 * TP_RST: EMIO[0] (PS GPIO pin 54, package pin R15)
 */
#ifndef TOUCH_H_
#define TOUCH_H_

#include "xil_types.h"

/* Native GT911 coordinate range used by the panel configuration. */
#define GT9147_RAW_WIDTH   800U
#define GT9147_RAW_HEIGHT  480U

typedef struct {
    u8  Touched;
    u8  Touched_Last;
    u8  Touch_Num;
    u16 Tp_X[5];
    u16 Tp_Y[5];
} TouchData;

extern TouchData TouchInfo;

int  gt9147_init(void);
void gt9147_scan(TouchData *p);
u8   gt9147_event_pending(void);
u8   gt9147_debug_state(void);
u8   gt9147_get_addr(void);    // 返回当前I2C地址

#endif

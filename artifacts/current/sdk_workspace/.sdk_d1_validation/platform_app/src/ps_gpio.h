/**
 * ps_gpio.h — PS GPIO 驱动封装 (基于 XGpioPs)
 * MIO 0 = TP_INT, EMIO[0] (pin 54, package pin R15) = TP_RST
 */
#ifndef PS_GPIO_H_
#define PS_GPIO_H_

#include "xgpiops.h"
#include "xparameters.h"

#define GPIO_DEV_ID   XPAR_XGPIOPS_0_DEVICE_ID

#define OUTPUT  1
#define INPUT   0

int  gpio_init(void);
void gpio_set_mode(u8 pin, u8 dir, u8 data);
void gpio_write(u8 pin, u8 data);
u8   gpio_read(u8 pin);
int  gpio_interrupt_init(u8 pin, u8 irq_type);
u8   gpio_interrupt_consume(void);

#endif

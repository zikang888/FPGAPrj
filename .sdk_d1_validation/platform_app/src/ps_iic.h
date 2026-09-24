/**
 * ps_iic.h — PS I2C 驱动封装 (基于 XIicPs)
 * 用于 GT911 触摸芯片 (I2C0, MIO 50-51, addr 0x14)
 */
#ifndef PS_IIC_H_
#define PS_IIC_H_

#include "xparameters.h"
#include "xiicps.h"

#define IIC_DEV_ID    XPAR_XIICPS_0_DEVICE_ID  // I2C0
#define IIC_CLK_FREQ  400000U                    // GT911 recommended maximum: 400kHz

int  iic_init(void);
int  iic_is_ok(void);
int  iic_write_reg(u8 dev_addr, u16 reg_addr, const u8 *data, u16 len);
int  iic_read_reg(u8 dev_addr, u16 reg_addr, u8 *data, u16 len);

#endif

/**
 * ps_iic.c — PS I2C 驱动 (带超时, 防止卡死)
 */
#include "ps_iic.h"

static XIicPs IicInst;
static int iic_ok = 0;  // I2C是否正常

int iic_init(void)
{
    XIicPs_Config *Config;
    int Status;

    iic_ok = 0;
    Config = XIicPs_LookupConfig(IIC_DEV_ID);
    if (!Config) return XST_FAILURE;

    Status = XIicPs_CfgInitialize(&IicInst, Config, Config->BaseAddress);
    if (Status != XST_SUCCESS) return XST_FAILURE;

    Status = XIicPs_SetSClk(&IicInst, IIC_CLK_FREQ);
    if (Status != XST_SUCCESS) return XST_FAILURE;

    iic_ok = 1;
    return XST_SUCCESS;
}

int iic_is_ok(void) { return iic_ok; }

int iic_write_reg(u8 dev_addr, u16 reg_addr, const u8 *data, u16 len)
{
    u8 buf[256];
    int ret, timeout;

    if (!iic_ok) return -1;
    if (len + 2 > 256) return -1;

    buf[0] = (u8)(reg_addr >> 8);
    buf[1] = (u8)(reg_addr & 0xFF);
    memcpy(buf + 2, data, len);

    ret = XIicPs_MasterSendPolled(&IicInst, buf, len + 2, dev_addr);
    if (ret != XST_SUCCESS) return -1;

    timeout = 100000;
    while (XIicPs_BusIsBusy(&IicInst)) {
        if (--timeout == 0) return -1;
    }
    return 0;
}

int iic_read_reg(u8 dev_addr, u16 reg_addr, u8 *data, u16 len)
{
    u8 wr[2];
    int ret, timeout;

    if (!iic_ok) return -1;

    wr[0] = (u8)(reg_addr >> 8);
    wr[1] = (u8)(reg_addr & 0xFF);

    ret = XIicPs_MasterSendPolled(&IicInst, wr, 2, dev_addr);
    if (ret != XST_SUCCESS) return -1;

    timeout = 100000;
    while (XIicPs_BusIsBusy(&IicInst)) {
        if (--timeout == 0) return -1;
    }

    ret = XIicPs_MasterRecvPolled(&IicInst, data, len, dev_addr);
    if (ret != XST_SUCCESS) return -1;

    timeout = 100000;
    while (XIicPs_BusIsBusy(&IicInst)) {
        if (--timeout == 0) return -1;
    }
    return 0;
}

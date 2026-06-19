#include "OLED.h"
#include "OLED_Font.h"
#include "i2c.h"
#include "cmsis_os.h"

#define OLED_ADDR       (0x3C << 1)   /* I2C 设备地址 0x78 */
#define OLED_CMD        0x00          /* 命令模式 */
#define OLED_DATA       0x40          /* 数据模式 */

/* 写命令 */
static void OLED_WriteCommand(uint8_t cmd)
{
    HAL_I2C_Mem_Write(&hi2c1, OLED_ADDR, OLED_CMD, I2C_MEMADD_SIZE_8BIT, &cmd, 1, 100);
}

/* 写数据 (逐字节, 兼容性好) */
static void OLED_WriteData(uint8_t data)
{
    HAL_I2C_Mem_Write(&hi2c1, OLED_ADDR, OLED_DATA, I2C_MEMADD_SIZE_8BIT, &data, 1, 100);
}

/* 设置光标位置 */
static void OLED_SetCursor(uint8_t y, uint8_t x)
{
    OLED_WriteCommand(0xB0 | y);                     /* 页地址 (0~7) */
    OLED_WriteCommand(0x10 | ((x & 0xF0) >> 4));    /* 列高4位 */
    OLED_WriteCommand(0x00 | (x & 0x0F));            /* 列低4位 */
}

/* 清屏 */
void OLED_Clear(void)
{
    uint8_t i, j;
    for (j = 0; j < 8; j++)
    {
        OLED_SetCursor(j, 0);
        for (i = 0; i < 128; i++)
        {
            OLED_WriteData(0x00);
        }
    }
}

/* 显示一个字符 (Line:1~4, Column:1~16) */
void OLED_ShowChar(uint8_t Line, uint8_t Column, char Char)
{
    uint8_t i;
    uint8_t idx = (uint8_t)(Char - ' ');
    OLED_SetCursor((Line - 1) * 2, (Column - 1) * 8);
    for (i = 0; i < 8; i++)
        OLED_WriteData(OLED_F8x16[idx][i]);
    OLED_SetCursor((Line - 1) * 2 + 1, (Column - 1) * 8);
    for (i = 0; i < 8; i++)
        OLED_WriteData(OLED_F8x16[idx][i + 8]);
}

/* 显示字符串 */
void OLED_ShowString(uint8_t Line, uint8_t Column, char *String)
{
    uint8_t i;
    for (i = 0; String[i] != '\0'; i++)
    {
        OLED_ShowChar(Line, Column + i, String[i]);
    }
}

/* 内部幂函数 */
static uint32_t OLED_Pow(uint32_t x, uint32_t y)
{
    uint32_t result = 1;
    while (y--) result *= x;
    return result;
}

/* 显示十进制数字 */
void OLED_ShowNum(uint8_t Line, uint8_t Column, uint32_t Number, uint8_t Length)
{
    uint8_t i;
    for (i = 0; i < Length; i++)
    {
        OLED_ShowChar(Line, Column + i,
            (uint8_t)(Number / OLED_Pow(10, Length - i - 1) % 10) + '0');
    }
}

/* OLED 初始化 (SSD1306, 128x64) */
void OLED_Init(void)
{
    uint32_t i, j;
    /* 上电延时 */
    for (i = 0; i < 1000; i++)
        for (j = 0; j < 1000; j++);

    OLED_WriteCommand(0xAE);    /* 关闭显示 */
    OLED_WriteCommand(0xD5);    /* 设置显示时钟分频 */
    OLED_WriteCommand(0x80);
    OLED_WriteCommand(0xA8);    /* 设置多路复用率 */
    OLED_WriteCommand(0x3F);
    OLED_WriteCommand(0xD3);    /* 设置显示偏移 */
    OLED_WriteCommand(0x00);
    OLED_WriteCommand(0x40);    /* 设置显示开始行 */
    OLED_WriteCommand(0xA1);    /* 左右方向正常 */
    OLED_WriteCommand(0xC8);    /* 上下方向正常 */
    OLED_WriteCommand(0xDA);    /* COM引脚配置 */
    OLED_WriteCommand(0x12);
    OLED_WriteCommand(0x81);    /* 对比度 */
    OLED_WriteCommand(0xCF);
    OLED_WriteCommand(0xD9);    /* 预充电周期 */
    OLED_WriteCommand(0xF1);
    OLED_WriteCommand(0xDB);    /* VCOMH */
    OLED_WriteCommand(0x30);
    OLED_WriteCommand(0xA4);    /* 全局显示开启 */
    OLED_WriteCommand(0xA6);    /* 正常显示 */
    OLED_WriteCommand(0x8D);    /* 充电泵 */
    OLED_WriteCommand(0x14);
    OLED_WriteCommand(0xAF);    /* 开启显示 */

    OLED_Clear();
}

/* ========== FreeRTOS __weak 覆盖函数 ========== */
/* 在 freertos.c 中 oled_work 被声明为 __weak, 此处定义将覆盖它 */
void oled_work(void const * argument)
{
    /* 任务启动时初始化 OLED */
    OLED_Init();

    for (;;)
    {
        /* OLED 显示更新由菜单状态机驱动, 见 KEY.c 中的 menu_work */
        /* 本任务仅保持存活, 实际显示由 key_work 中的菜单状态机触发 */
        /* 但为了确保显示更新, 这里也定期调用菜单显示刷新 */
        extern void Menu_DisplayUpdate(void);
        Menu_DisplayUpdate();
        osDelay(50);
    }
}

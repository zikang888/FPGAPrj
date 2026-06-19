#include "uart.h"
#include "KEY.h"
#include "usart.h"
#include <string.h>

/*
 * UART 数据帧格式 (发送给 ZYNQ):
 *   $F035A0500M50D110P000L00TCW*<CRC2>\r\n
 *
 * 字段说明:
 *   F   — 载波频率 (30~40 MHz), 3位数字, 如 F035
 *   A   — 直达信号幅度有效值 (100~1000 mV), 4位数字, 如 A0500
 *   M   — AM调制度 (30~90 %), 2位数字, 如 M50
 *   D   — 多径信号时延 (50~200 ns), 3位数字, 如 D110
 *   P   — 多径信号初相位差 (0~180 deg), 3位数字, 如 P000
 *   L   — 多径信号幅度衰减 (0~20 dB), 2位数字, 如 L00
 *   T   — 信号类型, CW 或 AM, 如 TCW
 *   CRC — CRC8 校验值, 2个十六进制字符
 */

/* 延时映射表 */
static const uint16_t DELAY_TABLE[] = {50, 80, 110, 140, 170, 200};
static const uint8_t  PHASE_TABLE[] = {0, 30, 60, 90, 120, 150, 180};
static const uint8_t  ATTN_TABLE[] = {0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20};

/* ========== CRC8 计算 (多项式 0x31, 初始值 0x00) ========== */
/* 适用于 MAXIM/Dallas 1-Wire CRC-8 */
static uint8_t CalcCRC8(const uint8_t *data, uint16_t len)
{
    uint8_t crc = 0x00;
    uint16_t i, j;
    for (i = 0; i < len; i++)
    {
        crc ^= data[i];
        for (j = 0; j < 8; j++)
        {
            if (crc & 0x80)
                crc = (uint8_t)((crc << 1) ^ 0x31);
            else
                crc = (uint8_t)(crc << 1);
        }
    }
    return crc;
}

/* ========== 发送参数数据 ========== */
void UART_SendParams(void)
{
    uint8_t tx_buf[64];
    uint8_t idx = 0;
    uint8_t crc_data[32];
    uint8_t crc_len = 0;
    uint8_t crc_val, i;
    char crc_hex[3];

    /* 构造数据帧: $ ... */
    tx_buf[idx++] = '$';

    /* --- F: 载波频率 (3位) --- */
    tx_buf[idx++] = 'F';
    tx_buf[idx++] = '0' + (g_menu.params.freq / 100);
    tx_buf[idx++] = '0' + ((g_menu.params.freq % 100) / 10);
    tx_buf[idx++] = '0' + (g_menu.params.freq % 10);

    /* --- A: 幅度 (4位) --- */
    tx_buf[idx++] = 'A';
    tx_buf[idx++] = '0' + (g_menu.params.amplitude / 1000);
    tx_buf[idx++] = '0' + ((g_menu.params.amplitude % 1000) / 100);
    tx_buf[idx++] = '0' + ((g_menu.params.amplitude % 100) / 10);
    tx_buf[idx++] = '0' + (g_menu.params.amplitude % 10);

    /* --- M: 调制度 (2位) --- */
    tx_buf[idx++] = 'M';
    tx_buf[idx++] = '0' + (g_menu.params.modulation / 10);
    tx_buf[idx++] = '0' + (g_menu.params.modulation % 10);

    /* --- D: 时延 (3位) --- */
    {
        uint16_t d = DELAY_TABLE[g_menu.params.delay];
        tx_buf[idx++] = 'D';
        tx_buf[idx++] = '0' + (d / 100);
        tx_buf[idx++] = '0' + ((d % 100) / 10);
        tx_buf[idx++] = '0' + (d % 10);
    }

    /* --- P: 相位 (3位) --- */
    {
        uint8_t p = PHASE_TABLE[g_menu.params.phase];
        tx_buf[idx++] = 'P';
        tx_buf[idx++] = '0' + (p / 100);
        tx_buf[idx++] = '0' + ((p % 100) / 10);
        tx_buf[idx++] = '0' + (p % 10);
    }

    /* --- L: 衰减 (2位) --- */
    {
        uint8_t l = ATTN_TABLE[g_menu.params.attenuation];
        tx_buf[idx++] = 'L';
        tx_buf[idx++] = '0' + (l / 10);
        tx_buf[idx++] = '0' + (l % 10);
    }

    /* --- T: 信号类型 (2字符) --- */
    tx_buf[idx++] = 'T';
    if (g_menu.params.signal_type)
    {
        tx_buf[idx++] = 'A';
        tx_buf[idx++] = 'M';
    }
    else
    {
        tx_buf[idx++] = 'C';
        tx_buf[idx++] = 'W';
    }

    /* --- CRC: 对 $ 之后到 * 之前的数据计算 CRC8 --- */
    crc_len = idx - 1;  /* 跳过 '$' */
    for (i = 0; i < crc_len; i++)
        crc_data[i] = tx_buf[i + 1];

    crc_val = CalcCRC8(crc_data, crc_len);

    /* 追加 * 和 CRC 十六进制 */
    tx_buf[idx++] = '*';
    crc_hex[0] = (crc_val >> 4) > 9 ? (crc_val >> 4) - 10 + 'A' : (crc_val >> 4) + '0';
    crc_hex[1] = (crc_val & 0x0F) > 9 ? (crc_val & 0x0F) - 10 + 'A' : (crc_val & 0x0F) + '0';
    crc_hex[2] = '\0';
    tx_buf[idx++] = (uint8_t)crc_hex[0];
    tx_buf[idx++] = (uint8_t)crc_hex[1];

    /* 追加 \r\n */
    tx_buf[idx++] = '\r';
    tx_buf[idx++] = '\n';

    /* 通过 UART1 发送 */
    HAL_UART_Transmit(&huart1, tx_buf, idx, 1000);
}

/* ========== FreeRTOS __weak 覆盖函数: uart_work ========== */
void uart_work(void const * argument)
{
    uint8_t last_params[7] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};

    for (;;)
    {
        /* 检查参数是否变化 */
        if (g_menu.params_changed)
        {
            /* 确认确有变化, 避免重复发送 */
            uint8_t curr[7] = {
                g_menu.params.freq,
                (uint8_t)(g_menu.params.amplitude >> 8),
                (uint8_t)(g_menu.params.amplitude & 0xFF),
                g_menu.params.modulation,
                g_menu.params.delay,
                g_menu.params.phase,
                g_menu.params.attenuation
            };

            if (memcmp(last_params, curr, 7) != 0)
            {
                memcpy(last_params, curr, 7);
                UART_SendParams();
            }
            g_menu.params_changed = 0;
        }
        osDelay(100); /* 100ms 检测周期 */
    }
}

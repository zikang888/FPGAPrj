#include "uart.h"
#include "KEY.h"
#include "usart.h"
#include <string.h>

#define FRAME_LEN        10
#define FRAME_SYNC       0xAA

static const uint16_t DELAY_TABLE[] = {50, 80, 110, 140, 170, 200};
static const uint8_t  PHASE_TABLE[] = {0, 30, 60, 90, 120, 150, 180};
static const uint8_t  ATTN_TABLE[]  = {0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20};
static const uint8_t  MOD_TABLE[]   = {30, 40, 50, 60, 70, 80, 90};

static uint8_t uart_rx_buf[FRAME_LEN];
static uint8_t uart_rx_idx = 0;
static uint8_t uart_rx_state = 0;

static uint8_t calc_xor_checksum(const uint8_t *data, uint16_t len)
{
    uint8_t xor = 0;
    uint16_t i;
    for (i = 0; i < len; i++)
        xor ^= data[i];
    return xor;
}

static void update_params_from_frame(const uint8_t *frame)
{
    uint8_t fc_idx   = frame[1] & 0x0F;
    uint8_t am_mode  = frame[2] & 0x01;
    uint8_t mod_idx  = frame[3] & 0x07;
    uint8_t amp_idx  = frame[4] & 0x0F;
    uint8_t dac_mode = frame[5] & 0x03;
    uint8_t delay_idx= frame[6] & 0x07;
    uint8_t atten_idx= frame[7] & 0x0F;
    uint8_t phase_idx= frame[8] & 0x07;

    g_menu.params.freq        = (uint8_t)(30 + fc_idx);
    g_menu.params.signal_type = am_mode;
    g_menu.params.modulation  = (mod_idx <= 6) ? MOD_TABLE[mod_idx] : 50;
    g_menu.params.amplitude   = (uint16_t)((amp_idx + 1) * 100);
    g_menu.params.final_out   = dac_mode;
    g_menu.params.delay       = (delay_idx <= 5) ? delay_idx : 0;
    g_menu.params.attenuation = (atten_idx <= 10) ? atten_idx : 0;
    g_menu.params.phase       = (phase_idx <= 6) ? phase_idx : 0;

    g_menu.params_changed = 1;
    g_menu.display_dirty = 1;
}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)
{
    if (huart->Instance == USART1)
    {
        switch (uart_rx_state)
        {
            case 0:
                if (uart_rx_buf[0] == FRAME_SYNC)
                {
                    uart_rx_idx = 1;
                    uart_rx_state = 1;
                }
                break;

            case 1:
                uart_rx_idx++;
                if (uart_rx_idx >= FRAME_LEN)
                {
                    uart_rx_state = 0;
                    uart_rx_idx = 0;

                    if (calc_xor_checksum(uart_rx_buf, FRAME_LEN - 1) == uart_rx_buf[FRAME_LEN - 1])
                    {
                        update_params_from_frame(uart_rx_buf);
                    }
                }
                break;
        }

        HAL_UART_Receive_IT(&huart1, &uart_rx_buf[uart_rx_idx], 1);
    }
}

void uart_work(void const * argument)
{
    HAL_UART_Receive_IT(&huart1, &uart_rx_buf[0], 1);

    for (;;)
    {
        osDelay(100);
    }
}
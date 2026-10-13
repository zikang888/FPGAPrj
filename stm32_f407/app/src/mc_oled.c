#include "mc_oled.h"
#include "main.h"

#include <string.h>

#define OLED_WIDTH 128U
#define OLED_PAGES 8U

static uint8_t g_frame[OLED_WIDTH * OLED_PAGES];

static void oled_pin(GPIO_TypeDef *port, uint16_t pin, GPIO_PinState state)
{
    HAL_GPIO_WritePin(port, pin, state);
}

static void oled_byte(uint8_t value, int is_data)
{
    uint8_t bit;
    oled_pin(GPIOC, GPIO_PIN_4, is_data ? GPIO_PIN_SET : GPIO_PIN_RESET);
    oled_pin(GPIOB, GPIO_PIN_12, GPIO_PIN_RESET);
    for (bit = 0U; bit < 8U; ++bit) {
        oled_pin(GPIOB, GPIO_PIN_13, GPIO_PIN_RESET);
        oled_pin(GPIOB, GPIO_PIN_15, (value & 0x80U) != 0U ? GPIO_PIN_SET : GPIO_PIN_RESET);
        oled_pin(GPIOB, GPIO_PIN_13, GPIO_PIN_SET);
        value <<= 1;
    }
    oled_pin(GPIOB, GPIO_PIN_13, GPIO_PIN_RESET);
    oled_pin(GPIOB, GPIO_PIN_12, GPIO_PIN_SET);
}

static void oled_command(uint8_t value)
{
    oled_byte(value, 0);
}

/* Column-major 5x7 glyphs used by the compact status/menu UI. */
static void glyph(char ch, uint8_t out[5])
{
    static const uint8_t digits[10][5] = {
        {0x3E,0x51,0x49,0x45,0x3E}, {0x00,0x42,0x7F,0x40,0x00},
        {0x42,0x61,0x51,0x49,0x46}, {0x21,0x41,0x45,0x4B,0x31},
        {0x18,0x14,0x12,0x7F,0x10}, {0x27,0x45,0x45,0x45,0x39},
        {0x3C,0x4A,0x49,0x49,0x30}, {0x01,0x71,0x09,0x05,0x03},
        {0x36,0x49,0x49,0x49,0x36}, {0x06,0x49,0x49,0x29,0x1E}
    };
    static const uint8_t letters[26][5] = {
        {0x7E,0x11,0x11,0x11,0x7E}, {0x7F,0x49,0x49,0x49,0x36},
        {0x3E,0x41,0x41,0x41,0x22}, {0x7F,0x41,0x41,0x22,0x1C},
        {0x7F,0x49,0x49,0x49,0x41}, {0x7F,0x09,0x09,0x09,0x01},
        {0x3E,0x41,0x49,0x49,0x7A}, {0x7F,0x08,0x08,0x08,0x7F},
        {0x00,0x41,0x7F,0x41,0x00}, {0x20,0x40,0x41,0x3F,0x01},
        {0x7F,0x08,0x14,0x22,0x41}, {0x7F,0x40,0x40,0x40,0x40},
        {0x7F,0x02,0x0C,0x02,0x7F}, {0x7F,0x04,0x08,0x10,0x7F},
        {0x3E,0x41,0x41,0x41,0x3E}, {0x7F,0x09,0x09,0x09,0x06},
        {0x3E,0x41,0x51,0x21,0x5E}, {0x7F,0x09,0x19,0x29,0x46},
        {0x46,0x49,0x49,0x49,0x31}, {0x01,0x01,0x7F,0x01,0x01},
        {0x3F,0x40,0x40,0x40,0x3F}, {0x1F,0x20,0x40,0x20,0x1F},
        {0x3F,0x40,0x38,0x40,0x3F}, {0x63,0x14,0x08,0x14,0x63},
        {0x07,0x08,0x70,0x08,0x07}, {0x61,0x51,0x49,0x45,0x43}
    };
    memset(out, 0, 5U);
    if (ch >= 'a' && ch <= 'z') {
        ch = (char)(ch - 'a' + 'A');
    }
    if (ch >= '0' && ch <= '9') {
        memcpy(out, digits[(unsigned int)(ch - '0')], 5U);
    } else if (ch >= 'A' && ch <= 'Z') {
        memcpy(out, letters[(unsigned int)(ch - 'A')], 5U);
    } else {
        switch (ch) {
        case '-': out[1]=0x08; out[2]=0x08; out[3]=0x08; break;
        case '_': out[0]=0x40; out[1]=0x40; out[2]=0x40; out[3]=0x40; out[4]=0x40; break;
        case '>': out[0]=0x41; out[1]=0x22; out[2]=0x14; out[3]=0x08; break;
        case ':': out[2]=0x36; break;
        case '/': out[0]=0x40; out[1]=0x30; out[2]=0x08; out[3]=0x06; out[4]=0x01; break;
        case '.': out[2]=0x60; break;
        case '?': out[0]=0x02; out[1]=0x01; out[2]=0x51; out[3]=0x09; out[4]=0x06; break;
        case '!': out[2]=0x5F; break;
        case '=': out[1]=0x14; out[2]=0x14; out[3]=0x14; break;
        default: break;
        }
    }
}

void mc_oled_init(void)
{
    GPIO_InitTypeDef gpio = {0};
    static const uint8_t init_commands[] = {
        0xAE, 0xD5, 0x80, 0xA8, 0x3F, 0xD3, 0x00, 0x40,
        0x8D, 0x14, 0x20, 0x02, 0xA1, 0xC8, 0xDA, 0x12,
        0x81, 0x7F, 0xD9, 0xF1, 0xDB, 0x40, 0xA4, 0xA6, 0xAF
    };
    size_t i;
    __HAL_RCC_GPIOB_CLK_ENABLE();
    __HAL_RCC_GPIOC_CLK_ENABLE();
    oled_pin(GPIOB, GPIO_PIN_12, GPIO_PIN_SET);
    oled_pin(GPIOB, GPIO_PIN_13, GPIO_PIN_RESET);
    oled_pin(GPIOB, GPIO_PIN_15, GPIO_PIN_RESET);
    oled_pin(GPIOC, GPIO_PIN_4, GPIO_PIN_RESET);
    oled_pin(GPIOC, GPIO_PIN_5, GPIO_PIN_SET);
    gpio.Pin = GPIO_PIN_12 | GPIO_PIN_13 | GPIO_PIN_15;
    gpio.Mode = GPIO_MODE_OUTPUT_PP;
    gpio.Pull = GPIO_NOPULL;
    gpio.Speed = GPIO_SPEED_FREQ_MEDIUM;
    HAL_GPIO_Init(GPIOB, &gpio);
    gpio.Pin = GPIO_PIN_4 | GPIO_PIN_5;
    HAL_GPIO_Init(GPIOC, &gpio);
    oled_pin(GPIOC, GPIO_PIN_5, GPIO_PIN_RESET);
    HAL_Delay(2U);
    oled_pin(GPIOC, GPIO_PIN_5, GPIO_PIN_SET);
    HAL_Delay(20U);
    for (i = 0U; i < sizeof(init_commands); ++i) {
        oled_command(init_commands[i]);
    }
    mc_oled_clear();
    mc_oled_flush();
}

void mc_oled_clear(void)
{
    memset(g_frame, 0, sizeof(g_frame));
}

void mc_oled_text(uint8_t col, uint8_t row, const char *text)
{
    uint8_t columns[5];
    uint8_t x = (uint8_t)(col * 6U);
    size_t i;
    if (text == NULL || row >= OLED_PAGES) {
        return;
    }
    while (*text != '\0' && x <= OLED_WIDTH - 6U) {
        glyph(*text++, columns);
        for (i = 0U; i < 5U; ++i) {
            g_frame[(size_t)row * OLED_WIDTH + x + i] = columns[i];
        }
        g_frame[(size_t)row * OLED_WIDTH + x + 5U] = 0U;
        x = (uint8_t)(x + 6U);
    }
}

void mc_oled_flush(void)
{
    uint8_t page;
    uint8_t column;
    for (page = 0U; page < OLED_PAGES; ++page) {
        oled_command((uint8_t)(0xB0U | page));
        oled_command(0x00U);
        oled_command(0x10U);
        for (column = 0U; column < OLED_WIDTH; ++column) {
            oled_byte(g_frame[(size_t)page * OLED_WIDTH + column], 1);
        }
    }
}

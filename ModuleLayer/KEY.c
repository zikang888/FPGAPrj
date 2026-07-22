#include "KEY.h"
#include "OLED.h"

#define MENU_ITEM_CNT   8
#define DEBOUNCE_MS     20

static const char * const MENU_NAMES[MENU_ITEM_CNT] = {
    "Freq",     /* 载波频率 */
    "Ampl",     /* 直达信号幅度有效值 */
    "Mod",      /* AM调制度 */
    "Delay",    /* 多径信号时延 */
    "Phase",    /* 多径信号初相位差 */
    "Attn",     /* 多径信号幅度衰减 */
    "Type",     /* 信号类型 */
    "Final",    /* 最终输出选择: SD/SM/Sout */
};

static const uint16_t DELAY_TABLE[] = {50, 80, 110, 140, 170, 200};
static const uint8_t  PHASE_TABLE[] = {0, 30, 60, 90, 120, 150, 180};
static const uint8_t  ATTN_TABLE[]  = {0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20};

MenuState g_menu = {
    .in_submenu     = 0,
    .current_index  = 0,
    .edit_mode      = 0,
    .params_changed = 0,
    .display_dirty  = 1,
    .params = {
        .freq        = 35,
        .amplitude   = 500,
        .modulation  = 50,
        .delay       = 0,
        .phase       = 0,
        .attenuation = 0,
        .signal_type = 0,
        .final_out   = 0,
    }
};

static GPIO_PinState last_up   = GPIO_PIN_SET;
static GPIO_PinState last_down = GPIO_PIN_SET;

static void uint32_to_str(uint32_t val, char *buf)
{
    char temp[12];
    uint8_t i = 0, len = 0;
    if (val == 0)
    {
        buf[0] = '0';
        buf[1] = '\0';
        return;
    }
    while (val > 0 && i < 11)
    {
        temp[i++] = (char)('0' + (val % 10));
        val /= 10;
    }
    while (i > 0)
        buf[len++] = temp[--i];
    buf[len] = '\0';
}

static void param_to_str(uint8_t index, char *buf)
{
    switch (index) {
        case 0:
            uint32_to_str((uint32_t)g_menu.params.freq, buf);
            break;
        case 1:
            uint32_to_str((uint32_t)g_menu.params.amplitude, buf);
            break;
        case 2:
            uint32_to_str((uint32_t)g_menu.params.modulation, buf);
            { uint8_t i; for (i = 0; buf[i] != '\0'; i++); buf[i] = '%'; buf[i+1] = '\0'; }
            break;
        case 3:
            uint32_to_str((uint32_t)DELAY_TABLE[g_menu.params.delay], buf);
            break;
        case 4:
            uint32_to_str((uint32_t)PHASE_TABLE[g_menu.params.phase], buf);
            break;
        case 5:
            uint32_to_str((uint32_t)ATTN_TABLE[g_menu.params.attenuation], buf);
            break;
        case 6:
            if (g_menu.params.signal_type)
                { buf[0]='A'; buf[1]='M'; buf[2]='\0'; }
            else
                { buf[0]='C'; buf[1]='W'; buf[2]='\0'; }
            break;
        case 7:
            if (g_menu.params.final_out == 0)
                { buf[0]='S'; buf[1]='D'; buf[2]='\0'; }
            else if (g_menu.params.final_out == 1)
                { buf[0]='S'; buf[1]='M'; buf[2]='\0'; }
            else
                { buf[0]='S'; buf[1]='O'; buf[2]='\0'; }
            break;
        default:
            buf[0] = '\0';
            break;
    }
}

void Menu_DisplayUpdate(void)
{
    char line_buf[17];
    char val_str[10];
    uint8_t i, disp_line, item_idx, name_pos, n;

    if (!g_menu.display_dirty)
        return;
    g_menu.display_dirty = 0;

    OLED_ShowString(1, 1, "==Param Menu==");

    for (i = 0; i < 3; i++)
    {
        disp_line = i + 2;
        if (disp_line > 4) break;

        item_idx = g_menu.current_index + i;
        if (item_idx >= MENU_ITEM_CNT) break;

        line_buf[0] = ' ';

        name_pos = 1;
        n = 0;
        while (MENU_NAMES[item_idx][n] != '\0' && n < 5)
            line_buf[name_pos++] = MENU_NAMES[item_idx][n++];
        while (name_pos < 8)
            line_buf[name_pos++] = ' ';

        param_to_str(item_idx, val_str);
        n = 0;
        while (val_str[n] != '\0' && name_pos < 16)
            line_buf[name_pos++] = val_str[n++];
        while (name_pos < 16)
            line_buf[name_pos++] = ' ';
        line_buf[16] = '\0';

        OLED_ShowString(disp_line, 1, line_buf);
    }

    if (g_menu.current_index + 3 < MENU_ITEM_CNT)
    {
        OLED_ShowString(4, 14, ">>");
    }
    else
    {
        OLED_ShowString(4, 14, "  ");
    }
}

void key_work(void const * argument)
{
    GPIO_PinState up, down;

    for (;;)
    {
        up   = HAL_GPIO_ReadPin(KEY_UP_GPIO_Port,   KEY_UP_Pin);
        down = HAL_GPIO_ReadPin(KEY_DOWN_GPIO_Port, KEY_DOWN_Pin);

        if (last_up == GPIO_PIN_SET && up == GPIO_PIN_RESET)
        {
            osDelay(DEBOUNCE_MS);
            if (HAL_GPIO_ReadPin(KEY_UP_GPIO_Port, KEY_UP_Pin) == GPIO_PIN_RESET)
            {
                if (g_menu.current_index > 0)
                {
                    g_menu.current_index--;
                    g_menu.display_dirty = 1;
                }
            }
        }
        last_up = up;

        if (last_down == GPIO_PIN_SET && down == GPIO_PIN_RESET)
        {
            osDelay(DEBOUNCE_MS);
            if (HAL_GPIO_ReadPin(KEY_DOWN_GPIO_Port, KEY_DOWN_Pin) == GPIO_PIN_RESET)
            {
                if (g_menu.current_index < MENU_ITEM_CNT - 3)
                {
                    g_menu.current_index++;
                    g_menu.display_dirty = 1;
                }
            }
        }
        last_down = down;

        osDelay(10);
    }
}
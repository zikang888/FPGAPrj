#include "KEY.h"
#include "OLED.h"

/* ========== 按键引脚定义 (gpio.c 中已配置) ==========
 * KEY_UP   -> PA0   (向上选择)
 * KEY_DOWN -> PA1   (向下选择)
 * KEY_OK   -> PA2   (确认)
 * 所有按键内部上拉, 按下为低电平
 */

/* 消抖时间 (ms) */
#define DEBOUNCE_MS     20
/* 双击检测窗口 (ms) */
#define DOUBLECLICK_MS  300

/* 菜单项个数 */
#define MENU_ITEM_CNT   8

/* 菜单项名称 (英文缩写, 每行最多16字符) */
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

/* 参数范围 */
#define FREQ_MIN        30
#define FREQ_MAX        40
#define FREQ_STEP       1
#define AMPL_MIN        100
#define AMPL_MAX        1000
#define AMPL_STEP       100
#define MOD_MIN         30
#define MOD_MAX         90
#define MOD_STEP        10
#define DELAY_STEP_NS   30      /* 50,80,110,140,170,200 (index 0~5) */
#define PHASE_STEP_DEG  30      /* 0,30,60,90,120,150,180 (index 0~6) */
#define ATTN_STEP_DB    2       /* 0,2,4,6,8,10,12,14,16,18,20 (index 0~10) */

/* 延迟映射表: index -> ns */
static const uint16_t DELAY_TABLE[] = {50, 80, 110, 140, 170, 200};
#define DELAY_IDX_MAX   5
/* 相位映射表: index -> deg */
static const uint8_t PHASE_TABLE[] = {0, 30, 60, 90, 120, 150, 180};
#define PHASE_IDX_MAX   6
/* 衰减映射表: index -> dB */
static const uint8_t ATTN_TABLE[] = {0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20};
#define ATTN_IDX_MAX   10

/* ========== 全局菜单状态 ========== */
MenuState g_menu = {
    .in_submenu     = 0,
    .current_index  = 0,
    .edit_mode      = 0,
    .params_changed = 0,
    .display_dirty  = 1,
    .params = {
        .freq        = 35,      /* 默认 35 MHz */
        .amplitude   = 500,     /* 默认 500 mV */
        .modulation  = 50,      /* 默认 50% */
        .delay       = 2,       /* index 2 -> 110 ns (最接近默认100) */
        .phase       = 0,       /* index 0 -> 0 deg */
        .attenuation = 0,       /* index 0 -> 0 dB */
        .signal_type = 0,       /* 默认 CW */
        .final_out   = 0,       /* 默认 SD */
    }
};

/* 按键消抖变量 */
static GPIO_PinState last_up   = GPIO_PIN_SET;
static GPIO_PinState last_down = GPIO_PIN_SET;
static GPIO_PinState last_ok   = GPIO_PIN_SET;
static uint32_t last_ok_tick   = 0;
static uint8_t  ok_pending     = 0;  /* 0=无, 1=等待第二次判断双击 */

/* OLED 显示行偏移 (主菜单滚动) */
static uint8_t menu_scroll_offset = 0;

/* 将 uint32_t 转为十进制字符串 */
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

/* ========== 参数值转显示字符串 ========== */
static void param_to_str(uint8_t index, char *buf)
{
    switch (index) {
        case 0: /* 载波频率 */
            uint32_to_str((uint32_t)g_menu.params.freq, buf);
            break;
        case 1: /* 幅度 */
            uint32_to_str((uint32_t)g_menu.params.amplitude, buf);
            break;
        case 2: /* 调制度 */
            uint32_to_str((uint32_t)g_menu.params.modulation, buf);
            /* 追加 % */
            { uint8_t i; for (i = 0; buf[i] != '\0'; i++); buf[i] = '%'; buf[i+1] = '\0'; }
            break;
        case 3: /* 时延 */
            uint32_to_str((uint32_t)DELAY_TABLE[g_menu.params.delay], buf);
            break;
        case 4: /* 相位 */
            uint32_to_str((uint32_t)PHASE_TABLE[g_menu.params.phase], buf);
            break;
        case 5: /* 衰减 */
            uint32_to_str((uint32_t)ATTN_TABLE[g_menu.params.attenuation], buf);
            break;
        case 6: /* 信号类型 */
            if (g_menu.params.signal_type)
                { buf[0]='A'; buf[1]='M'; buf[2]='\0'; }
            else
                { buf[0]='C'; buf[1]='W'; buf[2]='\0'; }
            break;
        case 7: /* 最终输出选择 */
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

/* ========== 参数值递增/递减 ========== */
static void param_adjust(uint8_t index, int8_t direction)
{
    int16_t val;
    switch (index) {
        case 0: /* 载波频率 */
            val = (int16_t)g_menu.params.freq + direction * FREQ_STEP;
            if (val >= FREQ_MIN && val <= FREQ_MAX)
                g_menu.params.freq = (uint8_t)val;
            break;
        case 1: /* 幅度 */
            val = (int16_t)g_menu.params.amplitude + direction * AMPL_STEP;
            if (val >= AMPL_MIN && val <= AMPL_MAX)
                g_menu.params.amplitude = (uint16_t)val;
            break;
        case 2: /* 调制度 */
            val = (int16_t)g_menu.params.modulation + direction * MOD_STEP;
            if (val >= MOD_MIN && val <= MOD_MAX)
                g_menu.params.modulation = (uint8_t)val;
            break;
        case 3: /* 时延 */
            val = (int16_t)g_menu.params.delay + direction;
            if (val >= 0 && val <= DELAY_IDX_MAX)
                g_menu.params.delay = (uint8_t)val;
            break;
        case 4: /* 相位 */
            val = (int16_t)g_menu.params.phase + direction;
            if (val >= 0 && val <= PHASE_IDX_MAX)
                g_menu.params.phase = (uint8_t)val;
            break;
        case 5: /* 衰减 */
            val = (int16_t)g_menu.params.attenuation + direction;
            if (val >= 0 && val <= ATTN_IDX_MAX)
                g_menu.params.attenuation = (uint8_t)val;
            break;
        case 6: /* 信号类型 */
            val = (int16_t)g_menu.params.signal_type + direction;
            if (val >= 0 && val <= 1)
                g_menu.params.signal_type = (uint8_t)val;
            break;
        case 7: /* 最终输出选择: 0=SD, 1=SM, 2=Sout */
            val = (int16_t)g_menu.params.final_out + direction;
            if (val >= 0 && val <= 2)
                g_menu.params.final_out = (uint8_t)val;
            break;
        default:
            break;
    }
    g_menu.params_changed = 1;
}

/* ========== 按键扫描 (含消抖) ========== */
void KEY_Scan(KeyEvent *event)
{
    GPIO_PinState up, down, ok;
    uint32_t now;

    *event = KEY_EVENT_NONE;

    up   = HAL_GPIO_ReadPin(KEY_UP_GPIO_Port,   KEY_UP_Pin);
    down = HAL_GPIO_ReadPin(KEY_DOWN_GPIO_Port, KEY_DOWN_Pin);
    ok   = HAL_GPIO_ReadPin(KEY_OK_GPIO_Port,   KEY_OK_Pin);

    /* ------ UP 键 (下降沿触发) ------ */
    if (last_up == GPIO_PIN_SET && up == GPIO_PIN_RESET)
    {
        osDelay(DEBOUNCE_MS); /* 消抖延时 */
        if (HAL_GPIO_ReadPin(KEY_UP_GPIO_Port, KEY_UP_Pin) == GPIO_PIN_RESET)
        {
            *event = KEY_EVENT_UP;
        }
    }
    last_up = up;

    /* ------ DOWN 键 ------ */
    if (last_down == GPIO_PIN_SET && down == GPIO_PIN_RESET)
    {
        osDelay(DEBOUNCE_MS);
        if (HAL_GPIO_ReadPin(KEY_DOWN_GPIO_Port, KEY_DOWN_Pin) == GPIO_PIN_RESET)
        {
            *event = KEY_EVENT_DOWN;
        }
    }
    last_down = down;

    /* ------ OK 键 (支持单击/双击) ------ */
    if (last_ok == GPIO_PIN_SET && ok == GPIO_PIN_RESET)
    {
        osDelay(DEBOUNCE_MS);
        if (HAL_GPIO_ReadPin(KEY_OK_GPIO_Port, KEY_OK_Pin) == GPIO_PIN_RESET)
        {
            now = xTaskGetTickCount();
            if (ok_pending)
            {
                /* 在双击窗口内再次按下 -> 双击 */
                if ((now - last_ok_tick) < pdMS_TO_TICKS(DOUBLECLICK_MS))
                {
                    *event = KEY_EVENT_OK_DOUBLE;
                    ok_pending = 0;
                }
                else
                {
                    /* 超时, 上次的单击事件先发出 */
                    *event = KEY_EVENT_OK_SINGLE;
                    ok_pending = 0;
                    /* 当前这次作为新的第一次按下 */
                    ok_pending = 1;
                    last_ok_tick = now;
                }
            }
            else
            {
                /* 第一次按下, 等待判断双击 */
                ok_pending = 1;
                last_ok_tick = now;
            }
        }
    }
    else if (last_ok == GPIO_PIN_RESET && ok == GPIO_PIN_SET)
    {
        /* OK 释放 */
        if (ok_pending)
        {
            now = xTaskGetTickCount();
            if ((now - last_ok_tick) >= pdMS_TO_TICKS(DOUBLECLICK_MS))
            {
                /* 超过双击窗口, 触发单击 */
                *event = KEY_EVENT_OK_SINGLE;
                ok_pending = 0;
            }
            /* 否则仍等待第二次按下 */
        }
    }
    last_ok = ok;
}

/* ========== 菜单事件处理 (状态机) ========== */
void Menu_ProcessEvent(KeyEvent event)
{
    switch (event)
    {
        case KEY_EVENT_UP:
            if (!g_menu.in_submenu)
            {
                /* 主菜单: 上移 */
                if (g_menu.current_index > 0)
                    g_menu.current_index--;
                /* 调整滚动偏移 */
                if (g_menu.current_index < menu_scroll_offset)
                    menu_scroll_offset = g_menu.current_index;
            }
            else
            {
                /* 子菜单: 增大参数值 */
                g_menu.edit_mode = 1;
                param_adjust(g_menu.current_index, 1);
            }
            g_menu.display_dirty = 1;
            break;

        case KEY_EVENT_DOWN:
            if (!g_menu.in_submenu)
            {
                /* 主菜单: 下移 */
                if (g_menu.current_index < MENU_ITEM_CNT - 1)
                    g_menu.current_index++;
                /* 调整滚动偏移 (每屏显示3项) */
                if (g_menu.current_index >= menu_scroll_offset + 3)
                    menu_scroll_offset = g_menu.current_index - 2;
            }
            else
            {
                /* 子菜单: 减小参数值 */
                g_menu.edit_mode = 1;
                param_adjust(g_menu.current_index, -1);
            }
            g_menu.display_dirty = 1;
            break;

        case KEY_EVENT_OK_SINGLE:
            if (!g_menu.in_submenu)
            {
                /* 主菜单 -> 进入子菜单 */
                g_menu.in_submenu = 1;
                g_menu.edit_mode = 0;
            }
            else
            {
                /* 子菜单: 确认当前值, 返回主菜单 */
                g_menu.edit_mode = 0;
                g_menu.in_submenu = 0;
            }
            g_menu.display_dirty = 1;
            break;

        case KEY_EVENT_OK_DOUBLE:
            /* 双击: 立即返回主菜单 */
            g_menu.in_submenu = 0;
            g_menu.edit_mode = 0;
            g_menu.display_dirty = 1;
            break;

        default:
            break;
    }
}

/* ========== 菜单显示刷新 (由 oled_work 定时调用) ========== */
void Menu_DisplayUpdate(void)
{
    char line_buf[17];
    char val_str[10];
    uint8_t i, disp_line, item_idx, name_pos, n, p;

    /* 没有显示变化时跳过刷新, 避免频繁 I2C 传输造成闪烁 */
    if (!g_menu.display_dirty)
        return;
    g_menu.display_dirty = 0;

    if (!g_menu.in_submenu)
    {
        /* ========== 主菜单显示 ========== */

        /* 标题行 */
        OLED_ShowString(1, 1, "==Param Menu==");

        /* 显示当前可见的3个菜单项 (Line 2~4) */
        for (i = 0; i < 3; i++)
        {
            disp_line = i + 2;
            if (disp_line > 4) break;

            item_idx = menu_scroll_offset + i;
            if (item_idx >= MENU_ITEM_CNT) break;

            /* 组装显示字符串: ">Freq 35MHz" 或 " Freq 35MHz" */
            line_buf[0] = (item_idx == g_menu.current_index) ? '>' : ' ';

            /* 名称 (最大5字符) */
            name_pos = 1;
            n = 0;
            while (MENU_NAMES[item_idx][n] != '\0' && n < 5)
                line_buf[name_pos++] = MENU_NAMES[item_idx][n++];
            /* 填充空格到第8列 */
            while (name_pos < 8)
                line_buf[name_pos++] = ' ';

            /* 数值 */
            param_to_str(item_idx, val_str);
            n = 0;
            while (val_str[n] != '\0' && name_pos < 16)
                line_buf[name_pos++] = val_str[n++];
            /* 填充剩余空格 */
            while (name_pos < 16)
                line_buf[name_pos++] = ' ';
            line_buf[16] = '\0';

            OLED_ShowString(disp_line, 1, line_buf);
        }
    }
    else
    {
        /* ========== 子菜单显示 ========== */

        /* Line 1: 参数名称 (补齐16字符覆盖残留) */
        n = 0;
        p = 0;
        while (MENU_NAMES[g_menu.current_index][p] != '\0' && n < 16)
            line_buf[n++] = MENU_NAMES[g_menu.current_index][p++];
        while (n < 16)
            line_buf[n++] = ' ';
        line_buf[16] = '\0';
        OLED_ShowString(1, 1, line_buf);

        /* Line 2: "Value: xxx" (先是7个字符, 接着数值, 然后空格补齐到16) */
        {
            uint8_t col;
            for (col = 0; col < 16; col++) line_buf[col] = ' ';
            /* 写 "Value: " */
            line_buf[0] = 'V'; line_buf[1] = 'a'; line_buf[2] = 'l';
            line_buf[3] = 'u'; line_buf[4] = 'e'; line_buf[5] = ':';
            line_buf[6] = ' ';
            /* 写数值 */
            param_to_str(g_menu.current_index, val_str);
            for (col = 0; val_str[col] != '\0' && (7 + col) < 16; col++)
                line_buf[7 + col] = val_str[col];
            line_buf[16] = '\0';
            OLED_ShowString(2, 1, line_buf);
        }

        /* Line 3: 范围提示 (固定字符串, 补齐到16) */
        {
            const char *range_str = "";
            switch (g_menu.current_index)
            {
                case 0: range_str = "Range:30-40MHz"; break;
                case 1: range_str = "Range:100-1KmV"; break;
                case 2: range_str = "Range:30-90%";   break;
                case 3: range_str = "Range:50-200ns"; break;
                case 4: range_str = "Range:0-180deg"; break;
                case 5: range_str = "Range:0-20dB";   break;
                case 6: range_str = "CW/AM";          break;
                case 7: range_str = "SD/SM/Sout";    break;
            }
            for (n = 0; n < 16; n++) line_buf[n] = ' ';
            for (n = 0; range_str[n] != '\0' && n < 16; n++)
                line_buf[n] = range_str[n];
            line_buf[16] = '\0';
            OLED_ShowString(3, 1, line_buf);
        }

        /* Line 4: 操作提示 (补齐到16) */
        {
            const char *hint = g_menu.edit_mode ? "OK:cfm D:back" : "UD:adj OK:cfm";
            for (n = 0; n < 16; n++) line_buf[n] = ' ';
            for (n = 0; hint[n] != '\0' && n < 16; n++)
                line_buf[n] = hint[n];
            line_buf[16] = '\0';
            OLED_ShowString(4, 1, line_buf);
        }
    }
}

/* ========== FreeRTOS __weak 覆盖函数: key_work ========== */
void key_work(void const * argument)
{
    KeyEvent event;

    menu_scroll_offset = 0;

    for (;;)
    {
        KEY_Scan(&event);
        if (event != KEY_EVENT_NONE)
        {
            Menu_ProcessEvent(event);
        }
        osDelay(10); /* 10ms 扫描周期 */
    }
}

/**
 * touch.c — Goodix GT911 触摸驱动
 * I2C0 (MIO 50-51), addr 0x14
 */
#include "touch.h"
#include "ps_iic.h"
#include "ps_gpio.h"
#include "xil_printf.h"
#include "sleep.h"

#define TP_INT_PIN   0U
#define TP_RST_PIN   54U
#define GT911_ADDR   0x14
#define TOUCH_MAX_X  GT9147_RAW_WIDTH
#define TOUCH_MAX_Y  GT9147_RAW_HEIGHT
#define GT911_REFRESH_RATE_INDEX  15U

TouchData TouchInfo;
static u8 TouchInterruptReady;

/* Proven 184-byte GT911 configuration for the board's 800x480 panel. */
static const u8 gt911_cfg[] = {
    0x42,0x20,0x03,0xE0,0x01,0x0A,0x0D,0x00,0x01,0x0A,
    0x28,0x0F,0x50,0x32,0x03,0x05,0x00,0x00,0x00,0x00,
    0x22,0x22,0x00,0x00,0x00,0x00,0x00,0x89,0x29,0x0B,
    0x26,0x24,0xEA,0x04,0x00,0x00,0x00,0x02,0x03,0x1C,
    0x00,0x00,0x00,0x00,0x00,0x03,0x64,0x32,0x00,0x00,
    0x00,0x14,0x37,0x94,0xC5,0x02,0x07,0x00,0x00,0x04,
    0xE8,0x13,0x00,0x97,0x1E,0x00,0x61,0x30,0x00,0x3E,
    0x4C,0x00,0x28,0x78,0x00,0x28,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x16,0x14,0x12,0x10,0x0E,0x0C,0x0A,0x08,
    0x06,0x04,0x02,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
    0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
    0xFF,0xFF,0x22,0x21,0x20,0x1F,0x1E,0x1D,0x1C,0x18,
    0x16,0x12,0x10,0x0F,0x0A,0x08,0x06,0x04,0x02,0x00,
    0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
    0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
    0x00,0x00,0x00,0x00,
};

static int gt911_send_cfg(u8 mode)
{
    u8 buf[2];
    u16 i;
    u8 sum = 0;

    for (i = 0; i < sizeof(gt911_cfg); i++) sum += gt911_cfg[i];
    buf[0] = (~sum) + 1;
    buf[1] = mode;

    if (iic_write_reg(GT911_ADDR, 0x8047, gt911_cfg, sizeof(gt911_cfg)) != 0) {
        return XST_FAILURE;
    }
    if (iic_write_reg(GT911_ADDR, 0x80FF, buf, 2) != 0) {
        return XST_FAILURE;
    }
    return XST_SUCCESS;
}

int gt9147_init(void)
{
    u8 buf;
    u8 id[4];
    u8 irq_mode;
    u8 irq_type;
    u8 cfg_version;
    u8 refresh_rate;

    if (iic_init() != XST_SUCCESS) {
        xil_printf("GT911 I2C init failed\r\n");
        return XST_FAILURE;
    }
    if (gpio_init() != XST_SUCCESS) {
        xil_printf("GT911 GPIO init failed\r\n");
        return XST_FAILURE;
    }

    /*
     * Select 7-bit address 0x14 by holding INT high while reset is low.
     * After releasing reset, drive INT low for the controller's startup
     * synchronization interval.  Only then release INT to input mode so
     * the GT911 can use it as the touch-data interrupt output.
     */
    TouchInterruptReady = 0U;
    gpio_set_mode(TP_INT_PIN, OUTPUT, 1U);
    gpio_set_mode(TP_RST_PIN, OUTPUT, 0U);
    usleep(10000);
    gpio_set_mode(TP_RST_PIN, OUTPUT, 1U);
    usleep(10000);
    gpio_set_mode(TP_INT_PIN, OUTPUT, 0U);
    usleep(100000);
    gpio_set_mode(TP_INT_PIN, INPUT, 0U);
    usleep(10000);

    /* A valid product ID read proves reset, address selection and I2C. */
    if (iic_read_reg(GT911_ADDR, 0x8140, id, 4) != 0) {
        xil_printf("GT911 ID read failed, addr=0x14\r\n");
        return XST_FAILURE;
    }
    xil_printf("GT911 ID: %c%c%c%c\r\n", id[0], id[1], id[2], id[3]);

    buf = 0x02;
    if (iic_write_reg(GT911_ADDR, 0x8040, &buf, 1) != 0) {
        xil_printf("GT911 soft reset failed\r\n");
        return XST_FAILURE;
    }

    if (iic_read_reg(GT911_ADDR, 0x8047, &cfg_version, 1) != 0) {
        xil_printf("GT911 config version read failed\r\n");
        return XST_FAILURE;
    }
    if (iic_read_reg(GT911_ADDR, 0x8056, &refresh_rate, 1) != 0) {
        xil_printf("GT911 refresh rate read failed\r\n");
        return XST_FAILURE;
    }
    xil_printf("GT911 cfg ver: 0x%x, report=%dms\r\n",
               cfg_version, (int)(5U + refresh_rate));

    /*
     * A previously downloaded low-latency build may have persisted a 5 ms
     * report period.  Restore the proven 10 ms configuration even when its
     * version byte is unchanged.
     */
    if ((cfg_version < gt911_cfg[0]) ||
        (refresh_rate != gt911_cfg[GT911_REFRESH_RATE_INDEX])) {
        if (gt911_send_cfg(1) != XST_SUCCESS) {
            xil_printf("GT911 config update failed\r\n");
            return XST_FAILURE;
        }
        xil_printf("GT911 config updated\r\n");
        usleep(10000);
        if (iic_read_reg(GT911_ADDR, 0x8056, &refresh_rate, 1) != 0 ||
            refresh_rate != gt911_cfg[GT911_REFRESH_RATE_INDEX]) {
            xil_printf("GT911 10ms report restore failed\r\n");
            return XST_FAILURE;
        }
        xil_printf("GT911 report period restored: 10ms\r\n");
    }

    buf = 0x00;
    if (iic_write_reg(GT911_ADDR, 0x8040, &buf, 1) != 0) {
        xil_printf("GT911 scan start failed\r\n");
        return XST_FAILURE;
    }

    /*
     * Config register 0x804D bits[1:0] select the interrupt mode:
     * 0 rising edge, 1 falling edge, 2 low level, 3 high level.
     */
    if (iic_read_reg(GT911_ADDR, 0x804D, &buf, 1) != 0) {
        xil_printf("GT911 interrupt mode read failed\r\n");
        return XST_FAILURE;
    }
    irq_mode = buf & 0x03U;
    switch (irq_mode) {
    case 0U: irq_type = XGPIOPS_IRQ_TYPE_EDGE_RISING; break;
    case 1U: irq_type = XGPIOPS_IRQ_TYPE_EDGE_FALLING; break;
    case 2U: irq_type = XGPIOPS_IRQ_TYPE_LEVEL_LOW; break;
    default: irq_type = XGPIOPS_IRQ_TYPE_LEVEL_HIGH; break;
    }

    /* Acknowledge stale data before enabling the GPIO interrupt. */
    buf = 0U;
    if (iic_write_reg(GT911_ADDR, 0x814E, &buf, 1) != 0) {
        xil_printf("GT911 stale status clear failed\r\n");
        return XST_FAILURE;
    }
    if (gpio_interrupt_init(TP_INT_PIN, irq_type) == XST_SUCCESS) {
        TouchInterruptReady = 1U;
        xil_printf("GT911 IRQ ready, pin=MIO0 mode=%d\r\n",
                   (int)irq_mode);
    } else {
        xil_printf("GT911 IRQ init failed, safety polling only\r\n");
    }

    /*
     * Sync: clear any touch data that may have accumulated between
     * the status-register clear above and the GPIO interrupt enable.
     * Without this, INT could already be LOW when the edge-triggered
     * interrupt is armed, causing the falling edge to be missed and
     * the ISR to never fire.
     */
    {
        u8 sync_state = 0;
        if (iic_read_reg(GT911_ADDR, 0x814E, &sync_state, 1) == 0 &&
            (sync_state & 0x80U) != 0U) {
            u8 clr = 0;
            iic_write_reg(GT911_ADDR, 0x814E, &clr, 1);
            xil_printf("GT911 sync-clear after IRQ init (state=0x%x)\r\n",
                       (int)sync_state);
        }
    }

    xil_printf("GT911 init done, addr=0x14\r\n");
    return XST_SUCCESS;
}

void gt9147_scan(TouchData *p)
{
    static const u16 tbl[5] = {0x8150,0x8158,0x8160,0x8168,0x8170};
    u16 xs[5], ys[5];
    u8 i, state = 0, data[4], touch_num;
    int valid = 1;

    p->Touched_Last = p->Touched;

    if (iic_read_reg(GT911_ADDR, 0x814E, &state, 1) != 0) {
        p->Touch_Num = 0;
        p->Touched = 0;
        return;
    }

    if (state & 0x80) {
        touch_num = state & 0x0F;
        if (touch_num > 5U) {
            valid = 0;
            touch_num = 0;
        }

        for (i = 0; i < touch_num; i++) {
            if (iic_read_reg(GT911_ADDR, tbl[i], data, 4) != 0) {
                valid = 0;
                break;
            }
            xs[i] = ((u16)data[1] << 8) | data[0];
            ys[i] = ((u16)data[3] << 8) | data[2];
            if (xs[i] >= TOUCH_MAX_X || ys[i] >= TOUCH_MAX_Y) {
                valid = 0;
                break;
            }
        }

        data[0] = 0;
        if (iic_write_reg(GT911_ADDR, 0x814E, data, 1) != 0) {
            valid = 0;
        }

        if (!valid) {
            p->Touch_Num = 0;
            p->Touched = 0;
            return;
        }

        p->Touch_Num = touch_num;
        p->Touched = (touch_num == 0U) ? 0U : (0x1FU >> (5U - touch_num));
        for (i = 0; i < touch_num; i++) {
            p->Tp_X[i] = xs[i];
            p->Tp_Y[i] = ys[i];
        }
    }
}

u8 gt9147_event_pending(void)
{
    u8 irq_pending;

    if (TouchInterruptReady == 0U) return 0U;
    irq_pending = gpio_interrupt_consume();
    if (irq_pending != 0U) return 1U;

    /*
     * Fallback: if the ISR missed an edge (e.g. due to the race condition
     * during init), the INT pin is still LOW while GT911 has data ready.
     * Check the raw pin level to catch this case.
     */
    if (gpio_read(TP_INT_PIN) == 0U) return 1U;
    return 0U;
}

u8 gt9147_debug_state(void)
{
    u8 state = 0;
    iic_read_reg(GT911_ADDR, 0x814E, &state, 1);
    return state;
}

u8 gt9147_get_addr(void) { return 0x14; }

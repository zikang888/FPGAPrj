#include "platform_ui.h"
#include "touch.h"
#include "xil_io.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xstatus.h"
#include "xuartps.h"
#include "sleep.h"

#define CORE_BASE       XPAR_MULTI_PROTOCOL_CORE_0_BASEADDR
#define REG_SYS_ID      (CORE_BASE + 0x0000U)
#define REG_VERSION     (CORE_BASE + 0x0004U)
#define REG_SCRATCH     (CORE_BASE + 0x002CU)
#define REG_LED_CTRL    (CORE_BASE + 0x0030U)

#define EXPECTED_ID     0x4D505254U
#define SCRATCH_TEST    0xA5A55A5AU

static XUartPs g_uart;

static int uart_init(void)
{
    XUartPs_Config *config = XUartPs_LookupConfig(XPAR_XUARTPS_0_DEVICE_ID);
    int status;
    if (config == 0) return XST_FAILURE;
    status = XUartPs_CfgInitialize(&g_uart, config, config->BaseAddress);
    if (status != XST_SUCCESS) return status;
    status = XUartPs_SetBaudRate(&g_uart, 115200U);
    return status;
}

int main(void)
{
    u32 id;
    u32 version;
    u32 scratch;
    u8 led_on = 0U;
    u8 touch_ok = 0U;

    if (uart_init() != XST_SUCCESS) {
        while (1) {
        }
    }
    xil_printf("PS READY\r\n");

    id = Xil_In32(REG_SYS_ID);
    version = Xil_In32(REG_VERSION);
    if (id == EXPECTED_ID) {
        xil_printf("PL ID OK: 0x%08lx\r\n", (unsigned long)id);
    } else {
        xil_printf("PL ID ERROR: 0x%08lx\r\n", (unsigned long)id);
    }

    Xil_Out32(REG_SCRATCH, SCRATCH_TEST);
    scratch = Xil_In32(REG_SCRATCH);
    if (scratch == SCRATCH_TEST) {
        xil_printf("SCRATCH OK: 0x%08lx\r\n", (unsigned long)scratch);
    } else {
        xil_printf("SCRATCH ERROR: 0x%08lx\r\n", (unsigned long)scratch);
    }

    if (platform_ui_init() != XST_SUCCESS) {
        xil_printf("UI ERROR\r\n");
        while (1) {
        }
    }

    if (gt9147_init() == XST_SUCCESS) {
        touch_ok = 1U;
        xil_printf("TOUCH READY\r\n");
    } else {
        xil_printf("TOUCH ERROR\r\n");
    }

    Xil_Out32(REG_LED_CTRL, 0U);
    platform_ui_render(id, version, scratch, led_on, touch_ok);
    xil_printf("UI READY\r\n");

    while (1) {
        if (touch_ok != 0U && platform_ui_poll_led_button() != 0U) {
            led_on ^= 1U;
            Xil_Out32(REG_LED_CTRL, (u32)led_on);
            platform_ui_render(id, version, scratch, led_on, touch_ok);
            xil_printf("LED %s\r\n", (led_on != 0U) ? "ON" : "OFF");
        }
        usleep(5000U);
    }
}

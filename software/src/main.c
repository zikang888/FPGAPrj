#include "platform_ui.h"
#include "capture_demo.h"
#include "touch.h"
#include "xil_io.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xstatus.h"
#include "xuartps.h"
#include "sleep.h"
#include "string.h"

#define CORE_BASE       XPAR_MULTI_PROTOCOL_CORE_0_BASEADDR
#define REG_SYS_ID      (CORE_BASE + 0x0000U)
#define REG_VERSION     (CORE_BASE + 0x0004U)
#define REG_CAPABILITIES (CORE_BASE + 0x000CU)
#define REG_SCRATCH     (CORE_BASE + 0x002CU)
#define REG_LED_CTRL    (CORE_BASE + 0x0030U)
#define REG_ARB_STATUS  (CORE_BASE + 0x0034U)
#define REG_EXT_DROPPED (CORE_BASE + 0x0038U)

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
    u8 capture_ok = 0U;
    CaptureDemoSnapshot capture_snapshot;
    PlatformUiStatus ui_status;
    PlatformUiPage page = PLATFORM_UI_PAGE_HOME;
    PlatformUiAction action;

    memset(&capture_snapshot, 0, sizeof(capture_snapshot));
    memset(&ui_status, 0, sizeof(ui_status));

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

    if (gt911_init() == XST_SUCCESS) {
        touch_ok = 1U;
        xil_printf("TOUCH READY\r\n");
    } else {
        xil_printf("TOUCH ERROR\r\n");
    }

    Xil_Out32(REG_LED_CTRL, 0U);
    if (capture_demo_run(&capture_snapshot) == XST_SUCCESS) {
        capture_ok = 1U;
    } else {
        xil_printf("CAPTURE DEMO ERROR\r\n");
    }

    ui_status.id = id;
    ui_status.version = version;
    ui_status.capabilities = Xil_In32(REG_CAPABILITIES);
    ui_status.scratch = scratch;
    ui_status.dropped_count = capture_snapshot.dropped_count;
    ui_status.ext_dropped_count = Xil_In32(REG_EXT_DROPPED);
    ui_status.arbitration_count = Xil_In32(REG_ARB_STATUS);
    ui_status.id_ok = (id == EXPECTED_ID) ? 1U : 0U;
    ui_status.version_ok = ((version & 0xFFFF0000U) == 0x00010000U) ? 1U : 0U;
    ui_status.scratch_ok = (scratch == SCRATCH_TEST) ? 1U : 0U;
    ui_status.touch_ok = touch_ok;
    ui_status.capture_ok = capture_ok;
    ui_status.led_on = led_on;
    platform_ui_render_page(page, &ui_status,
                            capture_ok != 0U ? &capture_snapshot : 0);
    xil_printf("UI READY\r\n");

    while (1) {
        action = (touch_ok != 0U) ? platform_ui_poll_action() :
                 PLATFORM_UI_ACTION_NONE;
        if (action == PLATFORM_UI_ACTION_HOME) {
            page = PLATFORM_UI_PAGE_HOME;
            xil_printf("UI PAGE HOME\r\n");
        } else if (action == PLATFORM_UI_ACTION_SELF_TEST) {
            page = PLATFORM_UI_PAGE_SELF_TEST;
            xil_printf("UI PAGE SELF TEST\r\n");
        } else if (action == PLATFORM_UI_ACTION_EVENTS) {
            page = PLATFORM_UI_PAGE_EVENTS;
            xil_printf("UI PAGE EVENTS\r\n");
        } else if (action == PLATFORM_UI_ACTION_EVENTS_PREVIOUS) {
            u32 first = capture_snapshot.first_index;
            first = first > 6U ? first - 6U : 0U;
            if (capture_ok != 0U &&
                capture_demo_read_window(&capture_snapshot, first) ==
                XST_SUCCESS) {
                xil_printf("UI EVENTS VIEW: %lu-%lu\r\n",
                           (unsigned long)capture_snapshot.first_index,
                           (unsigned long)(capture_snapshot.first_index +
                                           capture_snapshot.shown - 1U));
            }
        } else if (action == PLATFORM_UI_ACTION_EVENTS_NEXT) {
            u32 first = capture_snapshot.first_index + 6U;
            if (capture_ok != 0U &&
                capture_demo_read_window(&capture_snapshot, first) ==
                XST_SUCCESS) {
                xil_printf("UI EVENTS VIEW: %lu-%lu\r\n",
                           (unsigned long)capture_snapshot.first_index,
                           (unsigned long)(capture_snapshot.first_index +
                                           capture_snapshot.shown - 1U));
            }
        } else if (action == PLATFORM_UI_ACTION_LED_TOGGLE) {
            led_on ^= 1U;
            Xil_Out32(REG_LED_CTRL, (u32)led_on);
            ui_status.led_on = led_on;
            xil_printf("LED %s\r\n", (led_on != 0U) ? "ON" : "OFF");
        }
        if (action != PLATFORM_UI_ACTION_NONE) {
            platform_ui_render_page(page, &ui_status,
                                    capture_ok != 0U ? &capture_snapshot : 0);
        }
        usleep(5000U);
    }
}

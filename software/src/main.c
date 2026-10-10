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
#include "xtime_l.h"
#include "ui_counter_semantics.h"

#define CORE_BASE       XPAR_MULTI_PROTOCOL_CORE_0_BASEADDR
#define REG_SYS_ID      (CORE_BASE + 0x0000U)
#define REG_VERSION     (CORE_BASE + 0x0004U)
#define REG_CAPABILITIES (CORE_BASE + 0x000CU)
#define REG_SCRATCH     (CORE_BASE + 0x002CU)
#define REG_LED_CTRL    (CORE_BASE + 0x0030U)
#define REG_ARB_STATUS  (CORE_BASE + 0x0034U)
#define REG_EXT_DROPPED (CORE_BASE + 0x0038U)
#define REG_SPI_FRAME_ERRORS (CORE_BASE + 0x004CU)
#define REG_SPI_BOUNDARY_ERRORS (CORE_BASE + 0x0050U)
#define REG_SPI_DUPLICATES (CORE_BASE + 0x0054U)
#define REG_SPI_SEQUENCE_ERRORS (CORE_BASE + 0x0058U)
#define REG_CORE_REJECTED (CORE_BASE + 0x1014U)
#define COUNTER_POLL_TICKS ((uint64_t)COUNTS_PER_SECOND / 2U)

#define EXPECTED_ID     0x4D505254U
#define SCRATCH_TEST    0xA5A55A5AU

static XUartPs g_uart;
static CaptureDemoCache g_demo_cache;
static CaptureDemoCache g_live_cache;

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
    u8 touch_ok = 0U;
    u8 capture_ok = 0U;
    CaptureDemoSnapshot capture_snapshot;
    CaptureDemoSnapshot live_snapshot;
    const CaptureDemoSnapshot *visible_snapshot;
    int live_result;
    PlatformUiStatus ui_status;
    PlatformUiPage page = PLATFORM_UI_PAGE_HOME;
    PlatformUiAction action;
    XTime last_counter_poll;
    XTime now;
    u32 core_rejected;
    u32 external_loss;
    u32 spi_frame_errors;
    u32 spi_boundary_errors;
    u32 spi_duplicates;
    u32 spi_sequence_errors;

    memset(&capture_snapshot, 0, sizeof(capture_snapshot));
    memset(&live_snapshot, 0, sizeof(live_snapshot));
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
    if (capture_ok != 0U) {
        if (capture_demo_cache_snapshot(&g_demo_cache,
                                        &capture_snapshot) == XST_SUCCESS) {
            platform_ui_set_event_cache(&g_demo_cache);
            xil_printf("EVENT CACHE READY: count=%lu\r\n",
                       (unsigned long)g_demo_cache.count);
        } else {
            xil_printf("EVENT CACHE ERROR; showing initial window only\r\n");
        }
    }

    ui_status.id = id;
    ui_status.version = version;
    ui_status.capabilities = Xil_In32(REG_CAPABILITIES);
    ui_status.scratch = scratch;
    ui_status.core_rejected_count = Xil_In32(REG_CORE_REJECTED);
    ui_status.external_loss_count = Xil_In32(REG_EXT_DROPPED);
    ui_status.spi_frame_errors = Xil_In32(REG_SPI_FRAME_ERRORS);
    ui_status.spi_boundary_errors = Xil_In32(REG_SPI_BOUNDARY_ERRORS);
    ui_status.spi_duplicates = Xil_In32(REG_SPI_DUPLICATES);
    ui_status.spi_sequence_errors = Xil_In32(REG_SPI_SEQUENCE_ERRORS);
    ui_status.arbitration_count = Xil_In32(REG_ARB_STATUS);
    ui_status.id_ok = (id == EXPECTED_ID) ? 1U : 0U;
    ui_status.version_ok = ((version & 0xFFFF0000U) == 0x00010000U) ? 1U : 0U;
    ui_status.scratch_ok = (scratch == SCRATCH_TEST) ? 1U : 0U;
    ui_status.touch_ok = touch_ok;
    ui_status.capture_ok = capture_ok;
    platform_ui_render_page(page, &ui_status,
                            capture_ok != 0U ? &capture_snapshot : 0);
    xil_printf("UI READY\r\n");
    XTime_GetTime(&last_counter_poll);

    while (1) {
        XTime_GetTime(&now);
        if (ui_counter_poll_due((uint64_t)now, (uint64_t)last_counter_poll,
                                COUNTER_POLL_TICKS)) {
            last_counter_poll = now;
            core_rejected = Xil_In32(REG_CORE_REJECTED);
            external_loss = Xil_In32(REG_EXT_DROPPED);
            spi_frame_errors = Xil_In32(REG_SPI_FRAME_ERRORS);
            spi_boundary_errors = Xil_In32(REG_SPI_BOUNDARY_ERRORS);
            spi_duplicates = Xil_In32(REG_SPI_DUPLICATES);
            spi_sequence_errors = Xil_In32(REG_SPI_SEQUENCE_ERRORS);
            if (ui_counter_changed(ui_status.core_rejected_count,
                                   ui_status.external_loss_count,
                                   core_rejected, external_loss) ||
                ui_status.spi_frame_errors != spi_frame_errors ||
                ui_status.spi_boundary_errors != spi_boundary_errors ||
                ui_status.spi_duplicates != spi_duplicates ||
                ui_status.spi_sequence_errors != spi_sequence_errors) {
                ui_status.core_rejected_count = core_rejected;
                ui_status.external_loss_count = external_loss;
                ui_status.spi_frame_errors = spi_frame_errors;
                ui_status.spi_boundary_errors = spi_boundary_errors;
                ui_status.spi_duplicates = spi_duplicates;
                ui_status.spi_sequence_errors = spi_sequence_errors;
                platform_ui_update_counters(&ui_status);
            }
        }
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
        } else if (action == PLATFORM_UI_ACTION_ERRORS) {
            page = PLATFORM_UI_PAGE_ERRORS;
            xil_printf("UI PAGE ERRORS\r\n");
        } else if (action == PLATFORM_UI_ACTION_CAPTURE_LIVE) {
            if (ui_status.capture_source != 0U) {
                ui_status.capture_source = 0U;
                platform_ui_set_event_cache(g_demo_cache.valid != 0U ?
                                            &g_demo_cache : 0);
                xil_printf("EVENT SOURCE VIRTUAL\r\n");
            } else if (capture_live_arm() == XST_SUCCESS) {
                ui_status.capture_source = 1U;
                platform_ui_set_event_cache(0);
                xil_printf("SPI CAPTURE ARMED; one JEDEC transaction is enough\r\n");
            } else {
                xil_printf("SPI CAPTURE ARM ERROR\r\n");
            }
        }
        if (ui_status.capture_source == 1U) {
            live_result = capture_live_poll(&live_snapshot);
            if (live_result > 0) {
                if (capture_demo_cache_snapshot(&g_live_cache,
                                                &live_snapshot) == XST_SUCCESS) {
                    ui_status.capture_source = 2U;
                    platform_ui_set_event_cache(&g_live_cache);
                    xil_printf("SPI SNAPSHOT READY: id=%lu count=%lu trigger=%lu\r\n",
                               (unsigned long)live_snapshot.snapshot_id,
                               (unsigned long)live_snapshot.count,
                               (unsigned long)live_snapshot.trigger_index);
                } else {
                    ui_status.capture_source = 0U;
                    platform_ui_set_event_cache(&g_demo_cache);
                    xil_printf("SPI SNAPSHOT CACHE ERROR\r\n");
                }
                action = PLATFORM_UI_ACTION_CAPTURE_LIVE;
            } else if (live_result < 0) {
                ui_status.capture_source = 0U;
                platform_ui_set_event_cache(&g_demo_cache);
                xil_printf("SPI CAPTURE STATUS ERROR\r\n");
                action = PLATFORM_UI_ACTION_CAPTURE_LIVE;
            }
        }
        if (action != PLATFORM_UI_ACTION_NONE) {
            if (ui_status.capture_source == 2U) {
                /* Keep every page tied to the newest real capture. */
                visible_snapshot = &live_snapshot;
            } else if (page == PLATFORM_UI_PAGE_EVENTS &&
                       ui_status.capture_source == 1U) {
                visible_snapshot = 0;
            } else {
                visible_snapshot = capture_ok != 0U ? &capture_snapshot : 0;
            }
            platform_ui_render_page(page, &ui_status,
                                    visible_snapshot);
        }
        platform_ui_tick();
        usleep(5000U);
    }
}

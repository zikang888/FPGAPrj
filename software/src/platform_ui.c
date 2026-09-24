#include "platform_ui.h"

#include "font.h"
#include "touch.h"
#include "xaxivdma.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "xvtc.h"
#include "sleep.h"
#include "string.h"

#define FB_ADDR      (XPAR_PS7_DDR_0_S_AXI_BASEADDR + 0x01000000U)
#define FB_W         800U
#define FB_H         480U
#define FB_STRIDE    (FB_W * 3U)
#define FB_SIZE      (FB_STRIDE * FB_H)
#define FB_ADDR_0    FB_ADDR
#define FB_ADDR_1    (FB_ADDR + 0x00120000U)

#define C_BG         0x07131FU
#define C_PANEL      0x102B40U
#define C_BORDER     0x28566BU
#define C_TEXT       0xEAF8FFU
#define C_MUTED      0x8CB8CCU
#define C_CYAN       0x27D9FFU
#define C_GREEN      0x45E091U
#define C_RED        0x4A5CFFU
#define C_WARN       0x35B8FFU
#define C_BUTTON     0x17384CU
#define C_ACTIVE     0x0D7482U

static XAxiVdma g_vdma;
static XVtc g_vtc;
static const UINTPTR g_frame_addr[2] = {FB_ADDR_0, FB_ADDR_1};
static u8 *g_fb = (u8 *)FB_ADDR_1;
static u8 g_display_frame;
static u8 g_draw_frame = 1U;

static void px(u16 x, u16 y, u32 color)
{
    u32 offset;
    if (x >= FB_W || y >= FB_H) return;
    offset = (u32)y * FB_STRIDE + (u32)x * 3U;
    g_fb[offset] = (u8)color;
    g_fb[offset + 1U] = (u8)(color >> 8);
    g_fb[offset + 2U] = (u8)(color >> 16);
}

static void fill(u16 x0, u16 y0, u16 x1, u16 y1, u32 color)
{
    u16 x;
    u16 y;
    if (x1 >= FB_W) x1 = FB_W - 1U;
    if (y1 >= FB_H) y1 = FB_H - 1U;
    for (y = y0; y <= y1; ++y) {
        for (x = x0; x <= x1; ++x) px(x, y, color);
    }
}

static void glyph(u16 x, u16 y, char ch, u32 fg, u32 bg)
{
    u8 col;
    u8 row;
    u8 bits;
    if (ch < ' ' || ch > '~') ch = '?';
    for (col = 0U; col < 8U; ++col) {
        for (row = 0U; row < 16U; ++row) {
            bits = asc2_1608[(u8)ch - ' '][col * 2U + row / 8U];
            px((u16)(x + col), (u16)(y + row),
               (bits & (1U << (7U - row % 8U))) ? fg : bg);
        }
    }
}

static void text(u16 x, u16 y, const char *value, u32 fg, u32 bg)
{
    while (*value != '\0') {
        glyph(x, y, *value, fg, bg);
        value++;
        x = (u16)(x + 8U);
    }
}

static void hex32(u16 x, u16 y, u32 value, u32 fg, u32 bg)
{
    static const char digits[] = "0123456789ABCDEF";
    int shift;
    text(x, y, "0x", fg, bg);
    x = (u16)(x + 16U);
    for (shift = 28; shift >= 0; shift -= 4) {
        glyph(x, y, digits[(value >> shift) & 0xFU], fg, bg);
        x = (u16)(x + 8U);
    }
}

static void present_frame(void)
{
    Xil_DCacheFlushRange(g_frame_addr[g_draw_frame], FB_SIZE);
    (void)XAxiVdma_StartParking(&g_vdma, (int)g_draw_frame, XAXIVDMA_READ);
    g_display_frame = g_draw_frame;
    g_draw_frame ^= 1U;
    g_fb = (u8 *)g_frame_addr[g_draw_frame];
    usleep(34000U);
    memcpy(g_fb, (const void *)g_frame_addr[g_display_frame], FB_SIZE);
}

static int video_init(void)
{
    XAxiVdma_Config *vdma_config;
    XAxiVdma_DmaSetup dma;
    XVtc_Config *vtc_config;
    XVtc_Timing timing;
    XVtc_SourceSelect source;
    int status;
    int index;

    vdma_config = XAxiVdma_LookupConfig(XPAR_AXIVDMA_0_DEVICE_ID);
    if (vdma_config == 0) return XST_FAILURE;
    status = XAxiVdma_CfgInitialize(&g_vdma, vdma_config,
                                    vdma_config->BaseAddress);
    if (status != XST_SUCCESS) return status;

    memset(&dma, 0, sizeof(dma));
    dma.VertSizeInput = FB_H;
    dma.HoriSizeInput = FB_STRIDE;
    dma.Stride = FB_STRIDE;
    dma.EnableCircularBuf = 0;
    dma.EnableSync = 1;
    status = XAxiVdma_DmaConfig(&g_vdma, XAXIVDMA_READ, &dma);
    if (status != XST_SUCCESS) return status;
    for (index = 0; index < g_vdma.MaxNumFrames; ++index) {
        dma.FrameStoreStartAddr[index] = g_frame_addr[index & 1];
    }
    status = XAxiVdma_DmaSetBufferAddr(&g_vdma, XAXIVDMA_READ,
                                       dma.FrameStoreStartAddr);
    if (status != XST_SUCCESS) return status;
    status = XAxiVdma_DmaStart(&g_vdma, XAXIVDMA_READ);
    if (status != XST_SUCCESS) return status;
    status = XAxiVdma_StartParking(&g_vdma, 0, XAXIVDMA_READ);
    if (status != XST_SUCCESS) return status;

    g_display_frame = 0U;
    g_draw_frame = 1U;
    g_fb = (u8 *)g_frame_addr[g_draw_frame];

    vtc_config = XVtc_LookupConfig(XPAR_V_TC_0_DEVICE_ID);
    if (vtc_config == 0) return XST_FAILURE;
    status = XVtc_CfgInitialize(&g_vtc, vtc_config,
                                vtc_config->BaseAddress);
    if (status != XST_SUCCESS) return status;

    memset(&timing, 0, sizeof(timing));
    memset(&source, 0, sizeof(source));
    timing.HActiveVideo = 800;
    timing.HFrontPorch = 40;
    timing.HSyncWidth = 128;
    timing.HBackPorch = 88;
    timing.VActiveVideo = 480;
    timing.V0FrontPorch = 9;
    timing.V0SyncWidth = 2;
    timing.V0BackPorch = 34;
    timing.V1FrontPorch = 9;
    timing.V1SyncWidth = 2;
    timing.V1BackPorch = 34;
    source.VBlankPolSrc = 1;
    source.VSyncPolSrc = 1;
    source.HBlankPolSrc = 1;
    source.HSyncPolSrc = 1;
    source.ActiveVideoPolSrc = 1;
    source.ActiveChromaPolSrc = 1;
    source.VChromaSrc = 1;
    source.VActiveSrc = 1;
    source.VBackPorchSrc = 1;
    source.VSyncSrc = 1;
    source.VFrontPorchSrc = 1;
    source.VTotalSrc = 1;
    source.HActiveSrc = 1;
    source.HBackPorchSrc = 1;
    source.HSyncSrc = 1;
    source.HFrontPorchSrc = 1;
    source.HTotalSrc = 1;
    XVtc_RegUpdateEnable(&g_vtc);
    XVtc_SetGeneratorTiming(&g_vtc, &timing);
    XVtc_SetSource(&g_vtc, &source);
    XVtc_Enable(&g_vtc);
    XVtc_EnableGenerator(&g_vtc);
    return XST_SUCCESS;
}

int platform_ui_init(void)
{
    int status = video_init();
    if (status != XST_SUCCESS) return status;
    fill(0U, 0U, FB_W - 1U, FB_H - 1U, C_BG);
    present_frame();
    usleep(100000U);
    return XST_SUCCESS;
}

static void draw_header(const char *title)
{
    fill(20U, 18U, 779U, 66U, C_PANEL);
    text(44U, 34U, title, C_CYAN, C_PANEL);
}

static void draw_nav_button(u16 x0, u16 x1, const char *label, u8 active)
{
    u32 bg = (active != 0U) ? C_ACTIVE : C_BUTTON;
    fill(x0, 420U, x1, 469U, bg);
    fill(x0, 420U, x1, 422U, (active != 0U) ? C_CYAN : C_BORDER);
    text((u16)(x0 + 18U), 438U, label, C_TEXT, bg);
}

static void draw_navigation(PlatformUiPage page, const PlatformUiStatus *status)
{
    u32 led_bg = (status->led_on != 0U) ? C_ACTIVE : C_BUTTON;

    draw_nav_button(20U, 189U, "HOME", page == PLATFORM_UI_PAGE_HOME);
    draw_nav_button(199U, 388U, "SELF TEST",
                    page == PLATFORM_UI_PAGE_SELF_TEST);
    draw_nav_button(398U, 587U, "EVENTS",
                    page == PLATFORM_UI_PAGE_EVENTS);
    fill(597U, 420U, 779U, 469U, led_bg);
    fill(597U, 420U, 779U, 422U,
         (status->led_on != 0U) ? C_GREEN : C_BORDER);
    text(621U, 438U,
         (status->led_on != 0U) ? "LED: ON" : "LED: OFF",
         C_TEXT, led_bg);
}

static void draw_status_line(u16 y, const char *label, u32 value,
                             u8 passed)
{
    fill(58U, y, 741U, (u16)(y + 34U), C_PANEL);
    text(78U, (u16)(y + 9U), label, C_MUTED, C_PANEL);
    hex32(310U, (u16)(y + 9U), value, C_TEXT, C_PANEL);
    text(622U, (u16)(y + 9U), passed != 0U ? "PASS" : "FAIL",
         passed != 0U ? C_GREEN : C_RED, C_PANEL);
}

static void render_home_page(const PlatformUiStatus *status,
                             const CaptureDemoSnapshot *snapshot)
{
    u32 count = (snapshot != 0) ? snapshot->count : 0U;
    u32 trigger = (snapshot != 0) ? snapshot->trigger_index : 0U;

    draw_header("ZYNQ-7020 MULTI-PROTOCOL PLATFORM");

    fill(34U, 84U, 385U, 396U, C_PANEL);
    text(58U, 104U, "PL PLATFORM", C_CYAN, C_PANEL);
    text(58U, 146U, "SYSTEM ID", C_MUTED, C_PANEL);
    hex32(178U, 146U, status->id,
          status->id_ok != 0U ? C_GREEN : C_RED, C_PANEL);
    text(58U, 188U, "VERSION", C_MUTED, C_PANEL);
    hex32(178U, 188U, status->version, C_TEXT, C_PANEL);
    text(58U, 230U, "CAPABILITY", C_MUTED, C_PANEL);
    hex32(178U, 230U, status->capabilities, C_TEXT, C_PANEL);
    text(58U, 272U, "GT911", C_MUTED, C_PANEL);
    text(178U, 272U, status->touch_ok != 0U ? "READY" : "FAILED",
         status->touch_ok != 0U ? C_GREEN : C_RED, C_PANEL);
    text(58U, 314U, "SNAPSHOT", C_MUTED, C_PANEL);
    text(178U, 314U, status->capture_ok != 0U ? "READY" : "FAILED",
         status->capture_ok != 0U ? C_GREEN : C_RED, C_PANEL);

    fill(415U, 84U, 765U, 396U, C_PANEL);
    text(439U, 104U, "EVENT SUMMARY", C_CYAN, C_PANEL);
    text(439U, 146U, "COUNT", C_MUTED, C_PANEL);
    hex32(535U, 146U, count, C_TEXT, C_PANEL);
    text(439U, 188U, "TRIGGER", C_MUTED, C_PANEL);
    hex32(535U, 188U, trigger,
          status->capture_ok != 0U ? C_GREEN : C_MUTED, C_PANEL);
    text(439U, 230U, "CORE DROP", C_MUTED, C_PANEL);
    hex32(535U, 230U, status->dropped_count,
          status->dropped_count == 0U ? C_GREEN : C_WARN, C_PANEL);
    text(439U, 272U, "EXT DROP", C_MUTED, C_PANEL);
    hex32(535U, 272U, status->ext_dropped_count,
          status->ext_dropped_count == 0U ? C_GREEN : C_WARN, C_PANEL);
    text(439U, 314U, "ARBITRATE", C_MUTED, C_PANEL);
    hex32(535U, 314U, status->arbitration_count, C_TEXT, C_PANEL);
    text(439U, 356U, "SELECT A PAGE BELOW", C_MUTED, C_PANEL);
}

static void render_self_test_page(const PlatformUiStatus *status)
{
    draw_header("PLATFORM SELF TEST");
    draw_status_line(84U, "PL SYSTEM ID", status->id, status->id_ok);
    draw_status_line(124U, "PL VERSION", status->version,
                     status->version_ok);
    draw_status_line(164U, "AXI SCRATCH", status->scratch,
                     status->scratch_ok);
    draw_status_line(204U, "GT911 TOUCH", (u32)status->touch_ok,
                     status->touch_ok);
    draw_status_line(244U, "EVENT SNAPSHOT", (u32)status->capture_ok,
                     status->capture_ok);
    draw_status_line(284U, "CORE DROP", status->dropped_count,
                     status->dropped_count == 0U);
    draw_status_line(324U, "EXT DROP", status->ext_dropped_count,
                     status->ext_dropped_count == 0U);
    fill(58U, 370U, 741U, 401U,
         (status->id_ok != 0U && status->version_ok != 0U &&
          status->scratch_ok != 0U && status->touch_ok != 0U &&
          status->capture_ok != 0U && status->dropped_count == 0U &&
          status->ext_dropped_count == 0U) ? C_ACTIVE : C_BUTTON);
    text(246U, 378U,
         (status->id_ok != 0U && status->version_ok != 0U &&
          status->scratch_ok != 0U && status->touch_ok != 0U &&
          status->capture_ok != 0U && status->dropped_count == 0U &&
          status->ext_dropped_count == 0U) ?
         "ALL CHECKS PASSED" : "CHECKS NEED ATTENTION",
         C_TEXT,
         (status->id_ok != 0U && status->version_ok != 0U &&
          status->scratch_ok != 0U && status->touch_ok != 0U &&
          status->capture_ok != 0U && status->dropped_count == 0U &&
          status->ext_dropped_count == 0U) ? C_ACTIVE : C_BUTTON);
}

static void render_events_page(const PlatformUiStatus *status,
                               const CaptureDemoSnapshot *snapshot)
{
    u32 row;
    u32 event_index;
    u16 y;
    u32 row_bg;

    draw_header("EVENT SNAPSHOT");
    fill(24U, 76U, 775U, 112U, C_PANEL);
    text(42U, 86U, "ID", C_MUTED, C_PANEL);
    hex32(74U, 86U, snapshot != 0 ? snapshot->snapshot_id : 0U,
          C_TEXT, C_PANEL);
    text(216U, 86U, "COUNT", C_MUTED, C_PANEL);
    hex32(272U, 86U, snapshot != 0 ? snapshot->count : 0U,
          C_TEXT, C_PANEL);
    text(410U, 86U, "TRIGGER", C_MUTED, C_PANEL);
    hex32(482U, 86U, snapshot != 0 ? snapshot->trigger_index : 0U,
          status->capture_ok != 0U ? C_GREEN : C_RED, C_PANEL);

    if (snapshot == 0 || status->capture_ok == 0U) {
        fill(38U, 128U, 761U, 388U, C_PANEL);
        text(262U, 246U, "NO VALID SNAPSHOT", C_RED, C_PANEL);
        return;
    }

    for (row = 0U; row < snapshot->shown; ++row) {
        event_index = snapshot->first_index + row;
        y = (u16)(120U + row * 35U);
        row_bg = (event_index == snapshot->trigger_index) ? C_ACTIVE : C_PANEL;
        fill(38U, y, 761U, (u16)(y + 28U), row_bg);
        text(50U, (u16)(y + 6U),
             (event_index == snapshot->trigger_index) ? "TRG" : "EVT",
             (event_index == snapshot->trigger_index) ? C_TEXT : C_MUTED,
             row_bg);
        hex32(88U, (u16)(y + 6U), event_index, C_TEXT, row_bg);
        text(238U, (u16)(y + 6U), "VIRTUAL", C_MUTED, row_bg);
        text(382U, (u16)(y + 6U), "TXID", C_MUTED, row_bg);
        hex32(430U, (u16)(y + 6U), snapshot->transaction_id[row],
              C_TEXT, row_bg);
    }
}

void platform_ui_render_page(PlatformUiPage page,
                             const PlatformUiStatus *status,
                             const CaptureDemoSnapshot *snapshot)
{
    if (status == 0) return;
    fill(0U, 0U, FB_W - 1U, FB_H - 1U, C_BG);
    if (page == PLATFORM_UI_PAGE_SELF_TEST) {
        render_self_test_page(status);
    } else if (page == PLATFORM_UI_PAGE_EVENTS) {
        render_events_page(status, snapshot);
    } else {
        render_home_page(status, snapshot);
    }
    draw_navigation(page, status);
    present_frame();
}

PlatformUiAction platform_ui_poll_action(void)
{
    static u8 latched;
    u16 x;
    u16 y;

    gt911_scan(&TouchInfo);
    if (TouchInfo.Touch_Num == 0U) {
        latched = 0U;
        return PLATFORM_UI_ACTION_NONE;
    }
    if (latched != 0U) return PLATFORM_UI_ACTION_NONE;

    x = (u16)(((u32)TouchInfo.Tp_X[0] * FB_W) / GT911_RAW_WIDTH);
    y = (u16)(((u32)TouchInfo.Tp_Y[0] * FB_H) / GT911_RAW_HEIGHT);
    if (y < 410U || y > 479U) return PLATFORM_UI_ACTION_NONE;

    latched = 1U;
    if (x >= 20U && x <= 189U) return PLATFORM_UI_ACTION_HOME;
    if (x >= 199U && x <= 388U) return PLATFORM_UI_ACTION_SELF_TEST;
    if (x >= 398U && x <= 587U) return PLATFORM_UI_ACTION_EVENTS;
    if (x >= 597U && x <= 799U) return PLATFORM_UI_ACTION_LED_TOGGLE;
    return PLATFORM_UI_ACTION_NONE;
}

void platform_ui_render(u32 id, u32 version, u32 scratch, u8 led_on, u8 touch_ok)
{
    PlatformUiStatus status;
    memset(&status, 0, sizeof(status));
    status.id = id;
    status.version = version;
    status.scratch = scratch;
    status.id_ok = (id == 0x4D505254U) ? 1U : 0U;
    status.version_ok = (version != 0U) ? 1U : 0U;
    status.scratch_ok = (scratch == 0xA5A55A5AU) ? 1U : 0U;
    status.touch_ok = touch_ok;
    status.led_on = led_on;
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME, &status, 0);
}

void platform_ui_render_capture(const CaptureDemoSnapshot *snapshot,
                                u8 led_on, u8 touch_ok)
{
    PlatformUiStatus status;
    memset(&status, 0, sizeof(status));
    status.touch_ok = touch_ok;
    status.capture_ok = (snapshot != 0) ? 1U : 0U;
    status.led_on = led_on;
    if (snapshot != 0) status.dropped_count = snapshot->dropped_count;
    platform_ui_render_page(PLATFORM_UI_PAGE_EVENTS, &status, snapshot);
}

u8 platform_ui_poll_led_button(void)
{
    return platform_ui_poll_action() == PLATFORM_UI_ACTION_LED_TOGGLE ? 1U : 0U;
}

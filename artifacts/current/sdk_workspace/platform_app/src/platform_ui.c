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

void platform_ui_render(u32 id, u32 version, u32 scratch, u8 led_on, u8 touch_ok)
{
    u32 id_color = (id == 0x4D505254U) ? C_GREEN : C_RED;
    u32 touch_color = (touch_ok != 0U) ? C_GREEN : C_RED;

    fill(0U, 0U, FB_W - 1U, FB_H - 1U, C_BG);
    fill(20U, 18U, 779U, 66U, C_PANEL);
    text(44U, 34U, "ZYNQ-7020 MULTI-PROTOCOL PLATFORM", C_CYAN, C_PANEL);

    fill(60U, 96U, 739U, 300U, C_PANEL);
    text(90U, 120U, "PL SYSTEM ID", C_MUTED, C_PANEL);
    hex32(350U, 120U, id, id_color, C_PANEL);
    text(90U, 164U, "PL VERSION", C_MUTED, C_PANEL);
    hex32(350U, 164U, version, C_TEXT, C_PANEL);
    text(90U, 208U, "AXI SCRATCH", C_MUTED, C_PANEL);
    hex32(350U, 208U, scratch, C_TEXT, C_PANEL);
    text(90U, 252U, "GT911 TOUCH", C_MUTED, C_PANEL);
    text(350U, 252U, (touch_ok != 0U) ? "READY" : "FAILED",
         touch_color, C_PANEL);

    fill(250U, 350U, 549U, 439U, (led_on != 0U) ? C_ACTIVE : C_BUTTON);
    fill(250U, 350U, 549U, 352U, C_BORDER);
    text(330U, 375U, "PL LED CONTROL", C_TEXT,
         (led_on != 0U) ? C_ACTIVE : C_BUTTON);
    text(366U, 405U, (led_on != 0U) ? "ON" : "OFF", C_TEXT,
         (led_on != 0U) ? C_ACTIVE : C_BUTTON);
    present_frame();
}

void platform_ui_render_capture(const CaptureDemoSnapshot *snapshot,
                                u8 led_on, u8 touch_ok)
{
    u32 row;
    u32 event_index;
    u16 y;
    u32 row_bg;

    fill(0U, 0U, FB_W - 1U, FB_H - 1U, C_BG);
    fill(20U, 18U, 779U, 66U, C_PANEL);
    text(44U, 34U, "EVENT SNAPSHOT / GT911 READY", C_CYAN, C_PANEL);

    fill(24U, 82U, 775U, 118U, C_PANEL);
    text(42U, 92U, "SNAPSHOT", C_MUTED, C_PANEL);
    hex32(122U, 92U, snapshot->snapshot_id, C_TEXT, C_PANEL);
    text(260U, 92U, "COUNT", C_MUTED, C_PANEL);
    hex32(316U, 92U, snapshot->count, C_TEXT, C_PANEL);
    text(454U, 92U, "TRIGGER", C_MUTED, C_PANEL);
    hex32(526U, 92U, snapshot->trigger_index, C_GREEN, C_PANEL);

    for (row = 0U; row < snapshot->shown; ++row) {
        event_index = snapshot->first_index + row;
        y = (u16)(128U + row * 30U);
        row_bg = (event_index == snapshot->trigger_index) ? C_ACTIVE : C_PANEL;
        fill(38U, y, 761U, (u16)(y + 24U), row_bg);
        text(52U, (u16)(y + 4U),
             (event_index == snapshot->trigger_index) ? "TRG" : "EVT",
             (event_index == snapshot->trigger_index) ? C_TEXT : C_MUTED,
             row_bg);
        hex32(92U, (u16)(y + 4U), event_index, C_TEXT, row_bg);
        text(244U, (u16)(y + 4U), "SYSTEM/VIRTUAL", C_MUTED, row_bg);
        text(420U, (u16)(y + 4U), "TXID", C_MUTED, row_bg);
        hex32(468U, (u16)(y + 4U), snapshot->transaction_id[row],
              C_TEXT, row_bg);
    }

    fill(250U, 390U, 549U, 459U, (led_on != 0U) ? C_ACTIVE : C_BUTTON);
    text(314U, 404U, "PL LED CONTROL", C_TEXT,
         (led_on != 0U) ? C_ACTIVE : C_BUTTON);
    text(366U, 432U, (led_on != 0U) ? "ON" : "OFF", C_TEXT,
         (led_on != 0U) ? C_ACTIVE : C_BUTTON);
    if (touch_ok == 0U) {
        text(614U, 432U, "TOUCH FAIL", C_RED, C_BG);
    }
    present_frame();
}

u8 platform_ui_poll_led_button(void)
{
    static u8 latched;
    u16 x;
    u16 y;

    gt911_scan(&TouchInfo);
    if (TouchInfo.Touch_Num == 0U) {
        latched = 0U;
        return 0U;
    }
    x = (u16)(((u32)TouchInfo.Tp_X[0] * FB_W) / GT911_RAW_WIDTH);
    y = (u16)(((u32)TouchInfo.Tp_Y[0] * FB_H) / GT911_RAW_HEIGHT);
    if (x >= 250U && x <= 549U && y >= 350U && y <= 459U) {
        if (latched == 0U) {
            latched = 1U;
            return 1U;
        }
    }
    return 0U;
}

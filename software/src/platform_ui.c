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
#define C_GRID       0x183547U
#define C_TRIGGER    0x2D7DFFU
#define C_HEADER     0x0B2233U

static XAxiVdma g_vdma;
static XVtc g_vtc;
static const UINTPTR g_frame_addr[2] = {FB_ADDR_0, FB_ADDR_1};
static u8 *g_fb = (u8 *)FB_ADDR_1;
static u8 g_display_frame;
static u8 g_draw_frame = 1U;
static PlatformUiPage g_rendered_page = PLATFORM_UI_PAGE_HOME;
static CaptureDemoSnapshot g_last_event_snapshot;
static u8 g_last_event_snapshot_valid;
static u8 g_clip_enabled;
static u16 g_clip_x0;
static u16 g_clip_y0;
static u16 g_clip_x1;
static u16 g_clip_y1;

static void px(u16 x, u16 y, u32 color)
{
    u32 offset;
    if (x >= FB_W || y >= FB_H) return;
    if (g_clip_enabled != 0U &&
        (x < g_clip_x0 || x > g_clip_x1 ||
         y < g_clip_y0 || y > g_clip_y1)) return;
    offset = (u32)y * FB_STRIDE + (u32)x * 3U;
    g_fb[offset] = (u8)color;
    g_fb[offset + 1U] = (u8)(color >> 8);
    g_fb[offset + 2U] = (u8)(color >> 16);
}

static void set_clip(u16 x0, u16 y0, u16 x1, u16 y1)
{
    g_clip_x0 = x0;
    g_clip_y0 = y0;
    g_clip_x1 = x1;
    g_clip_y1 = y1;
    g_clip_enabled = 1U;
}

static void clear_clip(void)
{
    g_clip_enabled = 0U;
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

static void dec32(u16 x, u16 y, u32 value, u32 fg, u32 bg)
{
    char buffer[11];
    u8 length = 0U;
    u8 index;

    if (value == 0U) {
        glyph(x, y, '0', fg, bg);
        return;
    }
    while (value != 0U && length < 10U) {
        buffer[length++] = (char)('0' + (value % 10U));
        value /= 10U;
    }
    for (index = 0U; index < length; ++index) {
        glyph((u16)(x + index * 8U), y, buffer[length - index - 1U], fg, bg);
    }
}

static void hline(u16 x0, u16 x1, u16 y, u32 color)
{
    fill(x0, y, x1, y, color);
}

static void vline(u16 x, u16 y0, u16 y1, u32 color)
{
    fill(x, y0, x, y1, color);
}

static void outline(u16 x0, u16 y0, u16 x1, u16 y1, u32 color)
{
    hline(x0, x1, y0, color);
    hline(x0, x1, y1, color);
    vline(x0, y0, y1, color);
    vline(x1, y0, y1, color);
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

static u8 all_checks_passed(const PlatformUiStatus *status)
{
    return (status->id_ok != 0U && status->version_ok != 0U &&
            status->scratch_ok != 0U && status->touch_ok != 0U &&
            status->capture_ok != 0U && status->dropped_count == 0U &&
            status->ext_dropped_count == 0U) ? 1U : 0U;
}

static const char *protocol_name(u32 protocol)
{
    static const char *names[] = {"VIRT", "UART", "SPI", "I2C", "CAN"};
    return protocol < 5U ? names[protocol] : "UNKN";
}

static void draw_header(const char *title, const PlatformUiStatus *status,
                        const CaptureDemoSnapshot *snapshot)
{
    u32 state_bg = status->capture_ok != 0U ? C_ACTIVE : C_BUTTON;

    fill(0U, 0U, 799U, 41U, C_HEADER);
    fill(0U, 40U, 799U, 41U, C_CYAN);
    text(18U, 13U, "MPA-7020", C_CYAN, C_HEADER);
    text(116U, 13U, title, C_TEXT, C_HEADER);

    fill(582U, 7U, 670U, 34U, state_bg);
    text(596U, 13U, status->capture_ok != 0U ? "TRIGGER" : "IDLE",
         status->capture_ok != 0U ? C_GREEN : C_WARN, state_bg);
    text(690U, 13U, "SNAP", C_MUTED, C_HEADER);
    dec32(730U, 13U, snapshot != 0 ? snapshot->snapshot_id : 0U,
          C_TEXT, C_HEADER);
}

static void draw_nav_button(u16 x0, u16 x1, const char *label, u8 active)
{
    u32 bg = (active != 0U) ? C_ACTIVE : C_BUTTON;
    fill(x0, 422U, x1, 473U, bg);
    outline(x0, 422U, x1, 473U, active != 0U ? C_CYAN : C_BORDER);
    fill(x0, 422U, x1, 425U, active != 0U ? C_CYAN : C_BORDER);
    text((u16)(x0 + 18U), 440U, label, C_TEXT, bg);
}

static void draw_navigation(PlatformUiPage page, const PlatformUiStatus *status)
{
    u32 led_bg = (status->led_on != 0U) ? C_ACTIVE : C_BUTTON;

    draw_nav_button(12U, 188U, "HOME", page == PLATFORM_UI_PAGE_HOME);
    draw_nav_button(196U, 384U, "SELF TEST",
                    page == PLATFORM_UI_PAGE_SELF_TEST);
    draw_nav_button(392U, 580U, "EVENTS",
                    page == PLATFORM_UI_PAGE_EVENTS);
    fill(588U, 422U, 787U, 473U, led_bg);
    outline(588U, 422U, 787U, 473U,
            status->led_on != 0U ? C_GREEN : C_BORDER);
    fill(588U, 422U, 787U, 425U,
         status->led_on != 0U ? C_GREEN : C_BORDER);
    text(622U, 440U,
         status->led_on != 0U ? "D1 OUTPUT  ON" : "D1 OUTPUT OFF",
         C_TEXT, led_bg);
}

static void draw_badge(u16 x0, u16 y0, u16 x1, u16 y1,
                       const char *label, const char *value,
                       u32 accent)
{
    fill(x0, y0, x1, y1, C_PANEL);
    outline(x0, y0, x1, y1, C_BORDER);
    fill(x0, y0, (u16)(x0 + 4U), y1, accent);
    text((u16)(x0 + 15U), (u16)(y0 + 9U), label, C_MUTED, C_PANEL);
    text((u16)(x0 + 15U), (u16)(y0 + 29U), value, accent, C_PANEL);
}

static void draw_value_badge(u16 x0, u16 y0, u16 x1, u16 y1,
                             const char *label, u32 value, u32 accent)
{
    fill(x0, y0, x1, y1, C_PANEL);
    outline(x0, y0, x1, y1, C_BORDER);
    fill(x0, y0, (u16)(x0 + 4U), y1, accent);
    text((u16)(x0 + 15U), (u16)(y0 + 9U), label, C_MUTED, C_PANEL);
    dec32((u16)(x0 + 15U), (u16)(y0 + 29U), value, accent, C_PANEL);
}

static void render_home_page(const PlatformUiStatus *status,
                             const CaptureDemoSnapshot *snapshot)
{
    u32 count = snapshot != 0 ? snapshot->count : 0U;
    u32 trigger = snapshot != 0 ? snapshot->trigger_index : 0U;
    u32 event;
    u16 x;
    u16 trigger_x = 66U;

    draw_header("CAPTURE OVERVIEW", status, snapshot);

    fill(14U, 52U, 560U, 118U, C_PANEL);
    outline(14U, 52U, 560U, 118U, C_BORDER);
    text(30U, 63U, "DEVICE", C_MUTED, C_PANEL);
    text(30U, 86U, "ZYNQ-7020 / PL", C_TEXT, C_PANEL);
    text(210U, 63U, "SYSTEM ID", C_MUTED, C_PANEL);
    hex32(210U, 86U, status->id,
          status->id_ok != 0U ? C_GREEN : C_RED, C_PANEL);
    text(382U, 63U, "VERSION", C_MUTED, C_PANEL);
    hex32(382U, 86U, status->version, C_TEXT, C_PANEL);

    fill(14U, 128U, 560U, 407U, C_PANEL);
    outline(14U, 128U, 560U, 407U, C_BORDER);
    text(30U, 142U, "EVENT RECORD", C_CYAN, C_PANEL);
    text(410U, 142U, "PRE / TRG / POST", C_MUTED, C_PANEL);

    for (event = 0U; event < 9U; ++event) {
        x = (u16)(52U + event * 58U);
        vline(x, 177U, 373U, C_GRID);
    }
    hline(52U, 522U, 274U, C_BORDER);
    hline(52U, 522U, 222U, C_GRID);
    hline(52U, 522U, 326U, C_GRID);
    text(30U, 196U, "EVT", C_MUTED, C_PANEL);
    text(30U, 300U, "SEQ", C_MUTED, C_PANEL);

    if (count > 1U) {
        trigger_x = (u16)(52U + (trigger * 470U) / (count - 1U));
        if (trigger_x > 522U) trigger_x = 522U;
    }
    fill(trigger_x, 174U, (u16)(trigger_x + 3U), 375U, C_TRIGGER);
    text((u16)(trigger_x > 28U ? trigger_x - 28U : trigger_x), 382U,
         "TRIGGER", C_TRIGGER, C_PANEL);

    if (snapshot != 0) {
        for (event = 0U; event < snapshot->shown; ++event) {
            u32 logical = snapshot->first_index + event;
            u16 marker_x = count > 1U ?
                (u16)(52U + (logical * 470U) / (count - 1U)) : 52U;
            u32 marker_color = logical == trigger ? C_TRIGGER : C_CYAN;
            fill((u16)(marker_x - 3U), 266U,
                 (u16)(marker_x + 3U), 282U, marker_color);
        }
    }

    draw_value_badge(572U, 52U, 786U, 115U, "EVENTS", count, C_CYAN);
    draw_value_badge(572U, 124U, 786U, 187U, "TRIGGER INDEX", trigger,
                     C_TRIGGER);
    draw_value_badge(572U, 196U, 786U, 259U, "CORE DROPS",
                     status->dropped_count,
                     status->dropped_count == 0U ? C_GREEN : C_WARN);
    draw_value_badge(572U, 268U, 786U, 331U, "EXT DROPS",
                     status->ext_dropped_count,
                     status->ext_dropped_count == 0U ? C_GREEN : C_WARN);
    draw_badge(572U, 340U, 786U, 407U, "PLATFORM",
               all_checks_passed(status) != 0U ? "READY" : "ATTENTION",
               all_checks_passed(status) != 0U ? C_GREEN : C_WARN);
}

static void draw_check_row(u16 y, const char *label, u32 value, u8 passed)
{
    u32 bg = C_PANEL;
    fill(22U, y, 548U, (u16)(y + 40U), bg);
    outline(22U, y, 548U, (u16)(y + 40U), C_BORDER);
    fill(22U, y, 27U, (u16)(y + 40U), passed != 0U ? C_GREEN : C_RED);
    text(40U, (u16)(y + 12U), label, C_TEXT, bg);
    hex32(272U, (u16)(y + 12U), value, C_MUTED, bg);
    text(486U, (u16)(y + 12U), passed != 0U ? "PASS" : "FAIL",
         passed != 0U ? C_GREEN : C_RED, bg);
}

static void render_self_test_page(const PlatformUiStatus *status,
                                  const CaptureDemoSnapshot *snapshot)
{
    u8 passed = all_checks_passed(status);

    draw_header("SYSTEM HEALTH", status, snapshot);
    draw_check_row(56U, "PL SYSTEM ID", status->id, status->id_ok);
    draw_check_row(104U, "PL VERSION", status->version, status->version_ok);
    draw_check_row(152U, "AXI SCRATCH", status->scratch, status->scratch_ok);
    draw_check_row(200U, "GT911 TOUCH", (u32)status->touch_ok,
                   status->touch_ok);
    draw_check_row(248U, "EVENT SNAPSHOT", (u32)status->capture_ok,
                   status->capture_ok);
    draw_check_row(296U, "CORE DROP", status->dropped_count,
                   status->dropped_count == 0U);
    draw_check_row(344U, "EXTERNAL DROP", status->ext_dropped_count,
                   status->ext_dropped_count == 0U);

    fill(560U, 56U, 786U, 392U, C_PANEL);
    outline(560U, 56U, 786U, 392U, passed != 0U ? C_GREEN : C_WARN);
    text(582U, 76U, "OVERALL STATUS", C_MUTED, C_PANEL);
    text(606U, 112U, passed != 0U ? "READY" : "CHECK",
         passed != 0U ? C_GREEN : C_WARN, C_PANEL);
    hline(582U, 764U, 150U, C_BORDER);
    text(582U, 172U, "CAPABILITY", C_MUTED, C_PANEL);
    hex32(582U, 197U, status->capabilities, C_TEXT, C_PANEL);
    text(582U, 238U, "ARBITRATION", C_MUTED, C_PANEL);
    dec32(582U, 263U, status->arbitration_count, C_TEXT, C_PANEL);
    text(582U, 304U, "D1 OUTPUT", C_MUTED, C_PANEL);
    text(582U, 329U, status->led_on != 0U ? "ON" : "OFF",
         status->led_on != 0U ? C_GREEN : C_TEXT, C_PANEL);
    text(582U, 365U, "TAP D1 BELOW", C_MUTED, C_PANEL);
}

static void draw_events_chrome(const PlatformUiStatus *status,
                               const CaptureDemoSnapshot *snapshot)
{
    u32 last_index;

    draw_header("PROTOCOL DECODE", status, snapshot);
    fill(14U, 50U, 786U, 84U, C_PANEL);
    outline(14U, 50U, 786U, 84U, C_BORDER);
    text(28U, 60U, "SNAP", C_MUTED, C_PANEL);
    dec32(72U, 60U, snapshot != 0 ? snapshot->snapshot_id : 0U,
          C_TEXT, C_PANEL);
    text(150U, 60U, "EVENTS", C_MUTED, C_PANEL);
    dec32(214U, 60U, snapshot != 0 ? snapshot->count : 0U,
          C_TEXT, C_PANEL);
    text(292U, 60U, "TRIGGER", C_MUTED, C_PANEL);
    dec32(364U, 60U, snapshot != 0 ? snapshot->trigger_index : 0U,
          C_TRIGGER, C_PANEL);
    text(460U, 60U, "DROP", C_MUTED, C_PANEL);
    dec32(504U, 60U, status->dropped_count, C_GREEN, C_PANEL);
    text(586U, 60U, "VIEW", C_MUTED, C_PANEL);
    last_index = snapshot != 0 && snapshot->shown != 0U ?
                 snapshot->first_index + snapshot->shown - 1U : 0U;
    dec32(630U, 60U, snapshot != 0 ? snapshot->first_index : 0U,
          C_CYAN, C_PANEL);
    text(662U, 60U, "-", C_MUTED, C_PANEL);
    dec32(678U, 60U, last_index, C_CYAN, C_PANEL);
    text(718U, 60U, "SWIPE", C_MUTED, C_PANEL);

    fill(14U, 92U, 786U, 120U, C_HEADER);
    text(28U, 99U, "MARK", C_MUTED, C_HEADER);
    text(92U, 99U, "INDEX", C_MUTED, C_HEADER);
    text(164U, 99U, "BUS", C_MUTED, C_HEADER);
    text(230U, 99U, "TYPE", C_MUTED, C_HEADER);
    text(302U, 99U, "FLAGS", C_MUTED, C_HEADER);
    text(414U, 99U, "TX ID", C_MUTED, C_HEADER);
    text(550U, 99U, "TIME LO", C_MUTED, C_HEADER);
}

static void draw_event_row_at(const CaptureDemoSnapshot *snapshot,
                              u32 row, int y_position)
{
    u32 event_index;
    u32 word0;
    u32 word1;
    u32 protocol;
    u32 event_type;
    u32 flags;
    u32 row_bg;
    u16 y;

    if (snapshot == 0 || row >= snapshot->shown ||
        y_position > 407 || y_position + 32 < 122) return;

    event_index = snapshot->first_index + row;
    word0 = snapshot->event_word[row][0];
    word1 = snapshot->event_word[row][1];
    protocol = (word1 >> 28) & 0xFU;
    event_type = (word1 >> 16) & 0x3FU;
    flags = word1 & 0xFFFFU;
    y = (u16)y_position;
    row_bg = event_index == snapshot->trigger_index ? C_ACTIVE :
             ((event_index & 1U) != 0U ? C_BG : C_PANEL);
    fill(14U, y, 786U, (u16)(y + 32U), row_bg);
    hline(14U, 786U, (u16)(y + 32U), C_GRID);
    text(28U, (u16)(y + 8U),
         event_index == snapshot->trigger_index ? ">TRG" : " EVT",
         event_index == snapshot->trigger_index ? C_TRIGGER : C_MUTED,
         row_bg);
    dec32(100U, (u16)(y + 8U), event_index, C_TEXT, row_bg);
    text(164U, (u16)(y + 8U), protocol_name(protocol),
         protocol == 0U ? C_MUTED : C_CYAN, row_bg);
    hex32(222U, (u16)(y + 8U), event_type, C_TEXT, row_bg);
    hex32(294U, (u16)(y + 8U), flags, C_TEXT, row_bg);
    hex32(406U, (u16)(y + 8U), word0 & 0x00FFFFFFU,
          C_TEXT, row_bg);
    hex32(542U, (u16)(y + 8U), snapshot->event_word[row][2],
          C_MUTED, row_bg);
}

static void render_events_page(const PlatformUiStatus *status,
                               const CaptureDemoSnapshot *snapshot)
{
    u32 row;

    draw_events_chrome(status, snapshot);

    if (snapshot == 0 || status->capture_ok == 0U) {
        fill(14U, 122U, 786U, 407U, C_PANEL);
        outline(14U, 122U, 786U, 407U, C_BORDER);
        text(318U, 252U, "NO SNAPSHOT", C_RED, C_PANEL);
        return;
    }

    for (row = 0U; row < snapshot->shown; ++row) {
        draw_event_row_at(snapshot, row, (int)(122U + row * 35U));
    }
}

static void animate_events_scroll(const PlatformUiStatus *status,
                                  const CaptureDemoSnapshot *previous,
                                  const CaptureDemoSnapshot *current)
{
    const u32 animation_frames = 12U;
    u32 frame;
    u32 row;
    u32 previous_last;
    u32 event_index;
    u32 distance;
    u32 travel;
    u32 eased_numerator;
    u32 eased_denominator;
    u32 moved;
    u8 forward;
    int offset;
    int y;

    if (previous == 0 || current == 0 ||
        previous->first_index == current->first_index) return;

    forward = current->first_index > previous->first_index ? 1U : 0U;
    distance = forward != 0U ?
               current->first_index - previous->first_index :
               previous->first_index - current->first_index;
    if (distance > CAPTURE_DISPLAY_EVENTS) distance = CAPTURE_DISPLAY_EVENTS;
    travel = distance * 35U;
    previous_last = previous->first_index + previous->shown - 1U;
    eased_denominator = animation_frames * animation_frames * animation_frames;

    for (frame = 1U; frame <= animation_frames; ++frame) {
        /* Integer smoothstep: 3t^2 - 2t^3.  The final frame lands exactly. */
        eased_numerator = frame * frame *
                            (3U * animation_frames - 2U * frame);
        moved = (travel * eased_numerator) / eased_denominator;
        offset = (int)moved;
        if (forward != 0U) offset = -offset;

        fill(0U, 0U, FB_W - 1U, FB_H - 1U, C_BG);
        draw_events_chrome(status, current);
        fill(14U, 122U, 786U, 407U, C_PANEL);
        set_clip(14U, 122U, 786U, 407U);

        for (row = 0U; row < previous->shown; ++row) {
            y = 122 + (int)(row * 35U) + offset;
            draw_event_row_at(previous, row, y);
        }

        for (row = 0U; row < current->shown; ++row) {
            event_index = current->first_index + row;
            if ((forward != 0U && event_index <= previous_last) ||
                (forward == 0U && event_index >= previous->first_index)) {
                continue;
            }
            y = 122 +
                ((int)event_index - (int)previous->first_index) * 35 +
                offset;
            draw_event_row_at(current, row, y);
        }

        clear_clip();
        draw_navigation(PLATFORM_UI_PAGE_EVENTS, status);
        present_frame();
    }
}

void platform_ui_render_page(PlatformUiPage page,
                             const PlatformUiStatus *status,
                             const CaptureDemoSnapshot *snapshot)
{
    if (status == 0) return;
    g_rendered_page = page;
    if (page == PLATFORM_UI_PAGE_EVENTS && snapshot != 0 &&
        g_last_event_snapshot_valid != 0U &&
        g_last_event_snapshot.snapshot_id == snapshot->snapshot_id &&
        g_last_event_snapshot.first_index != snapshot->first_index) {
        animate_events_scroll(status, &g_last_event_snapshot, snapshot);
        g_last_event_snapshot = *snapshot;
        return;
    }
    fill(0U, 0U, FB_W - 1U, FB_H - 1U, C_BG);
    if (page == PLATFORM_UI_PAGE_SELF_TEST) {
        render_self_test_page(status, snapshot);
    } else if (page == PLATFORM_UI_PAGE_EVENTS) {
        render_events_page(status, snapshot);
    } else {
        render_home_page(status, snapshot);
    }
    draw_navigation(page, status);
    present_frame();
    if (page == PLATFORM_UI_PAGE_EVENTS && snapshot != 0) {
        g_last_event_snapshot = *snapshot;
        g_last_event_snapshot_valid = 1U;
    }
}

PlatformUiAction platform_ui_poll_action(void)
{
    static u8 tracking;
    static u16 start_x;
    static u16 start_y;
    static u16 last_x;
    static u16 last_y;
    u16 x;
    u16 y;
    int delta_y;

    gt911_scan(&TouchInfo);
    if (TouchInfo.Touch_Num == 0U) {
        if (tracking == 0U) return PLATFORM_UI_ACTION_NONE;
        tracking = 0U;
        if (g_rendered_page != PLATFORM_UI_PAGE_EVENTS ||
            start_y < 88U || start_y > 410U) {
            return PLATFORM_UI_ACTION_NONE;
        }
        delta_y = (int)last_y - (int)start_y;
        if (delta_y <= -36) return PLATFORM_UI_ACTION_EVENTS_NEXT;
        if (delta_y >= 36) return PLATFORM_UI_ACTION_EVENTS_PREVIOUS;
        return PLATFORM_UI_ACTION_NONE;
    }

    x = (u16)(((u32)TouchInfo.Tp_X[0] * FB_W) / GT911_RAW_WIDTH);
    y = (u16)(((u32)TouchInfo.Tp_Y[0] * FB_H) / GT911_RAW_HEIGHT);
    if (tracking != 0U) {
        last_x = x;
        last_y = y;
        return PLATFORM_UI_ACTION_NONE;
    }

    tracking = 1U;
    start_x = x;
    start_y = y;
    last_x = x;
    last_y = y;
    (void)start_x;
    (void)last_x;

    if (y < 414U || y > 479U) return PLATFORM_UI_ACTION_NONE;
    if (x >= 12U && x <= 188U) return PLATFORM_UI_ACTION_HOME;
    if (x >= 196U && x <= 384U) return PLATFORM_UI_ACTION_SELF_TEST;
    if (x >= 392U && x <= 580U) return PLATFORM_UI_ACTION_EVENTS;
    if (x >= 588U && x <= 799U) return PLATFORM_UI_ACTION_LED_TOGGLE;
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

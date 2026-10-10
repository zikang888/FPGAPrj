#include "platform_ui.h"
#include "pixel_scroll.h"
#include "event_view.h"
#include "event_audit.h"
#include "spi_trace.h"
#include "ui_counter_semantics.h"

#include "font.h"
#include "touch.h"
#include "xaxivdma.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "xvtc.h"
#include "sleep.h"
#include "string.h"
#include "xtime_l.h"

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
#define EVENTS_Y0    122U
#define EVENTS_Y1    407U
#define EVENT_ROW_PX 35U
#define FRAME_SETTLE_US 34000U

static XAxiVdma g_vdma;
static XVtc g_vtc;
static const UINTPTR g_frame_addr[2] = {FB_ADDR_0, FB_ADDR_1};
static u8 *g_fb = (u8 *)FB_ADDR_1;
static u8 g_display_frame;
static u8 g_draw_frame = 1U;
static PlatformUiPage g_rendered_page = PLATFORM_UI_PAGE_HOME;
static PlatformUiPage g_requested_page = PLATFORM_UI_PAGE_HOME;
static PlatformUiStatus g_requested_status;
static CaptureDemoSnapshot g_requested_snapshot;
static u8 g_requested_snapshot_valid;
static const CaptureDemoCache *g_event_cache;
static EventAudit g_event_audit;
static u8 g_event_audit_valid;
static u32 g_scroll_px;
static u32 g_scroll_snapshot_id;
static u8 g_render_pending;
static u8 g_render_full;
static u8 g_counter_render_pending;
static u8 g_frame_pending;
static XTime g_frame_switched_at;
static u16 g_dirty_y0;
static u16 g_dirty_y1;
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

static void present_frame_region(u16 y0, u16 y1)
{
    u32 offset = (u32)y0 * FB_STRIDE;
    u32 length = ((u32)y1 - (u32)y0 + 1U) * FB_STRIDE;
    Xil_DCacheFlushRange(g_frame_addr[g_draw_frame] + offset, length);
    (void)XAxiVdma_StartParking(&g_vdma, (int)g_draw_frame, XAXIVDMA_READ);
    g_display_frame = g_draw_frame;
    g_draw_frame ^= 1U;
    g_fb = (u8 *)g_frame_addr[g_draw_frame];
    g_dirty_y0 = y0;
    g_dirty_y1 = y1;
    XTime_GetTime(&g_frame_switched_at);
    g_frame_pending = 1U;
}

static u8 finish_frame_if_ready(void)
{
    XTime now;
    u32 offset;
    u32 length;
    if (g_frame_pending == 0U) return 1U;
    XTime_GetTime(&now);
    if (now - g_frame_switched_at <
        (XTime)FRAME_SETTLE_US * (COUNTS_PER_SECOND / 1000000U)) return 0U;
    offset = (u32)g_dirty_y0 * FB_STRIDE;
    length = ((u32)g_dirty_y1 - (u32)g_dirty_y0 + 1U) * FB_STRIDE;
    memcpy(g_fb + offset,
           (const u8 *)g_frame_addr[g_display_frame] + offset, length);
    g_frame_pending = 0U;
    return 1U;
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
    present_frame_region(0U, FB_H - 1U);
    usleep(100000U);
    (void)finish_frame_if_ready();
    return XST_SUCCESS;
}

static u8 all_checks_passed(const PlatformUiStatus *status)
{
    return (status->id_ok != 0U && status->version_ok != 0U &&
            status->scratch_ok != 0U && status->touch_ok != 0U &&
            status->capture_ok != 0U &&
            (g_event_audit_valid == 0U || g_event_audit.errors == 0U) &&
            !ui_monitor_errors_present(status->external_loss_count,
                                       status->spi_frame_errors,
                                       status->spi_boundary_errors,
                                       status->spi_duplicates,
                                       status->spi_sequence_errors)) ? 1U : 0U;
}

static void draw_header(const char *title, const PlatformUiStatus *status,
                        const CaptureDemoSnapshot *snapshot)
{
    u32 state_bg = status->capture_ok != 0U ? C_ACTIVE : C_BUTTON;
    const char *state = status->capture_ok == 0U ? "IDLE" :
                        status->capture_source == 1U ? "ARMED" :
                        status->capture_source == 2U ? "FROZEN" : "DEMO";

    fill(0U, 0U, 799U, 41U, C_HEADER);
    fill(0U, 40U, 799U, 41U, C_CYAN);
    text(18U, 13U, "MPA-7020", C_CYAN, C_HEADER);
    text(116U, 13U, title, C_TEXT, C_HEADER);

    fill(582U, 7U, 670U, 34U, state_bg);
    text(596U, 13U, state,
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

static void draw_navigation(PlatformUiPage page)
{
    draw_nav_button(12U, 188U, "HOME", page == PLATFORM_UI_PAGE_HOME);
    draw_nav_button(196U, 384U, "SELF TEST",
                    page == PLATFORM_UI_PAGE_SELF_TEST);
    draw_nav_button(392U, 580U, "EVENTS",
                    page == PLATFORM_UI_PAGE_EVENTS);
    draw_nav_button(588U, 787U, "ERRORS",
                    page == PLATFORM_UI_PAGE_ERRORS);
}

static void hex8(u16 x, u16 y, u8 value, u32 fg, u32 bg)
{
    static const char digits[] = "0123456789ABCDEF";
    glyph(x, y, digits[(value >> 4) & 0xFU], fg, bg);
    glyph((u16)(x + 8U), y, digits[value & 0xFU], fg, bg);
}

static void draw_home_status(const PlatformUiStatus *status)
{
    const char *source = status->capture_source == 1U ? "WAIT SPI" :
                         status->capture_source == 2U ? "REAL SPI" : "DEMO";
    fill(14U, 52U, 786U, 100U, C_PANEL);
    outline(14U, 52U, 786U, 100U, C_BORDER);
    text(30U, 59U, "MONITOR", C_MUTED, C_PANEL);
    text(30U, 78U, all_checks_passed(status) != 0U ? "READY" : "CHECK",
         all_checks_passed(status) != 0U ? C_GREEN : C_WARN, C_PANEL);
    text(286U, 59U, "SOURCE", C_MUTED, C_PANEL);
    text(286U, 78U, source, C_CYAN, C_PANEL);
    text(574U, 59U, "EXTERNAL LOSS", C_MUTED, C_PANEL);
    dec32(574U, 78U, status->external_loss_count,
          status->external_loss_count == 0U ? C_GREEN : C_WARN, C_PANEL);
}

static void draw_spi_wave_lane(const u8 bytes[SPI_TRACE_BYTES], u16 high_y,
                               u16 low_y, u32 color)
{
    u32 bit;
    u8 previous = 0U;
    for (bit = 0U; bit < SPI_TRACE_BYTES * 8U; ++bit) {
        u8 level = (u8)((bytes[bit / 8U] >> (7U - bit % 8U)) & 1U);
        u16 x = (u16)(196U + bit * 15U);
        u16 y = level != 0U ? high_y : low_y;
        if (bit != 0U && level != previous) vline(x, high_y, low_y, color);
        hline(x, (u16)(x + 15U), y, color);
        previous = level;
    }
}

static void render_home_page(const PlatformUiStatus *status,
                             const CaptureDemoSnapshot *snapshot)
{
    SpiTrace trace;
    u32 byte_index;
    int have_trace = 0;

    if (status->capture_source == 2U && g_event_cache != 0 &&
        g_event_cache->valid != 0U && snapshot != 0 &&
        g_event_cache->snapshot_id == snapshot->snapshot_id) {
        have_trace = spi_trace_extract(&g_event_cache->event_word[0][0],
                                       g_event_cache->count, &trace);
    }

    draw_header("PROTOCOL MONITOR", status, snapshot);
    draw_home_status(status);
    fill(14U, 112U, 786U, 407U, C_PANEL);
    outline(14U, 112U, 786U, 407U, C_BORDER);
    text(30U, 126U, "SPI BYTE TRACE", C_CYAN, C_PANEL);
    text(302U, 126U, "DECODED - NOT SAMPLED", C_MUTED, C_PANEL);
    hline(30U, 770U, 160U, C_BORDER);
    if (have_trace == 0) {
        text(274U, 216U,
             status->capture_source == 1U ? "WAITING FOR SPI DATA" :
             "NO REAL SPI CAPTURE", C_TEXT, C_PANEL);
        text(250U, 246U,
             status->capture_source == 1U ? "SEND ONE STM32 JEDEC" :
             "TAP HERE TO ARM SPI", C_CYAN, C_PANEL);
        text(194U, 284U, "DEMO EVENTS ARE NOT BUS WAVEFORMS", C_MUTED, C_PANEL);
        return;
    }

    text(30U, 197U, "MOSI", C_CYAN, C_PANEL);
    text(30U, 279U, "MISO", C_GREEN, C_PANEL);
    text(84U, 197U, "TX", C_MUTED, C_PANEL);
    text(84U, 279U, "RX", C_MUTED, C_PANEL);
    for (byte_index = 0U; byte_index <= SPI_TRACE_BYTES; ++byte_index) {
        u16 x = (u16)(196U + byte_index * 120U);
        vline(x, 178U, 324U, C_GRID);
    }
    draw_spi_wave_lane(trace.mosi, 193U, 223U, C_CYAN);
    draw_spi_wave_lane(trace.miso, 275U, 305U, C_GREEN);
    text(30U, 344U, "TX", C_CYAN, C_PANEL);
    text(30U, 374U, "RX", C_GREEN, C_PANEL);
    for (byte_index = 0U; byte_index < SPI_TRACE_BYTES; ++byte_index) {
        u16 x = (u16)(242U + byte_index * 120U);
        hex8(x, 344U, trace.mosi[byte_index], C_CYAN, C_PANEL);
        hex8(x, 374U, trace.miso[byte_index], C_GREEN, C_PANEL);
    }
    text(692U, 344U, "HEX", C_MUTED, C_PANEL);
    text(692U, 374U, "HEX", C_MUTED, C_PANEL);
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

static void draw_info_row(u16 y, const char *label, u32 value)
{
    fill(22U, y, 548U, (u16)(y + 40U), C_PANEL);
    outline(22U, y, 548U, (u16)(y + 40U), C_BORDER);
    fill(22U, y, 27U, (u16)(y + 40U), C_CYAN);
    text(40U, (u16)(y + 12U), label, C_TEXT, C_PANEL);
    dec32(272U, (u16)(y + 12U), value, C_MUTED, C_PANEL);
    text(486U, (u16)(y + 12U), "INFO", C_CYAN, C_PANEL);
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
    draw_info_row(296U, "CORE REJECTED", status->core_rejected_count);
    draw_check_row(344U, "EXTERNAL LOSS", status->external_loss_count,
                   ui_counter_health_ok(status->external_loss_count));

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
    text(582U, 304U, "CAPTURE MODE", C_MUTED, C_PANEL);
    text(582U, 329U,
         status->capture_source == 1U ? "ARMED" :
         status->capture_source == 2U ? "FROZEN" : "DEMO",
         C_CYAN, C_PANEL);
    text(582U, 365U, "DETAILS: EVENTS", C_MUTED, C_PANEL);
}

static void draw_error_metric(u16 x0, u16 x1, u16 y,
                              const char *label, u32 value, u8 is_fault)
{
    u32 accent = is_fault == 0U ? C_CYAN :
                 value == 0U ? C_GREEN : C_RED;
    fill(x0, y, x1, (u16)(y + 52U), C_PANEL);
    outline(x0, y, x1, (u16)(y + 52U), C_BORDER);
    fill(x0, y, (u16)(x0 + 4U), (u16)(y + 52U), accent);
    text((u16)(x0 + 14U), (u16)(y + 7U), label, C_MUTED, C_PANEL);
    dec32((u16)(x0 + 14U), (u16)(y + 29U), value, accent, C_PANEL);
    text((u16)(x1 - 65U), (u16)(y + 29U),
         is_fault == 0U ? "INFO" : value == 0U ? "OK" : "FAULT",
         accent, C_PANEL);
}

static void render_errors_page(const PlatformUiStatus *status,
                               const CaptureDemoSnapshot *snapshot)
{
    u32 snapshot_errors = 0U;
    u8 fault;
    const char *source = status->capture_source == 1U ? "ARMED" :
                         status->capture_source == 2U ? "REAL SPI" : "DEMO";
    if (snapshot != 0 && g_event_cache != 0 &&
        g_event_cache->valid != 0U && g_event_audit_valid != 0U &&
        g_event_cache->snapshot_id == snapshot->snapshot_id) {
        snapshot_errors = g_event_audit.errors;
    }
    fault = (u8)(ui_monitor_errors_present(status->external_loss_count,
                                           status->spi_frame_errors,
                                           status->spi_boundary_errors,
                                           status->spi_duplicates,
                                           status->spi_sequence_errors) ||
                 snapshot_errors != 0U);
    draw_header("ERROR MONITOR", status, snapshot);
    fill(14U, 52U, 786U, 116U, C_PANEL);
    outline(14U, 52U, 786U, 116U, fault != 0U ? C_RED : C_GREEN);
    text(30U, 61U, "MONITOR STATUS", C_MUTED, C_PANEL);
    text(30U, 86U, fault != 0U ? "ERROR DETECTED" : "NO MONITOR ERRORS",
         fault != 0U ? C_RED : C_GREEN, C_PANEL);
    text(592U, 61U, "SOURCE", C_MUTED, C_PANEL);
    text(592U, 86U, source, C_CYAN, C_PANEL);

    draw_error_metric(14U, 390U, 128U, "EXTERNAL LOSS",
                      status->external_loss_count, 1U);
    draw_error_metric(14U, 390U, 190U, "SPI FRAME ERROR",
                      status->spi_frame_errors, 1U);
    draw_error_metric(14U, 390U, 252U, "SPI BOUNDARY ERROR",
                      status->spi_boundary_errors, 1U);
    draw_error_metric(14U, 390U, 314U, "SPI DUPLICATE",
                      status->spi_duplicates, 1U);

    draw_error_metric(406U, 786U, 128U, "SPI SEQUENCE ERROR",
                      status->spi_sequence_errors, 1U);
    draw_error_metric(406U, 786U, 190U, "SNAPSHOT ERROR EVENTS",
                      snapshot_errors, 1U);
    draw_error_metric(406U, 786U, 252U, "CORE REJECTED",
                      status->core_rejected_count, 0U);
    fill(406U, 314U, 786U, 407U, C_PANEL);
    outline(406U, 314U, 786U, 407U, C_BORDER);
    text(421U, 330U, "CORE REJECTED IS INFO", C_CYAN, C_PANEL);
    text(421U, 356U, "FROZEN SNAPSHOTS REFUSE", C_MUTED, C_PANEL);
    text(421U, 377U, "LATER EVENTS BY DESIGN", C_MUTED, C_PANEL);
}

static void draw_events_chrome(const PlatformUiStatus *status,
                               const CaptureDemoSnapshot *snapshot)
{
    draw_header("PROTOCOL DECODE", status, snapshot);
    if (snapshot != 0 && g_event_cache != 0 &&
        g_event_cache->valid != 0U &&
        g_event_cache->snapshot_id == snapshot->snapshot_id &&
        g_event_audit_valid != 0U) {
        text(422U, 13U, "ERR", C_MUTED, C_HEADER);
        dec32(459U, 13U, g_event_audit.errors,
              g_event_audit.errors != 0U ? C_RED : C_GREEN, C_HEADER);
    }
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
    text(448U, 60U, "REJ", C_MUTED, C_PANEL);
    dec32(488U, 60U, status->core_rejected_count, C_CYAN, C_PANEL);
    fill(580U, 53U, 781U, 81U, C_BUTTON);
    outline(580U, 53U, 781U, 81U, C_CYAN);
    text(616U, 60U,
         status->capture_source == 1U ? "WAIT SPI" :
         (status->capture_source == 2U ? "SHOW DEMO" : "ARM SPI"),
         C_CYAN, C_BUTTON);

    fill(14U, 92U, 786U, 120U, C_HEADER);
    text(28U, 99U, "MARK", C_MUTED, C_HEADER);
    text(92U, 99U, "INDEX", C_MUTED, C_HEADER);
    text(164U, 99U, "BUS", C_MUTED, C_HEADER);
    text(230U, 99U, "TYPE", C_MUTED, C_HEADER);
    text(302U, 99U, "FLAGS", C_MUTED, C_HEADER);
    text(414U, 99U, "TX ID", C_MUTED, C_HEADER);
    text(550U, 99U, "TIME LO", C_MUTED, C_HEADER);
}

static void draw_event_row_at(const u32 *words, u32 event_index,
                              u32 trigger_index, int y_position)
{
    EventView view;
    char type_text[8];
    u32 row_bg;
    u16 y;

    if (words == 0 || y_position > 407 ||
        y_position + 32 < 122) return;

    view = event_view_decode(words);
    event_view_type_text(view.event_type, type_text);
    y = (u16)y_position;
    row_bg = event_index == trigger_index ? C_ACTIVE :
             ((event_index & 1U) != 0U ? C_BG : C_PANEL);
    fill(14U, y, 786U, (u16)(y + 32U), row_bg);
    hline(14U, 786U, (u16)(y + 32U), C_GRID);
    text(28U, (u16)(y + 8U),
         event_index == trigger_index ? ">TRG" : " EVT",
         event_index == trigger_index ? C_TRIGGER : C_MUTED,
         row_bg);
    dec32(100U, (u16)(y + 8U), event_index, C_TEXT, row_bg);
    text(164U, (u16)(y + 8U), event_view_protocol_name(view.protocol),
         view.protocol == 0U ? C_MUTED : C_CYAN, row_bg);
    text(222U, (u16)(y + 8U), type_text,
         event_view_is_error(&view) ? C_RED : C_TEXT, row_bg);
    hex32(294U, (u16)(y + 8U), view.flags,
          event_view_is_error(&view) ? C_RED : C_TEXT, row_bg);
    hex32(406U, (u16)(y + 8U), view.transaction_id,
          C_TEXT, row_bg);
    hex32(542U, (u16)(y + 8U), words[2],
          C_MUTED, row_bg);
}

static u32 max_scroll_px(u32 count)
{
    return pixel_scroll_max(count, EVENT_ROW_PX,
                            EVENTS_Y1 - EVENTS_Y0 + 1U);
}

static void draw_events_region(const CaptureDemoSnapshot *snapshot)
{
    u32 index;
    int y;
    fill(14U, EVENTS_Y0, 786U, EVENTS_Y1, C_PANEL);
    if (snapshot == 0 || g_event_cache == 0 ||
        g_event_cache->valid == 0U ||
        g_event_cache->snapshot_id != snapshot->snapshot_id) return;
    index = g_scroll_px / EVENT_ROW_PX;
    y = (int)EVENTS_Y0 - (int)(g_scroll_px % EVENT_ROW_PX);
    set_clip(14U, EVENTS_Y0, 786U, EVENTS_Y1);
    for (; index < g_event_cache->count && y <= (int)EVENTS_Y1;
         ++index, y += (int)EVENT_ROW_PX) {
        draw_event_row_at(g_event_cache->event_word[index], index,
                          snapshot->trigger_index, y);
    }
    clear_clip();
}

static void render_events_page(const PlatformUiStatus *status,
                               const CaptureDemoSnapshot *snapshot)
{
    u32 row;
    CaptureDemoSnapshot view;

    if (snapshot != 0 && g_event_cache != 0 &&
        g_event_cache->valid != 0U &&
        g_event_cache->snapshot_id == snapshot->snapshot_id) {
        view = *snapshot;
        view.first_index = g_scroll_px / EVENT_ROW_PX;
        view.shown = (u8)((snapshot->count - view.first_index) > 9U ?
                          9U : (snapshot->count - view.first_index));
        draw_events_chrome(status, &view);
        draw_events_region(snapshot);
        return;
    }

    draw_events_chrome(status, snapshot);

    if (snapshot == 0 || status->capture_ok == 0U) {
        fill(14U, 122U, 786U, 407U, C_PANEL);
        outline(14U, 122U, 786U, 407U, C_BORDER);
        text(318U, 252U, "NO SNAPSHOT", C_RED, C_PANEL);
        return;
    }

    for (row = 0U; row < snapshot->shown; ++row) {
        draw_event_row_at(snapshot->event_word[row],
                          snapshot->first_index + row,
                          snapshot->trigger_index,
                          (int)(EVENTS_Y0 + row * EVENT_ROW_PX));
    }
}

void platform_ui_set_event_cache(const CaptureDemoCache *cache)
{
    g_event_cache = cache;
    g_event_audit_valid = 0U;
    if (cache != 0 && cache->valid != 0U &&
        event_audit_snapshot(&cache->event_word[0][0], cache->count,
                             cache->trigger_index, &g_event_audit) != 0) {
        g_event_audit_valid = 1U;
    }
}

void platform_ui_tick(void)
{
    const CaptureDemoSnapshot *snapshot =
        g_requested_snapshot_valid != 0U ? &g_requested_snapshot : 0;
    if (finish_frame_if_ready() == 0U || g_render_pending == 0U) return;

    if (g_render_full != 0U || g_requested_page != g_rendered_page) {
        fill(0U, 0U, FB_W - 1U, FB_H - 1U, C_BG);
        if (g_requested_page == PLATFORM_UI_PAGE_SELF_TEST) {
            render_self_test_page(&g_requested_status, snapshot);
        } else if (g_requested_page == PLATFORM_UI_PAGE_EVENTS) {
            render_events_page(&g_requested_status, snapshot);
        } else if (g_requested_page == PLATFORM_UI_PAGE_ERRORS) {
            render_errors_page(&g_requested_status, snapshot);
        } else {
            render_home_page(&g_requested_status, snapshot);
        }
        draw_navigation(g_requested_page);
        present_frame_region(0U, FB_H - 1U);
        g_counter_render_pending = 0U;
    } else if (g_counter_render_pending != 0U) {
        if (g_requested_page == PLATFORM_UI_PAGE_HOME) {
            draw_home_status(&g_requested_status);
            present_frame_region(52U, 100U);
        } else if (g_requested_page == PLATFORM_UI_PAGE_SELF_TEST) {
            draw_info_row(296U, "CORE REJECTED",
                          g_requested_status.core_rejected_count);
            draw_check_row(344U, "EXTERNAL LOSS",
                           g_requested_status.external_loss_count,
                           ui_counter_health_ok(g_requested_status.external_loss_count));
            fill(560U, 56U, 786U, 150U, C_PANEL);
            outline(560U, 56U, 786U, 150U,
                    all_checks_passed(&g_requested_status) != 0U ? C_GREEN : C_WARN);
            text(582U, 76U, "OVERALL STATUS", C_MUTED, C_PANEL);
            text(606U, 112U,
                 all_checks_passed(&g_requested_status) != 0U ? "READY" : "CHECK",
                 all_checks_passed(&g_requested_status) != 0U ? C_GREEN : C_WARN,
                 C_PANEL);
            present_frame_region(56U, 392U);
        } else if (g_requested_page == PLATFORM_UI_PAGE_EVENTS) {
            draw_events_chrome(&g_requested_status, snapshot);
            present_frame_region(0U, 120U);
        } else {
            render_errors_page(&g_requested_status, snapshot);
            present_frame_region(52U, 407U);
        }
        g_counter_render_pending = 0U;
    } else if (g_requested_page == PLATFORM_UI_PAGE_EVENTS) {
        draw_events_region(snapshot);
        present_frame_region(EVENTS_Y0, EVENTS_Y1);
    }
    g_rendered_page = g_requested_page;
    g_render_pending = 0U;
    g_render_full = 0U;
}

void platform_ui_update_counters(const PlatformUiStatus *status)
{
    if (status == 0) return;
    if (g_requested_status.core_rejected_count == status->core_rejected_count &&
        g_requested_status.external_loss_count == status->external_loss_count &&
        g_requested_status.spi_frame_errors == status->spi_frame_errors &&
        g_requested_status.spi_boundary_errors == status->spi_boundary_errors &&
        g_requested_status.spi_duplicates == status->spi_duplicates &&
        g_requested_status.spi_sequence_errors == status->spi_sequence_errors)
        return;
    g_requested_status.core_rejected_count = status->core_rejected_count;
    g_requested_status.external_loss_count = status->external_loss_count;
    g_requested_status.spi_frame_errors = status->spi_frame_errors;
    g_requested_status.spi_boundary_errors = status->spi_boundary_errors;
    g_requested_status.spi_duplicates = status->spi_duplicates;
    g_requested_status.spi_sequence_errors = status->spi_sequence_errors;
    g_counter_render_pending = 1U;
    g_render_pending = 1U;
}

void platform_ui_render_page(PlatformUiPage page,
                             const PlatformUiStatus *status,
                             const CaptureDemoSnapshot *snapshot)
{
    if (status == 0) return;
    if (page == PLATFORM_UI_PAGE_EVENTS && snapshot != 0 &&
        g_scroll_snapshot_id != snapshot->snapshot_id) {
        g_scroll_snapshot_id = snapshot->snapshot_id;
        g_scroll_px = snapshot->first_index * EVENT_ROW_PX;
        if (g_scroll_px > max_scroll_px(snapshot->count)) {
            g_scroll_px = max_scroll_px(snapshot->count);
        }
    }
    g_requested_page = page;
    g_requested_status = *status;
    g_requested_snapshot_valid = snapshot != 0 ? 1U : 0U;
    if (snapshot != 0) g_requested_snapshot = *snapshot;
    g_render_pending = 1U;
    g_render_full = 1U;
    platform_ui_tick();
}

PlatformUiAction platform_ui_poll_action(void)
{
    static u8 tracking;
    static u8 dragging_events;
    static u8 drag_moved;
    static u16 last_y;
    u16 x;
    u16 y;
    u32 next_scroll;
    u32 maximum;

    gt911_scan(&TouchInfo);
    if (TouchInfo.Touch_Num == 0U) {
        if (tracking == 0U) return PLATFORM_UI_ACTION_NONE;
        tracking = 0U;
        if (dragging_events != 0U && drag_moved != 0U) {
            /* Refresh VIEW metadata after the last pixel-aligned drag frame. */
            g_render_pending = 1U;
            g_render_full = 1U;
        }
        dragging_events = 0U;
        drag_moved = 0U;
        return PLATFORM_UI_ACTION_NONE;
    }

    x = (u16)(((u32)TouchInfo.Tp_X[0] * FB_W) / GT911_RAW_WIDTH);
    y = (u16)(((u32)TouchInfo.Tp_Y[0] * FB_H) / GT911_RAW_HEIGHT);
    if (tracking != 0U) {
        if (dragging_events != 0U) {
            maximum = max_scroll_px(g_requested_snapshot.count);
            next_scroll = pixel_scroll_drag(g_scroll_px, (int)last_y,
                                            (int)y, maximum);
            if (next_scroll != g_scroll_px) {
                g_scroll_px = next_scroll;
                drag_moved = 1U;
                g_render_pending = 1U;
            }
        }
        last_y = y;
        return PLATFORM_UI_ACTION_NONE;
    }

    tracking = 1U;
    last_y = y;
    drag_moved = 0U;
    dragging_events = (g_requested_page == PLATFORM_UI_PAGE_EVENTS &&
                       y >= EVENTS_Y0 && y <= EVENTS_Y1 &&
                       g_requested_snapshot_valid != 0U &&
                       g_event_cache != 0 && g_event_cache->valid != 0U &&
                       g_event_cache->snapshot_id ==
                           g_requested_snapshot.snapshot_id) ? 1U : 0U;
    if (dragging_events != 0U) return PLATFORM_UI_ACTION_NONE;

    if (g_requested_page == PLATFORM_UI_PAGE_EVENTS &&
        y >= 50U && y <= 84U && x >= 580U && x <= 786U)
        return PLATFORM_UI_ACTION_CAPTURE_LIVE;
    if (g_requested_page == PLATFORM_UI_PAGE_HOME &&
        g_requested_status.capture_source == 0U &&
        y >= 112U && y <= 407U && x >= 14U && x <= 786U)
        return PLATFORM_UI_ACTION_CAPTURE_LIVE;
    if (y < 414U || y > 479U) return PLATFORM_UI_ACTION_NONE;
    if (x >= 12U && x <= 188U) return PLATFORM_UI_ACTION_HOME;
    if (x >= 196U && x <= 384U) return PLATFORM_UI_ACTION_SELF_TEST;
    if (x >= 392U && x <= 580U) return PLATFORM_UI_ACTION_EVENTS;
    if (x >= 588U && x <= 799U) return PLATFORM_UI_ACTION_ERRORS;
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
    platform_ui_render_page(PLATFORM_UI_PAGE_EVENTS, &status, snapshot);
}

u8 platform_ui_poll_led_button(void)
{
    return 0U;
}

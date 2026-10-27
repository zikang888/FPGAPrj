#include "platform_ui.h"
#include "pixel_scroll.h"
#include "event_view.h"
#include "event_audit.h"
#include "spi_trace.h"
#include "protocol_trace.h"
#include "waveform_view.h"
#include "event_diagnostics.h"
#include "ui_counter_semantics.h"
#include "ui_workflow.h"

#include "font.h"
#include "touch.h"
#ifdef PLATFORM_UI_HOST_PREVIEW
#include "../tests/ui_preview_stubs.h"
#else
#include "xaxivdma.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "xvtc.h"
#include "sleep.h"
#endif
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
#define EVENTS_Y0    122U
#define EVENTS_Y1    407U
#define EVENT_ROW_PX 35U
#define HISTORY_LIST_Y0 122U
#define HISTORY_LIST_Y1 377U
#define HISTORY_ROW_PX 44U
#define HISTORY_DRAG_PX 10U

static XAxiVdma g_vdma;
#ifndef PLATFORM_UI_HOST_PREVIEW
static XVtc g_vtc;
#endif
#ifdef PLATFORM_UI_HOST_PREVIEW
static u8 g_preview_frame[2][FB_SIZE];
static const UINTPTR g_frame_addr[2] = {(UINTPTR)g_preview_frame[0],(UINTPTR)g_preview_frame[1]};
static u8 *g_fb = g_preview_frame[1];
#else
static const UINTPTR g_frame_addr[2] = {FB_ADDR_0, FB_ADDR_1};
static u8 *g_fb = (u8 *)FB_ADDR_1;
#endif
static u8 g_display_frame;
static u8 g_draw_frame = 1U;
static PlatformUiPage g_rendered_page = PLATFORM_UI_PAGE_HOME;
static PlatformUiPage g_requested_page = PLATFORM_UI_PAGE_HOME;
static PlatformUiStatus g_requested_status;
static CaptureDemoSnapshot g_requested_snapshot;
static u8 g_requested_snapshot_valid;
static const CaptureDemoCache *g_event_cache;
static const TestHistory *g_history;
static u32 g_history_selected;
static u32 g_history_scroll;
static u32 g_history_list_scroll;
static u8 g_history_detail;
static u8 g_history_errors;
static EventAudit g_event_audit;
static u8 g_event_audit_valid;
static u32 g_scroll_px;
static u32 g_scroll_snapshot_id;
static u8 g_render_pending;
static u8 g_render_full;
static u8 g_counter_render_pending;
static u8 g_frame_pending;
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

static int present_frame_region(u16 y0, u16 y1)
{
    u32 offset = (u32)y0 * FB_STRIDE;
    u32 length = ((u32)y1 - (u32)y0 + 1U) * FB_STRIDE;
    int status;

    Xil_DCacheFlushRange(g_frame_addr[g_draw_frame] + offset, length);
    status = XAxiVdma_StartParking(&g_vdma, (int)g_draw_frame,
                                   XAXIVDMA_READ);
    if (status != XST_SUCCESS) return status;

    /* A parking request does not mean that the requested frame is already
     * being scanned. Keep the previous frame untouched until VDMA confirms
     * the handover. */
    g_display_frame = g_draw_frame;
    g_draw_frame ^= 1U;
    g_fb = (u8 *)g_frame_addr[g_draw_frame];
    g_dirty_y0 = y0;
    g_dirty_y1 = y1;
    g_frame_pending = 1U;
    return XST_SUCCESS;
}

static u8 finish_frame_if_ready(void)
{
    u32 offset;
    u32 length;
    if (g_frame_pending == 0U) return 1U;
    if (XAxiVdma_CurrFrameStore(&g_vdma, XAXIVDMA_READ) !=
        (u32)g_display_frame) return 0U;

    /* The previous frame is now off-screen. Mirror the dirty region so that
     * the next partial redraw cannot expose stale pixels from the other
     * buffer. */
    offset = (u32)g_dirty_y0 * FB_STRIDE;
    length = ((u32)g_dirty_y1 - (u32)g_dirty_y0 + 1U) * FB_STRIDE;
    memcpy(g_fb + offset,
           (const u8 *)g_frame_addr[g_display_frame] + offset, length);
    /* The next present may flush a different partial region. Without this
     * flush, VDMA reads stale DDR pixels from the copied region. */
    Xil_DCacheFlushRange(g_frame_addr[g_draw_frame] + offset, length);
    g_frame_pending = 0U;
    return 1U;
}

static int video_init(void)
{
#ifdef PLATFORM_UI_HOST_PREVIEW
    memset(g_preview_frame,0,sizeof(g_preview_frame));
    return XST_SUCCESS;
#else
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
    memset((void *)g_frame_addr[0], 0, FB_SIZE);
    memset((void *)g_frame_addr[1], 0, FB_SIZE);
    Xil_DCacheFlushRange(g_frame_addr[0], FB_SIZE);
    Xil_DCacheFlushRange(g_frame_addr[1], FB_SIZE);
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
#endif
}

int platform_ui_init(void)
{
    int status = video_init();
    u32 wait_ms;
    if (status != XST_SUCCESS) return status;
    fill(0U, 0U, FB_W - 1U, FB_H - 1U, C_BG);
    status = present_frame_region(0U, FB_H - 1U);
    if (status != XST_SUCCESS) return status;
    for (wait_ms = 0U; wait_ms < 500U; ++wait_ms) {
        if (finish_frame_if_ready() != 0U) return XST_SUCCESS;
        usleep(1000U);
    }
    return XST_FAILURE;
}

static u8 all_checks_passed(const PlatformUiStatus *status)
{
    return (status->id_ok != 0U && status->version_ok != 0U &&
            status->scratch_ok != 0U && status->touch_ok != 0U &&
            status->capture_ok != 0U &&
            (g_event_audit_valid == 0U || g_event_audit.errors == 0U) &&
            !error_model_has_fault(&status->error_model) &&
            !ui_monitor_errors_present(status->external_loss_count,
                                       status->spi_frame_errors,
                                       status->spi_boundary_errors,
                                       status->spi_duplicates,
                                       status->spi_sequence_errors)) ? 1U : 0U;
}

static void draw_header(const char *title, const PlatformUiStatus *status,
                        const CaptureDemoSnapshot *snapshot)
{
    u8 listener_live = (u8)ui_protocol_live(status->selected_protocol,
                                             status->capabilities);
    u32 state_bg = listener_live != 0U && status->capture_ok != 0U ?
                   C_ACTIVE : C_BUTTON;
    const char *state = listener_live == 0U ? "OFFLINE" :
                        status->test_failed != 0U ? "ERROR" :
                        status->capture_ok == 0U ? "IDLE" :
                        status->test_running != 0U ? "RECORD" :
                        status->capture_source == 1U ? "ARMED" :
                        status->capture_source == 2U ? "SAVED" : "DEMO";

    fill(0U, 0U, 799U, 41U, C_HEADER);
    fill(0U, 40U, 799U, 41U, C_CYAN);
    text(18U, 13U, "MPA-7020", C_CYAN, C_HEADER);
    text(116U, 13U, title, C_TEXT, C_HEADER);
    text(326U, 13U, "VIEW", C_MUTED, C_HEADER);
    text(370U, 13U, ui_protocol_name(status->selected_protocol),
         C_CYAN, C_HEADER);

    fill(582U, 7U, 670U, 34U, state_bg);
    text(596U, 13U, state,
         listener_live != 0U && status->capture_ok != 0U ?
         C_GREEN : C_WARN, state_bg);
    text(690U, 13U, status->test_id != 0U ? "TEST" : "SNAP", C_MUTED, C_HEADER);
    dec32(730U, 13U, status->test_id != 0U ? status->test_id :
          snapshot != 0 ? snapshot->snapshot_id : 0U,
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
    draw_nav_button(12U,160U,"HOME",page==PLATFORM_UI_PAGE_HOME);
    draw_nav_button(168U,316U,"TESTS",page==PLATFORM_UI_PAGE_EVENTS);
    draw_nav_button(324U,472U,"ERRORS",page==PLATFORM_UI_PAGE_ERRORS);
    draw_nav_button(480U,628U,"HISTORY",page==PLATFORM_UI_PAGE_HISTORY);
    draw_nav_button(636U,787U,"STATUS",page==PLATFORM_UI_PAGE_SELF_TEST);
}

static void hex8(u16 x, u16 y, u8 value, u32 fg, u32 bg)
{
    static const char digits[] = "0123456789ABCDEF";
    glyph(x, y, digits[(value >> 4) & 0xFU], fg, bg);
    glyph((u16)(x + 8U), y, digits[value & 0xFU], fg, bg);
}

static int home_trace_available(const PlatformUiStatus *status)
{
    return !status->test_running &&
           (status->capture_source==1U || status->capture_source==2U) &&
           g_event_cache!=0 && g_event_cache->valid;
}

static void draw_home_status(const PlatformUiStatus *status)
{
    const char *source = status->test_failed ? "CAPTURE FAILED" :
                         status->test_running ? "TEST RECORDING" :
                         status->capture_source == 1U ?
                         (home_trace_available(status) ? "WAIT / PREVIOUS" : "WAIT DATA") :
                         status->capture_source == 2U ? "DATA RECEIVED" : "NO CAPTURE";
    fill(14U, 52U, 786U, 100U, C_PANEL);
    outline(14U, 52U, 786U, 100U, C_BORDER);
    text(30U, 59U, "INPUT MODE", C_MUTED, C_PANEL);
    text(30U,78U,status->selected_protocol==UI_PROTOCOL_CAN ? "CAN NODE" :
         "LISTEN ONLY",C_CYAN,C_PANEL);
    text(286U, 59U, "CAPTURE STATE", C_MUTED, C_PANEL);
    text(286U, 78U, source, C_CYAN, C_PANEL);
    fill(574U,58U,776U,94U,C_BUTTON);
    outline(574U,58U,776U,94U,C_BORDER);
    text(586U,69U,status->test_running ? "OPEN TESTS TO END" :
         status->capture_source==1U ? "WAIT FOR STM32" : "CAPTURE AGAIN",
         status->capture_source==1U ? C_MUTED : C_CYAN,C_BUTTON);
}

static void draw_protocol_tabs(const PlatformUiStatus *status)
{
    unsigned int i;
    for (i = 0U; i < UI_PROTOCOL_COUNT; ++i) {
        UiProtocol protocol = (UiProtocol)i;
        u16 x0 = ui_protocol_tab_left(protocol);
        u16 x1 = ui_protocol_tab_right(protocol);
        u8 active = status->selected_protocol == protocol;
        u8 live = (u8)ui_protocol_live(protocol, status->capabilities);
        u32 bg = active != 0U ? C_ACTIVE : C_BUTTON;
        fill(x0, 112U, x1, 166U, bg);
        outline(x0, 112U, x1, 166U, active != 0U ? C_CYAN : C_BORDER);
        fill(x0, 112U, x1, 115U, active != 0U ? C_CYAN : C_BORDER);
        text((u16)(x0 + 14U), 123U, ui_protocol_name(protocol), C_TEXT, bg);
        text((u16)(x0 + 14U), 145U,
             live != 0U ? "SUPPORTED" : "NOT IN BIT",
             live != 0U ? C_GREEN : C_MUTED, bg);
    }
}

static int home_fault_label(const PlatformUiStatus *status, char label[8])
{
    static const u32 protocol_ids[UI_PROTOCOL_COUNT]={2U,1U,3U,4U};
    u32 i;
    if(!home_trace_available(status))
        return 0;
    for(i=0U;i<g_event_cache->count;++i) {
        EventView event=event_view_decode(g_event_cache->event_word[i]);
        if(event.protocol!=protocol_ids[status->selected_protocol]) continue;
        if(event_diagnostic_label(&g_event_cache->event_word[0][0],
                                  g_event_cache->count,i,label)) {
            if(event.protocol==2U && event.event_type==0x3FU)
                strcpy(label,"PARTIAL");
            return 1;
        }
    }
    return 0;
}

static void draw_home_fault_notice(const PlatformUiStatus *status)
{
    char label[8];
    const char *name;
    if(!home_fault_label(status,label)) return;
    name=!strcmp(label,"BADSTOP")?"BAD STOP":
         !strcmp(label,"ADDRNCK")?"ADDRESS NACK":
         !strcmp(label,"BUSYNCK")?"BUSY NACK":label;
    fill(270U,181U,778U,210U,C_PANEL);
    outline(270U,181U,778U,210U,C_WARN);
    text(280U,190U,"!",C_WARN,C_PANEL);
    text(300U,190U,name,C_WARN,C_PANEL);
    text(460U,190U,"DECODED / SEE ERRORS",C_MUTED,C_PANEL);
}

static void draw_wave_fault(u16 x,u16 end_x,u16 high_y,u16 low_y)
{
    outline((u16)(x-2U),(u16)(high_y-3U),end_x,
            (u16)(low_y+3U),C_WARN);
    text((u16)((x+end_x)/2U-4U),(u16)(high_y-18U),"!",C_WARN,C_PANEL);
}

static void draw_fault_sequence(const PlatformUiStatus *status)
{
    static const u32 ids[UI_PROTOCOL_COUNT]={2U,1U,3U,4U};
    u32 i,n=0U,shown=0U;
    for(i=0U;i<g_event_cache->count;++i)
        if(event_view_decode(g_event_cache->event_word[i]).protocol==ids[status->selected_protocol]) ++n;
    text(30U,231U,"EVENT SEQUENCE - NOT A SAMPLED WAVEFORM",C_WARN,C_PANEL);
    hline(70U,730U,285U,C_BORDER);
    for(i=0U;i<g_event_cache->count && shown<6U;++i) {
        EventView event=event_view_decode(g_event_cache->event_word[i]);
        char label[8]; int fault; u16 x;
        if(event.protocol!=ids[status->selected_protocol]) continue;
        x=(u16)(92U+shown*(n>1U?600U/((n>6U?6U:n)-1U):0U));
        fault=event_diagnostic_label(&g_event_cache->event_word[0][0],g_event_cache->count,i,label);
        if(event.protocol==2U && event.event_type==0x3FU) strcpy(label,"PARTIAL");
        vline(x,271U,297U,fault?C_WARN:C_CYAN);
        text((u16)(x-24U),310U,label,fault?C_WARN:C_TEXT,C_PANEL);
        dec32((u16)(x-4U),250U,i,C_MUTED,C_PANEL);
        ++shown;
    }
    text(30U,351U,"REAL EVENTS; VOLTAGE LEVELS NOT RECORDED",C_MUTED,C_PANEL);
    text(30U,380U,n>6U?"MORE EVENTS IN EVENTS PAGE":"EVENT TIMES AND FLAGS: OPEN EVENTS",C_CYAN,C_PANEL);
}

static void draw_capture_help(const PlatformUiStatus *status)
{
    char label[8];
    const char *wiring[UI_PROTOCOL_COUNT] = {
        "STM32 PA4/5/7/6 > FPGA U11/U12/U10/U9",
        "STM32 PD8 TX > FPGA W5 RX; 115200 / 8N1",
        "PB6 / PB7 > EEPROM + FPGA AA6 / V8; 100 KHZ",
        "SECOND TRANSCEIVER: W8 TXD / AA11 RXD; 500 KBIT/S"
    };
    if(home_fault_label(status,label)) {
        draw_fault_sequence(status);
        return;
    }
    text(74U,240U,status->test_failed ? "CAPTURE FAILED - CHECK STATUS" :
         status->test_running ? "TEST RECORDING - OPEN TESTS, THEN STOP & SAVE" :
         status->capture_source==1U ? "WAITING FOR STM32 DATA" :
         "NO COMPLETE MESSAGE IN THIS CAPTURE",C_TEXT,C_PANEL);
    text(74U,274U,status->test_running ? "SAVED EVENTS AND ERRORS APPEAR AFTER STOP" :
         status->capture_source==1U ? "SEND DATA; THIS VIEW FREEZES AFTER THE NEXT BURST" :
         "TAP CAPTURE AGAIN; SEND ONE MESSAGE FROM STM32",C_CYAN,C_PANEL);
    text(74U,310U,wiring[status->selected_protocol],C_MUTED,C_PANEL);
    text(74U,350U,"FOR ERROR COUNTS: TESTS > START NEW > SEND > STOP & SAVE",
         C_MUTED,C_PANEL);
}

/* All traces use a 608px plot (76% of the 800px LCD). The horizontal
 * coordinate is a decoded bit index, not a measured sample timestamp. */
static void draw_trace_grid(u32 total_bits, u8 two_lanes)
{
    u32 division, dash;
    u16 y;
    for (division=0U; division<=4U; ++division) {
        u32 tick=total_bits*division/4U;
        u16 x=wave_x(tick,total_bits);
        for (dash=224U; dash<332U; dash+=8U)
            vline(x,(u16)dash,(u16)(dash+2U),C_GRID);
        dec32((u16)(x-4U),340U,tick,C_MUTED,C_PANEL);
    }
    for (y=231U; y<=323U; y=(u16)(y+(y==255U?44U:24U))) {
        if (!two_lanes && y>255U) break;
        for (dash=144U; dash<752U; dash+=10U)
            hline((u16)dash,(u16)(dash+2U),y,C_GRID);
        text(124U,(u16)(y-4U),(y==231U || y==299U)?"1":"0",C_MUTED,C_PANEL);
    }
    hline(144U,752U,335U,C_BORDER);
    text(30U,340U,"BIT / FIT",C_MUTED,C_PANEL);
}

static void draw_spi_wave_lane(const u8 *bytes, u32 count, u16 high_y,
                               u16 low_y, u32 color)
{
    u32 bit;
    u8 previous = 0U;
    for (bit = 0U; bit < count * 8U; ++bit) {
        u8 level = (u8)((bytes[bit / 8U] >> (7U - bit % 8U)) & 1U);
        u16 x = wave_x(bit,count*8U);
        u16 y = level != 0U ? high_y : low_y;
        if (bit != 0U && level != previous) vline(x, high_y, low_y, color);
        hline(x,wave_x(bit+1U,count*8U), y, color);
        previous = level;
    }
}

static void draw_uart_trace(const PlatformUiStatus *status)
{
    u32 i, frame=0U, bit, frames=0U;
    text(30U,190U,"UART RX FRAMES",C_CYAN,C_PANEL);
    text(280U,190U,"DECODED - NOT SAMPLED",C_MUTED,C_PANEL);
    hline(30U,770U,214U,C_BORDER);
    if(home_trace_available(status))
        for(i=0U;i<g_event_cache->count && frames<4U;++i) {
            EventView e=event_view_decode(g_event_cache->event_word[i]);
            if(e.protocol==1U && (e.event_type==1U ||
               (e.event_type==0x3FU && (e.flags>>8)==1U))) ++frames;
        }
    if(frames) {draw_trace_grid(frames*10U,0U);text(30U,300U,"HEX",C_MUTED,C_PANEL);}
    if(home_trace_available(status)) {
        for(i=0U;i<g_event_cache->count && frame<4U;++i) {
            EventView event=event_view_decode(g_event_cache->event_word[i]);
            u8 previous=1U;
            u8 bad_stop=(event.event_type==0x3FU && (event.flags>>8)==1U);
            if(event.protocol!=1U || (event.event_type!=1U && !bad_stop)) continue;
            for(bit=0U;bit<10U;++bit) {
                u8 level=bit==0U?0U:bit==9U?(bad_stop?0U:1U):
                         (u8)((event.flags>>(bit-1U))&1U);
                u16 x=wave_x(frame*10U+bit,frames*10U);
                if(level!=previous) vline(x,231U,255U,C_CYAN);
                hline(x,wave_x(frame*10U+bit+1U,frames*10U),level?231U:255U,C_CYAN);
                previous=level;
            }
            if(bad_stop) draw_wave_fault(wave_x(frame*10U+9U,frames*10U),wave_x((frame+1U)*10U,frames*10U),231U,255U);
            hex8((u16)(wave_x(frame*10U+5U,frames*10U)-8U),300U,(u8)event.flags,C_TEXT,C_PANEL);
            text((u16)(wave_x(frame*10U+5U,frames*10U)-32U),370U,bad_stop?"BAD STOP":"8N1",bad_stop?C_RED:C_GREEN,C_PANEL);
            ++frame;
        }
    }
    if(frame==0U) {
        draw_capture_help(status);
    } else text(30U,232U,"RX",C_CYAN,C_PANEL);
}

static void draw_i2c_trace(const PlatformUiStatus *status)
{
    I2cTrace trace;
    u32 byte_index, bit;
    u32 first=0U, i, j;
    u32 shown = 0U;
    u8 previous = 1U;
    int have_trace = 0;
    if (home_trace_available(status)) {
        /* Prefer the transaction containing a captured NACK, rather than
         * displaying the successful address probe preceding an injected fault. */
        for(i=0U;i<g_event_cache->count;++i) {
            EventView event=event_view_decode(g_event_cache->event_word[i]);
            if(event.protocol!=3U || event.event_type!=1U ||
               (event.flags&0x8000U)==0U) continue;
            for(j=i;j>0U;--j) {
                EventView start=event_view_decode(g_event_cache->event_word[j-1U]);
                if(start.protocol==3U && start.event_type==0U &&
                   start.transaction_id==event.transaction_id) {first=j-1U;break;}
            }
            break;
        }
        have_trace = i2c_trace_extract(&g_event_cache->event_word[first][0],
                                       g_event_cache->count-first,&trace);
    }
    text(30U,190U,"I2C BYTE TRACE",C_CYAN,C_PANEL);
    text(302U,190U,"DECODED - NOT SAMPLED",C_MUTED,C_PANEL);
    hline(30U,770U,214U,C_BORDER);
    if (!have_trace) {
        draw_capture_help(status);
        return;
    }
    shown = trace.count;
    draw_trace_grid(shown*9U,1U);
    text(30U,232U,"SCL",C_CYAN,C_PANEL);
    text(30U,300U,"SDA",C_GREEN,C_PANEL);
    for (byte_index=0U;byte_index<shown;++byte_index) {
        for (bit=0U;bit<9U;++bit) {
            u32 lane_bit=byte_index*9U+bit;
            u16 x=wave_x(lane_bit,shown*9U);
            u16 end=wave_x(lane_bit+1U,shown*9U);
            u16 middle=(u16)((x+end)/2U);
            u8 level=bit==8U ? (u8)trace.nack[byte_index] :
                     (u8)((trace.data[byte_index]>>(7U-bit))&1U);
            hline(x,middle,255U,C_CYAN);
            vline(middle,231U,255U,C_CYAN);
            hline(middle,end,231U,C_CYAN);
            vline(end,231U,255U,C_CYAN);
            hline(x,end,level?299U:323U,C_GREEN);
            if (level!=previous) vline(x,299U,323U,C_GREEN);
            previous=level;
        }
        if(trace.nack[byte_index])
            draw_wave_fault(wave_x(byte_index*9U+8U,shown*9U),wave_x((byte_index+1U)*9U,shown*9U),299U,323U);
        hex8((u16)((wave_x(byte_index*9U,shown*9U)+wave_x((byte_index+1U)*9U,shown*9U))/2U-8U),360U,trace.data[byte_index],
             C_TEXT,C_PANEL);
        text((u16)((wave_x(byte_index*9U,shown*9U)+wave_x((byte_index+1U)*9U,shown*9U))/2U-16U),383U,
             trace.nack[byte_index]?"NACK":"ACK",trace.nack[byte_index]?C_RED:C_GREEN,
             C_PANEL);
    }
    text(30U,360U,"HEX",C_MUTED,C_PANEL);
}

static void draw_can_trace(const PlatformUiStatus *status)
{
    CanTrace trace;
    u32 byte_index, shown;
    int have_trace = 0;
    if (home_trace_available(status))
        have_trace = can_trace_extract(&g_event_cache->event_word[0][0],
                                       g_event_cache->count,&trace);
    text(30U,190U,"CAN PAYLOAD BITS",C_CYAN,C_PANEL);
    text(302U,190U,"DECODED - NOT SAMPLED",C_MUTED,C_PANEL);
    hline(30U,770U,214U,C_BORDER);
    if (!have_trace) {
        draw_capture_help(status);
        return;
    }
    shown=trace.count;
    draw_trace_grid(shown*8U,0U);
    text(30U,232U,"DATA",C_CYAN,C_PANEL);
    draw_spi_wave_lane(trace.data,shown,231U,255U,C_CYAN);
    text(30U,300U,"ID",C_MUTED,C_PANEL);
    hex32(72U,300U,(u32)trace.identifier,C_TEXT,C_PANEL);
    text(250U,300U,"DLC",C_MUTED,C_PANEL);
    dec32(290U,300U,trace.dlc,C_TEXT,C_PANEL);
    text(30U,355U,"DATA",C_MUTED,C_PANEL);
    for(byte_index=0U;byte_index<shown;++byte_index)
        hex8((u16)(wave_x(byte_index*8U+4U,shown*8U)-8U),370U,trace.data[byte_index],C_CYAN,C_PANEL);
    text(30U,390U,"PAYLOAD ONLY: NO STUFF / CRC",C_MUTED,C_PANEL);
}

static void render_home_page(const PlatformUiStatus *status,
                             const CaptureDemoSnapshot *snapshot)
{
    WaveSpi trace;
    u32 byte_index;
    int have_trace = 0;

    if (status->selected_protocol == UI_PROTOCOL_SPI &&
        home_trace_available(status)) {
        have_trace = wave_spi_extract(&g_event_cache->event_word[0][0],
                                       g_event_cache->count, &trace);
    }

    draw_header("PROTOCOL MONITOR", status, snapshot);
    draw_home_status(status);
    draw_protocol_tabs(status);
    fill(14U, 176U, 786U, 407U, C_PANEL);
    outline(14U, 176U, 786U, 407U, C_BORDER);
    if (status->selected_protocol == UI_PROTOCOL_UART &&
        ui_protocol_live(UI_PROTOCOL_UART,status->capabilities)) {
        draw_uart_trace(status);
        return;
    }
    if (status->selected_protocol == UI_PROTOCOL_I2C &&
        ui_protocol_live(UI_PROTOCOL_I2C,status->capabilities)) {
        draw_i2c_trace(status);
        return;
    }
    if (status->selected_protocol == UI_PROTOCOL_CAN &&
        ui_protocol_live(UI_PROTOCOL_CAN,status->capabilities)) {
        draw_can_trace(status);
        return;
    }
    if (status->selected_protocol != UI_PROTOCOL_SPI) {
        text(30U, 190U, ui_protocol_name(status->selected_protocol),
             C_CYAN, C_PANEL);
        text(92U, 190U, "PROTOCOL VIEW", C_MUTED, C_PANEL);
        hline(30U, 770U, 214U, C_BORDER);
        text(246U, 248U, "PL LISTENER NOT CONNECTED", C_TEXT, C_PANEL);
        text(226U, 278U, "SELECTION SAVED - NO LIVE INPUT", C_CYAN, C_PANEL);
        text(218U, 310U, "EVENTS AND ERRORS: NO LIVE DATA", C_MUTED, C_PANEL);
        return;
    }
    text(30U, 190U, "SPI BYTE TRACE", C_CYAN, C_PANEL);
    text(302U, 190U, "DECODED - NOT SAMPLED", C_MUTED, C_PANEL);
    hline(30U, 770U, 214U, C_BORDER);
    if (have_trace == 0 || trace.count == 0U) {
        draw_capture_help(status);
        return;
    }

    text(30U, 232U, "MOSI", C_CYAN, C_PANEL);
    text(30U, 300U, "MISO", C_GREEN, C_PANEL);
    text(84U, 232U, "TX", C_MUTED, C_PANEL);
    text(84U, 300U, "RX", C_MUTED, C_PANEL);
    draw_trace_grid(trace.count*8U,1U);
    draw_spi_wave_lane(trace.mosi, trace.count, 231U, 255U, C_CYAN);
    draw_spi_wave_lane(trace.miso, trace.count, 299U, 323U, C_GREEN);
    text(30U, 355U, "TX", C_CYAN, C_PANEL);
    text(30U, 381U, "RX", C_GREEN, C_PANEL);
    for (byte_index = 0U; byte_index < trace.count; ++byte_index) {
        u16 x = (u16)(wave_x(byte_index*8U+4U,trace.count*8U)-8U);
        hex8(x, 355U, trace.mosi[byte_index], C_CYAN, C_PANEL);
        hex8(x, 381U, trace.miso[byte_index], C_GREEN, C_PANEL);
    }
    if(trace.mosi[0]==0x9FU && trace.total>4U)
        draw_wave_fault(wave_x(32U,trace.count*8U),752U,231U,323U);
    else if(trace.mosi[0]==0x9FU && trace.closed && trace.total<4U)
        draw_wave_fault(746U,756U,231U,323U);
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
    text(582U, 76U, "BOARD HEALTH", C_MUTED, C_PANEL);
    text(606U, 112U, passed != 0U ? "READY" : "CHECK",
         passed != 0U ? C_GREEN : C_WARN, C_PANEL);
    hline(582U, 764U, 150U, C_BORDER);
    text(582U, 172U, "CAPABILITY", C_MUTED, C_PANEL);
    hex32(582U, 197U, status->capabilities, C_TEXT, C_PANEL);
    text(582U, 238U, "ARBITRATION", C_MUTED, C_PANEL);
    dec32(582U, 263U, status->arbitration_count, C_TEXT, C_PANEL);
    text(582U, 304U, "LIVE CAPTURE", C_MUTED, C_PANEL);
    text(582U, 329U,
         status->capture_source == 1U ? "ARMED" :
         status->capture_source == 2U ? "FROZEN" : "DEMO",
         C_CYAN, C_PANEL);
    text(582U, 365U,
         ui_protocol_live(status->selected_protocol, status->capabilities) ?
         "LISTENER READY" : "LISTENER NOT WIRED", C_MUTED, C_PANEL);
}

static void draw_error_metric(u16 x0, u16 x1, u16 y,
                              const char *label, u32 value, u8 known)
{
    u32 accent = known == 0U ? C_MUTED :
                 value == 0U ? C_GREEN : C_RED;
    fill(x0, y, x1, (u16)(y + 69U), C_PANEL);
    outline(x0, y, x1, (u16)(y + 69U), C_BORDER);
    fill(x0, y, (u16)(x0 + 4U), (u16)(y + 69U), accent);
    text((u16)(x0 + 14U), (u16)(y + 10U), label, C_MUTED, C_PANEL);
    if (known != 0U)
        dec32((u16)(x0 + 14U), (u16)(y + 36U), value, accent, C_PANEL);
    else
        text((u16)(x0 + 14U), (u16)(y + 36U), "--", accent, C_PANEL);
    text((u16)(x1 - 90U), (u16)(y + 36U),
         known == 0U ? "UNKNOWN" : value == 0U ? "OK" : "FAULT",
         accent, C_PANEL);
}

static void draw_spi_checker_tile(const PlatformUiStatus *status)
{
    u8 fault = status->spi_boundary_errors != 0U ||
               status->spi_duplicates != 0U ||
               status->spi_sequence_errors != 0U;
    u32 accent = status->test_id==0U ? C_MUTED : fault != 0U ? C_RED : C_GREEN;
    fill(14U, 207U, 390U, 276U, C_PANEL);
    outline(14U, 207U, 390U, 276U, C_BORDER);
    fill(14U, 207U, 18U, 276U, accent);
    text(28U, 217U, "SPI EVENT CHECK", C_MUTED, C_PANEL);
    text(28U, 243U, "BND", C_MUTED, C_PANEL);
    dec32(65U, 243U, status->spi_boundary_errors, accent, C_PANEL);
    text(129U, 243U, "DUP", C_MUTED, C_PANEL);
    dec32(166U, 243U, status->spi_duplicates, accent, C_PANEL);
    text(230U, 243U, "SEQ", C_MUTED, C_PANEL);
    dec32(267U, 243U, status->spi_sequence_errors, accent, C_PANEL);
}

static void draw_planned_case(u16 x, u16 y, const char *label,
                              const ErrorModel *model, ErrorCode code)
{
    ErrorObservation reading = error_model_get(model, code);
    text(x, y, label, C_MUTED, C_PANEL);
    if (reading.origin == ERROR_ORIGIN_NONE)
        text((u16)(x + 265U), y, "--", C_MUTED, C_PANEL);
    else
        dec32((u16)(x + 265U), y, reading.count,
              reading.count == 0U ? C_GREEN : C_RED, C_PANEL);
}

static void draw_error_summary(const PlatformUiStatus *status,const char *mode,
                               const char *rate)
{
    u8 bad=(u8)(status->test_failed || status->external_loss_count ||
               error_model_has_fault(&status->error_model));
    u8 has_data=(u8)(status->test_id!=0U && status->test_events!=0U);
    u32 accent=bad ? C_RED : has_data ? C_GREEN : C_MUTED;
    fill(14U,52U,786U,116U,C_PANEL);
    outline(14U,52U,786U,116U,accent);
    text(30U,61U,mode,C_MUTED,C_PANEL);
    text(30U,86U,ui_test_result(status),accent,C_PANEL);
    text(584U,61U,rate,C_CYAN,C_PANEL);
    text(584U,86U,"LOST",C_MUTED,C_PANEL);
    dec32(630U,86U,status->external_loss_count,
          status->external_loss_count?C_RED:C_MUTED,C_PANEL);
}

static void draw_error_help(const PlatformUiStatus *status)
{
    fill(14U,360U,786U,407U,C_PANEL);
    text(28U,368U,ui_error_advice(status),C_CYAN,C_PANEL);
    text(28U,391U,status->selected_protocol==UI_PROTOCOL_CAN ?
         "BUS-OFF: READ STM32 STATUS. UNKNOWN DOES NOT MEAN ZERO." :
         "UNKNOWN = NOT MEASURED. START NEW RESETS THIS TEST ONLY.",
         C_MUTED,C_PANEL);
}

static void render_errors_page(const PlatformUiStatus *status,
                               const CaptureDemoSnapshot *snapshot)
{
    ErrorObservation partial = error_model_get(&status->error_model,
                                                ERROR_SPI_PARTIAL_BYTE);
    ErrorObservation uart_stop = error_model_get(&status->error_model,
                                                  ERROR_UART_STOP_BIT);
    ErrorObservation uart_break = error_model_get(&status->error_model,
                                                   ERROR_UART_BREAK);
    ErrorObservation uart_short = error_model_get(&status->error_model,
                                                   ERROR_UART_SHORT_TRANSACTION);
    ErrorObservation i2c_addr = error_model_get(&status->error_model,
                                                 ERROR_I2C_ADDRESS_NACK);
    ErrorObservation i2c_busy = error_model_get(&status->error_model,
                                                 ERROR_I2C_BUSY_NACK);
    ErrorObservation i2c_stop = error_model_get(&status->error_model,
                                                 ERROR_I2C_MISSING_STOP);
    ErrorObservation can_ack = error_model_get(&status->error_model,
                                                ERROR_CAN_ACK);
    ErrorObservation can_stuff = error_model_get(&status->error_model,
                                                  ERROR_CAN_STUFF);
    ErrorObservation can_crc = error_model_get(&status->error_model,
                                                ERROR_CAN_CRC);
    u32 snapshot_errors = 0U;
    u8 snapshot_known = 0U;
    u8 fault;
    /* Counts are reset at NEW TEST and latched at END & SAVE. */
    const char *source = status->test_id == 0U ? "NO TEST" : "THIS TEST";
    if (snapshot != 0 && g_event_cache != 0 &&
        g_event_cache->valid != 0U && g_event_audit_valid != 0U &&
        g_event_cache->snapshot_id == snapshot->snapshot_id) {
        snapshot_errors = g_event_audit.errors;
        snapshot_known = 1U;
    }
    fault = (u8)(ui_monitor_errors_present(status->external_loss_count,
                                           status->spi_frame_errors,
                                           status->spi_boundary_errors,
                                           status->spi_duplicates,
                                           status->spi_sequence_errors) ||
                 error_model_has_fault(&status->error_model) ||
                 snapshot_errors != 0U);
    draw_header("ERROR MONITOR", status, snapshot);
    if (!ui_protocol_live(status->selected_protocol, status->capabilities)) {
        fill(14U, 52U, 786U, 407U, C_PANEL);
        outline(14U, 52U, 786U, 407U, C_BORDER);
        text(30U, 66U, "SELECTED PROTOCOL", C_MUTED, C_PANEL);
        text(30U, 96U, ui_protocol_name(status->selected_protocol),
             C_CYAN, C_PANEL);
        text(248U, 150U, "ERROR DETECTOR NOT CONNECTED", C_TEXT, C_PANEL);
        text(207U, 185U, "NO RESULT IS NOT THE SAME AS ZERO ERRORS",
             C_WARN, C_PANEL);
        hline(30U, 770U, 234U, C_BORDER);
        text(30U, 257U, "GLOBAL EXTERNAL LOSS", C_MUTED, C_PANEL);
        dec32(30U, 285U, status->external_loss_count,
              status->external_loss_count == 0U ? C_GREEN : C_RED, C_PANEL);
        text(30U, 352U, "SELECT SPI FOR CONNECTED FAULT CHECKS",
             C_CYAN, C_PANEL);
        return;
    }
    if (status->selected_protocol == UI_PROTOCOL_I2C) {
        fault = (u8)(status->external_loss_count != 0U ||
                     i2c_addr.count != 0U || i2c_stop.count != 0U);
        fill(14U, 52U, 786U, 116U, C_PANEL);
        outline(14U, 52U, 786U, 116U, fault ? C_RED : C_GREEN);
        text(30U, 61U, "I2C PASSIVE MONITOR", C_MUTED, C_PANEL);
        text(30U, 86U, fault ? "ERROR DETECTED" : "NO DETECTED ERRORS",
             fault ? C_RED : C_GREEN, C_PANEL);
        text(614U, 61U, "100 KHZ", C_CYAN, C_PANEL);
        draw_error_summary(status,"I2C TEST RESULT","100 KHZ");
        draw_error_metric(14U,390U,128U,"DEVICE DID NOT ACK",i2c_addr.count,
                          i2c_addr.origin!=ERROR_ORIGIN_NONE);
        draw_error_metric(406U,786U,128U,"EEPROM BUSY (INFO)",i2c_busy.count,
                          i2c_busy.origin!=ERROR_ORIGIN_NONE);
        if(i2c_busy.origin!=ERROR_ORIGIN_NONE) {
            fill(420U,160U,776U,186U,C_PANEL);
            dec32(420U,164U,i2c_busy.count,C_CYAN,C_PANEL);
            text(696U,164U,"INFO",C_CYAN,C_PANEL);
        }
        draw_error_metric(14U,390U,207U,"STOP NOT RECEIVED",i2c_stop.count,
                          i2c_stop.origin!=ERROR_ORIGIN_NONE);
        draw_error_metric(406U,786U,207U,"EVENT LOSS",
                          status->external_loss_count,status->test_id!=0U);
        draw_error_help(status);
        return;
    }
    if (status->selected_protocol == UI_PROTOCOL_CAN) {
        fault = (u8)(status->external_loss_count != 0U || can_ack.count != 0U ||
                     can_stuff.count != 0U || can_crc.count != 0U);
        fill(14U,52U,786U,116U,C_PANEL);
        outline(14U,52U,786U,116U,fault ? C_RED : C_GREEN);
        text(30U,61U,"CAN ACTIVE LISTENER",C_MUTED,C_PANEL);
        text(30U,86U,fault ? "ERROR DETECTED" : "NO DETECTED ERRORS",
             fault ? C_RED : C_GREEN,C_PANEL);
        text(602U,61U,"500 KBIT/S",C_CYAN,C_PANEL);
        draw_error_summary(status,"CAN TEST RESULT","500 KBIT/S");
        draw_error_metric(14U,390U,128U,"NO ACK RECEIVED",can_ack.count,
                          can_ack.origin!=ERROR_ORIGIN_NONE);
        draw_error_metric(406U,786U,128U,"BIT STUFFING",can_stuff.count,
                          can_stuff.origin!=ERROR_ORIGIN_NONE);
        draw_error_metric(14U,390U,207U,"CRC CHECK FAILED",can_crc.count,
                          can_crc.origin!=ERROR_ORIGIN_NONE);
        draw_error_metric(406U,786U,207U,"EVENT LOSS",
                          status->external_loss_count,status->test_id!=0U);
        draw_error_help(status);
        return;
    }
    if (status->selected_protocol == UI_PROTOCOL_UART) {
        fault = (u8)(status->external_loss_count != 0U ||
                     uart_stop.count != 0U || uart_break.count != 0U ||
                     uart_short.count != 0U);
        fill(14U, 52U, 786U, 116U, C_PANEL);
        outline(14U, 52U, 786U, 116U, fault != 0U ? C_RED : C_GREEN);
        text(30U, 61U, "UART RX MONITOR", C_MUTED, C_PANEL);
        text(30U, 86U, fault != 0U ? "ERROR DETECTED" : "NO DETECTED ERRORS",
             fault != 0U ? C_RED : C_GREEN, C_PANEL);
        text(592U, 61U, "115200 8N1", C_CYAN, C_PANEL);
        draw_error_summary(status,"UART TEST RESULT","115200 8N1");
        draw_error_metric(14U, 390U, 128U, "BAD STOP BIT",
                          uart_stop.count,
                          uart_stop.origin != ERROR_ORIGIN_NONE);
        draw_error_metric(406U, 786U, 128U, "RX HELD LOW (BREAK)",
                          uart_break.count,
                          uart_break.origin != ERROR_ORIGIN_NONE);
        draw_error_metric(14U, 390U, 207U, "TOO FEW BYTES",
                          uart_short.count,
                          uart_short.origin != ERROR_ORIGIN_NONE);
        draw_error_metric(406U, 786U, 207U, "EXTERNAL EVENT LOSS",
                          status->external_loss_count, status->test_id!=0U);
        fill(14U, 288U, 786U, 407U, C_PANEL);
        outline(14U, 288U, 786U, 407U, C_BORDER);
        text(28U, 297U, "PASSIVE RX: W5; RESERVED TX IDLE: AA9",
             C_CYAN, C_PANEL);
        text(28U, 328U, "EVENTS", C_MUTED, C_PANEL);
        dec32(120U, 328U, status->uart_event_count, C_TEXT, C_PANEL);
        text(250U, 328U, "DATA BYTES", C_MUTED, C_PANEL);
        dec32(390U, 328U, status->uart_data_count, C_TEXT, C_PANEL);
        draw_error_help(status);
        return;
    }
    fill(14U, 52U, 786U, 116U, C_PANEL);
    outline(14U, 52U, 786U, 116U, fault != 0U ? C_RED : C_GREEN);
    text(30U, 61U, "MONITOR STATUS", C_MUTED, C_PANEL);
    text(30U, 86U, fault != 0U ? "ERROR DETECTED" : "NO DETECTED ERRORS",
         fault != 0U ? C_RED : C_GREEN, C_PANEL);
    text(592U, 61U, "SOURCE", C_MUTED, C_PANEL);
    text(592U, 86U, source, C_CYAN, C_PANEL);
    draw_error_summary(status,"SPI TEST RESULT","JEDEC 9F");

    draw_error_metric(14U, 390U, 128U, "SPI PARTIAL BYTE",
                      partial.count, partial.origin != ERROR_ORIGIN_NONE);
    draw_error_metric(406U, 786U, 128U, "EXTERNAL EVENT LOSS",
                      status->external_loss_count, status->test_id!=0U);
    draw_spi_checker_tile(status);
    draw_error_metric(406U, 786U, 207U, "SNAPSHOT ERROR EVENTS",
                      snapshot_errors, snapshot_known);

    fill(14U, 288U, 786U, 407U, C_PANEL);
    outline(14U, 288U, 786U, 407U, C_BORDER);
    text(28U, 297U, "W25Q128 JEDEC 9F SEMANTIC CHECKS", C_CYAN, C_PANEL);
    draw_planned_case(28U, 323U, "SPI SHORT TXN", &status->error_model,
                      ERROR_SPI_SHORT_TRANSACTION);
    draw_planned_case(420U, 323U, "SPI EXTRA BYTE", &status->error_model,
                      ERROR_SPI_EXTRA_BYTES);
    draw_planned_case(28U, 346U, "SPI BAD RESPONSE", &status->error_model,
                      ERROR_SPI_RESPONSE_MISMATCH);
    text(420U, 346U, "EXPECT EF 40 18", C_MUTED, C_PANEL);
    text(28U, 378U, "NEW TEST RESETS COUNTS; HISTORY KEEPS RESULTS",
         C_MUTED, C_PANEL);
}

static u32 selected_event_count(const PlatformUiStatus *status,
                                const CaptureDemoSnapshot *snapshot)
{
    u32 i;
    u32 count = 0U;
    if (status == 0 || snapshot == 0 || g_event_cache == 0 ||
        g_event_cache->valid == 0U ||
        g_event_cache->snapshot_id != snapshot->snapshot_id) return 0U;
    for (i = 0U; i < g_event_cache->count; ++i) {
        EventView event = event_view_decode(g_event_cache->event_word[i]);
        if (ui_protocol_event_matches(status->selected_protocol,
                                      event.protocol,
                                      status->capture_source != 2U)) ++count;
    }
    return count;
}

static void draw_test_button(u16 x0, u16 x1, const char *label, u8 enabled)
{
    fill(x0,50U,x1,84U,C_BUTTON);
    outline(x0,50U,x1,84U,enabled ? C_CYAN : C_BORDER);
    text((u16)(x0+15U),60U,label,enabled ? C_CYAN : C_MUTED,C_BUTTON);
}

static void draw_events_chrome(const PlatformUiStatus *status,
                               const CaptureDemoSnapshot *snapshot)
{
    draw_header("TEST EVENTS",status,snapshot);
    fill(116U,7U,320U,34U,C_HEADER);
    text(116U,13U,"EVENTS",C_TEXT,C_HEADER);
    dec32(180U,13U,status->test_events,C_CYAN,C_HEADER);
    text(440U,13U,"ERR",C_MUTED,C_HEADER);
    dec32(477U,13U,status->test_errors,status->test_errors ? C_RED : C_GREEN,C_HEADER);
    draw_test_button(14U,230U,"START NEW / RESET",
                     !status->test_running &&
                     ui_protocol_live(status->selected_protocol,status->capabilities));
    draw_test_button(244U,480U,"STOP & SAVE",status->test_running);
    draw_test_button(580U,786U,"HISTORY",1U);
    fill(14U,92U,786U,120U,C_HEADER);
    text(28U,99U,"MARK",C_MUTED,C_HEADER);
    text(92U,99U,"INDEX",C_MUTED,C_HEADER);
    text(164U,99U,"BUS",C_MUTED,C_HEADER);
    text(230U,99U,"RESULT",C_MUTED,C_HEADER);
    text(302U,99U,"DATA/DETAIL",C_MUTED,C_HEADER);
    text(414U,99U,"TX ID",C_MUTED,C_HEADER);
    text(550U,99U,"TIME US",C_MUTED,C_HEADER);
    if (status->retained_tail) text(670U,99U,"TAIL256",C_WARN,C_HEADER);
}

static void draw_event_row_at(const u32 *words, u32 event_index,
                              u32 trigger_index, int y_position,
                              const u32 *all_words, u32 word_count)
{
    EventView view;
    char type_text[8];
    int diagnostic_fault;
    u32 row_bg;
    u16 y;

    if (words == 0 || y_position > 407 ||
        y_position + 32 < 122) return;

    view = event_view_decode(words);
    diagnostic_fault = event_diagnostic_label(all_words,word_count,event_index,type_text);
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
         diagnostic_fault ? C_RED : C_TEXT, row_bg);
    if(view.protocol==1U) {
        if(view.event_type==1U || (view.event_type==0x3FU && (view.flags>>8)==1U))
            hex8(302U,(u16)(y+8U),(u8)view.flags,diagnostic_fault?C_RED:C_TEXT,row_bg);
        else if(view.event_type==0x3FU && (view.flags>>8)==2U)
            text(302U,(u16)(y+8U),"LINE LOW",C_RED,row_bg);
        else if(view.event_type==0x3FU && (view.flags>>8)==4U) {
            dec32(302U,(u16)(y+8U),(u8)view.flags,C_RED,row_bg);
            text(328U,(u16)(y+8U),"BYTES",C_RED,row_bg);
        } else text(302U,(u16)(y+8U),"-",C_MUTED,row_bg);
    } else if(view.protocol==2U && view.event_type==1U) {
        text(302U,(u16)(y+8U),"T",C_MUTED,row_bg);
        hex8(312U,(u16)(y+8U),(u8)view.flags,C_CYAN,row_bg);
        text(340U,(u16)(y+8U),"R",C_MUTED,row_bg);
        hex8(350U,(u16)(y+8U),(u8)(view.flags>>8),C_GREEN,row_bg);
    } else if(view.protocol==3U && view.event_type==1U) {
        text(294U,(u16)(y+8U),(view.flags & 0x8000U) ? "NACK" : "ACK",
             (view.flags & 0x8000U) ? C_RED : C_GREEN,row_bg);
        hex8(350U,(u16)(y+8U),(u8)view.flags,C_TEXT,row_bg);
    } else if(view.protocol==4U && view.event_type==1U) {
        text(294U,(u16)(y+8U),"B",C_MUTED,row_bg);
        dec32(306U,(u16)(y+8U),(u8)(view.flags>>8),C_MUTED,row_bg);
        hex8(350U,(u16)(y+8U),(u8)view.flags,C_TEXT,row_bg);
    } else hex32(294U,(u16)(y+8U),view.flags,C_MUTED,row_bg);
    dec32(414U,(u16)(y+8U),view.transaction_id,C_TEXT,row_bg);
    {
        EventView first=event_view_decode(all_words);
        uint64_t elapsed=view.timestamp>=first.timestamp?
                         (view.timestamp-first.timestamp)/100U:0U;
        dec32(550U,(u16)(y+8U),elapsed>0xFFFFFFFFU?0xFFFFFFFFU:(u32)elapsed,C_MUTED,row_bg);
    }
}

static u32 max_scroll_px(u32 count)
{
    return pixel_scroll_max(count, EVENT_ROW_PX,
                            EVENTS_Y1 - EVENTS_Y0 + 1U);
}

static void draw_scroll_indicator_region(u32 count,u32 row_px,u16 y0,u16 y1,u32 scroll)
{
    u32 height=y1-y0+1U;
    u32 maximum=pixel_scroll_max(count,row_px,height);
    u32 thumb, y;
    if(maximum==0U) return;
    thumb=height*height/(count*row_px);
    if(thumb<20U) thumb=20U;
    y=y0+(height-thumb)*scroll/maximum;
    fill(779U,y0,786U,y1,C_GRID);
    fill(780U,(u16)y,785U,(u16)(y+thumb-1U),C_CYAN);
}

static void draw_scroll_indicator(u32 count,u32 scroll)
{
    draw_scroll_indicator_region(count,EVENT_ROW_PX,EVENTS_Y0,EVENTS_Y1,scroll);
}

static u32 history_list_max_scroll(void)
{
    return pixel_scroll_max(g_history!=0?g_history->count:0U,HISTORY_ROW_PX,
                            HISTORY_LIST_Y1-HISTORY_LIST_Y0+1U);
}

static void draw_events_region(const PlatformUiStatus *status,
                               const CaptureDemoSnapshot *snapshot)
{
    u32 index;
    u32 visible = 0U;
    int y;
    fill(14U, EVENTS_Y0, 786U, EVENTS_Y1, C_PANEL);
    if (snapshot == 0 || g_event_cache == 0 ||
        g_event_cache->valid == 0U ||
        g_event_cache->snapshot_id != snapshot->snapshot_id) return;
    if (selected_event_count(status, snapshot) == 0U) {
        text(248U, 237U,
             ui_protocol_live(status->selected_protocol,
                              status->capabilities) ?
             "NO MATCHING BUS EVENTS" : "NO LIVE PROTOCOL EVENTS",
             C_MUTED, C_PANEL);
        return;
    }
    index = 0U;
    y = (int)EVENTS_Y0 - (int)(g_scroll_px % EVENT_ROW_PX);
    set_clip(14U, EVENTS_Y0, 786U, EVENTS_Y1);
    for (; index < g_event_cache->count && y <= (int)EVENTS_Y1; ++index) {
        EventView event = event_view_decode(g_event_cache->event_word[index]);
        if (!ui_protocol_event_matches(status->selected_protocol,
                                       event.protocol,
                                       status->capture_source != 2U)) continue;
        if (visible++ < g_scroll_px / EVENT_ROW_PX) continue;
        draw_event_row_at(g_event_cache->event_word[index], index,
                          snapshot->trigger_index, y,
                          &g_event_cache->event_word[0][0],g_event_cache->count);
        y += (int)EVENT_ROW_PX;
    }
    clear_clip();
    draw_scroll_indicator(selected_event_count(status,snapshot),g_scroll_px);
}

static void render_events_page(const PlatformUiStatus *status,
                               const CaptureDemoSnapshot *snapshot)
{
    draw_events_chrome(status,snapshot);
    if(status->test_failed) {
        fill(14U,EVENTS_Y0,786U,EVENTS_Y1,C_PANEL);
        text(230U,220U,"TEST CAPTURE FAILED",C_RED,C_PANEL);
        text(190U,260U,"CHECK MATCHED BIT/ELF AND TRY NEW TEST",C_MUTED,C_PANEL);
        return;
    }
    if (status->test_running) {
        fill(14U,EVENTS_Y0,786U,EVENTS_Y1,C_PANEL);
        text(252U,160U,"RECORDING THIS TEST",C_CYAN,C_PANEL);
        text(150U,201U,"1. SEND ONE OR MORE STM32 TESTS",C_TEXT,C_PANEL);
        text(150U,233U,"2. TAP STOP & SAVE WHEN FINISHED",C_TEXT,C_PANEL);
        text(150U,265U,"3. REVIEW EVENTS / ERRORS / HISTORY",C_TEXT,C_PANEL);
        text(150U,315U,"EVENT COUNTS UPDATE WHILE RECORDING",C_MUTED,C_PANEL);
        text(150U,345U,"LIST OPENS AFTER STOP; LAST 256 RETAINED",C_MUTED,C_PANEL);
        return;
    }
    if (status->test_id == 0U) {
        fill(14U,EVENTS_Y0,786U,EVENTS_Y1,C_PANEL);
        text(190U,213U,"1. START NEW   2. SEND   3. STOP & SAVE",C_TEXT,C_PANEL);
        text(190U,253U,"START NEW RESETS THIS TEST'S ERROR COUNTS",C_CYAN,C_PANEL);
        text(190U,293U,"PREVIOUS RESULTS REMAIN IN HISTORY",C_MUTED,C_PANEL);
        return;
    }
    if (snapshot != 0 && g_event_cache != 0 && g_event_cache->valid &&
        g_event_cache->snapshot_id == snapshot->snapshot_id && snapshot->count != 0U) {
        draw_events_region(status,snapshot);
    } else {
        fill(14U,EVENTS_Y0,786U,EVENTS_Y1,C_PANEL);
        text(246U,236U,"TEST SAVED WITH NO EVENTS",C_MUTED,C_PANEL);
        text(190U,275U,"CHECK SELECTED PROTOCOL AND WIRING",C_MUTED,C_PANEL);
    }
}

static void render_history_page(const PlatformUiStatus *status,
                                const CaptureDemoSnapshot *snapshot)
{
    const TestHistoryEntry *record;
    u32 i;
    draw_header("TEST HISTORY",status,snapshot);
    fill(326U,7U,799U,34U,C_HEADER);
    text(370U,13U,status->test_running?"LIVE RUN CONTINUES - RAM ONLY":
         "LAST 8 RUNS - RAM ONLY",C_MUTED,C_HEADER);
    draw_test_button(14U,230U,g_history_detail ? "BACK TO LIST" : "LIVE EVENTS",1U);
    fill(244U,50U,786U,84U,C_PANEL);
    if (!g_history_detail) {
        text(260U,60U,"SWIPE TO SCROLL; TAP TO OPEN",C_CYAN,C_PANEL);
        fill(14U,92U,786U,120U,C_HEADER);
        text(28U,99U,"TEST",C_MUTED,C_HEADER);
        text(110U,99U,"BUS",C_MUTED,C_HEADER);
        text(195U,99U,"EVENTS",C_MUTED,C_HEADER);
        text(305U,99U,"ERRORS",C_MUTED,C_HEADER);
        text(415U,99U,"SAVED",C_MUTED,C_HEADER);
        text(525U,99U,"TIME MS",C_MUTED,C_HEADER);
        fill(14U,HISTORY_LIST_Y0,786U,HISTORY_LIST_Y1,C_PANEL);
        if (g_history_list_scroll>history_list_max_scroll())
            g_history_list_scroll=history_list_max_scroll();
        if (g_history == 0 || g_history->count == 0U) {
            text(260U,230U,"NO COMPLETED TESTS YET",C_MUTED,C_PANEL);
            return;
        }
        set_clip(14U,HISTORY_LIST_Y0,786U,HISTORY_LIST_Y1);
        for (i=g_history_list_scroll/HISTORY_ROW_PX;i<g_history->count;++i) {
            u16 y=(u16)(HISTORY_LIST_Y0+i*HISTORY_ROW_PX-g_history_list_scroll);
            if(y>HISTORY_LIST_Y1) break;
            record=test_history_get(g_history,i);
            fill(14U,y,786U,(u16)(y+HISTORY_ROW_PX-3U),(i&1U)?C_BG:C_PANEL);
            dec32(28U,(u16)(y+7U),record->id,C_TEXT,(i&1U)?C_BG:C_PANEL);
            text(110U,(u16)(y+7U),ui_protocol_name((UiProtocol)record->protocol),C_CYAN,(i&1U)?C_BG:C_PANEL);
            dec32(195U,(u16)(y+7U),record->total_events,C_TEXT,(i&1U)?C_BG:C_PANEL);
            dec32(305U,(u16)(y+7U),record->error_count,record->error_count?C_RED:C_GREEN,(i&1U)?C_BG:C_PANEL);
            dec32(415U,(u16)(y+7U),record->count,C_TEXT,(i&1U)?C_BG:C_PANEL);
            dec32(525U,(u16)(y+7U),record->duration_ms,C_MUTED,(i&1U)?C_BG:C_PANEL);
            if(!record->snapshot_valid) text(652U,(u16)(y+7U),"NO SNAP",C_RED,(i&1U)?C_BG:C_PANEL);
            else if(record->overwritten) text(652U,(u16)(y+7U),"TAIL256",C_WARN,(i&1U)?C_BG:C_PANEL);
        }
        clear_clip();
        draw_scroll_indicator_region(g_history->count,HISTORY_ROW_PX,
                                    HISTORY_LIST_Y0,HISTORY_LIST_Y1,g_history_list_scroll);
        text(50U,392U,"NEWEST FIRST; HISTORY CLEARS AFTER POWER-OFF",C_MUTED,C_BG);
        return;
    }
    record=test_history_get(g_history,g_history_selected);
    if(record==0) return;
    text(260U,60U,"TEST",C_MUTED,C_PANEL);
    dec32(304U,60U,record->id,C_TEXT,C_PANEL);
    text(382U,60U,ui_protocol_name((UiProtocol)record->protocol),C_CYAN,C_PANEL);
    text(466U,60U,"ERR",C_MUTED,C_PANEL);
    dec32(502U,60U,record->error_count,record->error_count?C_RED:C_GREEN,C_PANEL);
    draw_test_button(580U,786U,g_history_errors?"EVENT LIST":"ERROR DETAILS",1U);
    if(g_history_errors) {
        ErrorCode codes[6];
        const char *labels[6];
        unsigned int n=ui_error_catalog((UiProtocol)record->protocol,codes,labels);
        fill(14U,92U,786U,407U,C_PANEL);
        for(i=0U;i<n;++i) {
            ErrorObservation reading=error_model_get(&record->errors,codes[i]);
            u16 tile_y=(u16)(105U+(i/2U)*79U);
            draw_error_metric((i&1U)?406U:14U,(i&1U)?786U:390U,
                              tile_y,labels[i],reading.count,
                              reading.origin!=ERROR_ORIGIN_NONE);
            if(codes[i]==ERROR_I2C_BUSY_NACK && reading.origin!=ERROR_ORIGIN_NONE) {
                u16 left=(i&1U)?420U:28U;
                fill(left,(u16)(tile_y+32U),(i&1U)?776U:380U,
                     (u16)(tile_y+60U),C_PANEL);
                dec32(left,(u16)(tile_y+36U),reading.count,C_CYAN,C_PANEL);
                text((i&1U)?696U:300U,(u16)(tile_y+36U),"INFO",C_CYAN,C_PANEL);
            }
        }
        text(30U,353U,"SAVED RESULT - NOT CHANGED BY A NEW TEST",C_CYAN,C_PANEL);
        text(30U,385U,"EVENTS",C_MUTED,C_PANEL);
        dec32(94U,385U,record->total_events,C_TEXT,C_PANEL);
        text(250U,385U,"BYTES",C_MUTED,C_PANEL);
        dec32(306U,385U,record->data_count,C_TEXT,C_PANEL);
        text(500U,385U,"LOST",C_MUTED,C_PANEL);
        dec32(548U,385U,record->external_loss,record->external_loss?C_RED:C_MUTED,C_PANEL);
        return;
    }
    fill(14U,92U,786U,120U,C_HEADER);
    text(28U,99U,"SAVED",C_MUTED,C_HEADER); text(92U,99U,"INDEX",C_MUTED,C_HEADER);
    text(164U,99U,"BUS",C_MUTED,C_HEADER); text(230U,99U,"RESULT",C_MUTED,C_HEADER);
    text(302U,99U,"DATA/DETAIL",C_MUTED,C_HEADER); text(414U,99U,"TX ID",C_MUTED,C_HEADER);
    text(550U,99U,"TIME US",C_MUTED,C_HEADER);
    fill(14U,EVENTS_Y0,786U,EVENTS_Y1,C_PANEL);
    if(record->count==0U) { text(260U,240U,record->snapshot_valid?
        "NO EVENTS IN THIS RUN":"SNAPSHOT UNAVAILABLE",C_MUTED,C_PANEL); return; }
    set_clip(14U,EVENTS_Y0,786U,EVENTS_Y1);
    for(i=g_history_scroll/EVENT_ROW_PX;i<record->count;++i) {
        int y=(int)EVENTS_Y0+(int)(i*EVENT_ROW_PX)-(int)g_history_scroll;
        if(y>(int)EVENTS_Y1) break;
        draw_event_row_at(record->words[i],i,0xFFFFFFFFU,y,&record->words[0][0],record->count);
    }
    clear_clip();
    draw_scroll_indicator(record->count,g_history_scroll);
}

void platform_ui_set_history(const TestHistory *history)
{
    g_history=history;
    g_history_detail=0U;
    g_history_errors=0U;
    g_history_scroll=0U;
    g_history_list_scroll=0U;
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
    int present_status = XST_SUCCESS;
    if (finish_frame_if_ready() == 0U || g_render_pending == 0U) return;

    if (g_render_full != 0U || g_requested_page != g_rendered_page) {
        fill(0U, 0U, FB_W - 1U, FB_H - 1U, C_BG);
        if (g_requested_page == PLATFORM_UI_PAGE_SELF_TEST) {
            render_self_test_page(&g_requested_status, snapshot);
        } else if (g_requested_page == PLATFORM_UI_PAGE_EVENTS) {
            render_events_page(&g_requested_status, snapshot);
        } else if (g_requested_page == PLATFORM_UI_PAGE_ERRORS) {
            render_errors_page(&g_requested_status, snapshot);
        } else if (g_requested_page == PLATFORM_UI_PAGE_HISTORY) {
            render_history_page(&g_requested_status, snapshot);
        } else {
            render_home_page(&g_requested_status, snapshot);
            draw_home_fault_notice(&g_requested_status);
        }
        draw_navigation(g_requested_page);
        present_status = present_frame_region(0U, FB_H - 1U);
    } else if (g_counter_render_pending != 0U) {
        if (g_requested_page == PLATFORM_UI_PAGE_HOME) {
            draw_home_status(&g_requested_status);
            present_status = present_frame_region(52U, 100U);
        } else if (g_requested_page == PLATFORM_UI_PAGE_SELF_TEST) {
            draw_info_row(296U, "CORE REJECTED",
                          g_requested_status.core_rejected_count);
            draw_check_row(344U, "EXTERNAL LOSS",
                           g_requested_status.external_loss_count,
                           ui_counter_health_ok(g_requested_status.external_loss_count));
            fill(560U, 56U, 786U, 150U, C_PANEL);
            outline(560U, 56U, 786U, 150U,
                    all_checks_passed(&g_requested_status) != 0U ? C_GREEN : C_WARN);
            text(582U, 76U, "BOARD HEALTH", C_MUTED, C_PANEL);
            text(606U, 112U,
                 all_checks_passed(&g_requested_status) != 0U ? "READY" : "CHECK",
                 all_checks_passed(&g_requested_status) != 0U ? C_GREEN : C_WARN,
                 C_PANEL);
            present_status = present_frame_region(56U, 392U);
        } else if (g_requested_page == PLATFORM_UI_PAGE_EVENTS) {
            render_events_page(&g_requested_status, snapshot);
            present_status = present_frame_region(0U, 407U);
        } else if (g_requested_page == PLATFORM_UI_PAGE_HISTORY) {
            render_history_page(&g_requested_status, snapshot);
            present_status = present_frame_region(0U, 407U);
        } else {
            render_errors_page(&g_requested_status, snapshot);
            present_status = present_frame_region(52U, 407U);
        }
    } else if (g_requested_page == PLATFORM_UI_PAGE_EVENTS) {
        draw_events_region(&g_requested_status, snapshot);
        present_status = present_frame_region(EVENTS_Y0, EVENTS_Y1);
    } else if (g_requested_page == PLATFORM_UI_PAGE_HISTORY) {
        render_history_page(&g_requested_status, snapshot);
        present_status = present_frame_region(0U, 407U);
    }
    if (present_status != XST_SUCCESS) return;
    g_counter_render_pending = 0U;
    g_rendered_page = g_requested_page;
    g_render_pending = 0U;
    g_render_full = 0U;
}

void platform_ui_update_counters(const PlatformUiStatus *status)
{
    if (status == 0) return;
    if (g_requested_status.core_rejected_count == status->core_rejected_count &&
        g_requested_status.test_events == status->test_events &&
        g_requested_status.test_errors == status->test_errors &&
        g_requested_status.external_loss_count == status->external_loss_count &&
        g_requested_status.spi_frame_errors == status->spi_frame_errors &&
        g_requested_status.spi_boundary_errors == status->spi_boundary_errors &&
        g_requested_status.spi_duplicates == status->spi_duplicates &&
        g_requested_status.spi_sequence_errors == status->spi_sequence_errors &&
        g_requested_status.spi_short_transactions ==
            status->spi_short_transactions &&
        g_requested_status.spi_extra_bytes == status->spi_extra_bytes &&
        g_requested_status.spi_response_mismatches ==
            status->spi_response_mismatches &&
        g_requested_status.uart_event_count == status->uart_event_count &&
        g_requested_status.uart_data_count == status->uart_data_count &&
        g_requested_status.uart_stop_errors == status->uart_stop_errors &&
        g_requested_status.uart_break_errors == status->uart_break_errors &&
        g_requested_status.uart_short_transactions ==
            status->uart_short_transactions &&
        g_requested_status.i2c_event_count == status->i2c_event_count &&
        g_requested_status.i2c_data_count == status->i2c_data_count &&
        g_requested_status.i2c_address_nacks == status->i2c_address_nacks &&
        g_requested_status.i2c_busy_nacks == status->i2c_busy_nacks &&
        g_requested_status.i2c_sda_stuck == status->i2c_sda_stuck &&
        g_requested_status.i2c_scl_stuck == status->i2c_scl_stuck &&
        g_requested_status.i2c_missing_stop == status->i2c_missing_stop &&
        g_requested_status.can_event_count == status->can_event_count &&
        g_requested_status.can_frame_count == status->can_frame_count &&
        g_requested_status.can_ack_errors == status->can_ack_errors &&
        g_requested_status.can_bit_errors == status->can_bit_errors &&
        g_requested_status.can_stuff_errors == status->can_stuff_errors &&
        g_requested_status.can_crc_errors == status->can_crc_errors &&
        g_requested_status.can_form_errors == status->can_form_errors &&
        g_requested_status.can_bus_off == status->can_bus_off &&
        error_model_equal(&g_requested_status.error_model,
                          &status->error_model))
        return;
    g_requested_status.core_rejected_count = status->core_rejected_count;
    g_requested_status.test_events = status->test_events;
    g_requested_status.test_errors = status->test_errors;
    g_requested_status.external_loss_count = status->external_loss_count;
    g_requested_status.spi_frame_errors = status->spi_frame_errors;
    g_requested_status.spi_boundary_errors = status->spi_boundary_errors;
    g_requested_status.spi_duplicates = status->spi_duplicates;
    g_requested_status.spi_sequence_errors = status->spi_sequence_errors;
    g_requested_status.spi_short_transactions = status->spi_short_transactions;
    g_requested_status.spi_extra_bytes = status->spi_extra_bytes;
    g_requested_status.spi_response_mismatches =
        status->spi_response_mismatches;
    g_requested_status.uart_event_count = status->uart_event_count;
    g_requested_status.uart_data_count = status->uart_data_count;
    g_requested_status.uart_stop_errors = status->uart_stop_errors;
    g_requested_status.uart_break_errors = status->uart_break_errors;
    g_requested_status.uart_short_transactions =
        status->uart_short_transactions;
    g_requested_status.i2c_event_count = status->i2c_event_count;
    g_requested_status.i2c_data_count = status->i2c_data_count;
    g_requested_status.i2c_address_nacks = status->i2c_address_nacks;
    g_requested_status.i2c_busy_nacks = status->i2c_busy_nacks;
    g_requested_status.i2c_sda_stuck = status->i2c_sda_stuck;
    g_requested_status.i2c_scl_stuck = status->i2c_scl_stuck;
    g_requested_status.i2c_missing_stop = status->i2c_missing_stop;
    g_requested_status.can_event_count = status->can_event_count;
    g_requested_status.can_frame_count = status->can_frame_count;
    g_requested_status.can_ack_errors = status->can_ack_errors;
    g_requested_status.can_bit_errors = status->can_bit_errors;
    g_requested_status.can_stuff_errors = status->can_stuff_errors;
    g_requested_status.can_crc_errors = status->can_crc_errors;
    g_requested_status.can_form_errors = status->can_form_errors;
    g_requested_status.can_bus_off = status->can_bus_off;
    g_requested_status.error_model = status->error_model;
    g_counter_render_pending = 1U;
    g_render_pending = 1U;
}

void platform_ui_render_page(PlatformUiPage page,
                             const PlatformUiStatus *status,
                             const CaptureDemoSnapshot *snapshot)
{
    if (status == 0) return;
    if (status->selected_protocol != g_requested_status.selected_protocol)
        g_scroll_px = 0U;
    if (page == PLATFORM_UI_PAGE_EVENTS && snapshot != 0 &&
        g_scroll_snapshot_id != snapshot->snapshot_id) {
        g_scroll_snapshot_id = snapshot->snapshot_id;
        g_scroll_px = 0U;
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
    static u8 tracking_history_list;
    static u16 last_y;
    static u16 last_x,press_x,press_y;
    static u32 pressed_history_row,pressed_history_id;
    static PlatformUiPage touch_page;
    u16 x;
    u16 y;
    u32 next_scroll;
    u32 maximum;
    UiProtocol selected;

    gt911_scan(&TouchInfo);
    if (TouchInfo.Touch_Num == 0U) {
        if (tracking == 0U) return PLATFORM_UI_ACTION_NONE;
        tracking = 0U;
        if(tracking_history_list && !drag_moved &&
           g_requested_page==touch_page && !g_history_detail &&
           last_x>=14U && last_x<=786U &&
           last_y>=HISTORY_LIST_Y0 && last_y<=HISTORY_LIST_Y1) {
            u32 row=(g_history_list_scroll+last_y-HISTORY_LIST_Y0)/HISTORY_ROW_PX;
            const TestHistoryEntry *record=test_history_get(g_history,row);
            if(row==pressed_history_row && record!=0 && record->id==pressed_history_id) {
                g_history_selected=row;g_history_detail=1U;g_history_scroll=0U;
                g_history_errors=0U;g_render_full=1U;g_render_pending=1U;
            }
        }
        tracking_history_list=0U;
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
        if(g_requested_page!=touch_page) {
            tracking_history_list=0U;dragging_events=0U;
            last_x=x;last_y=y;
            return PLATFORM_UI_ACTION_NONE;
        }
        if(tracking_history_list) {
            u8 was_dragging=drag_moved;
            u32 dx=x>press_x?x-press_x:press_x-x;
            u32 dy=y>press_y?y-press_y:press_y-y;
            if(dx>=HISTORY_DRAG_PX || dy>=HISTORY_DRAG_PX) drag_moved=1U;
            if(drag_moved) {
                next_scroll=pixel_scroll_drag(g_history_list_scroll,
                    was_dragging?(int)last_y:(int)press_y,(int)y,history_list_max_scroll());
                if(next_scroll!=g_history_list_scroll) {
                    g_history_list_scroll=next_scroll;g_render_pending=1U;
                }
            }
        } else if (dragging_events != 0U) {
            u32 current_scroll = g_scroll_px;
            if (g_requested_page == PLATFORM_UI_PAGE_HISTORY) {
                const TestHistoryEntry *record = test_history_get(g_history,g_history_selected);
                maximum = max_scroll_px(record != 0 ? record->count : 0U);
                current_scroll = g_history_scroll;
            } else maximum = max_scroll_px(selected_event_count(
                &g_requested_status, &g_requested_snapshot));
            next_scroll = pixel_scroll_drag(current_scroll, (int)last_y,
                                            (int)y, maximum);
            if (next_scroll != current_scroll) {
                if (g_requested_page == PLATFORM_UI_PAGE_HISTORY) g_history_scroll = next_scroll;
                else g_scroll_px = next_scroll;
                drag_moved = 1U;
                g_render_pending = 1U;
            }
        }
        last_y = y;last_x=x;
        return PLATFORM_UI_ACTION_NONE;
    }

    tracking = 1U;
    last_y = press_y = y;
    last_x = press_x = x;
    touch_page=g_requested_page;
    tracking_history_list=0U;
    drag_moved = 0U;
    if (g_requested_page == PLATFORM_UI_PAGE_HISTORY) {
        if (g_history_detail && y >= 50U && y <= 84U && x >= 580U && x <= 786U) {
            g_history_errors^=1U; g_render_full=1U; g_render_pending=1U;
            return PLATFORM_UI_ACTION_NONE;
        }
        if (y >= 50U && y <= 84U && x >= 14U && x <= 230U) {
            if (!g_history_detail) return PLATFORM_UI_ACTION_EVENTS;
            g_history_detail=0U; g_render_full=1U; g_render_pending=1U;
            return PLATFORM_UI_ACTION_NONE;
        }
        if (!g_history_detail && x>=14U && x<=786U &&
            y>=HISTORY_LIST_Y0 && y<=HISTORY_LIST_Y1 && g_history!=0) {
            u32 row=(g_history_list_scroll+y-HISTORY_LIST_Y0)/HISTORY_ROW_PX;
            if (row < g_history->count) {
                const TestHistoryEntry *record=test_history_get(g_history,row);
                pressed_history_row=row;pressed_history_id=record->id;
                tracking_history_list=1U;
            }
            return PLATFORM_UI_ACTION_NONE;
        }
        if (g_history_detail && !g_history_errors && y >= EVENTS_Y0 && y <= EVENTS_Y1) {
            dragging_events=1U;
            return PLATFORM_UI_ACTION_NONE;
        }
    }
    dragging_events = (g_requested_page == PLATFORM_UI_PAGE_EVENTS &&
                       y >= EVENTS_Y0 && y <= EVENTS_Y1 &&
                       g_requested_snapshot_valid != 0U &&
                       g_event_cache != 0 && g_event_cache->valid != 0U &&
                       g_event_cache->snapshot_id ==
                           g_requested_snapshot.snapshot_id &&
                       selected_event_count(&g_requested_status,
                                            &g_requested_snapshot) != 0U) ? 1U : 0U;
    if (dragging_events != 0U) return PLATFORM_UI_ACTION_NONE;

    if (g_requested_page == PLATFORM_UI_PAGE_HOME &&
        ui_protocol_from_touch(x, y, &selected))
        return (PlatformUiAction)(PLATFORM_UI_ACTION_SELECT_SPI + selected);
    if (g_requested_page == PLATFORM_UI_PAGE_EVENTS && y >= 50U && y <= 84U) {
        if (x >= 580U && x <= 786U) return PLATFORM_UI_ACTION_HISTORY;
        if (x >= 244U && x <= 480U && g_requested_status.test_running)
            return PLATFORM_UI_ACTION_END_TEST;
        if (x >= 14U && x <= 230U && !g_requested_status.test_running &&
            ui_protocol_live(g_requested_status.selected_protocol,g_requested_status.capabilities))
            return PLATFORM_UI_ACTION_CAPTURE_LIVE;
    }
    if (g_requested_page == PLATFORM_UI_PAGE_HOME &&
        ui_protocol_live(g_requested_status.selected_protocol,
                         g_requested_status.capabilities) &&
        g_requested_status.test_running == 0U &&
        g_requested_status.capture_source != 1U &&
        (y >= 58U && y <= 94U && x >= 574U && x <= 776U))
        return PLATFORM_UI_ACTION_CAPTURE_HOME;
    if (y < 414U || y > 479U) return PLATFORM_UI_ACTION_NONE;
    if (x >= 12U && x <= 160U) return PLATFORM_UI_ACTION_HOME;
    if (x >= 168U && x <= 316U) return PLATFORM_UI_ACTION_EVENTS;
    if (x >= 324U && x <= 472U) return PLATFORM_UI_ACTION_ERRORS;
    if (x >= 480U && x <= 628U) return PLATFORM_UI_ACTION_HISTORY;
    if (x >= 636U && x <= 787U) return PLATFORM_UI_ACTION_SELF_TEST;
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

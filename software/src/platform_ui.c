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

#include "ui_a_font.h"
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

#define C_BG         0x0D1318U
#define C_PANEL      0x151E25U
#define C_BORDER     0x28363EU
#define C_TEXT       0xE5EEF3U
#define C_MUTED      0x91A3AFU
#define C_CYAN       0x19DFB5U
#define C_GREEN      0x57D79AU
#define C_RED        0xFF6C74U
#define C_WARN       0xEDB74EU
#define C_BUTTON     0x151E25U
#define C_ACTIVE     0x153C36U
#define C_GRID       0x25323AU
#define C_TRIGGER    0xEDB74EU
#define C_HEADER     0x10191EU
#define C_BLUE       0x44BCF3U
#define EVENTS_Y0    212U
#define EVENTS_Y1    447U
#define EVENT_ROW_PX 38U
#define HISTORY_LIST_Y0 156U
#define HISTORY_LIST_Y1 419U
#define HISTORY_ROW_PX 48U
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

static u32 blend(u32 fg,u32 bg,u8 alpha)
{
    u32 r=(((fg>>16)&255U)*alpha+((bg>>16)&255U)*(255U-alpha))/255U;
    u32 g=(((fg>>8)&255U)*alpha+((bg>>8)&255U)*(255U-alpha))/255U;
    u32 b=((fg&255U)*alpha+(bg&255U)*(255U-alpha))/255U;
    return (r<<16)|(g<<8)|b;
}
static u16 unicode_glyph(u16 x,u16 y,u32 cp,u32 fg,u32 bg)
{
    u32 lo=0U,hi=UI_FONT_COUNT,i,j;u16 w=cp<128U?8U:16U;
    while(lo<hi){u32 m=(lo+hi)/2U;if(ui_font_code[m]<cp)lo=m+1U;else hi=m;}
    if(lo>=UI_FONT_COUNT||ui_font_code[lo]!=cp){cp='?';lo='?'-32U;w=8U;}
    for(j=0U;j<18U;++j)for(i=0U;i<w;++i){u8 v=ui_font_bits[lo][j*8U+i/2U];
        u8 alpha=(u8)(((i&1U)?v&15U:v>>4)*17U);px(x+(u16)i,y+(u16)j,blend(fg,bg,alpha));}
    return w;
}
static void glyph(u16 x,u16 y,char ch,u32 fg,u32 bg)
{(void)unicode_glyph(x,y,(u8)ch,fg,bg);}
static void text(u16 x,u16 y,const char *value,u32 fg,u32 bg)
{
    const u8 *v=(const u8*)value;
    while(*v){u32 cp=*v++;
        if(cp>=0xE0U&&cp<0xF0U&&v[0]&&v[1]){cp=((cp&15U)<<12)|((v[0]&63U)<<6)|(v[1]&63U);v+=2;}
        else if(cp>=0xC0U&&cp<0xE0U&&v[0]){cp=((cp&31U)<<6)|(v[0]&63U);++v;}
        if(x+(cp<128U?8U:16U)>FB_W)break;
        x=(u16)(x+unicode_glyph(x,y,cp,fg,bg));
    }
}
static void large_dec(u16 x,u16 y,u32 value,u32 fg,u32 bg)
{
    char digits[11];u32 n=0U,i,j,k;
    do{digits[n++]=(char)(value%10U);value/=10U;}while(value&&n<10U);
    for(k=0U;k<n;++k)for(j=0U;j<28U;++j)for(i=0U;i<14U;++i)
        px((u16)(x+k*14U+i),(u16)(y+j),blend(fg,bg,ui_large_digit[(u8)digits[n-1U-k]][j*14U+i]));
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

#include "ui_a_views.inc"

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
        if(g_requested_page==PLATFORM_UI_PAGE_HOME){
            draw_header("",&g_requested_status,snapshot);
            draw_home_status(&g_requested_status);
            present_status=present_frame_region(0U,171U);
        } else {
            if(g_requested_page==PLATFORM_UI_PAGE_SELF_TEST) render_self_test_page(&g_requested_status,snapshot);
            else if(g_requested_page==PLATFORM_UI_PAGE_EVENTS) render_events_page(&g_requested_status,snapshot);
            else if(g_requested_page==PLATFORM_UI_PAGE_HISTORY) render_history_page(&g_requested_status,snapshot);
            else render_errors_page(&g_requested_status,snapshot);
            draw_navigation(g_requested_page);
            present_status=present_frame_region(0U,479U);
        }
    } else if (g_requested_page == PLATFORM_UI_PAGE_EVENTS) {
        draw_events_region(&g_requested_status, snapshot);
        present_status = present_frame_region(EVENTS_Y0, EVENTS_Y1);
    } else if (g_requested_page == PLATFORM_UI_PAGE_HISTORY) {
        render_history_page(&g_requested_status, snapshot);
        present_status = present_frame_region(0U, 479U);
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
           last_x>=108U && last_x<=786U &&
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
    /* Navigation is checked before list drags; the sidebar never scrolls data. */
    if(x>=7U&&x<=85U&&y>=58U&&y<58U+5U*66U){
        static const PlatformUiAction nav[5]={PLATFORM_UI_ACTION_HOME,PLATFORM_UI_ACTION_EVENTS,
            PLATFORM_UI_ACTION_ERRORS,PLATFORM_UI_ACTION_HISTORY,PLATFORM_UI_ACTION_SELF_TEST};
        u32 row=(y-58U)/66U;
        if((y-58U)%66U<=56U)return nav[row];
        return PLATFORM_UI_ACTION_NONE;
    }
    if(g_requested_page!=PLATFORM_UI_PAGE_HISTORY&&!g_requested_status.test_running&&
       ui_protocol_from_touch(x,y,&selected))
        return (PlatformUiAction)(PLATFORM_UI_ACTION_SELECT_SPI+selected);
    if (g_requested_page == PLATFORM_UI_PAGE_HISTORY) {
        if (g_history_detail && y >= 54U && y <= 94U && x >= 626U && x <= 786U) {
            g_history_errors^=1U; g_render_full=1U; g_render_pending=1U;
            return PLATFORM_UI_ACTION_NONE;
        }
        if (y >= 54U && y <= 94U && x >= 108U && x <= 274U) {
            if (!g_history_detail) return PLATFORM_UI_ACTION_EVENTS;
            g_history_detail=0U; g_render_full=1U; g_render_pending=1U;
            return PLATFORM_UI_ACTION_NONE;
        }
        if (!g_history_detail && x>=108U && x<=786U &&
            y>=HISTORY_LIST_Y0 && y<=HISTORY_LIST_Y1 && g_history!=0) {
            u32 row=(g_history_list_scroll+y-HISTORY_LIST_Y0)/HISTORY_ROW_PX;
            if (row < g_history->count) {
                const TestHistoryEntry *record=test_history_get(g_history,row);
                pressed_history_row=row;pressed_history_id=record->id;
                tracking_history_list=1U;
            }
            return PLATFORM_UI_ACTION_NONE;
        }
        if (g_history_detail && !g_history_errors && x >= 108U && y >= EVENTS_Y0 && y <= EVENTS_Y1) {
            dragging_events=1U;
            return PLATFORM_UI_ACTION_NONE;
        }
    }
    dragging_events = (g_requested_page == PLATFORM_UI_PAGE_EVENTS && x >= 108U &&
                       y >= EVENTS_Y0 && y <= EVENTS_Y1 &&
                       g_requested_snapshot_valid != 0U &&
                       g_event_cache != 0 && g_event_cache->valid != 0U &&
                       g_event_cache->snapshot_id ==
                           g_requested_snapshot.snapshot_id &&
                       selected_event_count(&g_requested_status,
                                            &g_requested_snapshot) != 0U) ? 1U : 0U;
    if (dragging_events != 0U) return PLATFORM_UI_ACTION_NONE;

    if(g_requested_page==PLATFORM_UI_PAGE_EVENTS&&y>=54U&&y<=94U&&x>=626U&&x<=786U){
        if(g_requested_status.test_running)return PLATFORM_UI_ACTION_END_TEST;
        if(ui_protocol_live(g_requested_status.selected_protocol,g_requested_status.capabilities))
            return PLATFORM_UI_ACTION_CAPTURE_LIVE;
    }
    if(g_requested_page==PLATFORM_UI_PAGE_HOME&&
       ui_protocol_live(g_requested_status.selected_protocol,g_requested_status.capabilities)&&
       !g_requested_status.test_running&&g_requested_status.capture_source!=1U&&
       y>=54U&&y<=94U&&x>=626U&&x<=786U)return PLATFORM_UI_ACTION_CAPTURE_HOME;

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

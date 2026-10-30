/* Exercises real renderer/hit-testing with finger down/move/up sequences. */
#include <assert.h>
#include <stdio.h>
#define PLATFORM_UI_HOST_PREVIEW 1
#include "../src/platform_ui.c"
TouchData TouchInfo;
void gt911_scan(TouchData *touch) { (void)touch; }
static TestHistory history;
static PlatformUiStatus status;
static const char *preview_dir;
static void preview(const char *name)
{
    char path[1024];FILE *file;
    if(!preview_dir) return;
    platform_ui_tick();snprintf(path,sizeof(path),"%s/%s.rgb",preview_dir,name);
    file=fopen(path,"wb");assert(file!=0);
    assert(fwrite((const void *)g_frame_addr[g_display_frame],1,FB_SIZE,file)==FB_SIZE);
    fclose(file);
}
static void finger(u16 x,u16 y)
{
    TouchInfo.Touch_Num=1U;TouchInfo.Tp_X[0]=x;TouchInfo.Tp_Y[0]=y;
    (void)platform_ui_poll_action();platform_ui_tick();
}
static void release(void)
{
    TouchInfo.Touch_Num=0U;(void)platform_ui_poll_action();platform_ui_tick();
}
static void tap_at(u16 x,u16 y) {finger(x,y);release();}
static void fill_history(u32 count)
{
    u32 i,j;
    memset(&history,0,sizeof(history));
    for(i=0U;i<count;++i) {
        TestHistoryEntry *r=test_history_append(&history);
        r->id=i+1U;r->protocol=UI_PROTOCOL_UART;r->snapshot_valid=1U;
        r->count=r->total_events=25U;
        for(j=0U;j<r->count;++j) {
            r->words[j][0]=0x01000001U;
            r->words[j][1]=0x10010000U|j;
            r->words[j][2]=j*100U;
        }
    }
    platform_ui_set_history(&history);
    platform_ui_render_page(PLATFORM_UI_PAGE_HISTORY,&status,0);
}
int main(int argc,char **argv)
{
    u32 saved_scroll;
    preview_dir=argc>1?argv[1]:0;
    status.selected_protocol=UI_PROTOCOL_UART;status.capabilities=0x1FFU;
    assert(platform_ui_init()==0);
    fill_history(8U);
    preview("history_gesture_top");
    finger(180U,215U);
    if(g_history_detail) {
        fputs("FAIL: finger-down opened history before tap/drag discrimination\n",stderr);
        return 1;
    }
    release();
    assert(g_history_detail && g_history_selected==1U);
    tap_at(180U,74U);assert(!g_history_detail);
    /* A swipe opens nothing, even when it ends at a scroll boundary. */
    finger(300U,350U);finger(300U,180U);
    assert(!g_history_detail && g_history_list_scroll==history_list_max_scroll());
    release();assert(!g_history_detail);
    preview("history_gesture_bottom");
    saved_scroll=g_history_list_scroll;
    finger(300U,250U);finger(345U,250U);release();
    assert(!g_history_detail && g_history_list_scroll==saved_scroll);
    /* Scrolled row hit-testing includes the viewport offset. */
    tap_at(180U,170U);
    assert(g_history_detail && g_history_selected==2U);
    finger(300U,350U);finger(300U,180U);release();
    assert(g_history_scroll==170U);
    preview("history_gesture_detail");
    tap_at(650U,65U);assert(g_history_errors);
    tap_at(650U,65U);assert(!g_history_errors);
    tap_at(180U,74U);
    assert(!g_history_detail && g_history_list_scroll==saved_scroll);
    /* Drag back to the first row; clamp at zero without opening it. */
    finger(300U,220U);finger(300U,390U);release();
    assert(!g_history_detail && g_history_list_scroll==0U);
    /* Small jitter is a tap; cumulative movement is a drag. */
    finger(180U,215U);finger(182U,217U);release();
    assert(g_history_detail && g_history_selected==1U);
    tap_at(180U,74U);
    finger(300U,350U);finger(300U,344U);
    assert(g_history_list_scroll==0U);
    finger(300U,338U);release();
    assert(!g_history_detail && g_history_list_scroll==12U);
    /* Leaving and returning to the original point still cancels the tap. */
    finger(300U,250U);finger(330U,250U);finger(300U,250U);release();
    assert(!g_history_detail);
    /* A page switch or changed history must not complete a stale row tap. */
    finger(180U,215U);
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&status,0);release();
    assert(!g_history_detail);
    platform_ui_render_page(PLATFORM_UI_PAGE_HISTORY,&status,0);
    finger(180U,215U);
    test_history_append(&history)->id=99U;
    release();assert(!g_history_detail);
    /* A fitting list must not scroll, but swipes still must not open rows. */
    fill_history(2U);
    finger(180U,215U);finger(180U,265U);release();
    assert(!g_history_detail && g_history_list_scroll==0U);
    tap_at(180U,215U);assert(g_history_detail && g_history_selected==1U);
    tap_at(180U,74U);fill_history(0U);
    finger(180U,215U);finger(180U,265U);release();
    assert(!g_history_detail);
    puts("PASS: history release-tap, drag, clamping, jitter, row offset, detail, back, stale touch and empty list");
    return 0;
}

/* Exercise actual renderer: idle taps, explicit capture and retained pixels. */
#include <assert.h>
#include <stdio.h>
#define PLATFORM_UI_HOST_PREVIEW 1
#include "../src/platform_ui.c"
TouchData TouchInfo;
void gt911_scan(TouchData *touch) { (void)touch; }
static u8 old_plot[232U*FB_STRIDE];
static CaptureDemoCache cache;
static PlatformUiAction tap(u16 x,u16 y)
{
    PlatformUiAction action;
    TouchInfo.Touch_Num=1U;TouchInfo.Tp_X[0]=x;TouchInfo.Tp_Y[0]=y;
    action=platform_ui_poll_action();
    TouchInfo.Touch_Num=0U;(void)platform_ui_poll_action();
    return action;
}
int main(void)
{
    PlatformUiStatus s;
    CaptureDemoSnapshot snap;
    unsigned int p,i;
    memset(&s,0,sizeof(s));memset(&snap,0,sizeof(snap));
    assert(platform_ui_init()==0);
    s.capabilities=0x1FFU;
    for(p=0U;p<UI_PROTOCOL_COUNT;++p) {
        memset(&cache,0,sizeof(cache));cache.valid=1U;cache.count=6U;
        cache.snapshot_id=snap.snapshot_id=p+1U;snap.count=6U;
        s.selected_protocol=(UiProtocol)p;s.capture_source=2U;
        for(i=0U;i<6U;++i) {
            u32 flags=i==5U?(p==UI_PROTOCOL_CAN?0x4321U:0U):
                      p==UI_PROTOCOL_SPI?(i==1U?0xFF9FU:i==2U?0xEF00U:i==3U?0x4000U:0x1800U):
                      p==UI_PROTOCOL_I2C?(i==1U?0x40A0U:i):i;
            cache.event_word[i][0]=7U|((i>0U && i<5U)?0x02000000U:0U);
            cache.event_word[i][1]=((u32)ui_protocol_event_id((UiProtocol)p)<<28)|
                ((i==0U?0U:i==5U?2U:1U)<<16)|flags;
        }
        platform_ui_set_event_cache(&cache);
        platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&s,&snap);platform_ui_tick();
        assert(home_trace_available(&s));
        memcpy(old_plot,(const u8*)g_frame_addr[g_display_frame]+176U*FB_STRIDE,sizeof(old_plot));
        assert(tap(400U,260U)==PLATFORM_UI_ACTION_NONE);
        assert(tap(15U,177U)==PLATFORM_UI_ACTION_NONE);
        assert(tap(780U,405U)==PLATFORM_UI_ACTION_NONE);
        assert(tap(670U,76U)==PLATFORM_UI_ACTION_CAPTURE_HOME);
        s.capture_source=1U;
        platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&s,0);platform_ui_tick();
        assert(home_trace_available(&s));
        assert(memcmp(old_plot,(const u8*)g_frame_addr[g_display_frame]+176U*FB_STRIDE,sizeof(old_plot))==0);
        assert(tap(670U,76U)==PLATFORM_UI_ACTION_NONE);
        s.test_running=1U;assert(!home_trace_available(&s));s.test_running=0U;
        platform_ui_set_event_cache(0);assert(!home_trace_available(&s));
    }
    puts("PASS: four-protocol plot taps inert; capture button explicit; previous plot pixels retained while waiting");
    return 0;
}

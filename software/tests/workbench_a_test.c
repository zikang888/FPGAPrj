/* Exercise new sidebar boundaries, cross-page protocol selection and recording locks. */
#include <assert.h>
#include <stdio.h>
#define PLATFORM_UI_HOST_PREVIEW 1
#include "../src/platform_ui.c"
TouchData TouchInfo;
void gt911_scan(TouchData *t){(void)t;}
static PlatformUiAction tap(u16 x,u16 y)
{
    PlatformUiAction a;
    TouchInfo.Touch_Num=1U;TouchInfo.Tp_X[0]=x;TouchInfo.Tp_Y[0]=y;
    a=platform_ui_poll_action();TouchInfo.Touch_Num=0U;(void)platform_ui_poll_action();return a;
}
int main(void)
{
    PlatformUiStatus s;unsigned int p,i;
    const PlatformUiAction nav[]={PLATFORM_UI_ACTION_HOME,PLATFORM_UI_ACTION_EVENTS,
        PLATFORM_UI_ACTION_ERRORS,PLATFORM_UI_ACTION_HISTORY,PLATFORM_UI_ACTION_SELF_TEST};
    memset(&s,0,sizeof(s));s.capabilities=0x1FFU;s.capture_ok=1U;
    assert(platform_ui_init()==0);
    for(p=0U;p<5U;++p){
        platform_ui_render_page((PlatformUiPage)p,&s,0);
        for(i=0U;i<5U;++i)assert(tap(40U,(u16)(84U+i*66U))==nav[i]);
        assert(tap(40U,120U)==PLATFORM_UI_ACTION_NONE); /* gap */
        assert(tap(40U,445U)==PLATFORM_UI_ACTION_NONE); /* no old bottom nav */
        if(p!=PLATFORM_UI_PAGE_HISTORY)for(i=0U;i<4U;++i)
            assert(tap((u16)(120U+i*72U),74U)==PLATFORM_UI_ACTION_SELECT_SPI+i);
    }
    s.test_running=1U;s.test_id=1U;
    platform_ui_render_page(PLATFORM_UI_PAGE_EVENTS,&s,0);
    assert(tap(270U,74U)==PLATFORM_UI_ACTION_NONE);
    assert(tap(700U,74U)==PLATFORM_UI_ACTION_END_TEST);
    s.test_running=0U;s.capture_source=2U;
    platform_ui_render_page(PLATFORM_UI_PAGE_EVENTS,&s,0);
    assert(tap(700U,74U)==PLATFORM_UI_ACTION_CAPTURE_LIVE);
    s.capabilities=0U;
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&s,0);
    assert(tap(700U,74U)==PLATFORM_UI_ACTION_NONE);
    platform_ui_render_page(PLATFORM_UI_PAGE_EVENTS,&s,0);
    assert(tap(700U,74U)==PLATFORM_UI_ACTION_NONE);
    puts("PASS: A sidebar, dead areas, page protocol tabs, running lock, capture capability gates");
    return 0;
}

/* Executes the production renderer and touch hit-testing with host-only
 * frame stores. Generated RGB files are offline fixtures, not board evidence. */
#include <assert.h>
#include <stdio.h>
#define PLATFORM_UI_HOST_PREVIEW 1
#include "../src/platform_ui.c"
TouchData TouchInfo;
void gt911_scan(TouchData *touch) { (void)touch; }
static TestHistory history;
static CaptureDemoCache cache;
static CaptureDemoSnapshot snapshot;

static void put(u32 type,u32 flags,u32 transaction)
{
    u32 n=cache.count++;
    cache.event_word[n][0]=(type==1U?0x01000000U:0U)|transaction;
    cache.event_word[n][1]=0x10000000U|(type<<16)|flags;
    cache.event_word[n][2]=n*100U;
    cache.event_word[n][3]=0U;
}
static void save(const char *dir,const char *name)
{
    char path[1024]; FILE *file;
    platform_ui_tick();
    snprintf(path,sizeof(path),"%s/%s.rgb",dir,name);
    file=fopen(path,"wb"); assert(file!=0);
    assert(fwrite((const void *)g_frame_addr[g_display_frame],1,FB_SIZE,file)==FB_SIZE);
    fclose(file);
}
static PlatformUiAction tap(u16 x,u16 y)
{
    PlatformUiAction action;
    TouchInfo.Touch_Num=1U; TouchInfo.Tp_X[0]=x; TouchInfo.Tp_Y[0]=y;
    action=platform_ui_poll_action();
    TouchInfo.Touch_Num=0U; (void)platform_ui_poll_action();
    return action;
}
int main(int argc,char **argv)
{
    PlatformUiStatus s;TestHistoryEntry *r;u32 original[CAPTURE_MAX_EVENTS][4];
    assert(argc==2);memset(&s,0,sizeof(s));s.selected_protocol=UI_PROTOCOL_UART;
    s.capabilities=0x1ffU;s.capture_source=2U;s.test_id=7U;
    assert(platform_ui_init()==0);
    put(0U,0U,9U);put(1U,0x55U,9U);put(2U,0U,9U);
    put(0U,0U,11U);put(0x3fU,0x155U,11U);put(0x3fU,0x200U,11U);put(2U,0U,11U);
    put(0U,0U,22U);put(0x3fU,0x1AAU,22U);put(2U,0U,22U);
    r=test_history_append(&history);r->id=7U;r->protocol=UI_PROTOCOL_UART;
    r->snapshot_valid=1U;r->count=cache.count;r->total_events=cache.count;r->error_count=3U;
    memcpy(r->words,cache.event_word,sizeof(r->words));
    assert(saved_error_transactions(r,g_saved_txn)==2U);
    assert(g_saved_txn[0].txn==11U&&g_saved_txn[0].errors==2U);
    assert(g_saved_txn[1].txn==22U&&g_saved_txn[1].errors==1U);
    cache.count=0U;put(0U,0U,99U);put(1U,0x42U,99U);put(2U,0U,99U);
    cache.valid=1U;cache.snapshot_id=1U;snapshot.snapshot_id=1U;snapshot.count=cache.count;
    memcpy(original,cache.event_word,sizeof(original));
    platform_ui_set_history(&history);platform_ui_set_event_cache(&cache);
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&s,&snapshot);save(argv[1],"replay-single");
    assert(!g_home_saved&&saved_record(&s)==0);
    assert(tap(490U,75U)==PLATFORM_UI_ACTION_NONE);save(argv[1],"replay-error-1");
    assert(g_home_saved&&g_saved_selected==0U&&g_saved_txn[0].txn==11U);
    assert(g_event_cache==&cache&&!memcmp(original,cache.event_word,sizeof(original)));
    assert(tap(700U,465U)==PLATFORM_UI_ACTION_NONE);save(argv[1],"replay-error-2");
    assert(g_saved_selected==1U);
    (void)tap(700U,465U);platform_ui_tick();assert(g_saved_selected==1U);
    (void)tap(170U,465U);platform_ui_tick();assert(g_saved_selected==0U);
    assert(tap(490U,75U)==PLATFORM_UI_ACTION_NONE);save(argv[1],"replay-return-single");
    assert(!g_home_saved&&g_event_cache==&cache&&!memcmp(original,cache.event_word,sizeof(original)));
    platform_ui_render_page(PLATFORM_UI_PAGE_HISTORY,&s,&snapshot);platform_ui_tick();
    (void)tap(180U,170U);platform_ui_tick();assert(g_history_detail);
    (void)tap(490U,75U);save(argv[1],"replay-history");assert(g_history_trace);
    (void)tap(700U,465U);platform_ui_tick();assert(g_saved_selected==1U);
    (void)tap(490U,75U);platform_ui_tick();assert(!g_history_trace&&g_history_detail);
    r->count=0U;g_home_saved=1U;g_saved_id=0U;
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&s,&snapshot);save(argv[1],"replay-missing");
    assert(saved_error_transactions(r,g_saved_txn)==0U);
    r->protocol=UI_PROTOCOL_I2C;r->count=1U;r->words[0][0]=1U;
    r->words[0][1]=(3U<<28)|(0x3fU<<16)|0x200U;
    assert(saved_error_transactions(r,g_saved_txn)==0U);
    puts("PASS saved replay: grouped faults, next/previous, immutable live capture, history and missing evidence");
    return 0;
}

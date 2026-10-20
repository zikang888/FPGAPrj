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
    PlatformUiStatus status;
    TestHistoryEntry *record;
    u32 i;
    assert(argc==2);
    memset(&status,0,sizeof(status));
    status.selected_protocol=UI_PROTOCOL_UART;
    status.capabilities=0x7FU; status.id_ok=status.version_ok=status.scratch_ok=1U;
    status.touch_ok=status.capture_ok=1U;
    status.test_id=1U; status.test_running=1U; status.capture_source=1U;
    status.test_events=23U; status.test_errors=5U;
    assert(platform_ui_init()==0);
    platform_ui_render_page(PLATFORM_UI_PAGE_EVENTS,&status,0);
    save(argv[1],"recording");
    assert(tap(60U,65U)==PLATFORM_UI_ACTION_CAPTURE_LIVE);
    assert(tap(300U,65U)==PLATFORM_UI_ACTION_END_TEST);
    assert(tap(650U,65U)==PLATFORM_UI_ACTION_HISTORY);
    cache.snapshot_id=1U;cache.trigger_index=0xFFFFFFFFU;cache.valid=1U;
    for(i=1U;i<=3U;++i) { put(0U,0U,i);put(0x3FU,0x0155U,i); }
    put(0U,0U,4U);put(0x3FU,0x0200U,4U);
    put(0U,0U,5U);for(i=0U;i<3U;++i)put(1U,i,5U);put(0x3FU,0x0403U,5U);
    put(0U,0U,6U);for(i=0U;i<8U;++i)put(1U,i,6U);put(2U,0U,6U);
    assert(cache.count==23U);
    snapshot.snapshot_id=1U;snapshot.count=cache.count;snapshot.trigger_index=0xFFFFFFFFU;
    status.test_running=0U;status.capture_source=2U;
    (void)error_model_report(&status.error_model,ERROR_UART_STOP_BIT,ERROR_ORIGIN_PL,3U);
    (void)error_model_report(&status.error_model,ERROR_UART_BREAK,ERROR_ORIGIN_PL,1U);
    (void)error_model_report(&status.error_model,ERROR_UART_SHORT_TRANSACTION,ERROR_ORIGIN_PL,1U);
    platform_ui_set_event_cache(&cache);
    platform_ui_render_page(PLATFORM_UI_PAGE_EVENTS,&status,&snapshot);
    save(argv[1],"events_faults");
    record=test_history_append(&history);
    record->id=1U;record->protocol=UI_PROTOCOL_UART;record->error_count=5U;
    record->count=record->total_events=23U;record->duration_ms=4200U;
    record->trigger_index=0xFFFFFFFFU;record->snapshot_valid=1U;
    memcpy(record->words,cache.event_word,sizeof(cache.event_word));
    record->errors=status.error_model;
    record->data_count=11U;
    cache.count=0U;cache.snapshot_id=2U;
    put(0U,0U,7U);for(i=0U;i<8U;++i)put(1U,i,7U);put(2U,0U,7U);
    snapshot.snapshot_id=2U;snapshot.count=10U;
    status.test_id=2U;status.test_events=10U;status.test_errors=0U;
    status.uart_event_count=10U;status.uart_data_count=8U;
    (void)error_model_report(&status.error_model,ERROR_UART_STOP_BIT,ERROR_ORIGIN_PL,0U);
    (void)error_model_report(&status.error_model,ERROR_UART_BREAK,ERROR_ORIGIN_PL,0U);
    (void)error_model_report(&status.error_model,ERROR_UART_SHORT_TRANSACTION,ERROR_ORIGIN_PL,0U);
    record=test_history_append(&history);
    record->id=2U;record->protocol=UI_PROTOCOL_UART;record->duration_ms=1000U;
    record->count=record->total_events=10U;record->snapshot_valid=1U;
    record->data_count=8U;
    memcpy(record->words,cache.event_word,sizeof(cache.event_word));
    platform_ui_set_event_cache(&cache);
    platform_ui_render_page(PLATFORM_UI_PAGE_ERRORS,&status,&snapshot);
    save(argv[1],"second_run_clean");
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&status,&snapshot);
    save(argv[1],"uart_frames");
    platform_ui_set_history(&history);
    platform_ui_render_page(PLATFORM_UI_PAGE_HISTORY,&status,&snapshot);
    save(argv[1],"history_list");
    (void)tap(180U,168U);
    assert(g_history_detail && g_history_selected==1U);
    platform_ui_tick();save(argv[1],"history_old_faults");
    (void)tap(650U,65U);assert(g_history_errors);
    platform_ui_tick();save(argv[1],"history_old_errors");
    (void)tap(650U,65U);assert(!g_history_errors);
    TouchInfo.Touch_Num=1U;TouchInfo.Tp_X[0]=300U;TouchInfo.Tp_Y[0]=350U;
    (void)platform_ui_poll_action();TouchInfo.Tp_Y[0]=180U;
    (void)platform_ui_poll_action();
    assert(g_history_scroll==170U);
    TouchInfo.Touch_Num=0U;(void)platform_ui_poll_action();
    platform_ui_tick();save(argv[1],"history_scroll");
    (void)tap(80U,65U);assert(!g_history_detail);
    puts("PASS: session UI rendering, buttons, history reopening and scrolling");
    return 0;
}

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
    /* A running test cannot be reset by an accidental second START tap. */
    assert(tap(60U,65U)==PLATFORM_UI_ACTION_NONE);
    assert(tap(300U,65U)==PLATFORM_UI_ACTION_END_TEST);
    assert(tap(650U,65U)==PLATFORM_UI_ACTION_HISTORY);
    status.test_running=0U; status.capture_source=0U;
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&status,0);
    assert(tap(400U,260U)==PLATFORM_UI_ACTION_NONE);
    assert(tap(670U,76U)==PLATFORM_UI_ACTION_CAPTURE_HOME);
    status.capture_source=1U;
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&status,0);
    assert(tap(400U,260U)==PLATFORM_UI_ACTION_NONE);
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
    assert(tap(80U,448U)==PLATFORM_UI_ACTION_HOME);
    assert(tap(240U,448U)==PLATFORM_UI_ACTION_EVENTS);
    assert(tap(400U,448U)==PLATFORM_UI_ACTION_ERRORS);
    assert(tap(550U,448U)==PLATFORM_UI_ACTION_HISTORY);
    assert(tap(700U,448U)==PLATFORM_UI_ACTION_SELF_TEST);
    status.capabilities=0x1FFU;
    status.selected_protocol=UI_PROTOCOL_I2C;
    status.test_id=3U;status.test_events=25U;
    error_model_init(&status.error_model);
    status.i2c_busy_nacks=16U;
    (void)error_model_report(&status.error_model,ERROR_I2C_ADDRESS_NACK,ERROR_ORIGIN_PL,0U);
    (void)error_model_report(&status.error_model,ERROR_I2C_SDA_STUCK,ERROR_ORIGIN_PL,0U);
    (void)error_model_report(&status.error_model,ERROR_I2C_SCL_STUCK,ERROR_ORIGIN_PL,0U);
    (void)error_model_report(&status.error_model,ERROR_I2C_MISSING_STOP,ERROR_ORIGIN_PL,0U);
    (void)error_model_report(&status.error_model,ERROR_I2C_BUSY_NACK,ERROR_ORIGIN_PL,16U);
    platform_ui_render_page(PLATFORM_UI_PAGE_ERRORS,&status,&snapshot);
    save(argv[1],"i2c_busy_info");
    status.test_id=0U;status.test_events=0U;
    error_model_init(&status.error_model);
    platform_ui_render_page(PLATFORM_UI_PAGE_ERRORS,&status,0);
    save(argv[1],"i2c_not_tested");
    status.capture_source=1U;
    platform_ui_set_event_cache(0);
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&status,0);
    save(argv[1],"i2c_waiting");
    assert(tap(670U,76U)==PLATFORM_UI_ACTION_NONE);
    status.capture_source=2U;
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&status,0);
    assert(tap(670U,76U)==PLATFORM_UI_ACTION_CAPTURE_HOME);
    status.selected_protocol=UI_PROTOCOL_CAN;
    status.capture_source=1U;
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&status,0);
    save(argv[1],"can_waiting");
    status.test_id=4U;status.test_events=12U;status.can_ack_errors=1U;
    (void)error_model_report(&status.error_model,ERROR_CAN_ACK,ERROR_ORIGIN_PL,1U);
    platform_ui_render_page(PLATFORM_UI_PAGE_ERRORS,&status,&snapshot);
    save(argv[1],"can_errors");
    record=test_history_append(&history);
    record->id=3U;record->protocol=UI_PROTOCOL_I2C;record->snapshot_valid=1U;
    (void)error_model_report(&record->errors,ERROR_I2C_BUSY_NACK,ERROR_ORIGIN_PL,16U);
    record=test_history_append(&history);
    record->id=4U;record->protocol=UI_PROTOCOL_CAN;record->snapshot_valid=1U;
    record->error_count=1U;record->total_events=12U;
    (void)error_model_report(&record->errors,ERROR_CAN_ACK,ERROR_ORIGIN_PL,1U);
    platform_ui_set_history(&history);
    platform_ui_render_page(PLATFORM_UI_PAGE_HISTORY,&status,0);
    (void)tap(180U,136U);(void)tap(650U,65U);
    assert(g_history_errors && g_history_selected==0U);
    platform_ui_tick();save(argv[1],"history_can_errors");
    (void)tap(80U,65U);(void)tap(180U,168U);(void)tap(650U,65U);
    assert(g_history_errors && g_history_selected==1U);
    platform_ui_tick();save(argv[1],"history_i2c_info");
    status.capture_source=2U;status.test_id=0U;status.test_events=0U;
    status.test_errors=0U;status.can_ack_errors=0U;
    error_model_init(&status.error_model);
    memset(&cache,0,sizeof(cache));
    cache.valid=1U;cache.snapshot_id=10U;cache.count=6U;
    snapshot.snapshot_id=10U;snapshot.count=6U;
    for(i=0U;i<6U;++i) {
        cache.event_word[i][0]=(i>0U && i<5U?0x01000000U:0U)|7U;
        cache.event_word[i][1]=(3U<<28)|((i==0U?0U:i==5U?2U:1U)<<16)|
                                 (i==1U?0x40A0U:i==2U?1U:i==3U?0U:i==4U?0xB9U:0U);
        cache.event_word[i][2]=i*100U;
    }
    status.selected_protocol=UI_PROTOCOL_I2C;
    platform_ui_set_event_cache(&cache);
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&status,&snapshot);
    save(argv[1],"i2c_data");
    for(i=0U;i<6U;++i)
        cache.event_word[i][1]=(4U<<28)|((i==0U?0U:i==5U?2U:1U)<<16)|
                                  (i==5U?0x4321U:i==0U?0U:((i-1U)<<8)|(i-1U));
    status.selected_protocol=UI_PROTOCOL_CAN;
    platform_ui_set_event_cache(&cache);
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&status,&snapshot);
    save(argv[1],"can_data");
    for(i=0U;i<6U;++i) {
        cache.event_word[i][0]=(i>0U && i<5U?0x02000000U:0U)|7U;
        cache.event_word[i][1]=(2U<<28)|((i==0U?0U:i==5U?2U:1U)<<16)|
                                 (i==1U?0xFF9FU:i==2U?0xEF00U:i==3U?0x4000U:i==4U?0x1800U:0U);
    }
    status.selected_protocol=UI_PROTOCOL_SPI;
    platform_ui_set_event_cache(&cache);
    platform_ui_render_page(PLATFORM_UI_PAGE_HOME,&status,&snapshot);
    save(argv[1],"spi_data");
    platform_ui_render_page(PLATFORM_UI_PAGE_SELF_TEST,&status,&snapshot);
    save(argv[1],"status");
    puts("PASS: session UI rendering, buttons, history reopening and scrolling");
    return 0;
}

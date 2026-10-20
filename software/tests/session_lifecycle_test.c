#include <assert.h>
#define SESSION_HOST_TEST 1
#define main firmware_main
#include "../src/main.c"
#undef main
u32 mock_regs[2048];
XTime mock_time;
static u32 mock_count;
static u32 mock_snapshot_id;
static int mock_copy_failure;
static const TestHistory *observed_history;
void platform_ui_set_event_cache(const CaptureDemoCache *cache) { (void)cache; }
void platform_ui_set_history(const TestHistory *history) { observed_history=history; }
int capture_session_arm(u8 protocol)
{
    assert(protocol==1U || protocol==2U);
    mock_count=0U;
    mock_regs[0x101CU/4U]=0U;
    mock_regs[0x1004U/4U]=0x11U;
    return 0;
}
int capture_session_freeze(CaptureDemoSnapshot *snapshot)
{
    snapshot->count=mock_count;
    snapshot->snapshot_id=++mock_snapshot_id;
    snapshot->trigger_index=0xFFFFFFFFU;
    mock_regs[0x1004U/4U] &= ~1U;
    mock_regs[0x1004U/4U] |= 2U;
    return 0;
}
int capture_demo_cache_snapshot(CaptureDemoCache *cache,const CaptureDemoSnapshot *snapshot)
{
    if(mock_copy_failure) { cache->valid=0U;return XST_FAILURE; }
    cache->count=snapshot->count; cache->snapshot_id=snapshot->snapshot_id;
    cache->trigger_index=0xFFFFFFFFU; cache->valid=1U;
    cache->event_word[0][0]=snapshot->snapshot_id;
    return 0;
}
int main(void)
{
    PlatformUiStatus s;
    CaptureDemoSnapshot snap;
    memset(&s,0,sizeof(s)); memset(&snap,0,sizeof(snap));
    s.selected_protocol=UI_PROTOCOL_UART; s.capabilities=0x7FU;
    mock_regs[0x38U/4U]=7U;
    begin_test(&s,&snap);
    assert(s.test_id==1U && s.test_running && s.test_errors==0U);
    mock_regs[0x7CU/4U]=3U; mock_regs[0x80U/4U]=1U;
    mock_regs[0x101CU/4U]=8U; mock_count=8U; mock_time=100U;
    end_test(&s,&snap);
    assert(!s.test_running && s.test_errors==4U && s.external_loss_count==0U);
    assert(observed_history->count==1U && test_history_get(&g_history,0)->error_count==4U);
    begin_test(&s,&snap);
    assert(s.test_id==2U && s.test_errors==0U && s.uart_stop_errors==0U);
    assert(error_model_get(&s.error_model,ERROR_UART_STOP_BIT).count==0U);
    mock_regs[0x101CU/4U]=10U; mock_regs[0x74U/4U]=10U;
    mock_regs[0x78U/4U]=8U; mock_count=10U; mock_time=200U;
    end_test(&s,&snap);
    assert(s.test_errors==0U && g_history.count==2U);
    assert(test_history_get(&g_history,1)->error_count==4U);
    assert(test_history_get(&g_history,1)->words[0][0]==1U);
    assert(test_history_get(&g_history,0)->words[0][0]==2U);
    begin_test(&s,&snap); end_test(&s,&snap);
    assert(test_history_get(&g_history,0)->count==0U);
    assert(test_history_get(&g_history,0)->snapshot_valid);
    begin_test(&s,&snap);
    mock_regs[0x101CU/4U]=600U; mock_regs[0x1004U/4U]|=4U; mock_count=256U;
    end_test(&s,&snap);
    assert(test_history_get(&g_history,0)->total_events==600U);
    assert(test_history_get(&g_history,0)->count==256U && s.retained_tail);
    begin_test(&s,&snap);
    begin_test(&s,&snap); /* Restart saves the preceding run before clearing. */
    assert(g_history.count==5U && s.test_running && s.test_errors==0U);
    mock_copy_failure=1;
    end_test(&s,&snap);
    assert(s.test_failed && !test_history_get(&g_history,0)->snapshot_valid);
    mock_copy_failure=0;
    begin_test(&s,&snap);assert(!s.test_failed && s.test_running);
    return 0;
}

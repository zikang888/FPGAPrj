#include <assert.h>
#include <string.h>
#include "../src/capture_demo.c"
static u32 regs[0x7000U/4U];
static u32 last_arm;
static u32 change_id_after_read;
u32 test_read32(u32 address)
{
    if(address==REG_SNAPSHOT_ID && change_id_after_read) {
        if(--change_id_after_read==0U) ++regs[address/4U];
    }
    return regs[address/4U];
}
void test_write32(u32 address,u32 value)
{
    if(address==REG_CAPTURE_CTRL) {
        if(value&1U) {
            last_arm=value;
            regs[REG_CAPTURE_STATUS/4U]=1U|((value&16U)?16U:0U);
        } else if(value&8U) {
            regs[REG_CAPTURE_STATUS/4U]=0x12U;
            regs[REG_TRIGGER_INDEX/4U]=0xFFFFFFFFU;
        } else if(value&2U) regs[REG_CAPTURE_STATUS/4U]&=~2U;
    } else regs[address/4U]=value;
}
int main(void)
{
    CaptureDemoSnapshot snapshot;
    CaptureDemoCache cache;
    u32 i;
    memset(&snapshot,0,sizeof(snapshot));memset(&cache,0,sizeof(cache));
    assert(capture_session_arm(1U)==XST_FAILURE);
    regs[0xCU/4U]=0x7FU;
    assert(capture_session_arm(1U)==XST_SUCCESS && last_arm==0x00010011U);
    regs[REG_SNAPSHOT_ID/4U]=3U;regs[REG_SNAPSHOT_COUNT/4U]=17U;
    for(i=0U;i<17U*4U;++i) regs[SNAPSHOT_BASE/4U+i]=i;
    assert(capture_session_freeze(&snapshot)==XST_SUCCESS);
    assert(snapshot.trigger_index==0xFFFFFFFFU && snapshot.shown==8U && snapshot.first_index==0U);
    assert(capture_demo_cache_snapshot(&cache,&snapshot)==XST_SUCCESS);
    assert(cache.valid && cache.count==17U && cache.event_word[16][3]==67U);
    change_id_after_read=2U;
    assert(capture_demo_cache_snapshot(&cache,&snapshot)==XST_FAILURE && !cache.valid);
    assert(capture_session_arm(2U)==XST_SUCCESS && last_arm==0x00020011U);
    regs[REG_SNAPSHOT_COUNT/4U]=0U;
    assert(capture_session_freeze(&snapshot)==XST_SUCCESS && snapshot.count==0U);
    assert(capture_demo_cache_snapshot(&cache,&snapshot)==XST_SUCCESS && cache.valid && cache.count==0U);
    return 0;
}

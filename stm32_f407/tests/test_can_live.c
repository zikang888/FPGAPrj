#include "mc_can_live.h"
#include <stdio.h>
#include <string.h>
#define CHECK(x) do { if(!(x)) { fprintf(stderr,"failed %d: %s\n",__LINE__,#x); return 1; } } while(0)
int main(void)
{
    uint8_t tx[8]={0U};
    mc_can_config_t c;
    mc_can_live_timing_t t;
    unsigned int i;
    CHECK(mc_can_live_timing(tx,&t)==MC_ERR_VERIFY); /* no recessive DATA bit */
    for(i=1U;i<=10000U;++i) {
        mc_can_raw_wave_t w;
        tx[6]=(uint8_t)(i>>8); tx[7]=(uint8_t)i;
        CHECK(mc_can_live_timing(tx,&t)==MC_OK);
        CHECK(mc_can_raw_build(MC_CAN_RAW_VALID,0x321U,tx,8U,&w)==MC_OK);
        CHECK(w.bits[t.wire_bit]==1U && t.wire_bit>=19U && t.wire_bit<w.stuffed_end-15U);
        CHECK(t.start_ticks<t.sample_ticks && t.sample_ticks<t.end_ticks);
        CHECK(t.start_ticks/168U==t.wire_bit && t.end_ticks/168U==t.wire_bit);
    }
    CHECK(mc_can_live_parse("bit 10 100",&c)==MC_OK && c.every==1U && c.bitrate==500000U);
    CHECK(mc_can_live_parse("disturb 100 100 20",&c)==MC_OK && c.every==20U);
    CHECK(mc_can_live_parse("busoff 64 100",&c)==MC_OK && c.mode==MC_CAN_LIVE_BUSOFF);
    CHECK(mc_can_live_parse("busoff 31 100",&c)==MC_ERR_ARGUMENT);
    CHECK(mc_can_live_parse("busoff 64 100 2",&c)==MC_ERR_ARGUMENT);
    CHECK(mc_can_live_parse("busoff 129 100",&c)==MC_ERR_ARGUMENT);
    CHECK(mc_can_live_parse("busoff 64 1001",&c)==MC_ERR_ARGUMENT);
    CHECK(mc_can_live_parse("bit -1 100",&c)==MC_ERR_ARGUMENT);
    CHECK(mc_can_live_parse("bit 1 100 extra",&c)==MC_ERR_ARGUMENT);
    puts("LIVE DATA timing, boundaries and strict parsing PASS");
    return 0;
}

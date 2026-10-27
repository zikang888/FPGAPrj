#ifndef WAVEFORM_VIEW_H_
#define WAVEFORM_VIEW_H_
#include <stdint.h>
#include <string.h>
#include "event_view.h"

/* Presentation of observed bytes, including short/extra/partial transactions.
 * Residual SPI bits have a count only: never infer their voltage levels. */
typedef struct {
    uint8_t mosi[8], miso[8];
    uint32_t count, total, transaction_id;
    uint8_t partial_bits, closed;
} WaveSpi;

static inline uint16_t wave_x(uint32_t bit, uint32_t total)
{
    return (uint16_t)(144U + (total ? 608U * bit / total : 0U));
}

static inline int wave_spi_extract(const uint32_t *words, uint32_t count,
                                  WaveSpi *out)
{
    uint32_t i;
    int active=0;
    if(!words || !out || count>256U) return 0;
    memset(out,0,sizeof(*out));
    for(i=0;i<count;++i) {
        EventView e=event_view_decode(words+i*4U);
        uint8_t rx,tx;
        if(e.protocol!=2U) continue;
        if(!active) {
            if(e.event_type!=0U) continue;
            active=1; out->transaction_id=e.transaction_id; continue;
        }
        if(e.transaction_id!=out->transaction_id) continue;
        if(event_view_spi_bytes(&e,&rx,&tx)) {
            if(out->count<8U) {
                out->miso[out->count]=rx; out->mosi[out->count]=tx; ++out->count;
            }
            ++out->total;
        } else if(e.event_type==2U || e.event_type==0x3FU) {
            out->closed=(uint8_t)(e.event_type==2U);
            if(e.event_type==0x3FU) out->partial_bits=(uint8_t)(e.flags&7U);
            return 1;
        }
    }
    return active && out->count!=0U;
}
#endif

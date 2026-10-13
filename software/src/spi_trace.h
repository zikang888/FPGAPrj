#ifndef SPI_TRACE_H_
#define SPI_TRACE_H_

#include <stdint.h>
#include "event_view.h"

#define SPI_TRACE_BYTES 4U

typedef struct {
    uint8_t mosi[SPI_TRACE_BYTES];
    uint8_t miso[SPI_TRACE_BYTES];
    uint32_t transaction_id;
    uint8_t count;
} SpiTrace;

/* Reconstruct a byte/bit view from decoded SPI events. This is not a sampled
 * electrical waveform and carries no per-bit timing information. */
static inline int spi_trace_extract(const uint32_t *words, uint32_t count,
                                    SpiTrace *out)
{
    uint32_t i;
    uint32_t j;
    EventView start;
    EventView event;
    uint8_t miso;
    uint8_t mosi;
    if (words == 0 || out == 0 || count < SPI_TRACE_BYTES + 2U ||
        count > 256U) return 0;
    for (i = 0U; i + SPI_TRACE_BYTES + 1U < count; ++i) {
        start = event_view_decode(&words[i * 4U]);
        if (start.protocol != 2U || start.event_type != 0U) continue;
        for (j = 0U; j < SPI_TRACE_BYTES; ++j) {
            event = event_view_decode(&words[(i + 1U + j) * 4U]);
            if (event.transaction_id != start.transaction_id ||
                !event_view_spi_bytes(&event, &miso, &mosi)) break;
            out->miso[j] = miso;
            out->mosi[j] = mosi;
        }
        if (j != SPI_TRACE_BYTES) continue;
        event = event_view_decode(&words[(i + 1U + SPI_TRACE_BYTES) * 4U]);
        if (event.protocol != 2U || event.event_type != 2U ||
            event.transaction_id != start.transaction_id) continue;
        out->transaction_id = start.transaction_id;
        out->count = SPI_TRACE_BYTES;
        return 1;
    }
    return 0;
}

#endif

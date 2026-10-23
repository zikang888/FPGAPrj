#ifndef PROTOCOL_TRACE_H_
#define PROTOCOL_TRACE_H_

#include <stdint.h>
#include <string.h>
#include "event_view.h"

#define PROTOCOL_TRACE_BYTES 8U

typedef struct {
    uint8_t data[PROTOCOL_TRACE_BYTES];
    uint8_t nack[PROTOCOL_TRACE_BYTES];
    uint8_t count;
    uint32_t transaction_id;
} I2cTrace;

typedef struct {
    uint8_t data[PROTOCOL_TRACE_BYTES];
    uint8_t count;
    uint8_t dlc;
    uint16_t identifier;
    uint32_t transaction_id;
} CanTrace;

static inline int i2c_trace_extract(const uint32_t *words, uint32_t count,
                                    I2cTrace *out)
{
    uint32_t i;
    EventView event;
    uint8_t active = 0U;
    if (words == 0 || out == 0 || count == 0U || count > 256U) return 0;
    memset(out,0,sizeof(*out));
    for (i = 0U; i < count; ++i) {
        event = event_view_decode(&words[i * 4U]);
        if (!active) {
            if (event.protocol != 3U || event.event_type != 0U) continue;
            active = 1U;
            out->transaction_id = event.transaction_id;
            continue;
        }
        if (event.protocol != 3U ||
            event.transaction_id != out->transaction_id) continue;
        if (event.event_type == 1U && out->count < PROTOCOL_TRACE_BYTES) {
            out->data[out->count] = (uint8_t)event.flags;
            out->nack[out->count] = (uint8_t)(event.flags >> 15);
            ++out->count;
        } else if (event.event_type == 2U) {
            return out->count != 0U;
        }
    }
    return 0;
}

static inline int can_trace_extract(const uint32_t *words, uint32_t count,
                                    CanTrace *out)
{
    uint32_t i;
    EventView event;
    uint8_t active = 0U;
    if (words == 0 || out == 0 || count == 0U || count > 256U) return 0;
    memset(out,0,sizeof(*out));
    for (i = 0U; i < count; ++i) {
        event = event_view_decode(&words[i * 4U]);
        if (!active) {
            if (event.protocol != 4U || event.event_type != 0U) continue;
            active = 1U;
            out->transaction_id = event.transaction_id;
            continue;
        }
        if (event.protocol != 4U ||
            event.transaction_id != out->transaction_id) continue;
        if (event.event_type == 1U && out->count < PROTOCOL_TRACE_BYTES) {
            out->data[out->count++] = (uint8_t)event.flags;
        } else if (event.event_type == 2U) {
            out->dlc = (uint8_t)((event.flags >> 12) & 0x0FU);
            out->identifier = (uint16_t)(event.flags & 0x07FFU);
            return out->count == out->dlc && out->dlc <= PROTOCOL_TRACE_BYTES;
        }
    }
    return 0;
}

#endif

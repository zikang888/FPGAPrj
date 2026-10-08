#ifndef EVENT_AUDIT_H_
#define EVENT_AUDIT_H_

/* Snapshot-level ABI checks for PS display and host golden corpora.
 * UART/I2C/CAN-specific flags remain opaque until their producer contracts
 * are approved and implemented. */
#include "event_view.h"

#define EVENT_AUDIT_MAX_EVENTS 256U
#define EVENT_AUDIT_KNOWN_PROTOCOLS 5U

typedef struct {
    uint32_t total;
    uint32_t errors;
    uint32_t extensions;
    uint32_t unknown_protocols;
    uint32_t spi_invalid_data_length;
    uint32_t timestamp_regressions;
    uint32_t trigger_protocol;
    uint32_t protocol_events[EVENT_AUDIT_KNOWN_PROTOCOLS];
    uint32_t protocol_errors[EVENT_AUDIT_KNOWN_PROTOCOLS];
    uint32_t protocol_starts[EVENT_AUDIT_KNOWN_PROTOCOLS];
    uint32_t protocol_data[EVENT_AUDIT_KNOWN_PROTOCOLS];
    uint32_t protocol_ends[EVENT_AUDIT_KNOWN_PROTOCOLS];
} EventAudit;

/* Returns 1 for valid snapshot metadata, 0 otherwise. An ERROR event is
 * counted as observed evidence, not treated as malformed metadata. */
/* words is a contiguous count x 4 array in low-word-first order. */
static inline int event_audit_snapshot(const uint32_t *words,
                                       uint32_t count, uint32_t trigger_index,
                                       EventAudit *out)
{
    uint32_t i;
    uint32_t p;
    uint64_t previous_timestamp = 0U;
    if (words == 0 || out == 0 || count == 0U ||
        count > EVENT_AUDIT_MAX_EVENTS || trigger_index >= count) return 0;

    out->total = count;
    out->errors = 0U;
    out->extensions = 0U;
    out->unknown_protocols = 0U;
    out->spi_invalid_data_length = 0U;
    out->timestamp_regressions = 0U;
    out->trigger_protocol = 0U;
    for (p = 0U; p < EVENT_AUDIT_KNOWN_PROTOCOLS; ++p) {
        out->protocol_events[p] = 0U;
        out->protocol_errors[p] = 0U;
        out->protocol_starts[p] = 0U;
        out->protocol_data[p] = 0U;
        out->protocol_ends[p] = 0U;
    }
    for (i = 0U; i < count; ++i) {
        EventView view = event_view_decode(&words[i * 4U]);
        if (i == trigger_index) out->trigger_protocol = view.protocol;
        if (i != 0U && view.timestamp < previous_timestamp) {
            ++out->timestamp_regressions;
        }
        previous_timestamp = view.timestamp;
        if (view.protocol >= EVENT_AUDIT_KNOWN_PROTOCOLS) {
            ++out->unknown_protocols;
        } else {
            ++out->protocol_events[view.protocol];
            if (view.event_type == 0U) ++out->protocol_starts[view.protocol];
            if (view.event_type == 1U) ++out->protocol_data[view.protocol];
            if (view.event_type == 2U) ++out->protocol_ends[view.protocol];
            if (view.event_type == 0x3FU) ++out->protocol_errors[view.protocol];
        }
        if (view.event_type == 0x3FU) ++out->errors;
        else if (view.event_type > 2U) ++out->extensions;
        if (view.protocol == 2U && view.event_type == 1U &&
            view.payload_length != 2U) ++out->spi_invalid_data_length;
    }
    return 1;
}

#endif

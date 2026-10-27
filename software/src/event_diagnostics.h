#ifndef EVENT_DIAGNOSTICS_H_
#define EVENT_DIAGNOSTICS_H_
#include "event_view.h"
/* Labels interpret captured evidence; they do not insert synthetic PL events.
 * A truncated transaction without START cannot establish a JEDEC length fault. */
static inline int event_diagnostic_label(const uint32_t *words, uint32_t count,
                                         uint32_t index, char out[8])
{
    EventView view;
    const char *label = 0;
    uint32_t i, bytes = 0U;
    uint8_t cmd = 0U, mismatch = 0U, have_start = 0U;
    int fault;
    if (words == 0 || index >= count) return 0;
    view = event_view_decode(words + index * 4U);
    fault = event_view_is_error(&view);
    event_view_type_text(view.event_type, out);
    /* Preserve raw records as INFO without advertising retired detectors. */
    if (view.event_type == 0x3FU && !fault) {
        out[0]='I'; out[1]='N'; out[2]='F'; out[3]='O'; out[4]='\0';
    }
    if (view.protocol == 1U && fault) {
        if ((view.flags >> 8) == 1U) label = "BADSTOP";
        else if ((view.flags >> 8) == 2U) label = "BREAK";
        else if ((view.flags >> 8) == 4U) label = "SHORT";
    } else if (view.protocol == 3U && fault) {
        if ((view.flags >> 8) == 1U) label = "ADDRNCK";
        else if ((view.flags >> 8) == 2U) label = "BUSYNCK";
        else if ((view.flags >> 8) == 5U) label = "NO STOP";
    } else if (view.protocol == 4U && fault) {
        if ((view.flags >> 8) == 1U) label = "NO ACK";
        else if ((view.flags >> 8) == 3U) label = "STUFF";
        else if ((view.flags >> 8) == 4U) label = "CRC ERR";
        else if ((view.flags >> 8) == 6U) label = "BUS OFF";
    } else if (view.protocol == 2U && view.event_type == 2U) {
        uint32_t start = index;
        while (start > 0U) {
            EventView prev = event_view_decode(words + (--start) * 4U);
            if (prev.protocol != 2U || prev.transaction_id != view.transaction_id) continue;
            if (prev.event_type == 2U) break;
            if (prev.event_type == 0U) { have_start = 1U; break; }
        }
        if (have_start) for (i = start + 1U; i < index; ++i) {
            EventView data = event_view_decode(words + i * 4U);
            if (data.protocol != 2U || data.transaction_id != view.transaction_id ||
                data.event_type != 1U) continue;
            if (bytes == 0U) cmd = (uint8_t)data.flags;
            if ((bytes == 1U && (data.flags >> 8) != 0xEFU) ||
                (bytes == 2U && (data.flags >> 8) != 0x40U) ||
                (bytes == 3U && (data.flags >> 8) != 0x18U)) mismatch = 1U;
            ++bytes;
        }
        if (have_start && cmd == 0x9FU) {
            if (bytes < 4U) label = "SHORT";
            else if (bytes > 4U) label = "EXTRA";
            else if (mismatch) label = "BAD ID";
            if (label != 0) fault = 1;
        }
    }
    if (label != 0) {
        for (i = 0U; label[i] != '\0'; ++i) out[i] = label[i];
        out[i] = '\0';
    }
    return fault;
}
#endif

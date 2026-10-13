#include "../src/event_audit.h"

#include <assert.h>
#include <stdio.h>

static void make_event(uint32_t out[4], uint8_t protocol, uint8_t type,
                       uint8_t length, uint16_t flags, uint32_t transaction,
                       uint64_t timestamp)
{
    out[0] = ((uint32_t)length << 24) | (transaction & UINT32_C(0x00FFFFFF));
    out[1] = ((uint32_t)protocol << 28) | ((uint32_t)type << 16) | flags;
    out[2] = (uint32_t)timestamp;
    out[3] = (uint32_t)(timestamp >> 32);
}

static void check_uart_i2c_and_errors(void)
{
    uint32_t words[7][4];
    EventAudit audit;
    make_event(words[0], 1U, 0U, 0U, 0U, 7U, 10U);
    make_event(words[1], 1U, 1U, 1U, 0x0041U, 7U, 11U);
    make_event(words[2], 1U, 0x3FU, 0U, 0x0020U, 7U, 12U);
    make_event(words[3], 3U, 0U, 0U, 0U, 8U, 13U);
    make_event(words[4], 3U, 3U, 0U, 0x0012U, 8U, 14U);
    make_event(words[5], 3U, 1U, 1U, 0x005AU, 8U, 15U);
    make_event(words[6], 3U, 0x3FU, 0U, 0x0001U, 8U, 16U);
    assert(event_audit_snapshot(&words[0][0], 7U, 2U, &audit) == 1);
    assert(audit.total == 7U && audit.errors == 2U);
    assert(audit.extensions == 1U && audit.trigger_protocol == 1U);
    assert(audit.protocol_events[1] == 3U);
    assert(audit.protocol_starts[1] == 1U);
    assert(audit.protocol_data[1] == 1U);
    assert(audit.protocol_errors[1] == 1U);
    assert(audit.protocol_events[3] == 4U);
    assert(audit.protocol_starts[3] == 1U);
    assert(audit.protocol_data[3] == 1U);
    assert(audit.protocol_errors[3] == 1U);
    assert(audit.spi_invalid_data_length == 0U);
    assert(audit.timestamp_regressions == 0U);
}

static void check_only_defined_spi_shape_and_metadata(void)
{
    uint32_t words[3][4];
    EventAudit audit;
    make_event(words[0], 2U, 1U, 1U, 0xEF9FU, 3U, 100U);
    make_event(words[1], 15U, 0x3FU, 0U, 0U, 3U, 99U);
    make_event(words[2], 4U, 2U, 0U, 0U, 4U, 101U);
    assert(event_audit_snapshot(&words[0][0], 3U, 1U, &audit) == 1);
    assert(audit.trigger_protocol == 15U);
    assert(audit.unknown_protocols == 1U && audit.errors == 1U);
    assert(audit.spi_invalid_data_length == 1U);
    assert(audit.timestamp_regressions == 1U);
    assert(audit.protocol_ends[4] == 1U);
    assert(event_audit_snapshot(&words[0][0], 0U, 0U, &audit) == 0);
    assert(event_audit_snapshot(&words[0][0], 3U, 3U, &audit) == 0);
    assert(event_audit_snapshot(&words[0][0], 257U, 1U, &audit) == 0);
    assert(event_audit_snapshot(0, 3U, 1U, &audit) == 0);
    assert(event_audit_snapshot(&words[0][0], 3U, 1U, 0) == 0);
}

static void check_full_snapshot_capacity(void)
{
    uint32_t words[EVENT_AUDIT_MAX_EVENTS][4];
    EventAudit audit;
    uint32_t i;
    for (i = 0U; i < EVENT_AUDIT_MAX_EVENTS; ++i) {
        make_event(words[i], 3U, i == 255U ? 0x3FU : 1U,
                   i == 255U ? 0U : 1U, 0U, 9U, i);
    }
    assert(event_audit_snapshot(&words[0][0], EVENT_AUDIT_MAX_EVENTS,
                                255U, &audit) == 1);
    assert(audit.total == 256U && audit.protocol_events[3] == 256U);
    assert(audit.protocol_data[3] == 255U && audit.protocol_errors[3] == 1U);
    assert(audit.errors == 1U && audit.trigger_protocol == 3U);
    assert(audit.timestamp_regressions == 0U);
}

int main(void)
{
    check_uart_i2c_and_errors();
    check_only_defined_spi_shape_and_metadata();
    check_full_snapshot_capacity();
    puts("event audit tests passed");
    return 0;
}

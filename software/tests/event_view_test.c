#include "../src/event_view.h"

#include <assert.h>
#include <stdio.h>
#include <string.h>

static void check_common_fields(void)
{
    const uint32_t words[4] = {
        UINT32_C(0x02123456), UINT32_C(0x20C1EF00),
        UINT32_C(0x89ABCDEF), UINT32_C(0x01234567)
    };
    const EventView view = event_view_decode(words);
    uint8_t miso = 0U;
    uint8_t mosi = 0U;
    char type[8];

    assert(view.timestamp == UINT64_C(0x0123456789ABCDEF));
    assert(view.transaction_id == UINT32_C(0x123456));
    assert(view.payload_length == 2U);
    assert(view.protocol == 2U);
    assert(view.channel == 0U);
    assert(view.direction == 3U);
    assert(view.event_type == 1U);
    assert(view.flags == UINT16_C(0xEF00));
    assert(event_view_spi_bytes(&view, &miso, &mosi) == 1);
    assert(miso == 0xEFU && mosi == 0x00U);
    assert(event_view_is_error(&view) == 0);
    event_view_type_text(view.event_type, type);
    assert(strcmp(type, "DATA") == 0);
}

static void check_protocols_and_types(void)
{
    static const char *const names[5] = {"VIRT", "UART", "SPI", "I2C", "CAN"};
    uint32_t words[4] = {0U, 0U, 0U, 0U};
    unsigned int protocol;
    char type[8];
    uint8_t miso = 0U;
    uint8_t mosi = 0U;

    for (protocol = 0U; protocol < 5U; ++protocol) {
        EventView view;
        words[1] = ((uint32_t)protocol << 28) | UINT32_C(0x00C100FF);
        words[0] = UINT32_C(0x02000001);
        view = event_view_decode(words);
        assert(strcmp(event_view_protocol_name(view.protocol), names[protocol]) == 0);
        assert(event_view_spi_bytes(&view, &miso, &mosi) == (protocol == 2U));
        words[1] = ((uint32_t)protocol << 28) | UINT32_C(0x00FF0004);
        view = event_view_decode(words);
        assert(event_view_is_error(&view) == 1);
        assert(event_view_spi_bytes(&view, &miso, &mosi) == 0);
    }
    assert(strcmp(event_view_protocol_name(15U), "UNKN") == 0);
    event_view_type_text(0U, type);
    assert(strcmp(type, "START") == 0);
    event_view_type_text(2U, type);
    assert(strcmp(type, "END") == 0);
    event_view_type_text(0x3FU, type);
    assert(strcmp(type, "ERROR") == 0);
    event_view_type_text(0x2AU, type);
    assert(strcmp(type, "EXT2A") == 0);
}

static void check_error_is_not_spi_data(void)
{
    const uint32_t words[4] = {
        UINT32_C(0x00000007), UINT32_C(0x20FF0004), 0U, 0U
    };
    const EventView view = event_view_decode(words);
    uint8_t miso = 0U;
    uint8_t mosi = 0U;
    assert(view.protocol == 2U && view.event_type == 0x3FU);
    assert(view.flags == 4U);
    assert(event_view_is_error(&view) == 1);
    assert(event_view_spi_bytes(&view, &miso, &mosi) == 0);
}

static void check_all_ids_and_type_buffer(void)
{
    uint32_t words[4] = {0U, 0U, 0U, 0U};
    unsigned int protocol;
    unsigned int type;

    for (protocol = 0U; protocol < 16U; ++protocol) {
        for (type = 0U; type < 64U; ++type) {
            char buffer[9] = {'?', '?', '?', '?', '?', '?', '?', '?', '!'};
            EventView view;
            words[1] = ((uint32_t)protocol << 28) |
                       ((uint32_t)type << 16) | UINT32_C(0xA55A);
            view = event_view_decode(words);
            assert(view.protocol == protocol);
            assert(view.event_type == type);
            assert(view.flags == UINT16_C(0xA55A));
            assert(event_view_is_error(&view) == (type == 63U));
            event_view_type_text(view.event_type, buffer);
            assert(buffer[8] == '!');
            assert(memchr(buffer, '\0', 8U) != NULL);
            if (type >= 3U && type < 63U) {
                assert(strncmp(buffer, "EXT", 3U) == 0);
            }
        }
    }
}

static void check_field_boundaries(void)
{
    const uint32_t all_ones[4] = {
        UINT32_MAX, UINT32_MAX, UINT32_MAX, UINT32_MAX
    };
    const EventView view = event_view_decode(all_ones);
    uint8_t miso = 0x5AU;
    uint8_t mosi = 0xA5U;

    assert(view.timestamp == UINT64_MAX);
    assert(view.transaction_id == UINT32_C(0x00FFFFFF));
    assert(view.payload_length == UINT8_MAX);
    assert(view.protocol == 15U);
    assert(view.channel == 15U);
    assert(view.direction == 3U);
    assert(view.event_type == 63U);
    assert(view.flags == UINT16_MAX);
    assert(event_view_spi_bytes(&view, &miso, &mosi) == 0);
    assert(miso == 0x5AU && mosi == 0xA5U);
}

int main(void)
{
    check_common_fields();
    check_protocols_and_types();
    check_error_is_not_spi_data();
    check_all_ids_and_type_buffer();
    check_field_boundaries();
    puts("event view tests passed");
    return 0;
}

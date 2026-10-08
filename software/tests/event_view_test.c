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

int main(void)
{
    check_common_fields();
    check_protocols_and_types();
    check_error_is_not_spi_data();
    puts("event view tests passed");
    return 0;
}

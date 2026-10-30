#include <assert.h>
#include <string.h>
#include "../src/ui_protocol_select.h"

int main(void)
{
    UiProtocol selected = UI_PROTOCOL_CAN;
    assert(ui_protocol_live(UI_PROTOCOL_SPI, 0xFU));
    assert(!ui_protocol_live(UI_PROTOCOL_SPI, 0U));
    assert(!ui_protocol_live(UI_PROTOCOL_UART, 0xFU));
    assert(ui_protocol_live(UI_PROTOCOL_UART, 1U << 5));
    assert(ui_protocol_live(UI_PROTOCOL_I2C, 1U << 7));
    assert(ui_protocol_live(UI_PROTOCOL_CAN, 1U << 8));
    assert(!ui_protocol_live(UI_PROTOCOL_I2C, 0x7FU));
    assert(!ui_protocol_live(UI_PROTOCOL_CAN, 0xFFU));
    assert(ui_protocol_event_id(UI_PROTOCOL_SPI) == 2U);
    assert(ui_protocol_event_id(UI_PROTOCOL_UART) == 1U);
    assert(ui_protocol_event_id(UI_PROTOCOL_I2C) == 3U);
    assert(ui_protocol_event_id(UI_PROTOCOL_CAN) == 4U);
    assert(strcmp(ui_protocol_name(UI_PROTOCOL_I2C), "I2C") == 0);
    assert(ui_protocol_from_touch(108U, 54U, &selected) &&
           selected == UI_PROTOCOL_SPI);
    assert(ui_protocol_from_touch(180U, 94U, &selected) &&
           selected == UI_PROTOCOL_UART);
    assert(ui_protocol_from_touch(252U, 74U, &selected) &&
           selected == UI_PROTOCOL_I2C);
    assert(ui_protocol_from_touch(390U, 74U, &selected) &&
           selected == UI_PROTOCOL_CAN);
    assert(!ui_protocol_from_touch(176U, 74U, &selected));
    assert(!ui_protocol_from_touch(30U, 180U, &selected));
    assert(!ui_protocol_from_touch(30U, 120U, 0));
    assert(ui_protocol_event_matches(UI_PROTOCOL_SPI, 2U, 0));
    assert(!ui_protocol_event_matches(UI_PROTOCOL_SPI, 1U, 0));
    assert(ui_protocol_event_matches(UI_PROTOCOL_UART, 1U, 0));
    assert(ui_protocol_event_matches(UI_PROTOCOL_I2C, 3U, 0));
    assert(ui_protocol_event_matches(UI_PROTOCOL_CAN, 4U, 0));
    assert(ui_protocol_event_matches(UI_PROTOCOL_SPI, 0U, 1));
    assert(!ui_protocol_event_matches(UI_PROTOCOL_UART, 0U, 1));
    assert(!ui_protocol_event_matches(UI_PROTOCOL_SPI, 0U, 0));
    return 0;
}

#ifndef UI_PROTOCOL_SELECT_H_
#define UI_PROTOCOL_SELECT_H_

#include <stdint.h>

/* UI selection is distinct from the on-wire event protocol ID. Selecting a
 * tab never changes PL wiring or silently enables an unimplemented listener. */
typedef enum {
    UI_PROTOCOL_SPI = 0,
    UI_PROTOCOL_UART,
    UI_PROTOCOL_I2C,
    UI_PROTOCOL_CAN,
    UI_PROTOCOL_COUNT
} UiProtocol;

static inline const char *ui_protocol_name(UiProtocol protocol)
{
    static const char *const name[UI_PROTOCOL_COUNT] = {
        "SPI", "UART", "I2C", "CAN"
    };
    return (unsigned int)protocol < UI_PROTOCOL_COUNT ?
           name[protocol] : "UNKNOWN";
}

/* The current matched PL ABI has only the passive SPI listener (bit 2). */
static inline int ui_protocol_live(UiProtocol protocol, uint32_t capabilities)
{
    return protocol == UI_PROTOCOL_SPI && (capabilities & (1U << 2)) != 0U;
}

/* Event ABI IDs differ from UI order: UART=1, SPI=2, I2C=3, CAN=4.
 * Virtual demo rows (ID 0) are visible only in the SPI demo view and must
 * always be labelled as demonstration data, never as SPI bus traffic. */
static inline int ui_protocol_event_matches(UiProtocol selected,
                                            uint8_t event_protocol,
                                            int demo_snapshot)
{
    static const uint8_t event_id[UI_PROTOCOL_COUNT] = {2U, 1U, 3U, 4U};
    if ((unsigned int)selected >= UI_PROTOCOL_COUNT) return 0;
    if (demo_snapshot != 0)
        return selected == UI_PROTOCOL_SPI && event_protocol == 0U;
    return event_protocol == event_id[selected];
}

static inline uint16_t ui_protocol_tab_left(UiProtocol protocol)
{
    static const uint16_t left[UI_PROTOCOL_COUNT] = {14U, 205U, 396U, 587U};
    return (unsigned int)protocol < UI_PROTOCOL_COUNT ? left[protocol] : 0U;
}

static inline uint16_t ui_protocol_tab_right(UiProtocol protocol)
{
    static const uint16_t right[UI_PROTOCOL_COUNT] = {195U, 386U, 577U, 786U};
    return (unsigned int)protocol < UI_PROTOCOL_COUNT ? right[protocol] : 0U;
}

static inline int ui_protocol_from_touch(uint16_t x, uint16_t y,
                                         UiProtocol *selected)
{
    unsigned int i;
    if (selected == 0 || y < 112U || y > 166U) return 0;
    for (i = 0U; i < UI_PROTOCOL_COUNT; ++i) {
        if (x >= ui_protocol_tab_left((UiProtocol)i) &&
            x <= ui_protocol_tab_right((UiProtocol)i)) {
            *selected = (UiProtocol)i;
            return 1;
        }
    }
    return 0;
}

#endif

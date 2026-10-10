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

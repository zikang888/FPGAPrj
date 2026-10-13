#ifndef EVENT_VIEW_H_
#define EVENT_VIEW_H_

/* Host-testable presentation of the shared 128-bit event ABI.
 * Protocol-specific flag meanings are intentionally not inferred here. */
#include <stdint.h>

typedef struct {
    uint64_t timestamp;
    uint32_t transaction_id;
    uint16_t flags;
    uint8_t payload_length;
    uint8_t protocol;
    uint8_t channel;
    uint8_t direction;
    uint8_t event_type;
} EventView;

static inline EventView event_view_decode(const uint32_t words[4])
{
    EventView view;
    const uint32_t metadata = words[1];
    view.timestamp = ((uint64_t)words[3] << 32) | words[2];
    view.transaction_id = words[0] & UINT32_C(0x00FFFFFF);
    view.payload_length = (uint8_t)(words[0] >> 24);
    view.flags = (uint16_t)metadata;
    view.event_type = (uint8_t)((metadata >> 16) & 0x3FU);
    view.direction = (uint8_t)((metadata >> 22) & 0x03U);
    view.channel = (uint8_t)((metadata >> 24) & 0x0FU);
    view.protocol = (uint8_t)((metadata >> 28) & 0x0FU);
    return view;
}

static inline const char *event_view_protocol_name(uint8_t protocol)
{
    static const char *const names[5] = {"VIRT", "UART", "SPI", "I2C", "CAN"};
    return protocol < 5U ? names[protocol] : "UNKN";
}

/* out must have room for at least 8 characters. Unknown 0x03..0x3E
 * extensions retain their numeric code instead of guessing a meaning. */
static inline void event_view_type_text(uint8_t event_type, char out[8])
{
    static const char hex[] = "0123456789ABCDEF";
    const char *known = 0;
    unsigned int i;
    if (event_type == 0U) known = "START";
    else if (event_type == 1U) known = "DATA";
    else if (event_type == 2U) known = "END";
    else if (event_type == 0x3FU) known = "ERROR";
    if (known != 0) {
        for (i = 0U; known[i] != '\0'; ++i) out[i] = known[i];
        out[i] = '\0';
    } else {
        out[0] = 'E'; out[1] = 'X'; out[2] = 'T';
        out[3] = hex[(event_type >> 4) & 0x0FU];
        out[4] = hex[event_type & 0x0FU];
        out[5] = '\0';
    }
}

static inline int event_view_is_error(const EventView *view)
{
    return view->event_type == 0x3FU;
}

/* The currently approved SPI DATA flags carry MISO in [15:8], MOSI in [7:0].
 * Do not apply this split to future UART/I2C/CAN events. */
static inline int event_view_spi_bytes(const EventView *view,
                                       uint8_t *miso, uint8_t *mosi)
{
    if (view->protocol != 2U || view->event_type != 1U ||
        view->payload_length != 2U || miso == 0 || mosi == 0) return 0;
    *miso = (uint8_t)(view->flags >> 8);
    *mosi = (uint8_t)view->flags;
    return 1;
}

#endif

#ifndef MC_BUTTON_H
#define MC_BUTTON_H

#include <stdint.h>

#define MC_BUTTON_DEBOUNCE_MS 30U
#define MC_BUTTON_HOLD_MS 800U

typedef enum { MC_BUTTON_NONE, MC_BUTTON_SHORT, MC_BUTTON_LONG } mc_button_event_t;
typedef struct {
    uint32_t changed_ms;
    uint32_t pressed_ms;
    uint8_t candidate;
    uint8_t stable;
    uint8_t armed;
    uint8_t long_sent;
} mc_button_t;

/* pressed=1 for PA0 high. A key held at boot must be released before use. */
void mc_button_init(mc_button_t *button, int pressed, uint32_t now_ms);
mc_button_event_t mc_button_poll(mc_button_t *button, int pressed, uint32_t now_ms);

#endif

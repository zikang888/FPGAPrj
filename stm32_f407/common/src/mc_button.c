#include "mc_button.h"

void mc_button_init(mc_button_t *button, int pressed, uint32_t now_ms)
{
    button->changed_ms = now_ms;
    button->pressed_ms = now_ms;
    button->candidate = pressed ? 1U : 0U;
    button->stable = button->candidate;
    button->armed = pressed ? 0U : 1U;
    button->long_sent = 0U;
}

mc_button_event_t mc_button_poll(mc_button_t *button, int pressed, uint32_t now_ms)
{
    uint8_t raw = pressed ? 1U : 0U;
    if (raw != button->candidate) {
        button->candidate = raw;
        button->changed_ms = now_ms;
    }
    if (button->candidate != button->stable &&
        (uint32_t)(now_ms - button->changed_ms) >= MC_BUTTON_DEBOUNCE_MS) {
        button->stable = button->candidate;
        if (button->stable) {
            button->pressed_ms = button->changed_ms;
            button->long_sent = 0U;
        } else {
            int short_press = button->armed && !button->long_sent;
            button->armed = 1U;
            button->long_sent = 0U;
            if (short_press) { return MC_BUTTON_SHORT; }
        }
    }
    /* Suppress a new long event while a possible release is being debounced.
       Once sent, retain the latch through any release glitch shorter than 30ms. */
    if (button->stable && button->candidate && button->armed && !button->long_sent &&
        (uint32_t)(now_ms - button->pressed_ms) >= MC_BUTTON_HOLD_MS) {
        button->long_sent = 1U;
        return MC_BUTTON_LONG;
    }
    return MC_BUTTON_NONE;
}

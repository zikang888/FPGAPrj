#include "mc_can_live.h"
#include <stdio.h>
#include <string.h>

int mc_can_live_timing(const uint8_t tx[8], mc_can_live_timing_t *timing)
{
    mc_can_raw_wave_t wave;
    uint16_t wire, source = 0U;
    uint8_t run = 0U, previous = 2U;
    if (tx == NULL || timing == NULL) { return MC_ERR_ARGUMENT; }
    if (mc_can_raw_build(MC_CAN_RAW_VALID, 0x321U, tx, 8U, &wave) != MC_OK) { return MC_ERR_IO; }
    for (wire = 0U; wire < wave.stuffed_end; ++wire) {
        uint8_t bit = wave.bits[wire];
        if (run == 5U) { previous = bit; run = 1U; continue; }
        if (source >= 19U && source < 83U && bit == 1U) {
            timing->wire_bit = wire;
            timing->start_ticks = (uint32_t)wire * 168U + 42U;
            timing->sample_ticks = (uint32_t)wire * 168U + 144U;
            timing->end_ticks = (uint32_t)wire * 168U + 151U;
            return MC_OK;
        }
        run = bit == previous ? (uint8_t)(run + 1U) : 1U;
        previous = bit;
        ++source;
    }
    return MC_ERR_VERIFY;
}

int mc_can_live_parse(const char *args, mc_can_config_t *config)
{
    static const char *const names[] = {"disturb", "bit", "busoff"};
    char proxy[64];
    mc_can_config_t parsed;
    unsigned int i;
    int n;
    if (args == NULL || config == NULL) { return MC_ERR_ARGUMENT; }
    for (i = 0U; i < 3U; ++i) {
        size_t length = strlen(names[i]);
        if (strncmp(args, names[i], length) == 0 && args[length] == ' ') { break; }
    }
    if (i == 3U) { return MC_ERR_ARGUMENT; }
    /* Reuse the strict COUNT/PERIOD/EVERY parser; LIVE defaults to every frame. */
    n = snprintf(proxy, sizeof(proxy), "bitrate%s", args + strlen(names[i]));
    if (n < 0 || (size_t)n >= sizeof(proxy) || mc_can_session_parse(proxy, &parsed) != MC_OK) {
        return MC_ERR_ARGUMENT;
    }
    {
        const char *p = args + strlen(names[i]);
        unsigned int tokens = 0U;
        while (*p) { while (*p == ' ') { ++p; } if (*p) { ++tokens; while (*p && *p != ' ') { ++p; } } }
        if (tokens == 2U) { parsed.every = 1U; }
    }
    parsed.mode = (mc_can_mode_t)(MC_CAN_LIVE_DISTURB + i);
    parsed.bitrate = 500000U;
    if (parsed.mode == MC_CAN_LIVE_BUSOFF &&
        (parsed.count < 32U || parsed.count > 128U || parsed.every != 1U || parsed.period_ms > 1000U)) {
        return MC_ERR_ARGUMENT;
    }
    *config = parsed;
    return MC_OK;
}

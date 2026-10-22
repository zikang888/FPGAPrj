#ifndef MC_CAN_LIVE_H
#define MC_CAN_LIVE_H
#include "mc_can_raw.h"

typedef struct {
    uint16_t wire_bit;
    uint32_t start_ticks;
    uint32_t end_ticks;
    uint32_t sample_ticks;
} mc_can_live_timing_t;

int mc_can_live_timing(const uint8_t tx[8], mc_can_live_timing_t *timing);
int mc_can_live_parse(const char *args, mc_can_config_t *config);
#endif

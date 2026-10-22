#ifndef MC_CAN_RAW_H
#define MC_CAN_RAW_H

#include "mc_can_session.h"

#define MC_CAN_RAW_MAX_BITS 192U
#define MC_CAN_RAW_NO_FAULT 0xffffU

typedef struct {
    uint8_t bits[MC_CAN_RAW_MAX_BITS];
    uint16_t count;
    uint16_t stuffed_end; /* CRC delimiter starts here; ACK delimiter is +2. */
    uint16_t fault_bit;   /* zero-based wire position, or NO_FAULT */
    uint16_t crc;
} mc_can_raw_wave_t;

uint16_t mc_can_crc15_bits(const uint8_t *bits, size_t count);
int mc_can_raw_build(mc_can_mode_t mode, uint32_t standard_id,
                     const uint8_t *data, size_t length, mc_can_raw_wave_t *wave);
/* valid|crc|stuff|form BITRATE COUNT PERIOD_MS [EVERY]; default EVERY=1. */
int mc_can_raw_parse(const char *arguments, mc_can_config_t *config);

#endif

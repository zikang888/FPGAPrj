#ifndef MC_TRUTH_LOG_H
#define MC_TRUTH_LOG_H

#include "mc_protocol_platform.h"

#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    uint32_t sequence;
    uint32_t case_id;
    uint32_t transaction_id;
    const char *protocol;
    const char *operation;
    const char *direction;
    const uint8_t *data;
    size_t data_length;
    /* Optional transmitted bytes. SPI records keep data as actual RX. */
    const uint8_t *tx_data;
    size_t tx_length;
    int result;
    const char *detail;
} mc_log_record_t;

int mc_truth_log_write(const mc_platform_t *platform, const mc_log_record_t *record);

#ifdef __cplusplus
}
#endif

#endif

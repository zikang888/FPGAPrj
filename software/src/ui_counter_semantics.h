#ifndef UI_COUNTER_SEMANTICS_H_
#define UI_COUNTER_SEMANTICS_H_

#include <stdint.h>

/* Core rejects may rise after a snapshot freezes; only producer loss is a fault. */
static inline int ui_counter_health_ok(uint32_t external_loss_count)
{
    return external_loss_count == 0U;
}

static inline int ui_counter_poll_due(uint64_t now, uint64_t previous,
                                      uint64_t interval)
{
    return (uint64_t)(now - previous) >= interval;
}

static inline int ui_counter_changed(uint32_t old_core, uint32_t old_external,
                                     uint32_t new_core, uint32_t new_external)
{
    return old_core != new_core || old_external != new_external;
}

/* A rejected event in a frozen one-shot snapshot is informational. The four
 * SPI checker faults and producer-side loss are actual monitor faults. */
static inline int ui_monitor_errors_present(uint32_t external_loss,
                                            uint32_t frame_errors,
                                            uint32_t boundary_errors,
                                            uint32_t duplicates,
                                            uint32_t sequence_errors)
{
    return (external_loss | frame_errors | boundary_errors |
            duplicates | sequence_errors) != 0U;
}

#endif

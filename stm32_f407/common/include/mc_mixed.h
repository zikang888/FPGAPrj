#ifndef MC_MIXED_H
#define MC_MIXED_H
#include "mc_faults.h"

typedef enum { MC_MIX_NORMAL, MC_MIX_ONCE, MC_MIX_EVERY, MC_MIX_RANDOM } mc_mix_mode_t;
typedef enum { MC_MIX_IDLE, MC_MIX_RUNNING, MC_MIX_DONE, MC_MIX_STOPPED, MC_MIX_ERROR } mc_mix_state_t;
enum { MC_MIX_PENDING = 1 };
typedef struct {
    mc_fault_id_t fault;
    mc_mix_mode_t mode;
    uint32_t total, gap_ms, value, seed;
} mc_mix_config_t;
struct mc_mixed;
typedef struct {
    void *context;
    uint32_t (*now_ms)(void *context);
    int (*start_slot)(void *context, const struct mc_mixed *session);
    int (*poll_slot)(void *context);
    /* Must restore resources. A failure keeps the mixed session locked. */
    int (*cancel)(void *context);
    int (*record)(void *context, const struct mc_mixed *session, const char *phase);
} mc_mix_port_t;
typedef struct mc_mixed {
    mc_mix_port_t port;
    mc_mix_config_t config;
    mc_mix_state_t state;
    uint32_t run, index, completed, planned_faults, fault_attempts, fault_ok;
    uint32_t normal_ok, failed, cancelled, rng, remaining_faults;
    uint32_t dispatch_ms, started_ms, ended_ms, last_finish_ms;
    uint8_t held, waiting, is_fault;
    int last_result, restore_result;
} mc_mixed_t;

void mc_mix_init(mc_mixed_t *session, const mc_mix_port_t *port);
int mc_mix_fault_supported(mc_fault_id_t fault);
int mc_mix_validate(const mc_mix_config_t *config);
int mc_mix_start(mc_mixed_t *session, const mc_mix_config_t *config);
void mc_mix_tick(mc_mixed_t *session);
int mc_mix_stop(mc_mixed_t *session);
int mc_mix_recover(mc_mixed_t *session);
/* FAULT_INDEX TOTAL GAP_MS normal|once|every|random VALUE [SEED]. */
int mc_mix_parse(const char *args, mc_mix_config_t *config);
#endif

#ifndef MC_CAN_SESSION_H
#define MC_CAN_SESSION_H

#include "mc_protocol_platform.h"

/* Experimental sessions do not allocate or redefine frozen protocol case IDs. */
typedef enum {
    MC_CAN_NORMAL, MC_CAN_NO_ACK, MC_CAN_BITRATE, MC_CAN_ECHO,
    MC_CAN_RAW_VALID, MC_CAN_RAW_CRC, MC_CAN_RAW_STUFF, MC_CAN_RAW_FORM,
    MC_CAN_LIVE_DISTURB, MC_CAN_LIVE_BIT, MC_CAN_LIVE_BUSOFF
} mc_can_mode_t;

typedef enum {
    MC_CAN_IDLE, MC_CAN_RUNNING, MC_CAN_DONE, MC_CAN_STOPPED, MC_CAN_ERROR
} mc_can_state_t;

enum { MC_CAN_PENDING = 1 };

typedef struct {
    mc_can_mode_t mode;
    uint32_t count;
    uint32_t period_ms;
    uint32_t timeout_ms;
    uint32_t every; /* BITRATE: every Nth frame uses 250 kbit/s, otherwise 500k. */
    uint32_t bitrate; /* RAW only: 125000 or 500000. */
} mc_can_config_t;

typedef struct {
    uint32_t esr;
    uint32_t tsr;
    uint32_t rf0r;
    uint32_t observed_ms;
    uint8_t first_lec; /* first error sampled by poll, not a complete error history */
    uint8_t fifo_overrun;
    int backend_error;
    uint8_t injected;
    uint8_t bit_error;
    uint8_t tx_error;
} mc_can_evidence_t;

typedef struct {
    uint32_t run;
    uint32_t frame;
    uint32_t submitted_ms;
    uint32_t bitrate;
    mc_can_mode_t mode;
    uint8_t tx[8];
    uint8_t rx[8];
    uint8_t rx_valid;
    uint8_t submitted;
    uint8_t fault_slot;
    int transport_result;
    int cancel_result;
    int result; /* scenario expectation; never implies PL detection */
    mc_can_evidence_t evidence;
} mc_can_frame_t;

typedef struct {
    void *context;
    int (*begin)(void *context, mc_can_mode_t mode);
    int (*submit)(void *context, mc_can_mode_t mode, uint32_t bitrate, const uint8_t tx[8]);
    int (*poll_tx)(void *context, mc_can_evidence_t *evidence);
    int (*poll_rx)(void *context, uint8_t rx[8], mc_can_evidence_t *evidence);
    int (*cancel)(void *context, mc_can_evidence_t *evidence);
    int (*restore)(void *context);
    int (*record)(void *context, const mc_can_frame_t *frame);
} mc_can_session_port_t;

typedef struct {
    mc_can_session_port_t port;
    mc_can_config_t config;
    mc_can_state_t state;
    mc_can_frame_t frame;
    uint32_t run;
    uint32_t completed;
    uint32_t submitted;
    uint32_t passed;
    uint32_t failed;
    uint32_t fault_slots;
    uint32_t last_start_ms;
    uint8_t held;
    uint8_t waiting;
    uint8_t waiting_rx;
    int last_result;
    int restore_result;
} mc_can_session_t;

void mc_can_session_init(mc_can_session_t *session, const mc_can_session_port_t *port);
int mc_can_session_start(mc_can_session_t *session, const mc_can_config_t *config);
void mc_can_session_tick(mc_can_session_t *session, uint32_t now_ms);
int mc_can_session_stop(mc_can_session_t *session);
/* Also retries restoration after a hardware error. held remains set on failure. */
int mc_can_session_recover(mc_can_session_t *session);
/* Parses: normal|noack|bitrate|echo COUNT PERIOD_MS [EVERY]. */
int mc_can_session_parse(const char *arguments, mc_can_config_t *config);

#endif

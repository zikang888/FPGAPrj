#include "mc_can_session.h"

#include <string.h>

void mc_can_session_init(mc_can_session_t *s, const mc_can_session_port_t *port)
{
    if (s == NULL) { return; }
    memset(s, 0, sizeof(*s));
    if (port != NULL) { s->port = *port; }
}

static int release_port(mc_can_session_t *s, mc_can_state_t state)
{
    s->restore_result = s->held ? s->port.restore(s->port.context) : MC_OK;
    if (s->restore_result == MC_OK) {
        s->held = 0U;
        s->state = state;
    } else {
        s->state = MC_CAN_ERROR;
        s->last_result = s->restore_result;
    }
    return s->restore_result;
}

int mc_can_session_start(mc_can_session_t *s, const mc_can_config_t *config)
{
    int result;
    mc_can_session_port_t port;
    mc_can_config_t requested;
    uint32_t run;
    if (s == NULL || config == NULL || (unsigned int)config->mode > MC_CAN_LIVE_BUSOFF ||
        config->count == 0U || config->count > 10000U ||
        config->period_ms < 50U || config->period_ms > 60000U ||
        config->timeout_ms == 0U || config->timeout_ms > config->period_ms ||
        ((config->mode == MC_CAN_BITRATE || config->mode > MC_CAN_RAW_VALID) &&
         config->every == 0U) ||
        (config->mode >= MC_CAN_RAW_VALID && config->mode <= MC_CAN_RAW_FORM &&
         config->bitrate != 125000U && config->bitrate != 500000U) ||
        (config->mode >= MC_CAN_LIVE_DISTURB && config->bitrate != 500000U) ||
        (config->mode == MC_CAN_LIVE_BUSOFF &&
         (config->count < 32U || config->count > 128U || config->every != 1U ||
          config->period_ms > 1000U))) {
        return MC_ERR_ARGUMENT;
    }
    if (s->held || s->state == MC_CAN_RUNNING) { return MC_ERR_BUSY; }
    if (s->port.begin == NULL || s->port.submit == NULL ||
        s->port.poll_tx == NULL || s->port.poll_rx == NULL ||
        s->port.cancel == NULL || s->port.restore == NULL || s->port.record == NULL) {
        return MC_ERR_UNSUPPORTED;
    }
    port = s->port;
    requested = *config;
    run = s->run + 1U;
    memset(s, 0, sizeof(*s));
    s->port = port;
    s->config = requested;
    s->run = run;
    s->held = 1U;
    result = s->port.begin(s->port.context, requested.mode);
    if (result != MC_OK) {
        s->last_result = result;
        (void)release_port(s, MC_CAN_ERROR);
        return s->restore_result != MC_OK ? s->restore_result : result;
    }
    s->state = MC_CAN_RUNNING;
    return MC_OK;
}

static void complete_frame(mc_can_session_t *s, int transport)
{
    int log_result;
    int expected = transport;
    int reached_busoff = s->config.mode == MC_CAN_LIVE_BUSOFF &&
                        (s->frame.evidence.esr & 4U) != 0U &&
                        s->frame.evidence.injected && s->frame.evidence.bit_error;
    s->frame.transport_result = transport;
    if (s->config.mode == MC_CAN_NO_ACK) {
        expected = s->frame.submitted && s->frame.cancel_result == MC_OK &&
                   s->frame.evidence.backend_error == MC_OK && transport != MC_OK &&
                   s->frame.evidence.first_lec == 3U ? MC_OK : MC_ERR_VERIFY;
    } else if (s->config.mode == MC_CAN_ECHO && transport == MC_OK) {
        expected = s->frame.rx_valid && memcmp(s->frame.tx, s->frame.rx, 8U) == 0 ?
                   MC_OK : MC_ERR_VERIFY;
    } else if (s->frame.mode == MC_CAN_LIVE_DISTURB) {
        expected = s->frame.evidence.injected ? MC_OK : MC_ERR_VERIFY;
    } else if (s->frame.mode == MC_CAN_LIVE_BIT || s->frame.mode == MC_CAN_LIVE_BUSOFF) {
        expected = s->frame.evidence.injected && s->frame.evidence.bit_error &&
                   (s->frame.evidence.tx_error || reached_busoff) && transport != MC_OK ?
                   MC_OK : MC_ERR_VERIFY;
    }
    if (s->config.mode == MC_CAN_LIVE_BUSOFF && !reached_busoff &&
        s->frame.frame >= s->config.count) { expected = MC_ERR_VERIFY; }
    if (s->frame.cancel_result != MC_OK) { expected = s->frame.cancel_result; }
    if (s->frame.evidence.backend_error != MC_OK) { expected = s->frame.evidence.backend_error; }
    if ((s->frame.evidence.esr & 4U) != 0U && !reached_busoff) { expected = MC_ERR_IO; }
    s->frame.result = expected;
    s->last_result = expected;
    ++s->completed;
    if (expected == MC_OK) { ++s->passed; } else { ++s->failed; }
    s->waiting = 0U;
    s->waiting_rx = 0U;
    log_result = s->port.record(s->port.context, &s->frame);
    if (log_result != MC_OK || !s->frame.submitted ||
        s->frame.cancel_result != MC_OK || s->frame.evidence.backend_error != MC_OK ||
        ((s->frame.evidence.esr & 4U) != 0U && !reached_busoff)) {
        s->last_result = log_result != MC_OK ? log_result :
                         (s->frame.cancel_result != MC_OK ? s->frame.cancel_result :
                         (s->frame.evidence.backend_error != MC_OK ?
                          s->frame.evidence.backend_error :
                         (!s->frame.submitted ? transport : MC_ERR_IO)));
        (void)release_port(s, MC_CAN_ERROR);
    } else if (reached_busoff || s->completed >= s->config.count) {
        (void)release_port(s, s->config.mode == MC_CAN_LIVE_BUSOFF && !reached_busoff ?
                           MC_CAN_ERROR : MC_CAN_DONE);
    }
}

void mc_can_session_tick(mc_can_session_t *s, uint32_t now_ms)
{
    int result;
    unsigned int i;
    if (s == NULL || s->state != MC_CAN_RUNNING) { return; }
    if (!s->waiting) {
        if (s->completed != 0U &&
            (uint32_t)(now_ms - s->last_start_ms) < s->config.period_ms) { return; }
        memset(&s->frame, 0, sizeof(s->frame));
        s->frame.run = s->run;
        s->frame.frame = s->completed + 1U;
        s->frame.submitted_ms = now_ms;
        s->frame.bitrate = 500000U;
        s->frame.mode = s->config.mode;
        if (s->config.mode >= MC_CAN_LIVE_DISTURB) {
            s->frame.mode = MC_CAN_NORMAL;
            if (s->frame.frame % s->config.every == 0U) {
                s->frame.mode = s->config.mode;
                s->frame.fault_slot = 1U;
            }
        } else if (s->config.mode >= MC_CAN_RAW_VALID) {
            s->frame.bitrate = s->config.bitrate;
            s->frame.mode = MC_CAN_RAW_VALID;
            if (s->config.mode > MC_CAN_RAW_VALID &&
                s->frame.frame % s->config.every == 0U) {
                s->frame.mode = s->config.mode;
                s->frame.fault_slot = 1U;
            }
        } else if (s->config.mode == MC_CAN_BITRATE &&
            s->frame.frame % s->config.every == 0U) {
            s->frame.bitrate = 250000U;
            s->frame.fault_slot = 1U;
        } else if (s->config.mode == MC_CAN_NO_ACK) {
            s->frame.fault_slot = 1U;
        }
        s->fault_slots += s->frame.fault_slot;
        /* Big-endian run/frame, preventing an old echo from passing a new frame. */
        for (i = 0U; i < 4U; ++i) {
            s->frame.tx[i] = (uint8_t)(s->run >> (24U - i * 8U));
            s->frame.tx[i + 4U] = (uint8_t)(s->frame.frame >> (24U - i * 8U));
        }
        s->last_start_ms = now_ms;
        result = s->port.submit(s->port.context, s->frame.mode, s->frame.bitrate, s->frame.tx);
        if (result != MC_OK) {
            s->frame.cancel_result = s->port.cancel(s->port.context, &s->frame.evidence);
            complete_frame(s, result);
            return;
        }
        s->frame.submitted = 1U;
        ++s->submitted;
        s->waiting = 1U;
        return;
    }
    result = s->waiting_rx ?
             s->port.poll_rx(s->port.context, s->frame.rx, &s->frame.evidence) :
             s->port.poll_tx(s->port.context, &s->frame.evidence);
    if (s->frame.evidence.backend_error != MC_OK ||
        (s->frame.evidence.esr & 4U) != 0U) {
        complete_frame(s, s->frame.evidence.backend_error != MC_OK ?
                       s->frame.evidence.backend_error : MC_ERR_IO);
        return;
    }
    if (result == MC_CAN_PENDING) {
        if ((uint32_t)(now_ms - s->last_start_ms) >= s->config.timeout_ms) {
            int cancel_result = s->port.cancel(s->port.context, &s->frame.evidence);
            s->frame.cancel_result = cancel_result;
            complete_frame(s, cancel_result == MC_OK ? MC_ERR_TIMEOUT : cancel_result);
        }
        return;
    }
    if (result == MC_OK && !s->waiting_rx && s->config.mode == MC_CAN_ECHO) {
        s->waiting_rx = 1U;
        return;
    }
    if (result == MC_OK && s->waiting_rx) { s->frame.rx_valid = 1U; }
    complete_frame(s, result);
}

int mc_can_session_stop(mc_can_session_t *s)
{
    int result = MC_OK;
    if (s == NULL) { return MC_ERR_ARGUMENT; }
    if (s->state == MC_CAN_RUNNING) {
        if (s->waiting) {
            result = s->port.cancel(s->port.context, &s->frame.evidence);
            s->frame.cancel_result = result;
            /* A cancelled in-flight frame is logged, not reported as a pass. */
            s->frame.transport_result = MC_ERR_BUSY;
            s->frame.result = MC_ERR_BUSY;
            if (s->port.record(s->port.context, &s->frame) != MC_OK) { result = MC_ERR_IO; }
        }
        s->waiting = 0U;
        s->waiting_rx = 0U;
        s->last_result = result;
        (void)release_port(s, result == MC_OK ? MC_CAN_STOPPED : MC_CAN_ERROR);
    }
    return s->restore_result != MC_OK ? s->restore_result : result;
}

int mc_can_session_recover(mc_can_session_t *s)
{
    if (s == NULL) { return MC_ERR_ARGUMENT; }
    if (s->state == MC_CAN_RUNNING) { return mc_can_session_stop(s); }
    return release_port(s, s->state);
}

static int parse_number(const char **cursor, uint32_t *value)
{
    uint32_t number = 0U;
    const char *p = *cursor;
    while (*p == ' ') { ++p; }
    if (*p < '0' || *p > '9') { return MC_ERR_ARGUMENT; }
    do {
        number = number * 10U + (uint32_t)(*p - '0');
        if (number > 60000U) { return MC_ERR_ARGUMENT; }
        ++p;
    } while (*p >= '0' && *p <= '9');
    if (*p != ' ' && *p != '\0') { return MC_ERR_ARGUMENT; }
    *cursor = p;
    *value = number;
    return MC_OK;
}

int mc_can_session_parse(const char *args, mc_can_config_t *config)
{
    static const char *const modes[] = {"normal", "noack", "bitrate", "echo"};
    unsigned int i;
    const char *cursor;
    mc_can_config_t value;
    if (args == NULL || config == NULL) { return MC_ERR_ARGUMENT; }
    memset(&value, 0, sizeof(value));
    for (i = 0U; i < 4U; ++i) {
        size_t length = strlen(modes[i]);
        if (strncmp(args, modes[i], length) == 0 && args[length] == ' ') { break; }
    }
    if (i == 4U) { return MC_ERR_ARGUMENT; }
    value.mode = (mc_can_mode_t)i;
    cursor = args + strlen(modes[i]);
    if (parse_number(&cursor, &value.count) != MC_OK ||
        parse_number(&cursor, &value.period_ms) != MC_OK ||
        value.count == 0U || value.count > 10000U ||
        value.period_ms < 50U || value.period_ms > 60000U) { return MC_ERR_ARGUMENT; }
    while (*cursor == ' ') { ++cursor; }
    if (value.mode == MC_CAN_BITRATE) {
        value.every = 20U;
        if (*cursor != '\0' && parse_number(&cursor, &value.every) != MC_OK) {
            return MC_ERR_ARGUMENT;
        }
        if (value.every == 0U) { return MC_ERR_ARGUMENT; }
        while (*cursor == ' ') { ++cursor; }
    }
    if (*cursor != '\0') { return MC_ERR_ARGUMENT; }
    value.timeout_ms = value.period_ms / 2U;
    if (value.timeout_ms > 40U) { value.timeout_ms = 40U; }
    *config = value;
    return MC_OK;
}

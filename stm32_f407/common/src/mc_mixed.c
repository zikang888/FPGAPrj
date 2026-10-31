#include "mc_mixed.h"
#include <string.h>

int mc_mix_fault_supported(mc_fault_id_t fault)
{
    switch (fault) {
    case MC_FAULT_SPI_PARTIAL: case MC_FAULT_SPI_SHORT: case MC_FAULT_SPI_EXTRA:
    case MC_FAULT_UART_BAD_STOP: case MC_FAULT_UART_BREAK: case MC_FAULT_UART_MISSING_BYTES:
    case MC_FAULT_I2C_ADDRESS_NACK: case MC_FAULT_I2C_NO_STOP:
    case MC_FAULT_CAN_STUFF: case MC_FAULT_CAN_CRC: case MC_FAULT_CAN_FORM: return 1;
    default: return 0;
    }
}

void mc_mix_init(mc_mixed_t *s, const mc_mix_port_t *port)
{
    if (s == NULL) { return; }
    memset(s, 0, sizeof(*s));
    if (port != NULL) { s->port = *port; }
}

static int finish(mc_mixed_t *s, mc_mix_state_t state)
{
    int logged;
    s->restore_result = s->port.cancel(s->port.context);
    s->held = s->restore_result != MC_OK;
    s->state = s->held ? MC_MIX_ERROR : state;
    if (s->held) { s->last_result = s->restore_result; }
    if (state == MC_MIX_STOPPED && s->cancelled != 0U &&
        s->port.record(s->port.context, s, "slot_cancel") != MC_OK) {
        s->last_result = MC_ERR_IO; s->state = MC_MIX_ERROR;
    }
    logged = s->port.record(s->port.context, s, "end");
    if (logged != MC_OK) { s->last_result = logged; s->state = MC_MIX_ERROR; }
    return s->last_result;
}

int mc_mix_validate(const mc_mix_config_t *config)
{
    if (config == NULL || !mc_mix_fault_supported(config->fault) ||
        (unsigned int)config->mode > MC_MIX_RANDOM || config->total == 0U || config->total > 10000U ||
        config->gap_ms < 100U || config->gap_ms > 60000U || config->seed == 0U ||
        (config->mode == MC_MIX_NORMAL ? config->value != 0U :
         (config->value == 0U || config->value > config->total))) { return MC_ERR_ARGUMENT; }
    return MC_OK;
}

int mc_mix_start(mc_mixed_t *s, const mc_mix_config_t *config)
{
    mc_mix_port_t port;
    mc_mix_config_t requested;
    uint32_t run;
    int result;
    if (s == NULL || mc_mix_validate(config) != MC_OK) { return MC_ERR_ARGUMENT; }
    if (s->held || s->state == MC_MIX_RUNNING) { return MC_ERR_BUSY; }
    if (s->port.now_ms == NULL || s->port.start_slot == NULL || s->port.poll_slot == NULL ||
        s->port.cancel == NULL || s->port.record == NULL) { return MC_ERR_UNSUPPORTED; }
    port = s->port; requested = *config; run = s->run + 1U;
    memset(s, 0, sizeof(*s)); s->port = port; s->config = requested; s->run = run;
    s->planned_faults = config->mode == MC_MIX_NORMAL ? 0U :
        (config->mode == MC_MIX_ONCE ? 1U :
         (config->mode == MC_MIX_EVERY ? config->total / config->value : config->value));
    s->remaining_faults = s->planned_faults; s->rng = config->seed;
    s->held = 1U; s->state = MC_MIX_RUNNING;
    result = s->port.record(s->port.context, s, "begin");
    if (result != MC_OK) { s->last_result = result; (void)finish(s, MC_MIX_ERROR); }
    return result;
}

static int choose_fault(mc_mixed_t *s)
{
    if (s->config.mode == MC_MIX_ONCE) { return s->index == s->config.value; }
    if (s->config.mode == MC_MIX_EVERY) { return s->index % s->config.value == 0U; }
    if (s->config.mode == MC_MIX_RANDOM) {
        uint32_t remaining = s->config.total - s->index + 1U;
        int chosen;
        s->rng ^= s->rng << 13; s->rng ^= s->rng >> 17; s->rng ^= s->rng << 5;
        chosen = s->rng % remaining < s->remaining_faults;
        if (chosen) { --s->remaining_faults; }
        return chosen;
    }
    return 0;
}

static void complete(mc_mixed_t *s, int result)
{
    int logged;
    s->waiting = 0U; s->last_result = result;
    s->ended_ms = s->port.now_ms(s->port.context);
    ++s->completed;
    if (result != MC_OK) { ++s->failed; }
    else if (s->is_fault) { ++s->fault_ok; }
    else { ++s->normal_ok; }
    logged = s->port.record(s->port.context, s, "slot_end");
    s->last_finish_ms = s->port.now_ms(s->port.context);
    if (logged != MC_OK) { s->last_result = logged; }
    if (s->last_result != MC_OK) { (void)finish(s, MC_MIX_ERROR); }
    else if (s->completed == s->config.total) { (void)finish(s, MC_MIX_DONE); }
}

void mc_mix_tick(mc_mixed_t *s)
{
    int result;
    if (s == NULL || s->state != MC_MIX_RUNNING) { return; }
    if (s->waiting) {
        result = s->port.poll_slot(s->port.context);
        if (result != MC_MIX_PENDING) { complete(s, result); }
        return;
    }
    if (s->completed != 0U &&
        (uint32_t)(s->port.now_ms(s->port.context) - s->last_finish_ms) < s->config.gap_ms) { return; }
    s->index = s->completed + 1U;
    s->is_fault = (uint8_t)choose_fault(s);
    s->dispatch_ms = s->port.now_ms(s->port.context); s->started_ms = 0U; s->ended_ms = 0U;
    s->last_result = MC_OK;
    result = s->port.record(s->port.context, s, "slot_begin");
    if (result != MC_OK) { s->last_result = result; (void)finish(s, MC_MIX_ERROR); return; }
    if (s->is_fault) { ++s->fault_attempts; }
    s->started_ms = s->port.now_ms(s->port.context);
    result = s->port.start_slot(s->port.context, s);
    if (result == MC_MIX_PENDING) { s->waiting = 1U; }
    else { complete(s, result); }
}

int mc_mix_stop(mc_mixed_t *s)
{
    if (s == NULL) { return MC_ERR_ARGUMENT; }
    if (s->state != MC_MIX_RUNNING) { return s->held ? mc_mix_recover(s) : MC_OK; }
    if (s->waiting) {
        ++s->cancelled; s->waiting = 0U;
        s->last_result = MC_ERR_BUSY; s->ended_ms = s->port.now_ms(s->port.context);
    } else { s->last_result = MC_ERR_BUSY; }
    return finish(s, MC_MIX_STOPPED);
}

int mc_mix_recover(mc_mixed_t *s)
{
    if (s == NULL) { return MC_ERR_ARGUMENT; }
    if (s->state == MC_MIX_RUNNING) { return mc_mix_stop(s); }
    if (!s->held) { return MC_OK; }
    return finish(s, MC_MIX_ERROR);
}

static int number(const char **cursor, uint32_t *out)
{
    const char *p = *cursor;
    uint32_t n = 0U;
    while (*p == ' ') { ++p; }
    if (*p < '0' || *p > '9') { return MC_ERR_ARGUMENT; }
    do {
        uint32_t digit = (uint32_t)(*p - '0');
        if (n > (0xffffffffU - digit) / 10U) { return MC_ERR_ARGUMENT; }
        n = n * 10U + digit; ++p;
    } while (*p >= '0' && *p <= '9');
    if (*p != '\0' && *p != ' ') { return MC_ERR_ARGUMENT; }
    *out = n; *cursor = p; return MC_OK;
}

int mc_mix_parse(const char *args, mc_mix_config_t *config)
{
    static const char *const names[] = {"normal", "once", "every", "random"};
    mc_mix_config_t value;
    const char *p = args;
    uint32_t fault;
    unsigned int i;
    if (p == NULL || config == NULL) { return MC_ERR_ARGUMENT; }
    memset(&value, 0, sizeof(value)); value.seed = 1U;
    if (number(&p, &fault) != MC_OK || fault >= MC_FAULT_COUNT ||
        number(&p, &value.total) != MC_OK || number(&p, &value.gap_ms) != MC_OK) { return MC_ERR_ARGUMENT; }
    while (*p == ' ') { ++p; }
    for (i = 0U; i < 4U; ++i) {
        size_t len = strlen(names[i]);
        if (strncmp(p, names[i], len) == 0 && p[len] == ' ') { p += len; break; }
    }
    if (i == 4U || number(&p, &value.value) != MC_OK) { return MC_ERR_ARGUMENT; }
    value.mode = (mc_mix_mode_t)i; value.fault = (mc_fault_id_t)fault;
    while (*p == ' ') { ++p; }
    if (*p != '\0') {
        if (value.mode != MC_MIX_RANDOM || number(&p, &value.seed) != MC_OK) { return MC_ERR_ARGUMENT; }
        while (*p == ' ') { ++p; }
    }
    if (*p != '\0') { return MC_ERR_ARGUMENT; }
    /* start() owns range validation; parsing does not change a live session. */
    *config = value; return MC_OK;
}

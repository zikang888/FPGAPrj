#include "mc_mixed.h"
#include <stdio.h>
#include <string.h>

#define CHECK(c) do { if (!(c)) { fprintf(stderr, "FAIL line %d: %s\n", __LINE__, #c); return 1; } } while (0)
typedef struct {
    uint32_t now, calls, faults, cancels, ends, positions[10000];
    int pending, result, restore, log_fail;
} fixture_t;
static uint32_t now(void *ctx) { return ((fixture_t *)ctx)->now; }
static int start(void *ctx, const mc_mixed_t *s)
{
    fixture_t *f = ctx;
    ++f->calls;
    if (s->is_fault) { f->positions[f->faults++] = s->index; }
    f->now += 7U; /* variable real operation duration */
    return f->pending ? MC_MIX_PENDING : f->result;
}
static int poll(void *ctx) { fixture_t *f = ctx; return f->pending ? MC_MIX_PENDING : f->result; }
static int cancel(void *ctx) { fixture_t *f = ctx; ++f->cancels; return f->restore; }
static int record(void *ctx, const mc_mixed_t *s, const char *phase)
{
    fixture_t *f = ctx; (void)s;
    if (strcmp(phase, "end") == 0) { ++f->ends; }
    return f->log_fail ? MC_ERR_IO : MC_OK;
}
static void init(mc_mixed_t *s, fixture_t *f)
{
    mc_mix_port_t port;
    memset(f, 0, sizeof(*f)); memset(&port, 0, sizeof(port)); port.context = f;
    port.now_ms = now; port.start_slot = start; port.poll_slot = poll; port.cancel = cancel; port.record = record;
    mc_mix_init(s, &port);
}
static void drain(mc_mixed_t *s, fixture_t *f)
{
    unsigned int limit = 30000U;
    while (s->state == MC_MIX_RUNNING && limit-- != 0U) { mc_mix_tick(s); f->now += s->config.gap_ms; }
}
int main(void)
{
    fixture_t f, other;
    mc_mixed_t s, copy;
    mc_mix_config_t c = {MC_FAULT_SPI_PARTIAL, MC_MIX_ONCE, 1000U, 100U, 500U, 1U};
    const mc_fault_id_t ids[] = {MC_FAULT_SPI_PARTIAL, MC_FAULT_SPI_SHORT, MC_FAULT_SPI_EXTRA,
        MC_FAULT_UART_BAD_STOP, MC_FAULT_UART_BREAK, MC_FAULT_UART_MISSING_BYTES, MC_FAULT_I2C_ADDRESS_NACK, MC_FAULT_I2C_NO_STOP,
        MC_FAULT_CAN_STUFF, MC_FAULT_CAN_CRC, MC_FAULT_CAN_FORM};
    unsigned int i;
    for (i = 0U; i < sizeof(ids)/sizeof(ids[0]); ++i) {
        init(&s, &f); c.fault = ids[i]; CHECK(mc_mix_start(&s, &c) == MC_OK); drain(&s, &f);
        CHECK(s.state == MC_MIX_DONE && !s.held && f.calls == 1000U && f.faults == 1U && f.positions[0] == 500U);
        CHECK(s.normal_ok == 999U && s.fault_ok == 1U && s.failed == 0U && f.ends == 1U);
    }
    c.mode = MC_MIX_EVERY; c.value = 100U; init(&s, &f);
    CHECK(mc_mix_start(&s, &c) == MC_OK); drain(&s, &f);
    CHECK(f.faults == 10U && s.planned_faults == 10U);
    for (i = 0U; i < 10U; ++i) { CHECK(f.positions[i] == (i+1U)*100U); }
    c.mode = MC_MIX_RANDOM; c.value = 5U; c.seed = 987654321U;
    init(&s, &f); init(&copy, &other);
    CHECK(mc_mix_start(&s, &c) == MC_OK && mc_mix_start(&copy, &c) == MC_OK);
    drain(&s, &f); drain(&copy, &other);
    CHECK(f.faults == 5U && memcmp(f.positions, other.positions, sizeof(f.positions)) == 0);
    for (i = 1U; i < f.faults; ++i) { CHECK(f.positions[i] > f.positions[i-1U]); }
    c.value = 1000U; init(&s, &f); CHECK(mc_mix_start(&s, &c) == MC_OK); drain(&s, &f);
    CHECK(f.faults == 1000U);
    c.mode = MC_MIX_NORMAL; c.value = 0U; init(&s, &f);
    f.now = 0xfffffff0U; CHECK(mc_mix_start(&s, &c) == MC_OK); mc_mix_tick(&s);
    CHECK(f.calls == 1U); f.now += 99U; mc_mix_tick(&s); CHECK(f.calls == 1U);
    ++f.now; mc_mix_tick(&s); CHECK(f.calls == 2U); /* wrap and completion-relative gap */
    f.now += 60000U; mc_mix_tick(&s); CHECK(f.calls == 3U);
    mc_mix_tick(&s); CHECK(f.calls == 3U); /* no catch-up burst */
    CHECK(mc_mix_start(&s, &c) == MC_ERR_BUSY);
    CHECK(mc_mix_stop(&s) == MC_ERR_BUSY && s.state == MC_MIX_STOPPED && !s.held);
    init(&s, &f); f.pending = 1; CHECK(mc_mix_start(&s, &c) == MC_OK); mc_mix_tick(&s);
    CHECK(s.waiting && s.completed == 0U); mc_mix_tick(&s); CHECK(f.calls == 1U);
    f.pending = 0; mc_mix_tick(&s); CHECK(s.completed == 1U);
    f.now += 100U; f.pending = 1; mc_mix_tick(&s);
    f.restore = MC_ERR_IO; CHECK(mc_mix_stop(&s) == MC_ERR_IO && s.held && s.cancelled == 1U);
    CHECK(f.cancels == 1U && s.state == MC_MIX_ERROR);
    CHECK(mc_mix_start(&s, &c) == MC_ERR_BUSY);
    CHECK(mc_mix_recover(&s) == MC_ERR_IO && s.held);
    f.restore = MC_OK; (void)mc_mix_recover(&s); CHECK(!s.held);
    init(&s, &f); f.result = MC_ERR_TIMEOUT; CHECK(mc_mix_start(&s, &c) == MC_OK); mc_mix_tick(&s);
    CHECK(s.state == MC_MIX_ERROR && s.completed == 1U && s.failed == 1U && !s.held);
    init(&s, &f); f.log_fail = 1; CHECK(mc_mix_start(&s, &c) == MC_ERR_IO && f.calls == 0U && !s.held);
    init(&s, &f); CHECK(mc_mix_start(&s, &c) == MC_OK); f.log_fail = 1; mc_mix_tick(&s);
    CHECK(f.calls == 0U && s.state == MC_MIX_ERROR); /* no unlogged transmission */
    CHECK(mc_mix_parse("0 1000 100 once 500", &c) == MC_OK && mc_mix_validate(&c) == MC_OK);
    CHECK(mc_mix_parse("18 1000 100 random 5 4294967295", &c) == MC_OK && c.seed == 0xffffffffU);
    CHECK(mc_mix_parse("0 1000 100 once 500 junk", &c) == MC_ERR_ARGUMENT);
    CHECK(mc_mix_parse("0 1000 100 random 5 4294967296", &c) == MC_ERR_ARGUMENT);
    CHECK(mc_mix_parse("0 1000 100 once -1", &c) == MC_ERR_ARGUMENT);
    CHECK(mc_mix_parse("0 1000 100 normal 0", &c) == MC_OK);
    c.total = 0U; CHECK(mc_mix_validate(&c) == MC_ERR_ARGUMENT);
    c.total = 10001U; CHECK(mc_mix_validate(&c) == MC_ERR_ARGUMENT);
    c.total = 1000U; c.gap_ms = 99U; CHECK(mc_mix_validate(&c) == MC_ERR_ARGUMENT);
    c.gap_ms = 100U; c.seed = 0U; CHECK(mc_mix_validate(&c) == MC_ERR_ARGUMENT);
    c.seed = 1U; c.fault = MC_FAULT_CAN_BIT; CHECK(mc_mix_validate(&c) == MC_ERR_ARGUMENT);
    CHECK(mc_mix_stop(NULL) == MC_ERR_ARGUMENT && mc_mix_recover(NULL) == MC_ERR_ARGUMENT);
    puts("Mixed scheduler: 11 faults, normal/once/every/random, exact random count, stop/restore, timing, logging and parser PASS");
    return 0;
}

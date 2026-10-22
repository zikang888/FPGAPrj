#include "mc_can_session.h"

#include <stdio.h>
#include <string.h>

#define CHECK(x) do { if (!(x)) { \
    fprintf(stderr, "check failed: %s:%d: %s\n", __FILE__, __LINE__, #x); return 1; \
} } while (0)

typedef struct {
    unsigned int begins, sends, cancels, restores, logs;
    int begin_result, submit_result, tx_result, rx_result, restore_result, log_result;
    int cancel_result, backend_error;
    uint32_t bitrate[16];
    mc_can_mode_t modes[16];
    uint8_t tx[8];
    uint8_t lec;
    int bad_rx;
    uint32_t esr;
    mc_can_frame_t last;
} fake_t;

static int begin(void *p, mc_can_mode_t mode)
{
    fake_t *f = p;
    (void)mode;
    ++f->begins;
    return f->begin_result;
}
static int submit(void *p, mc_can_mode_t mode, uint32_t bitrate, const uint8_t tx[8])
{
    fake_t *f = p;
    if (f->sends < 16U) { f->bitrate[f->sends] = bitrate; f->modes[f->sends] = mode; }
    ++f->sends;
    memcpy(f->tx, tx, 8U);
    return f->submit_result;
}
static int poll_tx(void *p, mc_can_evidence_t *e)
{
    fake_t *f = p;
    e->first_lec = f->lec;
    e->esr = f->esr;
    e->backend_error = f->backend_error;
    return f->tx_result;
}
static int poll_rx(void *p, uint8_t rx[8], mc_can_evidence_t *e)
{
    fake_t *f = p;
    (void)e;
    memcpy(rx, f->tx, 8U);
    if (f->bad_rx) { rx[7] ^= 1U; }
    return f->rx_result;
}
static int cancel(void *p, mc_can_evidence_t *e)
{
    fake_t *f = p;
    ++f->cancels;
    e->first_lec = f->lec;
    e->esr = f->esr;
    return f->cancel_result;
}
static int restore(void *p)
{
    fake_t *f = p;
    ++f->restores;
    return f->restore_result;
}
static int record(void *p, const mc_can_frame_t *frame)
{
    fake_t *f = p;
    ++f->logs;
    f->last = *frame;
    return f->log_result;
}
static void setup(mc_can_session_t *s, fake_t *f)
{
    mc_can_session_port_t port;
    memset(f, 0, sizeof(*f));
    memset(&port, 0, sizeof(port));
    port.context = f; port.begin = begin; port.submit = submit;
    port.poll_tx = poll_tx; port.poll_rx = poll_rx; port.cancel = cancel;
    port.restore = restore; port.record = record;
    mc_can_session_init(s, &port);
}
static mc_can_config_t config(mc_can_mode_t mode, uint32_t count)
{
    mc_can_config_t c;
    c.mode = mode; c.count = count; c.period_ms = 50U;
    c.timeout_ms = 25U; c.every = 2U;
    c.bitrate = 500000U;
    return c;
}

static int scheduling(void)
{
    mc_can_session_t s;
    fake_t f;
    mc_can_config_t c = config(MC_CAN_BITRATE, 3U);
    setup(&s, &f);
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    CHECK(mc_can_session_start(&s, &c) == MC_ERR_BUSY);
    CHECK(f.begins == 1U);
    mc_can_session_tick(&s, 100U); /* one submit per tick */
    CHECK(f.sends == 1U && s.submitted == 1U);
    mc_can_session_tick(&s, 101U);
    mc_can_session_tick(&s, 149U);
    CHECK(f.sends == 1U);
    mc_can_session_tick(&s, 150U);
    mc_can_session_tick(&s, 151U);
    mc_can_session_tick(&s, 10000U); /* delayed scheduler must not burst catch-up */
    CHECK(f.sends == 3U);
    mc_can_session_tick(&s, 10001U);
    CHECK(s.state == MC_CAN_DONE && !s.held);
    CHECK(s.completed == 3U && s.passed == 3U && s.fault_slots == 1U);
    CHECK(f.bitrate[0] == 500000U && f.bitrate[1] == 250000U && f.bitrate[2] == 500000U);
    CHECK(f.logs == 3U && f.restores == 1U && f.last.tx[7] == 3U);
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    CHECK(s.run == 2U && s.completed == 0U);
    CHECK(mc_can_session_stop(&s) == MC_OK && s.state == MC_CAN_STOPPED);
    setup(&s, &f);
    c = config(MC_CAN_RAW_CRC, 3U); c.bitrate = 125000U;
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0U); mc_can_session_tick(&s, 1U);
    mc_can_session_tick(&s, 50U); mc_can_session_tick(&s, 51U);
    mc_can_session_tick(&s, 100U); mc_can_session_tick(&s, 101U);
    CHECK(s.state == MC_CAN_DONE && s.fault_slots == 1U);
    CHECK(f.modes[0] == MC_CAN_RAW_VALID && f.modes[1] == MC_CAN_RAW_CRC &&
          f.modes[2] == MC_CAN_RAW_VALID && f.bitrate[1] == 125000U);
    c.bitrate = 250000U;
    CHECK(mc_can_session_start(&s, &c) == MC_ERR_ARGUMENT);
    return 0;
}

static int ack_and_echo(void)
{
    mc_can_session_t s;
    fake_t f;
    mc_can_config_t c = config(MC_CAN_NO_ACK, 1U);
    setup(&s, &f);
    f.tx_result = MC_ERR_IO; f.lec = 3U;
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0U); mc_can_session_tick(&s, 1U);
    CHECK(s.passed == 1U && f.last.transport_result == MC_ERR_IO && f.last.result == MC_OK);
    setup(&s, &f); f.tx_result = MC_ERR_IO; f.lec = 1U;
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0U); mc_can_session_tick(&s, 1U);
    CHECK(s.failed == 1U); /* other errors are not ACK evidence */
    setup(&s, &f); f.lec = 3U; /* a successful TX must not pass a no-ACK test */
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0U); mc_can_session_tick(&s, 1U);
    CHECK(s.failed == 1U);
    c = config(MC_CAN_ECHO, 1U);
    setup(&s, &f);
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0U); mc_can_session_tick(&s, 1U); mc_can_session_tick(&s, 2U);
    CHECK(s.passed == 1U && f.last.rx_valid);
    setup(&s, &f); f.bad_rx = 1;
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0U); mc_can_session_tick(&s, 1U); mc_can_session_tick(&s, 2U);
    CHECK(s.failed == 1U && s.last_result == MC_ERR_VERIFY);
    return 0;
}

static int failures_and_cleanup(void)
{
    mc_can_session_t s;
    fake_t f;
    mc_can_config_t c = config(MC_CAN_NORMAL, 2U);
    setup(&s, &f); f.tx_result = MC_CAN_PENDING;
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0xfffffff0U);
    mc_can_session_tick(&s, 8U); CHECK(s.completed == 0U);
    mc_can_session_tick(&s, 9U);
    CHECK(s.failed == 1U && f.cancels == 1U && f.last.transport_result == MC_ERR_TIMEOUT);
    CHECK(mc_can_session_stop(&s) == MC_OK && f.restores == 1U);
    setup(&s, &f); f.tx_result = MC_CAN_PENDING;
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0U);
    CHECK(mc_can_session_stop(&s) == MC_OK);
    CHECK(f.cancels == 1U && f.logs == 1U && f.last.result == MC_ERR_BUSY);
    CHECK(s.completed == 0U && !s.held);
    setup(&s, &f); f.log_result = MC_ERR_IO;
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0U); mc_can_session_tick(&s, 1U);
    CHECK(s.state == MC_CAN_ERROR && !s.held && f.restores == 1U);
    setup(&s, &f); f.restore_result = MC_ERR_IO;
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    CHECK(mc_can_session_stop(&s) == MC_ERR_IO && s.held);
    CHECK(mc_can_session_start(&s, &c) == MC_ERR_BUSY);
    f.restore_result = MC_OK;
    CHECK(mc_can_session_recover(&s) == MC_OK && !s.held);
    setup(&s, &f); f.begin_result = MC_ERR_UNSUPPORTED;
    CHECK(mc_can_session_start(&s, &c) == MC_ERR_UNSUPPORTED && !s.held);
    CHECK(f.sends == 0U && f.restores == 1U);
    setup(&s, &f); f.submit_result = MC_ERR_IO;
    c.count = 1U;
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0U);
    CHECK(s.state == MC_CAN_ERROR && !s.held && !f.last.submitted);
    CHECK(f.restores == 1U);
    setup(&s, &f); f.tx_result = MC_CAN_PENDING; f.cancel_result = MC_ERR_IO;
    f.lec = 3U; c = config(MC_CAN_NO_ACK, 1U);
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0U); mc_can_session_tick(&s, 25U);
    CHECK(s.state == MC_CAN_ERROR && s.failed == 1U && f.last.cancel_result == MC_ERR_IO);
    setup(&s, &f); f.backend_error = MC_ERR_IO;
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0U); mc_can_session_tick(&s, 1U);
    CHECK(s.state == MC_CAN_ERROR && s.failed == 1U);
    c = config(MC_CAN_ECHO, 1U);
    setup(&s, &f); f.rx_result = MC_CAN_PENDING;
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0U); mc_can_session_tick(&s, 1U); mc_can_session_tick(&s, 25U);
    CHECK(s.state == MC_CAN_DONE && s.last_result == MC_ERR_TIMEOUT && s.failed == 1U);
    setup(&s, &f); f.esr = 4U; /* BOFF stops the run, even if transport reports OK */
    CHECK(mc_can_session_start(&s, &c) == MC_OK);
    mc_can_session_tick(&s, 0U); mc_can_session_tick(&s, 1U);
    CHECK(s.state == MC_CAN_ERROR && f.restores == 1U);
    return 0;
}

static int parsing(void)
{
    mc_can_config_t c;
    const char *const invalid[] = {
        "normal 0 100", "normal -1 100", "normal 10001 100", "normal 1 49",
        "normal 1 60001", "normal 99999999999999999999 100", "normal 1 100 extra",
        "bitrate 1 100 0", "bitrate 1 100 2x", "normal 1 100 2", "normal 1", "normalx 1 100"
    };
    size_t i;
    CHECK(mc_can_session_parse("normal 100 100", &c) == MC_OK && c.timeout_ms == 40U);
    CHECK(mc_can_session_parse("bitrate 100 50 20", &c) == MC_OK && c.every == 20U);
    CHECK(mc_can_session_parse("bitrate 100 100", &c) == MC_OK && c.every == 20U);
    for (i = 0U; i < sizeof(invalid) / sizeof(invalid[0]); ++i) {
        CHECK(mc_can_session_parse(invalid[i], &c) == MC_ERR_ARGUMENT);
    }
    return 0;
}

int main(void)
{
    CHECK(scheduling() == 0);
    CHECK(ack_and_echo() == 0);
    CHECK(failures_and_cleanup() == 0);
    CHECK(parsing() == 0);
    puts("CAN session scheduling, evidence, ownership and cleanup tests passed");
    return 0;
}

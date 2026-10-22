#include "mc_can_raw.h"
#include <stdio.h>
#include <string.h>

#define CHECK(x) do { if (!(x)) { \
    fprintf(stderr, "check failed: %s:%d: %s\n", __FILE__, __LINE__, #x); return 1; \
} } while (0)

/* Independent polynomial long division: valid message + received CRC has zero remainder. */
static uint16_t polynomial_remainder(const uint8_t *bits, size_t length)
{
    uint8_t work[98];
    size_t i;
    unsigned int j;
    memcpy(work, bits, length);
    for (i = 0U; i + 15U < length; ++i) {
        if (work[i]) {
            for (j = 0U; j <= 15U; ++j) {
                work[i + j] ^= (uint8_t)((0xc599U >> (15U - j)) & 1U);
            }
        }
    }
    {
        uint16_t value = 0U;
        for (i = length - 15U; i < length; ++i) { value = (uint16_t)((value << 1) | work[i]); }
        return value;
    }
}

/* Decode precisely the stuffed prefix, reporting the first bad stuff position. */
static int unstuff(const mc_can_raw_wave_t *wave, uint8_t *raw, size_t *length)
{
    uint8_t previous = 2U, count = 0U;
    uint16_t i;
    *length = 0U;
    for (i = 0U; i < wave->stuffed_end; ++i) {
        uint8_t bit = wave->bits[i];
        if (count == 5U) {
            if (bit == previous) { return (int)i; }
            previous = bit; count = 1U;
            continue;
        }
        if (*length >= 98U) { return -2; }
        raw[(*length)++] = bit;
        count = bit == previous ? (uint8_t)(count + 1U) : 1U;
        previous = bit;
    }
    return count == 5U ? -2 : -1;
}

static int waves(void)
{
    uint8_t data[8] = {0U}, raw[98], vector[72];
    const uint8_t check[] = "123456789";
    size_t n, i;
    unsigned int mode, length, pattern;
    mc_can_raw_wave_t w;
    for (i = 0U; i < 72U; ++i) { vector[i] = (uint8_t)((check[i / 8U] >> (7U - i % 8U)) & 1U); }
    CHECK(mc_can_crc15_bits(vector, 72U) == 0x059eU);
    for (length = 0U; length <= 8U; ++length) {
        for (pattern = 0U; pattern < 4U; ++pattern) {
            memset(data, pattern == 0U ? 0 : (pattern == 1U ? 255 : (pattern == 2U ? 0x55 : 0xaa)), sizeof(data));
            for (mode = MC_CAN_RAW_VALID; mode <= MC_CAN_RAW_FORM; ++mode) {
                int fault;
                int built = mc_can_raw_build((mc_can_mode_t)mode, 0x321U, data, length, &w);
                /* Some arbitrary payloads contain no inserted stuff bit to corrupt. */
                if (mode == MC_CAN_RAW_STUFF && built == MC_ERR_VERIFY) {
                    CHECK(w.fault_bit == MC_CAN_RAW_NO_FAULT && unstuff(&w, raw, &n) == -1);
                    CHECK(polynomial_remainder(raw, n) == 0U);
                    continue;
                }
                CHECK(built == MC_OK);
                CHECK(w.count < MC_CAN_RAW_MAX_BITS && w.bits[0] == 0U);
                for (i = w.count - 16U; i < w.count; ++i) { CHECK(w.bits[i] == 1U); }
                fault = unstuff(&w, raw, &n);
                if (mode == MC_CAN_RAW_STUFF) {
                    CHECK(fault == (int)w.fault_bit);
                    continue;
                }
                CHECK(fault == -1 && n == 19U + length * 8U + 15U);
                CHECK(raw[0] == 0U && raw[12] == 0U && raw[13] == 0U && raw[14] == 0U);
                {
                    unsigned int id = 0U, dlc = 0U;
                    for (i = 1U; i <= 11U; ++i) { id = (id << 1) | raw[i]; }
                    for (i = 15U; i < 19U; ++i) { dlc = (dlc << 1) | raw[i]; }
                    CHECK(id == 0x321U && dlc == length);
                    for (i = 0U; i < length * 8U; ++i) {
                        CHECK(raw[19U + i] == ((data[i / 8U] >> (7U - i % 8U)) & 1U));
                    }
                }
                CHECK((polynomial_remainder(raw, n) == 0U) == (mode != MC_CAN_RAW_CRC));
                CHECK(w.bits[w.stuffed_end] == 1U && w.bits[w.stuffed_end + 1U] == 1U);
                CHECK(w.bits[w.stuffed_end + 2U] == (mode == MC_CAN_RAW_FORM ? 0U : 1U));
                if (mode == MC_CAN_RAW_VALID) { CHECK(w.fault_bit == MC_CAN_RAW_NO_FAULT); }
            }
        }
    }
    CHECK(mc_can_raw_build(MC_CAN_RAW_VALID, 0x800U, data, 8U, &w) == MC_ERR_ARGUMENT);
    CHECK(mc_can_raw_build(MC_CAN_RAW_VALID, 1U, data, 9U, &w) == MC_ERR_ARGUMENT);
    CHECK(mc_can_raw_build(MC_CAN_NORMAL, 1U, data, 8U, &w) == MC_ERR_ARGUMENT);
    CHECK(mc_can_raw_build(MC_CAN_RAW_VALID, 1U, NULL, 1U, &w) == MC_ERR_ARGUMENT);
    /* Fixed run/frame payload always has a stuff opportunity in frame's high bytes. */
    for (i = 1U; i <= 10000U; ++i) {
        memset(data, 0x55, 4U);
        data[4] = 0U; data[5] = 0U; data[6] = (uint8_t)(i >> 8); data[7] = (uint8_t)i;
        CHECK(mc_can_raw_build(MC_CAN_RAW_STUFF, 0x321U, data, 8U, &w) == MC_OK);
    }
    return 0;
}

static int parser(void)
{
    mc_can_config_t c;
    const char *const bad[] = {"crc 250000 1 100", "crc 500000 0 100", "form 125000 1 49",
        "stuff 500000 1 100 0", "crc 500000 -1 100", "valid 500000 1 100 extra",
        "crc 999999999999999999999 1 100", "crc 500000 1 100 2 extra"};
    size_t i;
    CHECK(mc_can_raw_parse("crc 500000 100 100 20", &c) == MC_OK);
    CHECK(c.mode == MC_CAN_RAW_CRC && c.every == 20U && c.timeout_ms == 20U);
    CHECK(mc_can_raw_parse("valid 125000 1 50", &c) == MC_OK && c.every == 1U);
    for (i = 0U; i < sizeof(bad) / sizeof(bad[0]); ++i) {
        CHECK(mc_can_raw_parse(bad[i], &c) == MC_ERR_ARGUMENT);
    }
    return 0;
}

int main(void)
{
    CHECK(waves() == 0); CHECK(parser() == 0);
    puts("RAW CRC reference, independent decoder, faults, bounds and parser: PASS");
    return 0;
}

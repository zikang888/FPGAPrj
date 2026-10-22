#include "mc_can_raw.h"

#include <string.h>

uint16_t mc_can_crc15_bits(const uint8_t *bits, size_t count)
{
    uint16_t crc = 0U;
    size_t i;
    for (i = 0U; i < count; ++i) {
        uint16_t feedback = (uint16_t)(((crc >> 14) ^ bits[i]) & 1U);
        crc = (uint16_t)((crc << 1) & 0x7fffU);
        if (feedback) { crc ^= 0x4599U; }
    }
    return crc;
}

static void field_bits(uint8_t *raw, size_t *used, uint32_t value, unsigned int width)
{
    while (width != 0U) { --width; raw[(*used)++] = (uint8_t)((value >> width) & 1U); }
}

int mc_can_raw_build(mc_can_mode_t mode, uint32_t id,
                     const uint8_t *data, size_t length, mc_can_raw_wave_t *wave)
{
    uint8_t raw[98];
    size_t used = 0U, payload_end, i;
    uint16_t first_stuff = MC_CAN_RAW_NO_FAULT;
    uint16_t crc_last_wire = MC_CAN_RAW_NO_FAULT;
    uint8_t previous = 2U, run = 0U;
    if (wave == NULL || (unsigned int)mode < MC_CAN_RAW_VALID ||
        (unsigned int)mode > MC_CAN_RAW_FORM || id > 0x7ffU || length > 8U ||
        (length != 0U && data == NULL)) { return MC_ERR_ARGUMENT; }
    memset(wave, 0, sizeof(*wave));
    wave->fault_bit = MC_CAN_RAW_NO_FAULT;
    field_bits(raw, &used, 0U, 1U); /* SOF */
    field_bits(raw, &used, id, 11U);
    field_bits(raw, &used, 0U, 3U); /* RTR, IDE, r0 */
    field_bits(raw, &used, (uint32_t)length, 4U);
    for (i = 0U; i < length; ++i) { field_bits(raw, &used, data[i], 8U); }
    payload_end = used;
    wave->crc = mc_can_crc15_bits(raw, payload_end);
    field_bits(raw, &used, mode == MC_CAN_RAW_CRC ? wave->crc ^ 1U : wave->crc, 15U);
    for (i = 0U; i < used; ++i) {
        uint8_t bit = raw[i];
        if (wave->count + 2U >= MC_CAN_RAW_MAX_BITS) { return MC_ERR_IO; }
        if (i == used - 1U) { crc_last_wire = wave->count; }
        wave->bits[wave->count++] = bit;
        run = bit == previous ? (uint8_t)(run + 1U) : 1U;
        previous = bit;
        if (run == 5U) {
            if (first_stuff == MC_CAN_RAW_NO_FAULT) { first_stuff = wave->count; }
            wave->bits[wave->count++] = (uint8_t)(bit ^ 1U);
            previous = (uint8_t)(bit ^ 1U);
            run = 1U;
        }
    }
    wave->stuffed_end = wave->count;
    /* CRC delimiter, released ACK slot, ACK delimiter, EOF(7), IFS(3), guard(16). */
    if (wave->count + 29U > MC_CAN_RAW_MAX_BITS) { return MC_ERR_IO; }
    for (i = 0U; i < 29U; ++i) { wave->bits[wave->count++] = 1U; }
    if (mode == MC_CAN_RAW_CRC) { wave->fault_bit = crc_last_wire; }
    if (mode == MC_CAN_RAW_STUFF) {
        if (first_stuff == MC_CAN_RAW_NO_FAULT) { return MC_ERR_VERIFY; }
        wave->bits[first_stuff] ^= 1U;
        wave->fault_bit = first_stuff;
    }
    if (mode == MC_CAN_RAW_FORM) {
        wave->fault_bit = (uint16_t)(wave->stuffed_end + 2U);
        wave->bits[wave->fault_bit] = 0U;
    }
    return MC_OK;
}

static int number(const char **cursor, uint32_t *value)
{
    uint32_t n = 0U;
    const char *p = *cursor;
    while (*p == ' ') { ++p; }
    if (*p < '0' || *p > '9') { return MC_ERR_ARGUMENT; }
    do {
        n = n * 10U + (uint32_t)(*p++ - '0');
        if (n > 500000U) { return MC_ERR_ARGUMENT; }
    } while (*p >= '0' && *p <= '9');
    if (*p != ' ' && *p != '\0') { return MC_ERR_ARGUMENT; }
    *cursor = p; *value = n;
    return MC_OK;
}

int mc_can_raw_parse(const char *args, mc_can_config_t *config)
{
    static const char *const modes[] = {"valid", "crc", "stuff", "form"};
    mc_can_config_t value;
    const char *cursor;
    unsigned int i;
    if (args == NULL || config == NULL) { return MC_ERR_ARGUMENT; }
    for (i = 0U; i < 4U; ++i) {
        size_t length = strlen(modes[i]);
        if (strncmp(args, modes[i], length) == 0 && args[length] == ' ') { break; }
    }
    if (i == 4U) { return MC_ERR_ARGUMENT; }
    memset(&value, 0, sizeof(value));
    value.mode = (mc_can_mode_t)(MC_CAN_RAW_VALID + i);
    cursor = args + strlen(modes[i]);
    if (number(&cursor, &value.bitrate) != MC_OK ||
        number(&cursor, &value.count) != MC_OK || number(&cursor, &value.period_ms) != MC_OK) {
        return MC_ERR_ARGUMENT;
    }
    value.every = 1U;
    while (*cursor == ' ') { ++cursor; }
    if (*cursor != '\0' && number(&cursor, &value.every) != MC_OK) { return MC_ERR_ARGUMENT; }
    while (*cursor == ' ') { ++cursor; }
    if (*cursor != '\0' || (value.bitrate != 125000U && value.bitrate != 500000U) ||
        value.count == 0U || value.count > 10000U || value.period_ms < 50U ||
        value.period_ms > 60000U || value.every == 0U || value.every > 60000U) {
        return MC_ERR_ARGUMENT;
    }
    value.timeout_ms = 20U; /* max wire time <2ms; bounded DMA completion watchdog */
    *config = value;
    return MC_OK;
}

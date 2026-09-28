#include "mc_truth_log.h"

#include <stdio.h>
#include <string.h>

#define MC_LOG_BUFFER_SIZE 640U

static int append_text(char *buffer, size_t capacity, size_t *used, const char *text)
{
    size_t length;

    if (buffer == NULL || used == NULL || text == NULL || *used >= capacity) {
        return MC_ERR_ARGUMENT;
    }

    length = strlen(text);
    if (length >= capacity - *used) {
        return MC_ERR_IO;
    }

    memcpy(buffer + *used, text, length);
    *used += length;
    buffer[*used] = '\0';
    return MC_OK;
}

static int append_hex(char *buffer, size_t capacity, size_t *used,
                      const uint8_t *data, size_t length)
{
    static const char digits[] = "0123456789ABCDEF";
    size_t index;

    if (length != 0U && data == NULL) {
        return MC_ERR_ARGUMENT;
    }
    if (*used >= capacity || length > (capacity - *used - 1U) / 2U) {
        return MC_ERR_IO;
    }
    for (index = 0U; index < length; ++index) {
        buffer[(*used)++] = digits[data[index] >> 4];
        buffer[(*used)++] = digits[data[index] & 0x0FU];
    }
    buffer[*used] = '\0';
    return MC_OK;
}

int mc_truth_log_write(const mc_platform_t *platform, const mc_log_record_t *record)
{
    char line[MC_LOG_BUFFER_SIZE];
    char fragment[96];
    size_t used = 0U;
    uint32_t now_ms = 0U;
    int count;

    if (platform == NULL || record == NULL || platform->write_log == NULL ||
        record->protocol == NULL || record->operation == NULL ||
        record->direction == NULL || record->detail == NULL ||
        (record->data_length != 0U && record->data == NULL) ||
        (record->tx_length != 0U && record->tx_data == NULL)) {
        return MC_ERR_ARGUMENT;
    }

    if (platform->now_ms != NULL) {
        now_ms = platform->now_ms(platform->context);
    }

    count = snprintf(line,
                     sizeof(line),
                     "{\"seq\":%lu,\"ms\":%lu,\"case\":%lu,\"txn\":%lu,"
                     "\"protocol\":\"%s\",\"op\":\"%s\",\"dir\":\"%s\",\"data\":\"",
                     (unsigned long)record->sequence,
                     (unsigned long)now_ms,
                     (unsigned long)record->case_id,
                     (unsigned long)record->transaction_id,
                     record->protocol,
                     record->operation,
                     record->direction);
    if (count < 0 || (size_t)count >= sizeof(line)) {
        return MC_ERR_IO;
    }
    used = (size_t)count;

    if (append_hex(line, sizeof(line), &used, record->data,
                   record->data_length) != MC_OK) {
        return MC_ERR_IO;
    }
    if (record->tx_data != NULL) {
        if (append_text(line, sizeof(line), &used, "\",\"tx\":\"") != MC_OK ||
            append_hex(line, sizeof(line), &used, record->tx_data,
                       record->tx_length) != MC_OK) {
            return MC_ERR_IO;
        }
    }

    count = snprintf(fragment,
                     sizeof(fragment),
                     "\",\"result\":%d,\"detail\":\"%s\"}\r\n",
                     record->result,
                     record->detail);
    if (count < 0 || (size_t)count >= sizeof(fragment) ||
        append_text(line, sizeof(line), &used, fragment) != MC_OK) {
        return MC_ERR_IO;
    }

    return platform->write_log(platform->context, line, used);
}

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

int mc_truth_log_write(const mc_platform_t *platform, const mc_log_record_t *record)
{
    char line[MC_LOG_BUFFER_SIZE];
    char fragment[96];
    size_t used = 0U;
    size_t index;
    uint32_t now_ms = 0U;
    int count;

    if (platform == NULL || record == NULL || platform->write_log == NULL ||
        record->protocol == NULL || record->operation == NULL ||
        record->direction == NULL || record->detail == NULL) {
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

    for (index = 0U; index < record->data_length; ++index) {
        count = snprintf(fragment, sizeof(fragment), "%02X", record->data[index]);
        if (count != 2 || append_text(line, sizeof(line), &used, fragment) != MC_OK) {
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

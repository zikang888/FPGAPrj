#ifndef TEST_HISTORY_H_
#define TEST_HISTORY_H_
#include <stdint.h>
#include <string.h>
#include "error_model.h"
#define TEST_HISTORY_CAPACITY 8U
#define TEST_HISTORY_EVENTS 256U
typedef struct {
    uint32_t id, protocol, duration_ms, total_events, error_count, external_loss;
    uint32_t count, trigger_index, data_count;
    uint8_t overwritten, snapshot_valid;
    ErrorModel errors;
    uint32_t words[TEST_HISTORY_EVENTS][4];
} TestHistoryEntry;
typedef struct {
    TestHistoryEntry entry[TEST_HISTORY_CAPACITY];
    uint32_t count, next;
} TestHistory;
static inline TestHistoryEntry *test_history_append(TestHistory *history)
{
    TestHistoryEntry *out = &history->entry[history->next];
    memset(out, 0, sizeof(*out));
    history->next = (history->next + 1U) % TEST_HISTORY_CAPACITY;
    if (history->count < TEST_HISTORY_CAPACITY) ++history->count;
    return out;
}
static inline const TestHistoryEntry *test_history_get(const TestHistory *history,
                                                       uint32_t newest_index)
{
    if (history == 0 || newest_index >= history->count) return 0;
    return &history->entry[(history->next + TEST_HISTORY_CAPACITY - 1U -
                           newest_index) % TEST_HISTORY_CAPACITY];
}
#endif

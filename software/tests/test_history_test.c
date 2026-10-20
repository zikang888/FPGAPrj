#include <assert.h>
#include "../src/test_history.h"
#include "../src/event_diagnostics.h"
static TestHistory history;
int main(void)
{
    uint32_t i;
    char label[8];
    uint32_t words[4][4] = {
        {1U,0x20000000U,0U,0U}, {0x02000001U,0x20C1FF9FU,1U,0U},
        {0x02000001U,0x20C1EF00U,2U,0U}, {1U,0x20C20000U,3U,0U}
    };
    for (i = 1U; i <= 10U; ++i) {
        TestHistoryEntry *r = test_history_append(&history);
        r->id = i; r->error_count = i; r->words[0][0] = i;
    }
    assert(history.count == 8U && test_history_get(&history,0)->id == 10U);
    assert(test_history_get(&history,7)->id == 3U);
    assert(test_history_get(&history,8) == 0);
    assert(test_history_get(&history,1)->words[0][0] == 9U);
    assert(event_diagnostic_label(&words[0][0],4U,3U,label));
    assert(strcmp(label,"SHORT") == 0);
    assert(!event_diagnostic_label(&words[1][0],3U,2U,label));
    words[0][1] = 0x103F0100U;
    assert(event_diagnostic_label(&words[0][0],1U,0U,label));
    assert(strcmp(label,"BADSTOP") == 0);
    words[0][1] = 0x103F0200U;
    assert(event_diagnostic_label(&words[0][0],1U,0U,label));
    assert(strcmp(label,"BREAK") == 0);
    return 0;
}

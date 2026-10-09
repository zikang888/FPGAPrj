#include <assert.h>
#include <stdint.h>

#include "../src/ui_counter_semantics.h"

int main(void)
{
    /* A frozen one-shot snapshot rejects later events, but this is not
     * producer-side loss and must not turn platform health red. */
    assert(ui_counter_health_ok(0U));
    assert(!ui_counter_health_ok(1U));
    assert(!ui_counter_health_ok(6000U));

    assert(!ui_counter_changed(0U, 0U, 0U, 0U));
    assert(ui_counter_changed(0U, 0U, 6000U, 0U));
    assert(ui_counter_changed(6000U, 0U, 6000U, 1U));

    assert(!ui_counter_poll_due(499U, 0U, 500U));
    assert(ui_counter_poll_due(500U, 0U, 500U));
    assert(ui_counter_poll_due(2U, UINT64_MAX - 2U, 4U));
    return 0;
}

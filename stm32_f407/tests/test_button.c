#include "mc_button.h"
#include <stdio.h>

#define CHECK(c) do { if (!(c)) { fprintf(stderr, "FAIL line %d: %s\n", __LINE__, #c); return 1; } } while (0)

int main(void)
{
    mc_button_t b;
    unsigned int i;
    mc_button_init(&b, 0, 0U);
    CHECK(mc_button_poll(&b, 1, 10U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 20U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 100U) == MC_BUTTON_NONE); /* short noise ignored */
    CHECK(mc_button_poll(&b, 1, 110U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 115U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 120U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 149U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 150U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 190U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 195U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 200U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 229U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 230U) == MC_BUTTON_SHORT);
    CHECK(mc_button_poll(&b, 0, 1000U) == MC_BUTTON_NONE);

    CHECK(mc_button_poll(&b, 1, 1100U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 1130U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 1600U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 1605U) == MC_BUTTON_NONE); /* held key glitch */
    CHECK(mc_button_poll(&b, 1, 1899U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 1900U) == MC_BUTTON_LONG);
    for (i = 0U; i < 100U; ++i) {
        uint32_t now = 2000U + i * 40U;
        CHECK(mc_button_poll(&b, 0, now) == MC_BUTTON_NONE);
        CHECK(mc_button_poll(&b, 0, now + 29U) == MC_BUTTON_NONE);
        CHECK(mc_button_poll(&b, 1, now + 30U) == MC_BUTTON_NONE);
        CHECK(mc_button_poll(&b, 1, now + 39U) == MC_BUTTON_NONE);
    }
    CHECK(mc_button_poll(&b, 0, 6100U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 6130U) == MC_BUTTON_NONE); /* no short after long */
    CHECK(mc_button_poll(&b, 1, 6200U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 6230U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 6280U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 6310U) == MC_BUTTON_SHORT); /* rearmed */

    mc_button_init(&b, 1, 0U);
    CHECK(mc_button_poll(&b, 1, 5000U) == MC_BUTTON_NONE); /* boot held */
    CHECK(mc_button_poll(&b, 0, 5100U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 5110U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 6000U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 6100U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 6130U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 6200U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 7000U) == MC_BUTTON_LONG);

    mc_button_init(&b, 0, 0xffffff00U);
    CHECK(mc_button_poll(&b, 1, 0xffffff10U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 0xffffff2eU) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 1, 0x00000230U) == MC_BUTTON_LONG); /* tick wrap */
    CHECK(mc_button_poll(&b, 0, 0x240U) == MC_BUTTON_NONE);
    CHECK(mc_button_poll(&b, 0, 0x25eU) == MC_BUTTON_NONE);
    puts("Button debounce, release latch, single long, boot hold and tick wrap PASS");
    return 0;
}

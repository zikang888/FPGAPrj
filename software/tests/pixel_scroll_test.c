#include "../src/pixel_scroll.h"
#include <stdio.h>

#define CHECK(actual, expected) do { \
    unsigned int value = (actual); \
    if (value != (expected)) { \
        printf("FAIL line %d: got %u expected %u\n", \
               __LINE__, value, (unsigned int)(expected)); \
        return 1; \
    } \
} while (0)

int main(void)
{
    unsigned int offset = 175U;
    unsigned int maximum = pixel_scroll_max(25U, 35U, 286U);
    CHECK(pixel_scroll_max(0U, 35U, 286U), 0U);
    CHECK(pixel_scroll_max(8U, 35U, 286U), 0U);
    CHECK(maximum, 589U);
    CHECK(pixel_scroll_max(256U, 35U, 286U), 8674U);

    offset = pixel_scroll_drag(offset, 200, 195, maximum);
    CHECK(offset, 180U); /* A five-pixel move is visible, not a page jump. */
    CHECK(offset / 35U, 5U);
    CHECK(offset % 35U, 5U);
    offset = pixel_scroll_drag(offset, 195, 198, maximum);
    CHECK(offset, 177U); /* Reversal follows immediately. */
    offset = pixel_scroll_drag(offset, 198, 20, maximum);
    CHECK(offset, 355U); /* One long drag crosses several rows. */
    offset = pixel_scroll_drag(offset, 20, -400, maximum);
    CHECK(offset, maximum); /* Stable lower boundary. */
    CHECK(offset / 35U, 16U);
    CHECK(offset % 35U, 29U);
    offset = pixel_scroll_drag(offset, 10, 700, maximum);
    CHECK(offset, 0U); /* Stable upper boundary. */
    offset = pixel_scroll_drag(offset, 300, 265, maximum);
    CHECK(offset, 35U); /* Repeated gesture after a boundary. */
    CHECK(pixel_scroll_drag(0U, 220, 180, 0U), 0U);
    puts("pixel_scroll_test PASS");
    return 0;
}

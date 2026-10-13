#include <assert.h>
#include <stdint.h>
#include "../src/spi_trace.h"

int main(void)
{
    const uint32_t words[6][4] = {
        {0x000000E3U, 0x20C00000U, 0U, 0U},
        {0x020000E3U, 0x20C1FF9FU, 1U, 0U},
        {0x020000E3U, 0x20C1EF00U, 2U, 0U},
        {0x020000E3U, 0x20C14000U, 3U, 0U},
        {0x020000E3U, 0x20C11800U, 4U, 0U},
        {0x000000E3U, 0x20C20000U, 5U, 0U}
    };
    uint32_t broken[6][4];
    SpiTrace trace;
    unsigned int i;
    unsigned int j;
    assert(spi_trace_extract(&words[0][0], 6U, &trace));
    assert(trace.transaction_id == 0xE3U && trace.count == 4U);
    assert(trace.mosi[0] == 0x9FU && trace.mosi[1] == 0U);
    assert(trace.miso[0] == 0xFFU && trace.miso[1] == 0xEFU);
    assert(trace.miso[2] == 0x40U && trace.miso[3] == 0x18U);
    assert(!spi_trace_extract(&words[0][0], 5U, &trace));
    for (i = 0U; i < 6U; ++i)
        for (j = 0U; j < 4U; ++j) broken[i][j] = words[i][j];
    broken[3][0] = 0x020000E4U;
    assert(!spi_trace_extract(&broken[0][0], 6U, &trace));
    broken[3][0] = words[3][0];
    broken[3][1] = 0x20C1FFFFU;
    broken[3][0] = 0x010000E3U;
    assert(!spi_trace_extract(&broken[0][0], 6U, &trace));
    return 0;
}

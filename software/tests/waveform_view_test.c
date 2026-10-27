#include <assert.h>
#include "../src/waveform_view.h"
int main(void)
{
    uint32_t words[7][4]={{7,0x20000000,0,0},
        {0x02000007,0x2001FF9F,1,0},{0x02000007,0x2001EF00,2,0},
        {7,0x20020000,3,0},{0},{0},{0}};
    WaveSpi trace;
    assert(wave_spi_extract(&words[0][0],4,&trace));
    assert(trace.count==2 && trace.total==2 && trace.closed);
    assert(trace.mosi[0]==0x9F && trace.miso[1]==0xEF);
    /* A partial byte reports only its residual bit count; no byte invented. */
    words[1][0]=7;words[1][1]=0x203F0004;
    assert(wave_spi_extract(&words[0][0],2,&trace));
    assert(trace.count==0 && trace.partial_bits==4 && !trace.closed);
    /* Every decoded length spans the same viewport, including a single ACK. */
    assert(wave_x(0,9)==144 && wave_x(9,9)==752);
    assert(wave_x(36,36)==752 && wave_x(64,64)==752);
    assert(wave_x(8,9)<wave_x(9,9));
    /* Capture tail without START must not be treated as a whole transaction. */
    assert(!wave_spi_extract(&words[1][0],1,&trace));
    return 0;
}

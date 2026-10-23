#include <assert.h>
#include <string.h>
#include "../src/protocol_trace.h"

static void put(uint32_t words[][4], uint32_t index, uint8_t protocol,
                uint8_t type, uint16_t flags, uint32_t transaction)
{
    words[index][0] = (type == 1U ? 0x01000000U : 0U) | transaction;
    words[index][1] = ((uint32_t)protocol << 28) |
                      ((uint32_t)type << 16) | flags;
    words[index][2] = index * 100U;
    words[index][3] = 0U;
}

int main(void)
{
    uint32_t words[12][4];
    I2cTrace i2c;
    CanTrace can;
    memset(words,0,sizeof(words));
    put(words,0U,3U,0U,0U,7U);
    put(words,1U,3U,1U,0x40A0U,7U);
    put(words,2U,3U,1U,0x0000U,7U);
    put(words,3U,3U,1U,0x8001U,7U);
    put(words,4U,3U,2U,0U,7U);
    assert(i2c_trace_extract(&words[0][0],5U,&i2c));
    assert(i2c.transaction_id==7U && i2c.count==3U);
    assert(i2c.data[0]==0xA0U && i2c.data[2]==0x01U);
    assert(i2c.nack[0]==0U && i2c.nack[2]==1U);
    assert(!i2c_trace_extract(&words[0][0],4U,&i2c));

    memset(words,0,sizeof(words));
    put(words,0U,4U,0U,0U,9U);
    put(words,1U,4U,1U,0x0012U,9U);
    put(words,2U,4U,1U,0x0134U,9U);
    put(words,3U,4U,1U,0x0256U,9U);
    put(words,4U,4U,1U,0x0378U,9U);
    put(words,5U,4U,2U,0x4321U,9U);
    assert(can_trace_extract(&words[0][0],6U,&can));
    assert(can.transaction_id==9U && can.identifier==0x321U);
    assert(can.dlc==4U && can.count==4U);
    assert(can.data[0]==0x12U && can.data[3]==0x78U);
    words[5][1] = (4U << 28) | (2U << 16) | 0x5321U;
    assert(!can_trace_extract(&words[0][0],6U,&can));
    return 0;
}

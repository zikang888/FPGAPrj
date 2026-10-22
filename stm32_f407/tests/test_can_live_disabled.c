#include "mc_can_live_hal.h"
#include <assert.h>
int main(void)
{
    mc_can_live_hal_t c;
    CAN_HandleTypeDef can;
    UART_HandleTypeDef uart;
    mc_can_session_t s;
    mc_can_config_t cfg;
    mc_can_session_port_t p=mc_can_live_hal_port(&c,&can,&uart);
    assert(mc_can_live_parse("bit 1 100",&cfg)==MC_OK);
    mc_can_session_init(&s,&p);
    assert(mc_can_session_start(&s,&cfg)==MC_ERR_UNSUPPORTED && !s.held);
    return 0;
}

#include "mc_can_raw_hal.h"
#include <assert.h>

int main(void)
{
    mc_can_raw_hal_t raw;
    CAN_HandleTypeDef can;
    UART_HandleTypeDef uart;
    mc_can_session_t session;
    mc_can_config_t config;
    mc_can_session_port_t port = mc_can_raw_hal_port(&raw, &can, &uart);
    assert(mc_can_raw_parse("crc 500000 1 100", &config) == MC_OK);
    mc_can_session_init(&session, &port);
    assert(mc_can_session_start(&session, &config) == MC_ERR_UNSUPPORTED);
    assert(!session.held && port.begin == 0 && port.submit == 0);
    return 0;
}

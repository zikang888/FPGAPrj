#include <assert.h>
#include <string.h>
#include "../src/ui_workflow.h"

int main(void)
{
    PlatformUiStatus s;
    ErrorCode codes[6];
    const char *labels[6];
    unsigned int n;
    memset(&s,0,sizeof(s));
    s.selected_protocol=UI_PROTOCOL_I2C;
    assert(strcmp(ui_test_result(&s),"NOT SUPPORTED")==0);
    s.capabilities=0x1FFU;
    assert(strcmp(ui_test_result(&s),"NO TEST YET")==0);
    s.test_id=1U;s.test_running=1U;
    assert(strcmp(ui_test_result(&s),"WAITING FOR DATA")==0);
    s.test_running=0U;
    assert(strcmp(ui_test_result(&s),"NO DATA RECEIVED")==0);
    s.test_events=20U;
    (void)error_model_report(&s.error_model,ERROR_I2C_BUSY_NACK,ERROR_ORIGIN_PL,16U);
    assert(strcmp(ui_test_result(&s),"NO ERRORS DETECTED")==0);
    (void)error_model_report(&s.error_model,ERROR_I2C_ADDRESS_NACK,ERROR_ORIGIN_PL,1U);
    assert(strcmp(ui_test_result(&s),"ERRORS FOUND")==0);
    s.test_failed=1U;
    assert(strcmp(ui_test_result(&s),"CAPTURE FAILED")==0);
    n=ui_error_catalog(UI_PROTOCOL_I2C,codes,labels);
    assert(n==3U && codes[0]==ERROR_I2C_ADDRESS_NACK &&
           codes[1]==ERROR_I2C_BUSY_NACK && codes[2]==ERROR_I2C_MISSING_STOP);
    assert(strstr(labels[1],"INFO")!=0);
    n=ui_error_catalog(UI_PROTOCOL_CAN,codes,labels);
    assert(n==4U && codes[0]==ERROR_CAN_ACK && codes[1]==ERROR_CAN_STUFF &&
           codes[2]==ERROR_CAN_CRC && codes[3]==ERROR_CAN_BUS_OFF);
    assert(strstr(labels[3],"STM32")!=0);
    assert(ui_error_catalog(UI_PROTOCOL_COUNT,codes,labels)==0U);
    return 0;
}

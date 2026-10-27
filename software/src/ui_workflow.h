#ifndef UI_WORKFLOW_H_
#define UI_WORKFLOW_H_

#include "platform_ui.h"

/* Capability means implemented logic, not verified wiring or a passing test. */
static inline const char *ui_test_result(const PlatformUiStatus *s)
{
    if (!ui_protocol_live(s->selected_protocol,s->capabilities)) return "NOT SUPPORTED";
    if (s->test_failed) return "CAPTURE FAILED";
    if (s->test_id == 0U) return "NO TEST YET";
    if (s->test_events == 0U) return s->test_running ? "WAITING FOR DATA" : "NO DATA RECEIVED";
    if (s->external_loss_count || error_model_has_fault(&s->error_model)) return "ERRORS FOUND";
    return s->test_running ? "RECORDING" : "NO ERRORS DETECTED";
}

static inline unsigned int ui_error_catalog(UiProtocol protocol,
                                           ErrorCode *codes,
                                           const char **labels)
{
    static const ErrorCode ids[4][6] = {
        {ERROR_SPI_PARTIAL_BYTE,ERROR_SPI_SHORT_TRANSACTION,ERROR_SPI_EXTRA_BYTES,
         ERROR_SPI_RESPONSE_MISMATCH,ERROR_CODE_COUNT,ERROR_CODE_COUNT},
        {ERROR_UART_STOP_BIT,ERROR_UART_BREAK,ERROR_UART_SHORT_TRANSACTION,
         ERROR_UART_PARITY,ERROR_UART_BAUD_MISMATCH,ERROR_CODE_COUNT},
        {ERROR_I2C_ADDRESS_NACK,ERROR_I2C_BUSY_NACK,ERROR_I2C_MISSING_STOP,
         ERROR_CODE_COUNT,ERROR_CODE_COUNT,ERROR_CODE_COUNT},
        {ERROR_CAN_ACK,ERROR_CAN_STUFF,ERROR_CAN_CRC,
         ERROR_CAN_BUS_OFF,ERROR_CODE_COUNT,ERROR_CODE_COUNT}
    };
    static const char *const names[4][6] = {
        {"INCOMPLETE BYTE","TOO FEW BYTES","TOO MANY BYTES","WRONG FLASH ID",
         "",""},
        {"BAD STOP BIT","RX HELD LOW","TOO FEW BYTES","PARITY (NOT 8N1)",
         "BAUD (NOT MEASURED)",""},
        {"DEVICE DID NOT ACK","EEPROM BUSY (INFO)","STOP NOT RECEIVED",
         "","",""},
        {"NO ACK RECEIVED","BIT STUFFING","CRC CHECK FAILED",
         "BUS-OFF (STM32 ONLY)","",""}
    };
    unsigned int i, n;
    if ((unsigned int)protocol >= UI_PROTOCOL_COUNT) return 0U;
    n = protocol == UI_PROTOCOL_I2C ? 3U : protocol == UI_PROTOCOL_UART ? 5U : 4U;
    for (i=0U;i<n;++i) { codes[i]=ids[protocol][i]; labels[i]=names[protocol][i]; }
    return n;
}

static inline const char *ui_error_advice(const PlatformUiStatus *s)
{
    if (s->test_failed) return "CHECK MATCHED BIT / ELF, THEN START A NEW TEST";
    if (s->test_id == 0U) return "OPEN TESTS > START NEW; THEN SEND DATA FROM STM32";
    if (s->test_events == 0U) return "NO DATA: CHECK PROTOCOL, WIRING AND STM32 TRANSMISSION";
    if (s->external_loss_count) return "EVENTS WERE LOST: LOWER TRAFFIC AND REPEAT THIS TEST";
    if (s->selected_protocol == UI_PROTOCOL_I2C) {
        if (s->i2c_address_nacks) return "CHECK EEPROM POWER, ADDRESS 0x50 AND SDA/SCL WIRING";
        if (s->i2c_missing_stop) return "STOP WAS NOT SEEN; CHECK EVENTS FOR THE LAST BYTE";
        if (s->i2c_busy_nacks) return "EEPROM WRITE BUSY IS INFORMATION, NOT A FAILED TEST";
    } else if (s->selected_protocol == UI_PROTOCOL_CAN) {
        if (s->can_ack_errors) return "CHECK PEER POWER, 500 KBIT/S, TERMINATION AND ACK MODE";
        if (error_model_has_fault(&s->error_model)) return "CHECK CAN H/L, COMMON GROUND, BITRATE AND FAULT MODE";
        return "BUS-OFF NEEDS STM32 STATUS; IT IS NOT A ZERO HERE";
    } else if (s->selected_protocol == UI_PROTOCOL_UART) {
        if (s->uart_break_errors) return "CHECK RX FOR A SHORT TO GROUND OR AN ACTIVE BREAK TEST";
        if (s->uart_stop_errors) return "CHECK 115200 / 8N1, COMMON GROUND AND SIGNAL QUALITY";
        if (s->uart_short_transactions) return "REPEAT WITH THE EXPECTED NUMBER OF UART BYTES";
        return "RX MONITOR ONLY; A CLEAN RX DOES NOT PROVE UART ECHO";
    } else {
        if (s->spi_response_mismatches) return "CHECK FLASH POWER / MISO; EXPECT JEDEC EF 40 18";
        if (s->spi_short_transactions || s->spi_extra_bytes) return "JEDEC TEST EXPECTS 9F FOLLOWED BY THREE CLOCKED BYTES";
        if (s->spi_frame_errors) return "CHECK CS TIMING; EACH BYTE NEEDS EIGHT CLOCKS";
    }
    return "REVIEW EVENTS FOR BYTE DETAILS; SAVED TESTS ARE IN HISTORY";
}

#endif

#ifndef PLATFORM_UI_H_
#define PLATFORM_UI_H_

#include "xil_types.h"
#include "capture_demo.h"
#include "error_model.h"
#include "ui_protocol_select.h"
#include "test_history.h"

typedef enum {
    PLATFORM_UI_PAGE_HOME = 0,
    PLATFORM_UI_PAGE_SELF_TEST = 1,
    PLATFORM_UI_PAGE_EVENTS = 2,
    PLATFORM_UI_PAGE_ERRORS = 3,
    PLATFORM_UI_PAGE_HISTORY = 4
} PlatformUiPage;

typedef enum {
    PLATFORM_UI_ACTION_NONE = 0,
    PLATFORM_UI_ACTION_HOME,
    PLATFORM_UI_ACTION_SELF_TEST,
    PLATFORM_UI_ACTION_EVENTS,
    PLATFORM_UI_ACTION_ERRORS,
    PLATFORM_UI_ACTION_CAPTURE_LIVE,
    /* One-shot triggered capture used by the HOME waveform panel.  Keep it
     * separate from CAPTURE_LIVE, which starts a bounded test session. */
    PLATFORM_UI_ACTION_CAPTURE_HOME,
    PLATFORM_UI_ACTION_END_TEST,
    PLATFORM_UI_ACTION_HISTORY,
    PLATFORM_UI_ACTION_SELECT_SPI,
    PLATFORM_UI_ACTION_SELECT_UART,
    PLATFORM_UI_ACTION_SELECT_I2C,
    PLATFORM_UI_ACTION_SELECT_CAN
} PlatformUiAction;

typedef struct {
    u32 id;
    u32 version;
    u32 capabilities;
    u32 scratch;
    u32 core_rejected_count;
    u32 external_loss_count;
    u32 spi_frame_errors;
    u32 spi_boundary_errors;
    u32 spi_duplicates;
    u32 spi_sequence_errors;
    u32 spi_short_transactions;
    u32 spi_extra_bytes;
    u32 spi_response_mismatches;
    u32 uart_event_count;
    u32 uart_data_count;
    u32 uart_stop_errors;
    u32 uart_break_errors;
    u32 uart_short_transactions;
    u32 i2c_event_count;
    u32 i2c_data_count;
    u32 i2c_address_nacks;
    u32 i2c_busy_nacks;
    u32 i2c_sda_stuck;
    u32 i2c_scl_stuck;
    u32 i2c_missing_stop;
    u32 can_event_count;
    u32 can_frame_count;
    u32 can_ack_errors;
    u32 can_bit_errors;
    u32 can_stuff_errors;
    u32 can_crc_errors;
    u32 can_form_errors;
    u32 can_bus_off;
    u32 arbitration_count;
    u32 test_id;
    u32 test_events;
    u32 test_errors;
    u8 test_running;
    u8 test_failed;
    u8 retained_tail;
    ErrorModel error_model;
    u8 id_ok;
    u8 version_ok;
    u8 scratch_ok;
    u8 touch_ok;
    u8 capture_ok;
    u8 led_on;
    /* 0: demo/no session, 1: recording, 2: saved real session. */
    u8 capture_source;
    UiProtocol selected_protocol;
} PlatformUiStatus;

int platform_ui_init(void);
void platform_ui_set_event_cache(const CaptureDemoCache *cache);
void platform_ui_set_history(const TestHistory *history);
void platform_ui_tick(void);
void platform_ui_update_counters(const PlatformUiStatus *status);
void platform_ui_render_page(PlatformUiPage page,
                             const PlatformUiStatus *status,
                             const CaptureDemoSnapshot *snapshot);
PlatformUiAction platform_ui_poll_action(void);

/* Compatibility entry points retained for existing callers. */
void platform_ui_render(u32 id, u32 version, u32 scratch, u8 led_on, u8 touch_ok);
void platform_ui_render_capture(const CaptureDemoSnapshot *snapshot,
                                u8 led_on, u8 touch_ok);
u8 platform_ui_poll_led_button(void);

#endif

#ifndef PLATFORM_UI_H_
#define PLATFORM_UI_H_

#include "xil_types.h"
#include "capture_demo.h"

typedef enum {
    PLATFORM_UI_PAGE_HOME = 0,
    PLATFORM_UI_PAGE_SELF_TEST = 1,
    PLATFORM_UI_PAGE_EVENTS = 2
} PlatformUiPage;

typedef enum {
    PLATFORM_UI_ACTION_NONE = 0,
    PLATFORM_UI_ACTION_HOME,
    PLATFORM_UI_ACTION_SELF_TEST,
    PLATFORM_UI_ACTION_EVENTS,
    PLATFORM_UI_ACTION_LED_TOGGLE
} PlatformUiAction;

typedef struct {
    u32 id;
    u32 version;
    u32 capabilities;
    u32 scratch;
    u32 dropped_count;
    u32 ext_dropped_count;
    u32 arbitration_count;
    u8 id_ok;
    u8 version_ok;
    u8 scratch_ok;
    u8 touch_ok;
    u8 capture_ok;
    u8 led_on;
} PlatformUiStatus;

int platform_ui_init(void);
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

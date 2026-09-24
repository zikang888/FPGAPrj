#ifndef PLATFORM_UI_H_
#define PLATFORM_UI_H_

#include "xil_types.h"
#include "capture_demo.h"

int platform_ui_init(void);
void platform_ui_render(u32 id, u32 version, u32 scratch, u8 led_on, u8 touch_ok);
void platform_ui_render_capture(const CaptureDemoSnapshot *snapshot,
                                u8 led_on, u8 touch_ok);
u8 platform_ui_poll_led_button(void);

#endif

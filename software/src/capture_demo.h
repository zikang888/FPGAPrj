#ifndef CAPTURE_DEMO_H_
#define CAPTURE_DEMO_H_

#include "xil_types.h"

#define CAPTURE_DISPLAY_EVENTS 8U

typedef struct {
    u32 snapshot_id;
    u32 count;
    u32 trigger_index;
    u32 first_index;
    u32 dropped_count;
    u32 transaction_id[CAPTURE_DISPLAY_EVENTS];
    u32 event_word[CAPTURE_DISPLAY_EVENTS][4];
    u8 shown;
} CaptureDemoSnapshot;

int capture_demo_run(CaptureDemoSnapshot *snapshot);
int capture_demo_read_window(CaptureDemoSnapshot *snapshot, u32 first_index);

#endif

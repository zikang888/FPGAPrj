#ifndef CAPTURE_DEMO_H_
#define CAPTURE_DEMO_H_

#include "xil_types.h"

#define CAPTURE_DISPLAY_EVENTS 8U

typedef struct {
    u32 snapshot_id;
    u32 count;
    u32 trigger_index;
    u32 first_index;
    u32 transaction_id[CAPTURE_DISPLAY_EVENTS];
    u8 shown;
} CaptureDemoSnapshot;

int capture_demo_run(CaptureDemoSnapshot *snapshot);

#endif

#include "capture_demo.h"

#include "xil_io.h"
#include "xil_printf.h"
#include "xparameters.h"
#include "xstatus.h"

#define CORE_BASE              XPAR_MULTI_PROTOCOL_CORE_0_BASEADDR
#define REG_CAPTURE_CTRL       (CORE_BASE + 0x1000U)
#define REG_CAPTURE_STATUS     (CORE_BASE + 0x1004U)
#define REG_SNAPSHOT_ID        (CORE_BASE + 0x1008U)
#define REG_SNAPSHOT_COUNT     (CORE_BASE + 0x100CU)
#define REG_TRIGGER_INDEX      (CORE_BASE + 0x1010U)
#define REG_DROPPED_COUNT      (CORE_BASE + 0x1014U)
#define REG_VIRTUAL_EVENT      (CORE_BASE + 0x1018U)
#define SNAPSHOT_BASE          (CORE_BASE + 0x6000U)

#define CAPTURE_STATUS_ACTIVE  0x00000001U
#define CAPTURE_STATUS_READY   0x00000002U
#define CAPTURE_CTRL_ARM       0x00000001U
#define CAPTURE_CTRL_ACK       0x00000002U
#define VIRTUAL_TRIGGER        0x80000000U
#define READY_TIMEOUT          1000000U

static u32 snapshot_word(u32 event_index, u32 word_index)
{
    return Xil_In32(SNAPSHOT_BASE + event_index * 16U + word_index * 4U);
}

int capture_demo_read_window(CaptureDemoSnapshot *snapshot, u32 first_index)
{
    u32 index;
    u32 shown;
    u32 maximum_first;

    if (snapshot == 0 || snapshot->count == 0U) return XST_FAILURE;

    maximum_first = snapshot->count > CAPTURE_DISPLAY_EVENTS ?
                    snapshot->count - CAPTURE_DISPLAY_EVENTS : 0U;
    if (first_index > maximum_first) first_index = maximum_first;
    shown = snapshot->count - first_index;
    if (shown > CAPTURE_DISPLAY_EVENTS) shown = CAPTURE_DISPLAY_EVENTS;

    snapshot->first_index = first_index;
    snapshot->shown = (u8)shown;
    for (index = 0U; index < shown; ++index) {
        snapshot->event_word[index][0] = snapshot_word(first_index + index, 0U);
        snapshot->event_word[index][1] = snapshot_word(first_index + index, 1U);
        snapshot->event_word[index][2] = snapshot_word(first_index + index, 2U);
        snapshot->event_word[index][3] = snapshot_word(first_index + index, 3U);
        snapshot->transaction_id[index] =
            snapshot->event_word[index][0] & 0x00FFFFFFU;
    }
    return XST_SUCCESS;
}

int capture_demo_run(CaptureDemoSnapshot *snapshot)
{
    u32 status;
    u32 index;
    u32 timeout;
    u32 first;
    u32 shown;

    if (snapshot == 0) return XST_FAILURE;

    Xil_Out32(REG_CAPTURE_CTRL, CAPTURE_CTRL_ACK);
    Xil_Out32(REG_CAPTURE_CTRL, CAPTURE_CTRL_ARM);
    status = Xil_In32(REG_CAPTURE_STATUS);
    if ((status & CAPTURE_STATUS_ACTIVE) == 0U) {
        xil_printf("CAPTURE ARM ERROR: 0x%08lx\r\n", (unsigned long)status);
        return XST_FAILURE;
    }

    for (index = 0U; index < 8U; ++index) {
        Xil_Out32(REG_VIRTUAL_EVENT, index);
    }
    Xil_Out32(REG_VIRTUAL_EVENT, VIRTUAL_TRIGGER | 8U);
    for (index = 9U; index < 25U; ++index) {
        Xil_Out32(REG_VIRTUAL_EVENT, index);
    }

    for (timeout = 0U; timeout < READY_TIMEOUT; ++timeout) {
        status = Xil_In32(REG_CAPTURE_STATUS);
        if ((status & CAPTURE_STATUS_READY) != 0U) break;
    }
    if ((status & CAPTURE_STATUS_READY) == 0U) {
        xil_printf("CAPTURE TIMEOUT: status=0x%08lx\r\n",
                   (unsigned long)status);
        return XST_FAILURE;
    }

    snapshot->snapshot_id = Xil_In32(REG_SNAPSHOT_ID);
    snapshot->count = Xil_In32(REG_SNAPSHOT_COUNT);
    snapshot->trigger_index = Xil_In32(REG_TRIGGER_INDEX);
    snapshot->dropped_count = Xil_In32(REG_DROPPED_COUNT);
    if (snapshot->count == 0U || snapshot->trigger_index >= snapshot->count) {
        xil_printf("CAPTURE META ERROR: id=%lu count=%lu trigger=%lu\r\n",
                   (unsigned long)snapshot->snapshot_id,
                   (unsigned long)snapshot->count,
                   (unsigned long)snapshot->trigger_index);
        return XST_FAILURE;
    }

    first = (snapshot->trigger_index >= 3U) ?
            snapshot->trigger_index - 3U : 0U;
    if (first + CAPTURE_DISPLAY_EVENTS > snapshot->count) {
        first = (snapshot->count > CAPTURE_DISPLAY_EVENTS) ?
                snapshot->count - CAPTURE_DISPLAY_EVENTS : 0U;
    }
    shown = snapshot->count - first;
    if (shown > CAPTURE_DISPLAY_EVENTS) shown = CAPTURE_DISPLAY_EVENTS;
    if (capture_demo_read_window(snapshot, first) != XST_SUCCESS) {
        xil_printf("CAPTURE WINDOW ERROR: first=%lu shown=%lu\r\n",
                   (unsigned long)first, (unsigned long)shown);
        return XST_FAILURE;
    }

    xil_printf("CAPTURE READY: id=%lu count=%lu trigger=%lu dropped=%lu\r\n",
               (unsigned long)snapshot->snapshot_id,
               (unsigned long)snapshot->count,
               (unsigned long)snapshot->trigger_index,
               (unsigned long)snapshot->dropped_count);
    /* Keep READY asserted so the frozen AXI snapshot remains readable while
     * the EVENTS page scrolls. The next capture_demo_run() acknowledges the
     * previous snapshot before issuing ARM. */
    return XST_SUCCESS;
}

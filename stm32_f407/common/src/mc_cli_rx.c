#include "mc_cli_rx.h"

void mc_cli_rx_init(mc_cli_rx_t *queue)
{
    if (queue != 0) {
        queue->head = 0U;
        queue->tail = 0U;
        queue->dropped = 0U;
    }
}

int mc_cli_rx_push(mc_cli_rx_t *queue, uint8_t value)
{
    uint16_t next;
    if (queue == 0) {
        return 0;
    }
    next = (uint16_t)((queue->head + 1U) % MC_CLI_RX_CAPACITY);
    if (next == queue->tail) {
        ++queue->dropped;
        return 0;
    }
    queue->bytes[queue->head] = value;
    queue->head = next;
    return 1;
}

int mc_cli_rx_pop(mc_cli_rx_t *queue, uint8_t *value)
{
    if (queue == 0 || value == 0 || queue->tail == queue->head) {
        return 0;
    }
    *value = queue->bytes[queue->tail];
    queue->tail = (uint16_t)((queue->tail + 1U) % MC_CLI_RX_CAPACITY);
    return 1;
}

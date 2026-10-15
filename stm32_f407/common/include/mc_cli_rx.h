#ifndef MC_CLI_RX_H
#define MC_CLI_RX_H

#include <stdint.h>

/* Single ISR producer, single main-loop consumer. One slot remains empty. */
#define MC_CLI_RX_CAPACITY 512U

typedef struct {
    volatile uint16_t head;
    volatile uint16_t tail;
    volatile uint32_t dropped;
    volatile uint8_t bytes[MC_CLI_RX_CAPACITY];
} mc_cli_rx_t;

void mc_cli_rx_init(mc_cli_rx_t *queue);
int mc_cli_rx_push(mc_cli_rx_t *queue, uint8_t value);
int mc_cli_rx_pop(mc_cli_rx_t *queue, uint8_t *value);

#endif

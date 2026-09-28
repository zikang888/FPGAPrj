#ifndef MC_PROTOCOL_RUNNER_H
#define MC_PROTOCOL_RUNNER_H

#include "mc_protocol_platform.h"

#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct {
    mc_platform_t platform;
    uint32_t next_sequence;
    uint32_t next_transaction_id;
} mc_runner_t;

typedef struct {
    uint32_t iterations;
    uint32_t passed;
    uint32_t failed;
    uint32_t first_failed_iteration;
    int first_error;
} mc_run_summary_t;

void mc_runner_init(mc_runner_t *runner, const mc_platform_t *platform);

int mc_run_spi_jedec(mc_runner_t *runner,
                     uint32_t case_id,
                     uint32_t iterations,
                     const uint8_t expected_id[3],
                     mc_run_summary_t *summary);

int mc_run_spi_patterns(mc_runner_t *runner,
                        uint32_t case_id,
                        uint32_t iterations,
                        mc_run_summary_t *summary);

int mc_run_uart_loopback(mc_runner_t *runner,
                         uint32_t case_id,
                         uint32_t iterations,
                         mc_run_summary_t *summary);

int mc_run_i2c_eeprom(mc_runner_t *runner,
                      uint32_t case_id,
                      uint8_t address_7bit,
                      uint16_t memory_address,
                      uint32_t iterations,
                      mc_run_summary_t *summary);

int mc_run_can_loopback(mc_runner_t *runner,
                        uint32_t case_id,
                        uint32_t standard_id,
                        uint32_t iterations,
                        mc_run_summary_t *summary);

int mc_run_spi_incomplete_fault(mc_runner_t *runner,
                                uint32_t case_id,
                                uint8_t value,
                                uint8_t valid_bits);

int mc_run_uart_bad_stop_fault(mc_runner_t *runner,
                               uint32_t case_id,
                               uint8_t value,
                               uint32_t baudrate);

#ifdef __cplusplus
}
#endif

#endif

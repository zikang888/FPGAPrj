#ifndef MC_PROTOCOL_PLATFORM_H
#define MC_PROTOCOL_PLATFORM_H

#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

enum {
    MC_OK = 0,
    MC_ERR_ARGUMENT = -1,
    MC_ERR_IO = -2,
    MC_ERR_TIMEOUT = -3,
    MC_ERR_VERIFY = -4,
    MC_ERR_UNSUPPORTED = -5
};

typedef struct {
    void *context;

    uint32_t (*now_ms)(void *context);
    int (*write_log)(void *context, const char *text, size_t length);

    int (*spi_select)(void *context, int selected);
    int (*spi_transfer)(void *context,
                        const uint8_t *tx,
                        uint8_t *rx,
                        size_t length,
                        uint32_t timeout_ms);

    int (*uart_write)(void *context,
                      const uint8_t *data,
                      size_t length,
                      uint32_t timeout_ms);
    int (*uart_read)(void *context,
                     uint8_t *data,
                     size_t length,
                     uint32_t timeout_ms);

    int (*i2c_mem_write)(void *context,
                         uint8_t address_7bit,
                         uint16_t memory_address,
                         const uint8_t *data,
                         size_t length,
                         uint32_t timeout_ms);
    int (*i2c_mem_read)(void *context,
                        uint8_t address_7bit,
                        uint16_t memory_address,
                        uint8_t *data,
                        size_t length,
                        uint32_t timeout_ms);
    int (*i2c_probe)(void *context, uint8_t address_7bit, uint32_t timeout_ms);

    int (*can_send)(void *context,
                    uint32_t standard_id,
                    const uint8_t *data,
                    size_t length,
                    uint32_t timeout_ms);
    int (*can_receive)(void *context,
                       uint32_t *standard_id,
                       uint8_t *data,
                       size_t *length,
                       uint32_t timeout_ms);

    /* Optional deterministic fault hooks. They must be safe and disabled by default. */
    int (*spi_emit_incomplete)(void *context, uint8_t value, uint8_t valid_bits);
    int (*uart_emit_bad_stop)(void *context, uint8_t value, uint32_t baudrate);
    int (*sync_pulse)(void *context, uint32_t case_id);
} mc_platform_t;

#ifdef __cplusplus
}
#endif

#endif

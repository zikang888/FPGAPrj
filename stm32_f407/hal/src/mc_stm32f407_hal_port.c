#include "mc_stm32f407_hal_port.h"

#include <string.h>

static int status_to_result(HAL_StatusTypeDef status)
{
    if (status == HAL_OK) {
        return MC_OK;
    }
    if (status == HAL_TIMEOUT) {
        return MC_ERR_TIMEOUT;
    }
    return MC_ERR_IO;
}

static uint32_t port_now_ms(void *opaque)
{
    (void)opaque;
    return HAL_GetTick();
}

static int port_write_log(void *opaque, const char *text, size_t length)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;

    if (context == NULL || context->debug_uart == NULL || text == NULL || length > 0xFFFFU) {
        return MC_ERR_ARGUMENT;
    }
    return status_to_result(HAL_UART_Transmit(context->debug_uart,
                                              (uint8_t *)(uintptr_t)text,
                                              (uint16_t)length,
                                              1000U));
}

static int port_spi_select(void *opaque, int selected)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;

    if (context == NULL || context->spi_cs_port == NULL) {
        return MC_ERR_ARGUMENT;
    }
    HAL_GPIO_WritePin(context->spi_cs_port,
                      context->spi_cs_pin,
                      selected != 0 ? GPIO_PIN_RESET : GPIO_PIN_SET);
    return MC_OK;
}

static int port_spi_transfer(void *opaque,
                             const uint8_t *tx,
                             uint8_t *rx,
                             size_t length,
                             uint32_t timeout_ms)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;

    if (context == NULL || context->spi == NULL || tx == NULL || rx == NULL ||
        length == 0U || length > 0xFFFFU) {
        return MC_ERR_ARGUMENT;
    }
    return status_to_result(HAL_SPI_TransmitReceive(context->spi,
                                                    (uint8_t *)(uintptr_t)tx,
                                                    rx,
                                                    (uint16_t)length,
                                                    timeout_ms));
}

static int port_uart_write(void *opaque,
                           const uint8_t *data,
                           size_t length,
                           uint32_t timeout_ms)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;

    if (context == NULL || context->test_uart == NULL || data == NULL || length > 0xFFFFU) {
        return MC_ERR_ARGUMENT;
    }
    return status_to_result(HAL_UART_Transmit(context->test_uart,
                                              (uint8_t *)(uintptr_t)data,
                                              (uint16_t)length,
                                              timeout_ms));
}

static int port_uart_read(void *opaque,
                          uint8_t *data,
                          size_t length,
                          uint32_t timeout_ms)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;

    if (context == NULL || context->test_uart == NULL || data == NULL || length > 0xFFFFU) {
        return MC_ERR_ARGUMENT;
    }
    return status_to_result(HAL_UART_Receive(context->test_uart,
                                             data,
                                             (uint16_t)length,
                                             timeout_ms));
}

static int port_i2c_mem_write(void *opaque,
                              uint8_t address_7bit,
                              uint16_t memory_address,
                              const uint8_t *data,
                              size_t length,
                              uint32_t timeout_ms)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;

    if (context == NULL || context->i2c == NULL || data == NULL || length > 0xFFFFU) {
        return MC_ERR_ARGUMENT;
    }
    return status_to_result(HAL_I2C_Mem_Write(context->i2c,
                                              (uint16_t)address_7bit << 1,
                                              memory_address,
                                              I2C_MEMADD_SIZE_16BIT,
                                              (uint8_t *)(uintptr_t)data,
                                              (uint16_t)length,
                                              timeout_ms));
}

static int port_i2c_mem_read(void *opaque,
                             uint8_t address_7bit,
                             uint16_t memory_address,
                             uint8_t *data,
                             size_t length,
                             uint32_t timeout_ms)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;

    if (context == NULL || context->i2c == NULL || data == NULL || length > 0xFFFFU) {
        return MC_ERR_ARGUMENT;
    }
    return status_to_result(HAL_I2C_Mem_Read(context->i2c,
                                             (uint16_t)address_7bit << 1,
                                             memory_address,
                                             I2C_MEMADD_SIZE_16BIT,
                                             data,
                                             (uint16_t)length,
                                             timeout_ms));
}

static int port_i2c_probe(void *opaque, uint8_t address_7bit, uint32_t timeout_ms)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;

    if (context == NULL || context->i2c == NULL) {
        return MC_ERR_ARGUMENT;
    }
    return status_to_result(HAL_I2C_IsDeviceReady(context->i2c,
                                                  (uint16_t)address_7bit << 1,
                                                  100U,
                                                  timeout_ms));
}

static int wait_for_can_mailbox(mc_stm32f407_context_t *context, uint32_t timeout_ms)
{
    uint32_t start = HAL_GetTick();

    while (HAL_CAN_GetTxMailboxesFreeLevel(context->can) == 0U) {
        if ((HAL_GetTick() - start) >= timeout_ms) {
            return MC_ERR_TIMEOUT;
        }
    }
    return MC_OK;
}

static int port_can_send(void *opaque,
                         uint32_t standard_id,
                         const uint8_t *data,
                         size_t length,
                         uint32_t timeout_ms)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;
    CAN_TxHeaderTypeDef header;
    uint32_t mailbox = 0U;
    int result;

    if (context == NULL || context->can == NULL || data == NULL ||
        standard_id > 0x7FFU || length > 8U) {
        return MC_ERR_ARGUMENT;
    }
    result = wait_for_can_mailbox(context, timeout_ms);
    if (result != MC_OK) {
        return result;
    }
    memset(&header, 0, sizeof(header));
    header.StdId = standard_id;
    header.IDE = CAN_ID_STD;
    header.RTR = CAN_RTR_DATA;
    header.DLC = (uint32_t)length;
    header.TransmitGlobalTime = DISABLE;
    return status_to_result(HAL_CAN_AddTxMessage(context->can,
                                                 &header,
                                                 (uint8_t *)(uintptr_t)data,
                                                 &mailbox));
}

static int port_can_receive(void *opaque,
                            uint32_t *standard_id,
                            uint8_t *data,
                            size_t *length,
                            uint32_t timeout_ms)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;
    CAN_RxHeaderTypeDef header;
    uint32_t start;

    if (context == NULL || context->can == NULL || standard_id == NULL ||
        data == NULL || length == NULL || *length < 8U) {
        return MC_ERR_ARGUMENT;
    }
    start = HAL_GetTick();
    while (HAL_CAN_GetRxFifoFillLevel(context->can, CAN_RX_FIFO0) == 0U) {
        if ((HAL_GetTick() - start) >= timeout_ms) {
            return MC_ERR_TIMEOUT;
        }
    }
    if (HAL_CAN_GetRxMessage(context->can, CAN_RX_FIFO0, &header, data) != HAL_OK) {
        return MC_ERR_IO;
    }
    if (header.IDE != CAN_ID_STD || header.RTR != CAN_RTR_DATA) {
        return MC_ERR_VERIFY;
    }
    *standard_id = header.StdId;
    *length = header.DLC;
    return MC_OK;
}

static int port_sync_pulse(void *opaque, uint32_t case_id)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;

    (void)case_id;
    if (context == NULL || context->sync_port == NULL || context->sync_pin == 0U) {
        return MC_OK;
    }
    HAL_GPIO_WritePin(context->sync_port, context->sync_pin, GPIO_PIN_SET);
    HAL_Delay(1U);
    HAL_GPIO_WritePin(context->sync_port, context->sync_pin, GPIO_PIN_RESET);
    return MC_OK;
}

mc_platform_t mc_stm32f407_make_platform(mc_stm32f407_context_t *context)
{
    mc_platform_t platform;

    memset(&platform, 0, sizeof(platform));
    platform.context = context;
    platform.now_ms = port_now_ms;
    platform.write_log = port_write_log;
    platform.spi_select = port_spi_select;
    platform.spi_transfer = port_spi_transfer;
    platform.uart_write = port_uart_write;
    platform.uart_read = port_uart_read;
    platform.i2c_mem_write = port_i2c_mem_write;
    platform.i2c_mem_read = port_i2c_mem_read;
    platform.i2c_probe = port_i2c_probe;
    platform.can_send = port_can_send;
    platform.can_receive = port_can_receive;
    platform.sync_pulse = port_sync_pulse;

    /* Unsafe waveform faults require board-specific GPIO code and remain disabled. */
    platform.spi_emit_incomplete = NULL;
    platform.uart_emit_bad_stop = NULL;
    return platform;
}

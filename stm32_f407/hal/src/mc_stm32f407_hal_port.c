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
                                                  1U,
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

static int cycle_timer_ready(void)
{
    CoreDebug->DEMCR |= CoreDebug_DEMCR_TRCENA_Msk;
    DWT->CYCCNT = 0U;
    DWT->CTRL |= DWT_CTRL_CYCCNTENA_Msk;
    return (DWT->CTRL & DWT_CTRL_CYCCNTENA_Msk) != 0U;
}

static void wait_cycles(uint32_t cycles)
{
    uint32_t start = DWT->CYCCNT;
    while ((uint32_t)(DWT->CYCCNT - start) < cycles) {
    }
}

static int port_spi_emit_incomplete(void *opaque, uint8_t value, uint8_t valid_bits)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;
    GPIO_InitTypeDef gpio = {0};
    uint32_t half_cycles;
    uint8_t bit;

    if (context == NULL || context->spi == NULL || valid_bits == 0U || valid_bits >= 8U ||
        HAL_SPI_GetState(context->spi) != HAL_SPI_STATE_READY || !cycle_timer_ready()) {
        return MC_ERR_ARGUMENT;
    }
    half_cycles = HAL_RCC_GetHCLKFreq() / 200000U; /* 100 kHz SCLK */
    __HAL_SPI_DISABLE(context->spi);
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_RESET);
    gpio.Pin = GPIO_PIN_5 | GPIO_PIN_7;
    gpio.Mode = GPIO_MODE_OUTPUT_PP;
    gpio.Pull = GPIO_NOPULL;
    gpio.Speed = GPIO_SPEED_FREQ_HIGH;
    HAL_GPIO_Init(GPIOA, &gpio);

    HAL_GPIO_WritePin(context->spi_cs_port, context->spi_cs_pin, GPIO_PIN_RESET);
    for (bit = 0U; bit < valid_bits; ++bit) {
        HAL_GPIO_WritePin(GPIOA, GPIO_PIN_7,
                          (value & (uint8_t)(0x80U >> bit)) != 0U ? GPIO_PIN_SET : GPIO_PIN_RESET);
        wait_cycles(half_cycles);
        HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_SET);
        wait_cycles(half_cycles);
        HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_RESET);
    }
    HAL_GPIO_WritePin(context->spi_cs_port, context->spi_cs_pin, GPIO_PIN_SET);

    gpio.Mode = GPIO_MODE_AF_PP;
    gpio.Alternate = GPIO_AF5_SPI1;
    HAL_GPIO_Init(GPIOA, &gpio);
    return MC_OK;
}

static int uart_gpio_frame(mc_stm32f407_context_t *context,
                           uint8_t value, uint32_t baudrate,
                           int bad_stop, uint32_t break_bits)
{
    GPIO_InitTypeDef gpio = {0};
    uint32_t cycles;
    uint32_t irq_state;
    uint8_t bit;

    if (context == NULL || context->test_uart == NULL || baudrate == 0U ||
        HAL_UART_GetState(context->test_uart) != HAL_UART_STATE_READY || !cycle_timer_ready()) {
        return MC_ERR_ARGUMENT;
    }
    cycles = HAL_RCC_GetHCLKFreq() / baudrate;
    if (cycles == 0U) {
        return MC_ERR_ARGUMENT;
    }
    __HAL_UART_DISABLE(context->test_uart);
    HAL_GPIO_WritePin(GPIOD, GPIO_PIN_8, GPIO_PIN_SET);
    gpio.Pin = GPIO_PIN_8;
    gpio.Mode = GPIO_MODE_OUTPUT_PP;
    gpio.Pull = GPIO_PULLUP;
    gpio.Speed = GPIO_SPEED_FREQ_HIGH;
    HAL_GPIO_Init(GPIOD, &gpio);
    irq_state = __get_PRIMASK();
    __disable_irq();
    HAL_GPIO_WritePin(GPIOD, GPIO_PIN_8, GPIO_PIN_RESET);
    if (break_bits != 0U) {
        while (break_bits-- > 0U) {
            wait_cycles(cycles);
        }
    } else {
        wait_cycles(cycles); /* start bit */
        for (bit = 0U; bit < 8U; ++bit) {
            HAL_GPIO_WritePin(GPIOD, GPIO_PIN_8,
                              (value & (uint8_t)(1U << bit)) != 0U ? GPIO_PIN_SET : GPIO_PIN_RESET);
            wait_cycles(cycles);
        }
        HAL_GPIO_WritePin(GPIOD, GPIO_PIN_8, bad_stop != 0 ? GPIO_PIN_RESET : GPIO_PIN_SET);
        wait_cycles(cycles);
    }
    HAL_GPIO_WritePin(GPIOD, GPIO_PIN_8, GPIO_PIN_SET);
    wait_cycles(cycles);
    if (irq_state == 0U) {
        __enable_irq();
    }
    gpio.Mode = GPIO_MODE_AF_PP;
    gpio.Alternate = GPIO_AF7_USART3;
    HAL_GPIO_Init(GPIOD, &gpio);
    __HAL_UART_ENABLE(context->test_uart);
    return MC_OK;
}

static int port_uart_emit_bad_stop(void *opaque, uint8_t value, uint32_t baudrate)
{
    return uart_gpio_frame((mc_stm32f407_context_t *)opaque, value, baudrate, 1, 0U);
}

static int port_uart_emit_break(void *opaque, uint32_t bit_times, uint32_t baudrate)
{
    if (bit_times < 11U || bit_times > 32U) {
        return MC_ERR_ARGUMENT;
    }
    return uart_gpio_frame((mc_stm32f407_context_t *)opaque, 0U, baudrate, 0, bit_times);
}

static int port_uart_set_baudrate(void *opaque, uint32_t baudrate)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;
    if (context == NULL || context->test_uart == NULL || baudrate < 9600U || baudrate > 230400U) {
        return MC_ERR_ARGUMENT;
    }
    context->test_uart->Init.BaudRate = baudrate;
    return status_to_result(HAL_UART_Init(context->test_uart));
}

#ifdef MC_ENABLE_I2C_FAULT_LINKS
static int port_i2c_hold_line_low(void *opaque, uint16_t pin, uint32_t duration_ms)
{
    GPIO_InitTypeDef gpio = {0};
    (void)opaque;
    if (duration_ms == 0U || duration_ms > 100U) {
        return MC_ERR_ARGUMENT;
    }
    __HAL_RCC_GPIOC_CLK_ENABLE();
    HAL_GPIO_WritePin(GPIOC, pin, GPIO_PIN_SET);
    gpio.Pin = pin;
    gpio.Mode = GPIO_MODE_OUTPUT_OD;
    gpio.Pull = GPIO_NOPULL;
    gpio.Speed = GPIO_SPEED_FREQ_LOW;
    HAL_GPIO_Init(GPIOC, &gpio);
    HAL_GPIO_WritePin(GPIOC, pin, GPIO_PIN_RESET);
    HAL_Delay(duration_ms);
    HAL_GPIO_WritePin(GPIOC, pin, GPIO_PIN_SET);
    return MC_OK;
}
static int port_i2c_hold_sda_low(void *opaque, uint32_t duration_ms)
{
    return port_i2c_hold_line_low(opaque, GPIO_PIN_7, duration_ms);
}
static int port_i2c_hold_scl_low(void *opaque, uint32_t duration_ms)
{
    return port_i2c_hold_line_low(opaque, GPIO_PIN_8, duration_ms);
}
#endif

static int port_i2c_emit_no_stop(void *opaque, uint8_t address_7bit, uint32_t hold_ms)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;
    GPIO_InitTypeDef gpio = {0};
    uint8_t address = (uint8_t)(address_7bit << 1);
    uint8_t bit;
    uint32_t half_cycles;
    if (context == NULL || context->i2c == NULL || address_7bit > 0x7FU ||
        hold_ms == 0U || hold_ms > 100U || !cycle_timer_ready()) {
        return MC_ERR_ARGUMENT;
    }
    if (HAL_I2C_GetState(context->i2c) != HAL_I2C_STATE_READY ||
        HAL_I2C_DeInit(context->i2c) != HAL_OK) {
        return MC_ERR_IO;
    }
    gpio.Pin = GPIO_PIN_6 | GPIO_PIN_7;
    gpio.Mode = GPIO_MODE_OUTPUT_OD;
    gpio.Pull = GPIO_NOPULL;
    gpio.Speed = GPIO_SPEED_FREQ_MEDIUM;
    HAL_GPIO_Init(GPIOB, &gpio);
    HAL_GPIO_WritePin(GPIOB, gpio.Pin, GPIO_PIN_SET);
    half_cycles = HAL_RCC_GetHCLKFreq() / 200000U;
    HAL_GPIO_WritePin(GPIOB, GPIO_PIN_7, GPIO_PIN_RESET); /* START */
    wait_cycles(half_cycles);
    HAL_GPIO_WritePin(GPIOB, GPIO_PIN_6, GPIO_PIN_RESET);
    for (bit = 0U; bit < 8U; ++bit) {
        HAL_GPIO_WritePin(GPIOB, GPIO_PIN_7,
                          (address & (uint8_t)(0x80U >> bit)) != 0U ? GPIO_PIN_SET : GPIO_PIN_RESET);
        wait_cycles(half_cycles);
        HAL_GPIO_WritePin(GPIOB, GPIO_PIN_6, GPIO_PIN_SET);
        wait_cycles(half_cycles);
        HAL_GPIO_WritePin(GPIOB, GPIO_PIN_6, GPIO_PIN_RESET);
    }
    HAL_GPIO_WritePin(GPIOB, GPIO_PIN_7, GPIO_PIN_SET); /* ACK clock */
    wait_cycles(half_cycles);
    HAL_GPIO_WritePin(GPIOB, GPIO_PIN_6, GPIO_PIN_SET);
    wait_cycles(half_cycles);
    HAL_GPIO_WritePin(GPIOB, GPIO_PIN_6, GPIO_PIN_RESET);
    HAL_Delay(hold_ms); /* deliberate missing STOP window */
    HAL_GPIO_WritePin(GPIOB, GPIO_PIN_7, GPIO_PIN_RESET);
    wait_cycles(half_cycles);
    HAL_GPIO_WritePin(GPIOB, GPIO_PIN_6, GPIO_PIN_SET);
    wait_cycles(half_cycles);
    HAL_GPIO_WritePin(GPIOB, GPIO_PIN_7, GPIO_PIN_SET); /* recovery STOP */
    return status_to_result(HAL_I2C_Init(context->i2c));
}

#ifdef MC_ENABLE_CAN_FAULTS
static int port_can_ack_probe(void *opaque, uint32_t standard_id, uint32_t timeout_ms)
{
    mc_stm32f407_context_t *context = (mc_stm32f407_context_t *)opaque;
    CAN_TxHeaderTypeDef header;
    uint8_t payload[1] = {0xA5U};
    uint32_t mailbox = 0U;
    uint32_t started;
    uint32_t error_bits;
    uint32_t lec;
    FunctionalState original_retry;
    int result = MC_ERR_IO;

    if (context == NULL || context->can == NULL || standard_id > 0x7FFU ||
        timeout_ms == 0U || timeout_ms > 500U) {
        return MC_ERR_ARGUMENT;
    }
    original_retry = context->can->Init.AutoRetransmission;
    if (HAL_CAN_Stop(context->can) != HAL_OK) {
        return MC_ERR_IO;
    }
    context->can->Init.AutoRetransmission = DISABLE;
    if (HAL_CAN_Init(context->can) != HAL_OK || HAL_CAN_Start(context->can) != HAL_OK) {
        result = MC_ERR_IO;
    } else {
        memset(&header, 0, sizeof(header));
        header.StdId = standard_id;
        header.IDE = CAN_ID_STD;
        header.RTR = CAN_RTR_DATA;
        header.DLC = 1U;
        if (HAL_CAN_AddTxMessage(context->can, &header, payload, &mailbox) == HAL_OK) {
            started = HAL_GetTick();
            while (HAL_CAN_IsTxMessagePending(context->can, mailbox) != 0U &&
                   (uint32_t)(HAL_GetTick() - started) < timeout_ms) {
            }
            error_bits = HAL_CAN_GetError(context->can);
            lec = (context->can->Instance->ESR & CAN_ESR_LEC) >> CAN_ESR_LEC_Pos;
            if ((error_bits & HAL_CAN_ERROR_ACK) != 0U || lec == 3U) {
                result = MC_OK; /* expected ACK error observed */
            } else if (HAL_CAN_IsTxMessagePending(context->can, mailbox) != 0U) {
                result = MC_ERR_TIMEOUT;
            } else {
                result = MC_ERR_VERIFY; /* a peer acknowledged */
            }
        }
    }
    (void)HAL_CAN_Stop(context->can);
    context->can->Init.AutoRetransmission = original_retry;
    if (HAL_CAN_Init(context->can) != HAL_OK || HAL_CAN_Start(context->can) != HAL_OK) {
        return MC_ERR_IO;
    }
    return result;
}
#endif

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

    platform.spi_emit_incomplete = port_spi_emit_incomplete;
    platform.uart_emit_bad_stop = port_uart_emit_bad_stop;
    platform.uart_emit_break = port_uart_emit_break;
    platform.uart_set_baudrate = port_uart_set_baudrate;
    platform.i2c_emit_no_stop = port_i2c_emit_no_stop;
#ifdef MC_ENABLE_I2C_FAULT_LINKS
    platform.i2c_hold_sda_low = port_i2c_hold_sda_low;
    platform.i2c_hold_scl_low = port_i2c_hold_scl_low;
#endif
    /* CAN bit/CRC/stuff/form errors require a physical bus injector. */
#ifdef MC_ENABLE_CAN_FAULTS
    platform.can_ack_probe = port_can_ack_probe;
#endif
    return platform;
}

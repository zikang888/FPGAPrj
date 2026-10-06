#include "mc_board_app.h"

#include "main.h"
#include "mc_protocol_runner.h"
#include "mc_stm32f407_hal_port.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern CAN_HandleTypeDef hcan1;
extern I2C_HandleTypeDef hi2c1;
extern SPI_HandleTypeDef hspi1;
extern UART_HandleTypeDef huart1;
extern UART_HandleTypeDef huart3;

#define MC_COMMAND_CAPACITY 64U
#define MC_DEFAULT_ITERATIONS 1U
#define MC_MAX_ITERATIONS 10000U

static mc_stm32f407_context_t g_port_context;
static mc_runner_t g_runner;
static char g_command[MC_COMMAND_CAPACITY];
static size_t g_command_length;
static GPIO_PinState g_previous_key_state;

static void console_write(const char *text)
{
    if (text != NULL) {
        (void)HAL_UART_Transmit(&huart1,
                                (uint8_t *)(uintptr_t)text,
                                (uint16_t)strlen(text),
                                1000U);
    }
}

static void print_help(void)
{
    console_write(
        "\r\nCommands:\r\n"
        "  spi jedec [count]    Read W25Q128 JEDEC ID\r\n"
        "  spi pattern [count]  Send deterministic SPI bytes\r\n"
        "  uart loop [count]    USART3 FPGA echo test\r\n"
        "  i2c eeprom [count]   AT24C256 write/read test at 0x50\r\n"
        "  can loop [count]     CAN1 frame echo test, ID 0x321\r\n"
        "  all                  Run one smoke test per protocol\r\n"
        "  help                 Show this help\r\n"
        "USER_KEY also runs one SPI JEDEC test.\r\n> ");
}

static uint32_t parse_count(const char *command)
{
    const char *cursor = strrchr(command, ' ');
    unsigned long value;

    if (cursor == NULL || cursor[1] == '\0') {
        return MC_DEFAULT_ITERATIONS;
    }
    value = strtoul(cursor + 1, NULL, 10);
    if (value == 0UL || value > MC_MAX_ITERATIONS) {
        return MC_DEFAULT_ITERATIONS;
    }
    return (uint32_t)value;
}

static void print_summary(const char *name, int result, const mc_run_summary_t *summary)
{
    char line[160];

    if (summary == NULL) {
        return;
    }
    (void)snprintf(line,
                   sizeof(line),
                   "SUMMARY protocol=%s result=%d iterations=%lu passed=%lu failed=%lu\r\n> ",
                   name,
                   result,
                   (unsigned long)summary->iterations,
                   (unsigned long)summary->passed,
                   (unsigned long)summary->failed);
    console_write(line);
    HAL_GPIO_WritePin(USER_LED_GPIO_Port,
                      USER_LED_Pin,
                      result == MC_OK ? GPIO_PIN_SET : GPIO_PIN_RESET);
}

static void run_spi_jedec(uint32_t iterations)
{
    /* W25Q128JV reference value. Replace after checking the mounted device. */
    static const uint8_t expected_id[3] = {0xEFU, 0x40U, 0x18U};
    mc_run_summary_t summary;
    int result = mc_run_spi_jedec(&g_runner, 1001U, iterations, expected_id, &summary);
    print_summary("SPI_JEDEC", result, &summary);
}

static void run_command(const char *command)
{
    mc_run_summary_t summary;
    uint32_t iterations = parse_count(command);
    int result;

    if (strcmp(command, "help") == 0) {
        print_help();
    } else if (strncmp(command, "spi jedec", 9U) == 0) {
        run_spi_jedec(iterations);
    } else if (strncmp(command, "spi pattern", 11U) == 0) {
        result = mc_run_spi_patterns(&g_runner, 1002U, iterations, &summary);
        print_summary("SPI_PATTERN", result, &summary);
    } else if (strncmp(command, "uart loop", 9U) == 0) {
        result = mc_run_uart_loopback(&g_runner, 2001U, iterations, &summary);
        print_summary("UART", result, &summary);
    } else if (strncmp(command, "i2c eeprom", 10U) == 0) {
        result = mc_run_i2c_eeprom(&g_runner, 3001U, 0x50U, 0x0100U, iterations, &summary);
        print_summary("I2C", result, &summary);
    } else if (strncmp(command, "can loop", 8U) == 0) {
        result = mc_run_can_loopback(&g_runner, 4001U, 0x321U, iterations, &summary);
        print_summary("CAN", result, &summary);
    } else if (strcmp(command, "all") == 0) {
        run_spi_jedec(1U);
        result = mc_run_uart_loopback(&g_runner, 2001U, 1U, &summary);
        print_summary("UART", result, &summary);
        result = mc_run_i2c_eeprom(&g_runner, 3001U, 0x50U, 0x0100U, 1U, &summary);
        print_summary("I2C", result, &summary);
        result = mc_run_can_loopback(&g_runner, 4001U, 0x321U, 1U, &summary);
        print_summary("CAN", result, &summary);
    } else {
        console_write("Unknown command. Type help.\r\n> ");
    }
}

static int can_start_accept_all(void)
{
    CAN_FilterTypeDef filter;

    memset(&filter, 0, sizeof(filter));
    filter.FilterBank = 0U;
    filter.FilterMode = CAN_FILTERMODE_IDMASK;
    filter.FilterScale = CAN_FILTERSCALE_32BIT;
    filter.FilterIdHigh = 0U;
    filter.FilterIdLow = 0U;
    filter.FilterMaskIdHigh = 0U;
    filter.FilterMaskIdLow = 0U;
    filter.FilterFIFOAssignment = CAN_RX_FIFO0;
    filter.FilterActivation = ENABLE;
    filter.SlaveStartFilterBank = 14U;
    if (HAL_CAN_ConfigFilter(&hcan1, &filter) != HAL_OK) {
        return MC_ERR_IO;
    }
    return HAL_CAN_Start(&hcan1) == HAL_OK ? MC_OK : MC_ERR_IO;
}

void mc_board_app_init(void)
{
    mc_platform_t platform;
    int can_result;

    memset(&g_port_context, 0, sizeof(g_port_context));
    g_port_context.spi = &hspi1;
    g_port_context.test_uart = &huart3;
    g_port_context.debug_uart = &huart1;
    g_port_context.i2c = &hi2c1;
    g_port_context.can = &hcan1;
    g_port_context.spi_cs_port = SPI_FLASH_CS_GPIO_Port;
    g_port_context.spi_cs_pin = SPI_FLASH_CS_Pin;
    g_port_context.sync_port = TEST_SYNC_GPIO_Port;
    g_port_context.sync_pin = TEST_SYNC_Pin;

    platform = mc_stm32f407_make_platform(&g_port_context);
    mc_runner_init(&g_runner, &platform);
    g_command_length = 0U;
    g_previous_key_state = HAL_GPIO_ReadPin(USER_KEY_GPIO_Port, USER_KEY_Pin);
    can_result = can_start_accept_all();

    console_write("\r\nSkyStar STM32F407 protocol truth node\r\n");
    console_write("Clock=168MHz SPI1=1.3125MHz I2C1=100k UART1/UART3=115200 CAN1=500k\r\n");
    console_write(can_result == MC_OK ? "CAN started\r\n" : "CAN start failed; check transceiver\r\n");
    print_help();
}

void mc_board_app_poll(void)
{
    uint8_t value;
    GPIO_PinState key_state;

    if (HAL_UART_Receive(&huart1, &value, 1U, 5U) == HAL_OK) {
        if (value == '\r' || value == '\n') {
            if (g_command_length > 0U) {
                g_command[g_command_length] = '\0';
                console_write("\r\n");
                run_command(g_command);
                g_command_length = 0U;
            }
        } else if (value == 0x08U || value == 0x7FU) {
            if (g_command_length > 0U) {
                --g_command_length;
            }
        } else if (g_command_length + 1U < sizeof(g_command)) {
            g_command[g_command_length++] = (char)value;
            (void)HAL_UART_Transmit(&huart1, &value, 1U, 50U);
        }
    }

    key_state = HAL_GPIO_ReadPin(USER_KEY_GPIO_Port, USER_KEY_Pin);
    if (key_state == GPIO_PIN_SET && g_previous_key_state == GPIO_PIN_RESET) {
        HAL_Delay(20U);
        if (HAL_GPIO_ReadPin(USER_KEY_GPIO_Port, USER_KEY_Pin) == GPIO_PIN_SET) {
            console_write("\r\nUSER_KEY: SPI JEDEC smoke\r\n");
            run_spi_jedec(1U);
        }
    }
    g_previous_key_state = key_state;
}

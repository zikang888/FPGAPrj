#include "mc_board_app.h"

#include "main.h"
#include "mc_protocol_runner.h"
#include "mc_stm32f407_hal_port.h"
#include "mc_faults.h"
#include "mc_oled.h"

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
static uint32_t g_key_down_ms;
static int g_long_press_ran;
static mc_fault_id_t g_selected_fault;
static int g_last_fault_result = MC_ERR_UNSUPPORTED;
static int g_has_fault_result;

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
        "  fault list           List selectable fault cases\r\n"
        "  fault select N       Select case index N (0..19)\r\n"
        "  fault run [N]        Trigger selected/indexed case\r\n"
        "  help                 Show this help\r\n"
        "USER_KEY: short=next, hold 0.8s=run.\r\n> ");
}

static void display_fault_menu(void)
{
    char line[24];
    unsigned int base = ((unsigned int)g_selected_fault / 4U) * 4U;
    unsigned int i;
    const mc_fault_info_t *selected = mc_fault_get(g_selected_fault);
    mc_oled_clear();
    mc_oled_text(0U, 0U, "FAULT SELECT");
    for (i = 0U; i < 4U; ++i) {
        const mc_fault_info_t *item = mc_fault_get((mc_fault_id_t)(base + i));
        if (item != NULL) {
            (void)snprintf(line, sizeof(line), "%c%02u %s",
                           base + i == (unsigned int)g_selected_fault ? '>' : ' ',
                           base + i, item->label);
            mc_oled_text(0U, (uint8_t)(i + 1U), line);
        }
    }
    mc_oled_text(0U, 5U, "TAP NEXT HOLD RUN");
    if (g_has_fault_result) {
        if (g_last_fault_result == MC_ERR_UNSUPPORTED) {
            strcpy(line, "NEEDS EXTERNAL HW");
        } else {
        (void)snprintf(line, sizeof(line), "RESULT %d", g_last_fault_result);
        }
    } else if (selected != NULL) {
        switch (selected->requirement) {
        case MC_FAULT_LOCAL: strcpy(line, "READY"); break;
        case MC_FAULT_NEEDS_WIRING: strcpy(line, "NEEDS LINK"); break;
        case MC_FAULT_NEEDS_PEER: strcpy(line, "NEEDS PEER"); break;
        case MC_FAULT_EXTERNAL_ONLY: strcpy(line, "EXTERNAL ONLY"); break;
        default: strcpy(line, "NOT BASELINE"); break;
        }
    } else {
        strcpy(line, "INVALID");
    }
    mc_oled_text(0U, 6U, line);
    if (selected != NULL) {
        (void)snprintf(line, sizeof(line), "CASE %lu", (unsigned long)selected->case_id);
        mc_oled_text(0U, 7U, line);
    }
    mc_oled_flush();
}

static void print_fault_list(void)
{
    unsigned int i;
    char line[100];
    for (i = 0U; i < (unsigned int)MC_FAULT_COUNT; ++i) {
        const mc_fault_info_t *item = mc_fault_get((mc_fault_id_t)i);
        (void)snprintf(line, sizeof(line), "%2u case=%lu %-20s requirement=%d\r\n",
                       i, (unsigned long)item->case_id, item->label, item->requirement);
        console_write(line);
    }
    console_write("> ");
}

static void trigger_selected_fault(void)
{
    const mc_fault_info_t *item = mc_fault_get(g_selected_fault);
    char line[110];
    if (item == NULL) {
        return;
    }
    (void)snprintf(line, sizeof(line), "\r\nFAULT case=%lu %s\r\n",
                   (unsigned long)item->case_id, item->label);
    console_write(line);
    g_last_fault_result = mc_fault_run(&g_runner, g_selected_fault);
    g_has_fault_result = 1;
    (void)snprintf(line, sizeof(line), "FAULT result=%d\r\n> ", g_last_fault_result);
    console_write(line);
    HAL_GPIO_WritePin(USER_LED_GPIO_Port, USER_LED_Pin,
                      g_last_fault_result == MC_OK ? GPIO_PIN_SET : GPIO_PIN_RESET);
    display_fault_menu();
}

static void select_fault(unsigned int index)
{
    if (index >= (unsigned int)MC_FAULT_COUNT) {
        console_write("Invalid fault index\r\n> ");
        return;
    }
    g_selected_fault = (mc_fault_id_t)index;
    g_has_fault_result = 0;
    display_fault_menu();
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
    } else if (strcmp(command, "fault list") == 0) {
        print_fault_list();
    } else if (strncmp(command, "fault select ", 13U) == 0) {
        char *endptr;
        unsigned long index = strtoul(command + 13, &endptr, 10);
        if (endptr == command + 13 || *endptr != '\0') {
            console_write("Invalid fault index\r\n");
        } else {
            select_fault((unsigned int)index);
        }
        console_write("> ");
    } else if (strncmp(command, "fault run", 9U) == 0) {
        if (command[9] == ' ') {
            char *endptr;
            unsigned long index = strtoul(command + 10, &endptr, 10);
            if (endptr == command + 10 || *endptr != '\0' ||
                index >= (unsigned long)MC_FAULT_COUNT) {
                console_write("Invalid fault index\r\n> ");
                return;
            }
            select_fault((unsigned int)index);
        }
        trigger_selected_fault();
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
    g_key_down_ms = HAL_GetTick();
    g_long_press_ran = 0;
    g_selected_fault = MC_FAULT_SPI_PARTIAL;
    g_has_fault_result = 0;
    can_result = can_start_accept_all();
    mc_oled_init();
    display_fault_menu();

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
        g_key_down_ms = HAL_GetTick();
        g_long_press_ran = 0;
    } else if (key_state == GPIO_PIN_SET && !g_long_press_ran &&
               (uint32_t)(HAL_GetTick() - g_key_down_ms) >= 800U) {
        g_long_press_ran = 1;
        trigger_selected_fault();
    } else if (key_state == GPIO_PIN_RESET && g_previous_key_state == GPIO_PIN_SET &&
               !g_long_press_ran && (uint32_t)(HAL_GetTick() - g_key_down_ms) >= 25U) {
        select_fault((unsigned int)(g_selected_fault + 1U) % (unsigned int)MC_FAULT_COUNT);
    }
    g_previous_key_state = key_state;
}

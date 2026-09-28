/*
 * Copy the marked block into the STM32CubeMX-generated main.c USER CODE areas.
 * Do not replace CubeMX clock, GPIO or peripheral initialization with this file.
 */

#include "main.h"
#include "mc_protocol_runner.h"
#include "mc_stm32f407_hal_port.h"

extern SPI_HandleTypeDef hspi1;
extern UART_HandleTypeDef huart1; /* Independent truth-log UART. */
extern UART_HandleTypeDef huart3; /* UART link under test. */
extern I2C_HandleTypeDef hi2c1;
extern CAN_HandleTypeDef hcan1;

static mc_stm32f407_context_t g_port_context;
static mc_runner_t g_runner;

void MemberC_Init(void)
{
    mc_platform_t platform;

    g_port_context.spi = &hspi1;
    g_port_context.test_uart = &huart3;
    g_port_context.debug_uart = &huart1;
    g_port_context.i2c = &hi2c1;
    g_port_context.can = &hcan1;
    g_port_context.spi_cs_port = SPI_FLASH_CS_GPIO_Port;
    g_port_context.spi_cs_pin = SPI_FLASH_CS_Pin;
    g_port_context.sync_port = TEST_SYNC_GPIO_Port;
    g_port_context.sync_pin = TEST_SYNC_Pin;

    HAL_GPIO_WritePin(SPI_FLASH_CS_GPIO_Port, SPI_FLASH_CS_Pin, GPIO_PIN_SET);
    HAL_GPIO_WritePin(TEST_SYNC_GPIO_Port, TEST_SYNC_Pin, GPIO_PIN_RESET);
    (void)HAL_CAN_Start(&hcan1);

    platform = mc_stm32f407_make_platform(&g_port_context);
    mc_runner_init(&g_runner, &platform);
}

void MemberC_RunSmokeTests(void)
{
    const uint8_t w25q128_jedec_id[3] = {0xEFU, 0x40U, 0x18U};
    mc_run_summary_t summary;

    /* Run one protocol at a time during first integration. */
    (void)mc_run_spi_jedec(&g_runner, 1001U, 10U, w25q128_jedec_id, &summary);

    /* Enable after FPGA UART echo is ready. */
    /* (void)mc_run_uart_loopback(&g_runner, 2001U, 10U, &summary); */

    /* AT24C256 address is 0x50 only when A2:A0 are all low. */
    /* (void)mc_run_i2c_eeprom(&g_runner, 3001U, 0x50U, 0x0100U, 10U, &summary); */

    /* Enable only after both SN65HVD230 nodes and termination are verified. */
    /* (void)mc_run_can_loopback(&g_runner, 4001U, 0x321U, 10U, &summary); */
}

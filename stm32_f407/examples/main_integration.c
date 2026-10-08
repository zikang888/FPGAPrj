/*
 * Copy the marked block into the STM32CubeMX-generated main.c USER CODE areas.
 * Do not replace CubeMX clock, GPIO or peripheral initialization with this file.
 */

#include "main.h"
#include "mc_protocol_runner.h"
#include "mc_stm32f407_hal_port.h"

extern SPI_HandleTypeDef hspi1;
extern UART_HandleTypeDef huart1; /* Independent truth-log UART. */

static mc_stm32f407_context_t g_port_context;
static mc_runner_t g_runner;

void MemberC_Init(void)
{
    mc_platform_t platform;

    g_port_context.spi = &hspi1;
    g_port_context.debug_uart = &huart1;
    /* SkyStar F407VGT6 high-end board: onboard W25Q128 CS is PA4.
     * CubeMX must configure PA4 as a push-pull GPIO output, initially high.
     * Do not use this example unchanged on a different board revision. */
    g_port_context.spi_cs_port = GPIOA;
    g_port_context.spi_cs_pin = GPIO_PIN_4;
#if defined(TEST_SYNC_GPIO_Port) && defined(TEST_SYNC_Pin)
    g_port_context.sync_port = TEST_SYNC_GPIO_Port;
    g_port_context.sync_pin = TEST_SYNC_Pin;
#endif

    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_4, GPIO_PIN_SET);
#if defined(TEST_SYNC_GPIO_Port) && defined(TEST_SYNC_Pin)
    HAL_GPIO_WritePin(TEST_SYNC_GPIO_Port, TEST_SYNC_Pin, GPIO_PIN_RESET);
#endif

    platform = mc_stm32f407_make_platform(&g_port_context);
    mc_runner_init(&g_runner, &platform);
}

int MemberC_RunSmokeTests(void)
{
    uint8_t mounted_jedec_id[3] = {0U, 0U, 0U};
    mc_run_summary_t summary;
    int result;

    /* First measure the mounted part. Do not assume the example EF4018 ID. */
    result = mc_probe_spi_jedec(&g_runner, 1001U, mounted_jedec_id);
    if (result != MC_OK) return result;
    return mc_run_spi_jedec(&g_runner, 1001U, 10U,
                            mounted_jedec_id, &summary);
}

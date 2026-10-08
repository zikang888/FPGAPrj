# STM32CubeMX 配置清单

目标芯片：天空星 STM32F407VGT6 **高配版且板载 W25Q128 已焊装**。以下映射依据[立创官方 SPI-FLASH 教程](https://wiki.lckfb.com/zh-hans/tkx/tkx-stm32f407vxt6/beginner/spi.html)，上板前仍须核对实物版本、原理图和排针。

| 功能 | 外设/引脚 | 配置 |
|---|---|---|
| 板载 SPI Flash | SPI1 PA5/PA6/PA7 | Master、Full Duplex、Mode 0、MSB First，初始分频到约 1 MHz |
| 板载 Flash CS | PA4，GPIO Output，软件片选 | 初始化为推挽输出前先置高，空闲保持高；不要设为 SPI1 硬件 NSS |
| I²C EEPROM | I2C1 PB6/PB7 | 100 kHz，开漏；总线只保留一组有效上拉 |
| UART 测试链路 | USART3 PD8/PD9 | 115200、8N1、无流控 |
| 真值日志 | USART1 PA9/PA10 | 115200 或更高，连接独立 USB-UART/DAP-Link |
| CAN | CAN1 PD0/PD1 | Normal mode，起步 500 kbit/s，AF9 |
| 同步标记 | 任一空闲 GPIO | 推挽输出，接 FPGA 纯输入；具体引脚待原理图确认 |

## 必要设置

- 打开 `USE_FULL_ASSERT` 便于联调。
- CAN 接收滤波器第一阶段可全接收，但正式测试要记录 ID 范围。
- I²C EEPROM 写入后通过 ACK polling 等待内部写周期结束，代码适配层已使用 `HAL_I2C_IsDeviceReady`。
- 本示例 `MemberC_Init()` 固定使用 `GPIOA/GPIO_PIN_4`；CubeMX 必须将 PA4 配为 GPIO Output，并确认它确实连接到板载 W25Q128 CS。若实物不是上述高配板，先改板级适配代码，不得照抄 PA4。
- 不要在 PA4/PA5/PA6/PA7 上再并联第二颗使用同一 CS 的外置 Flash；两个从机可能同时驱动 MISO。若扩展板占用 PA4 或 SPI1，也须先排除冲突。
- 第一阶段只需 SPI1、片选 GPIO、USART1 真值日志即可编译烟测；USART3/I2C1/CAN1 和同步 GPIO 不要求同时启用。
- SPI、UART、I²C、CAN 的被测链路不能与真值日志复用同一个 UART。
- 所有 GPIO 初始电平先设置，再初始化为输出，避免上电毛刺误选中 Flash。

将 `stm32_f407/common/src`、`stm32_f407/hal/src` 加入 Keil 工程，将两个 `include` 目录加入 Include Paths。`examples/main_integration.c` 只作为 USER CODE 接入示例，不应覆盖 CubeMX 生成的 `main.c`。

# 天空星 STM32F407VGT6 完整固件工程

## 打开与编译

Keil MDK-ARM 入口：

```text
Projects/MDK-ARM/sky_star_protocol_node.uvprojx
```

CubeMX 入口：

```text
sky_star_protocol_node.ioc
```

本工程由 STM32CubeMX 6.15.0、STM32CubeF4 v1.28.3 生成，目标芯片为
STM32F407VGT6。下面为第一阶段 `5d788f8` 的历史构建大小；当前默认/故障双配置及各自大小见发布目录：

```text
Program Size: Code=30886 RO-data=3362 RW-data=72 ZI-data=5512
0 Error(s), 0 Warning(s)
```

直接下载固件：[默认 / CAN 故障 HEX、来源提交和 SHA-256](releases/README.md)。发布文件被 Git 跟踪，Keil 的原始输出目录仍保持忽略。两个配置的完整 ARM 构建见 [验证记录](../../docs/test-results/2026-10-22-can-raw-profiles.md)。

## 时钟与引脚依据

- HSE：天空星板载 8 MHz 晶振，PLL 后 SYSCLK 168 MHz。
- LSE：板载 32.768 kHz，已在 `.ioc` 中保留晶振管脚；当前业务未启用 RTC。
- SPI1 PA4～PA7、USART1 PA9/PA10、PB2 LED、PA0 KEY 来自嘉立创天空星官方教程。
- USART3 PD8/PD9、I²C1 PB6/PB7、CAN1 PD0/PD1 来自 STM32F407 复用功能和天空星官方引脚定义图。

官方资料：

- <https://wiki.lckfb.com/zh-hans/tkx/tkx-stm32f407vxt6/>
- <https://wiki.lckfb.com/zh-hans/tkx/tkx-stm32f407vxt6/beginner/project-template.html>
- <https://wiki.lckfb.com/zh-hans/tkx/tkx-stm32f407vxt6/beginner/spi.html>
- <https://wiki.lckfb.com/zh-hans/tkx/tkx-stm32f407vxt6/beginner/uart.html>
- <https://lckfb.com/project/detail/lckfb-lspi-skystar-stm32f407vgt6-pro?param=baseInfo>

## 外接硬件

- FPGA SPI 监听线并接 PA4～PA7，FPGA 必须保持输入。
- AT24C256 接 PB6/PB7 和公共地，只保留一组有效上拉。
- USART3 交叉连接 FPGA UART，USART1 独立连接 USB-UART 日志终端。
- CAN1 PD0/PD1 必须先接 SN65HVD230，不能直连 CANH/CANL。
- TEST_SYNC PC6 可接 FPGA 的一个 3.3 V 输入。
- SSD1306 7 针 4 线 SPI OLED 接 PB12/PB13/PB15、PC4/PC5；接线和菜单用法见 `../../docs/hardware/stm32_fault_menu_oled.md`。

## CubeMX 再生成

`generate_cubemx.ps1` 是可移植的命令行生成脚本。当前 Keil 工程额外包含仓库上层的
`common`、`hal`、`app` 源码。CubeMX 再生成后需检查这些手工分组仍在，包含新增的
`mc_can_session.c` 和 `mc_can_session_hal.c`。CAN 会话没有新增 `.ioc` 外设资源，
操作说明见 [CAN 会话使用说明](../../docs/hardware/can_session_firmware_usage.md)。

GPIO RAW 后端还需要 `mc_can_raw.c`、`mc_can_raw_hal.c`；其 TIM1/DMA2 由后端按需配置，未在 `.ioc` 中常驻启用。故障版定义 Stream5 IRQ；后续 CubeMX 若新增同一 IRQ 必须先处理重复定义/资源冲突。双配置构建：`./build_profiles.ps1 -Profile all -Release`，RAW 接线和命令见 [说明](../../docs/hardware/can_gpio_bitstream_usage.md)。

LIVE 后端增加 `mc_can_live.c`、`mc_can_live_hal.c`，故障配置开启 `MC_ENABLE_CAN_LIVE`。
按需使用 PA1/PA2、TIM2、TIM2/CAN1_SCE IRQ，不在 default 启动时启用；这两个 IRQ 符号也不能与未来 CubeMX 同名处理函数重复定义。新接线、Bus-off 判定及恢复见 [LIVE 说明](../../docs/hardware/can_live_injection_usage.md)。

示例：

```powershell
.\generate_cubemx.ps1 -CubeMxRoot D:\STM32CubeMX `
  -FirmwarePackage C:\Users\你的用户名\STM32Cube\Repository\STM32Cube_FW_F4_V1.28.3
```

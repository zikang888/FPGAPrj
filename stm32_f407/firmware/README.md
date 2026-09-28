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
STM32F407VGT6。已在 Keil ARMCC 5.06 update 2 上构建：

```text
Program Size: Code=19434 RO-data=1426 RW-data=24 ZI-data=3696
0 Error(s), 0 Warning(s)
```

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

## CubeMX 再生成

`generate_cubemx.ps1` 是可移植的命令行生成脚本。当前 Keil 工程额外包含仓库上层的
`common`、`hal`、`app` 源码。CubeMX 再生成后需检查这些手工分组仍在。

示例：

```powershell
.\generate_cubemx.ps1 -CubeMxRoot D:\STM32CubeMX `
  -FirmwarePackage C:\Users\你的用户名\STM32Cube\Repository\STM32Cube_FW_F4_V1.28.3
```

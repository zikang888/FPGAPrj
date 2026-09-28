# STM32F407 天空星完整工程生成与编译记录

日期：2026-09-28  
分支：`memberC/stm32-f407-protocol-node`

## 依据

- 嘉立创天空星 STM32F407VGT6 高配版官方产品页与引脚定义图。
- 嘉立创天空星官方 STM32F407 教程：8 MHz HSE、PB2 LED、PA0 KEY、
  PA4～PA7 SPI1、PA9/PA10 USART1。
- STM32F407 数据手册复用功能：PB6/PB7 I²C1、PD8/PD9 USART3、
  PD0/PD1 CAN1。

官方页面：

- <https://wiki.lckfb.com/zh-hans/tkx/tkx-stm32f407vxt6/>
- <https://wiki.lckfb.com/zh-hans/tkx/tkx-stm32f407vxt6/beginner/project-template.html>
- <https://wiki.lckfb.com/zh-hans/tkx/tkx-stm32f407vxt6/beginner/spi.html>
- <https://wiki.lckfb.com/zh-hans/tkx/tkx-stm32f407vxt6/beginner/uart.html>
- <https://lckfb.com/project/detail/lckfb-lspi-skystar-stm32f407vgt6-pro?param=baseInfo>

## 生成配置

- STM32CubeMX 6.15.0。
- STM32CubeF4 v1.28.3，官方提交 `94cae6e83f00e276a11957e7833c01ac3d0bd7af`。
- MCU：STM32F407VGT6，LQFP100。
- HSE 8 MHz，PLL：M=8、N=336、P=2、Q=7，SYSCLK 168 MHz。
- APB1 42 MHz，APB2 84 MHz。
- SPI1 Mode 0，84 MHz/64=1.3125 MHz。
- I²C1 100 kHz。
- USART1/USART3 115200、8N1。
- CAN1 500 kbit/s：Prescaler=6、BS1=11TQ、BS2=2TQ、SJW=1TQ。

## 编译结果

Keil ARMCC 5.06 update 2 build 183：

```text
Program Size: Code=19434 RO-data=1426 RW-data=24 ZI-data=3696
0 Error(s), 0 Warning(s)
```

电脑端协议编排测试：

```text
1/1 mc_protocol_tests passed
100% tests passed
```

## 已纳入完整工程

- CubeMX `.ioc`。
- CubeMX 生成的 `Core`、HAL、CMSIS。
- Keil MDK-ARM `.uvprojx` 和启动文件。
- SPI、UART、I²C、CAN 协议测试编排。
- STM32F407 HAL 适配层。
- USART1 命令行和 JSONL 真值日志。
- 用户按键触发 SPI JEDEC 冒烟测试。
- CAN 全接收过滤器与正常模式启动。

## 尚未证明

- 尚未烧录天空星实板。
- 尚未读取板载 Flash 的实际 JEDEC ID。
- 尚未连接外部 AT24C256、SN65HVD230 或 FPGA UART 回环。
- 编译通过不等同于 SPI/I²C/UART/CAN 三方实测通过。

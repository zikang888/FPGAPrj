# 成员 C：天空星 STM32F407 多协议真值节点

这是独立、干净的 STM32F407 协作分支，不包含 Vivado、Zynq PS、BIT/HDF/ELF
或其他 FPGA 工程文件。

## 工程入口

- Keil：`stm32_f407/firmware/Projects/MDK-ARM/sky_star_protocol_node.uvprojx`
- CubeMX：`stm32_f407/firmware/sky_star_protocol_node.ioc`
- 板级应用：`stm32_f407/app/src/mc_board_app.c`
- 协议规则：`docs/protocol-rules/protocol_rules.yaml`
- 接线规划：`docs/hardware/member_c_stm32f407_implementation.md`
- 构建记录：`docs/test-results/2026-09-28-stm32f407-full-project.md`

## 已配置功能

- 板载 W25Q128：SPI1 PA4～PA7，Mode 0，1.3125 MHz。
- FPGA UART：USART3 PD8/PD9，115200 8N1。
- 日志/命令：USART1 PA9/PA10，115200 8N1。
- AT24C256：I²C1 PB6/PB7，100 kHz。
- CAN：CAN1 PD0/PD1，500 kbit/s，必须外接 SN65HVD230。
- 用户 LED：PB2；用户按键：PA0；同步脉冲：PC6。

## 验证状态

- Keil ARMCC 5.06：0 error、0 warning。
- 电脑端协议测试：1/1 passed。
- 尚未完成天空星、外设模块和 FPGA 的实板联调。

## 协作规则

所有协议参数、事件语义、异常条件、测试用例和验收阈值由成员 C 维护。
FPGA 和其他节点通过 `docs/protocol-rules/protocol_rules.yaml` 对接。


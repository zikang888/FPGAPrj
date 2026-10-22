# 成员 C：天空星 STM32F407 多协议真值节点

这是独立、干净的 STM32F407 协作分支，不包含 Vivado、Zynq PS、BIT/HDF/ELF
或其他 FPGA 工程文件。

仓库另有 `STM32_control_board` / `STM32_receive_board` 的 STM32F103 工程，
用途、HAL、OLED 接口和通信协议不同；本分支的 F407 HEX 不能用于这两种 F103 固件。

## 工程入口

- Keil：`stm32_f407/firmware/Projects/MDK-ARM/sky_star_protocol_node.uvprojx`
- CubeMX：`stm32_f407/firmware/sky_star_protocol_node.ioc`
- 板级应用：`stm32_f407/app/src/mc_board_app.c`
- 协议规则：`docs/protocol-rules/protocol_rules.yaml`
- 接线规划：`docs/hardware/member_c_stm32f407_implementation.md`
- 构建记录：`docs/test-results/2026-09-28-stm32f407-full-project.md`
- 当前固件：[2026-10-22 默认 HEX 与版本说明](stm32_f407/firmware/releases/2026-10-22-5d788f8/README.md)
- CAN 会话：[命令、开关与停止恢复](docs/hardware/can_session_firmware_usage.md)
- 分支检查：[兼容性与文档修订记录](docs/test-results/2026-10-22-branch-doc-release-audit.md)

## 已配置功能

- 板载 W25Q128：SPI1 PA4～PA7，Mode 0，1.3125 MHz。
- FPGA UART：USART3 PD8/PD9，115200 8N1。
- 日志/命令：USART1 PA9/PA10，115200 8N1。
- AT24C256：I²C1 PB6/PB7，100 kHz。
- CAN：CAN1 PD0/PD1，500 kbit/s，必须外接 SN65HVD230。
- 用户 LED：PB2；用户按键：PA0；同步脉冲：PC6。
- OLED：PB12/PB13/PB15、PC4/PC5；原菜单显示触发次数，CAN 会话显示进度。
- CAN 周期会话：normal/echo 默认可用；noack/bitrate 需显式启用故障宏。

## 验证状态

- Keil ARMCC 5.06：0 error、0 warning。
- 当前电脑端测试：4/4 passed（原协议回归、CAN 会话、HAL 默认/启用配置）。
- 尚未完成天空星、外设模块和 FPGA 的实板联调。

## 协作规则

所有协议参数、事件语义、异常条件、测试用例和验收阈值由成员 C 维护。
FPGA 和其他节点通过 `docs/protocol-rules/protocol_rules.yaml` 对接。


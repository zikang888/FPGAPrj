# 文档导航

本目录保存可复现的接口约定、硬件接线、集成决策和实板测试记录。历史测试记录按日期保留，不用旧记录覆盖当前接口定义。

## 当前实现优先阅读

- [寄存器与 128-bit 事件格式](interfaces/register_map.md)
- [I2C/CAN 被动监听接口](interfaces/i2c_can_passive_monitor.md)
- [错误事件接入状态](interfaces/error_event_catalog.md)
- [UART RX 监听接口](interfaces/uart_rx_monitor.md)
- [SPI Mode-0 监听接口](interfaces/spi_mode0_monitor.md)
- [PS 事件视图](interfaces/ps_event_view.md)
- [测试会话、过滤与冻结](interfaces/test_sessions.md)

## 硬件与接线

- [FPGA 管脚分配](hardware/pin_assignment.md)
- [STM32 多协议接线复核](hardware/stm32_multi_protocol_wiring_review.md)
- [STM32 SPI 最小契约](hardware/stm32_spi_minimum_contract.md)
- [SPI 实板测试](hardware/spi_board_test.md)

## 架构和集成

- `adr/`：平台、事件快照等架构决策记录。
- `integration/`：成员工程合并规则和首版验收门槛。
- `protocol-rules/`：协议规则草案；不能替代 RTL/PS 已实现能力说明。
- `migration/`：Vivado 版本迁移注意事项。

## 最新测试证据

- [2026-10-22 I2C/CAN 错误事件与 UI 实板测试](test-results/2026-10-22-i2c-can-error-ui-board.md)
- [2026-10-21 I2C/CAN 被动监听](test-results/2026-10-21-i2c-can-passive-monitor.md)
- [2026-10-20 会话离线测试](test-results/2026-10-20-session-offline.md)
- [2026-10-18 UART 合并实板测试](test-results/2026-10-18-uart-merge-board.md)
- [2026-10-17 UART RX 集成](test-results/2026-10-17-uart-rx-integration.md)

其余 `test-results/` 文件是按日期保留的阶段性证据。判断当前功能时，应同时核对最新测试记录、当前 RTL/PS 源码和寄存器表。

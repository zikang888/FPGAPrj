# STM32F407 错误事件菜单与 SSD1306 OLED 接线

状态：初版实现于 2026-10-12；2026-10-22 更新执行计数和 CAN 会话入口，已编译和主机测试，尚未烧录或完成波形实测。协议规则由成员 C 维护，详见 `docs/protocol-rules/protocol_rules.yaml`。

## OLED 选择

参考资料是用户指定的 `SSD1306-Revision_1.1.pdf`。该控制器支持 4 线 SPI，D0 为 SCLK、D1 为 SDIN；D/C 低表示命令、高表示显示数据。当前驱动按 **128×64、7 针、4 线 SPI、内部电荷泵** 模块编写。模块的实际针脚顺序和供电电压应以模块丝印/原理图为准，SSD1306 芯片手册不规定成品模块排针顺序。

| OLED 模块信号 | 天空星 STM32F407 | 说明 |
|---|---|---|
| GND | GND | 公共地 |
| VCC | 3.3 V | 先核对模块是否支持 3.3 V 供电 |
| SCLK / D0 | PB13 | 软件 SPI 时钟 |
| SDA / DIN / D1 | PB15 | 软件 SPI 数据 |
| CS | PB12 | 低有效 |
| DC / D-C | PC4 | 命令/数据选择 |
| RES / RST | PC5 | 低有效复位 |

OLED 使用独立 GPIO 软件 SPI，不占用连接板载 W25Q128 的 SPI1 PA4～PA7。驱动位于 `stm32_f407/app/src/mc_oled.c`，按页寻址写入 1024 字节画面。

## 选择和触发

- PA0 短按（25 ms～799 ms）：选择下一个事件；20 项循环。
- PA0 长按（至少 800 ms）：执行当前事件一次；OLED 显示结果码。
- USART1 115200 8N1：`fault list`、`fault select N`、`fault run`、`fault run N`。N 为 0～19。
- 菜单新增 `RUNS N` 显示本次开机的触发尝试次数。周期 CAN 测试使用独立会话，见 [CAN 会话使用说明](can_session_firmware_usage.md)；会话运行时长按停止，结束后可返回原菜单。
- 每次执行输出一条 JSONL，含 case ID、协议、动作、STM32 返回码和说明。对发波形的用例，`0` 只表示 STM32 完成了动作；仍需 FPGA 事件或独立采集确认线上实际波形。I²C NACK 与 CAN ACK 探测则由 STM32 检查对应状态。`-5` 表示当前硬件路径不支持。

## 事件菜单

| 索引 | 事件 | 当前执行方式/前提 |
|---:|---|---|
| 0 | SPI PARTIAL BYTE | PA5/PA7 临时切 GPIO，发 4 bit 后 CS 上升，再恢复 SPI1 |
| 1 | SPI SHORT TXN | JEDEC ID 事务只发 2 个完整字节，需 FPGA 知道预期 4 字节 |
| 2 | SPI EXTRA BYTE | JEDEC ID 事务发 5 个完整字节，需 FPGA 知道预期 4 字节 |
| 3 | SPI MISO CHECK | 仅能观测和比较真实 MISO，STM32 不会凭软件制造 Flash 输出损坏 |
| 4 | UART BAD STOP | PD8 临时 GPIO 输出停止位低电平，再恢复 USART3 |
| 5 | UART BREAK | PD8 保持低电平 13 位时间，再恢复 USART3 |
| 6 | UART BAUD OFFSET | 以 96000 baud 发 `55`，再恢复 115200；对端预期保持 115200 |
| 7 | UART SHORT TXN | 约定 8 字节时只发 3 字节，需对端事务长度/超时规则 |
| 8 | UART PARITY | 8N1 基线没有校验位，列为不可执行 |
| 9 | I2C ADDR NACK | 先确认 `0x50` ACK，再探测 `0x51` NACK |
| 10 | I2C BUSY NACK | 向 EEPROM 写 1 字节，立即 ACK 轮询，记录实际 NACK 次数；若无 NACK 返回 `-4` |
| 11 | I2C SDA LOW | 需 PC7 经限流电阻接 SDA，并启用 `MC_ENABLE_I2C_FAULT_LINKS` |
| 12 | I2C SCL LOW | 需 PC8 经限流电阻接 SCL，并启用 `MC_ENABLE_I2C_FAULT_LINKS` |
| 13 | I2C NO STOP | 开漏 GPIO 发地址后保持 SCL 低 30 ms，再发 STOP 恢复总线 |
| 14 | CAN NO ACK | 需收发器且无其他节点应答；启用 `MC_ENABLE_CAN_FAULTS` 后单次发送并恢复重发设置 |
| 15～18 | CAN BIT/STUFF/CRC/FORM | bxCAN 自动生成合法帧，需要外部物理层注入设备 |
| 19 | CAN BUS OFF | 需要外部重复故障与恢复流程，当前不主动累积错误 |

后续 CAN 扩展方案见 [CAN 实际故障复现与检测实施规划](can_real_fault_reproduction_plan.md)：额外 GPIO 配合独立收发器可设计位流发生器或显性干扰器，因此上表“外部物理层注入设备”也可由 STM32 的新增发送后端承担。该后端当前尚未实现，现有菜单的可执行范围不变。

## FPGA 配合

- 现有 SPI 监听器只对索引 0 的残帧有线级 `FRAME_ERROR` 触发。索引 1/2 要求对端知道测试用例的期望长度。
- UART、I²C、CAN 的新增事件必须由对应监听器/PS 分析逻辑实现，STM32 只能产生或观察总线条件。
- `TEST_SYNC` PC6 在每次用例前输出 1 ms 脉冲；如 FPGA 未接同步输入，按测试顺序和日志 `case_id` 对齐。
- CAN 项目规则仍是 `enabled: false`。完成收发器、终端和 PS/EMIO 接线核对后，由成员 C 决定是否启用。

## 恢复与保护

- SPI 残帧结束后拉高 PA4 并恢复 PA5/PA7 到 SPI1 AF5。
- UART 位级故障结束后将 PD8 拉高并恢复 USART3 AF7。
- I²C 延迟 STOP 最长 30 ms，之后发送 STOP 并重新初始化 I²C1。
- PC7/PC8 故障连线默认关闭；启用时只能开漏下拉，不允许推挽输出高。
- CAN 单次无 ACK 探测默认关闭；启用时使用一次发送且恢复正常自动重发设置。

资料来源：SSD1306 Rev 1.1，第 17～18 页（4 线 SPI），第 30～31 页（页寻址与显示 RAM）；嘉立创天空星官方引脚资料及本项目 CubeMX `.ioc`。

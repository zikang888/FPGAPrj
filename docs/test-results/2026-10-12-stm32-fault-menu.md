# STM32 错误事件菜单：本地验证记录

日期：2026-10-12。对象：`memberC/stm32-f407` 本地工作树，尚未推送远端。

## 已完成

- 20 项错误事件目录、索引、case ID 和 JSONL 结果记录。
- PA0 单键短按选择、长按执行；USART1 提供 `fault list/select/run` 命令。
- SSD1306 128×64 OLED 页面，4 线 SPI GPIO：PB12/PB13/PB15、PC4/PC5。
- SPI 4-bit 残帧、2-byte 短事务、5-byte 长事务。
- UART 停止位低、13-bit Break、96000 baud 偏移、3/8 字节短事务。
- I²C `0x51` 地址 NACK、写周期忙 NACK 计数、延迟 STOP。
- PC7/PC8 开漏拉低 SDA/SCL 的可选跳线实现，默认关闭。
- CAN 单次无 ACK 探测的可选实现，默认关闭；CAN 位/填充/CRC/格式错误仍需外部物理注入。

## 验证

```text
Host CMake/Ninja: build PASS
Host CTest: 1/1 passed
Keil ARMCC 5.06 update 2: 0 Error(s), 0 Warning(s)
Code=24126 RO-data=2510 RW-data=40 ZI-data=4744
Optional I2C/CAN hooks: ARMCC direct compile PASS
```

主机测试覆盖 SPI 残帧、短/长事务，UART 停止位、Break、波特率恢复、短事务，I²C 地址 NACK、忙 NACK，以及 CAN 无 ACK 回调的分派与日志。硬件波形、OLED 显示方向和实际响应仍需实板验证。

日志中 `result=0` 对波形输出用例表示 STM32 动作完成，不代表 FPGA 已检测到相应事件；实板验收需要对照 FPGA 事件与独立逻辑采集。

## 关键边界

- SPI 短/长事务、UART 少字节是“与测试用例期望不符”，不是总线自身的线级错误。
- I²C 忙 NACK 是观察结果，若 EEPROM 太快恢复、没有观测到 NACK，返回 `MC_ERR_VERIFY`，不会假报故障成功。
- CAN 无 ACK 只有在收发器完整、总线上没有应答节点时才能观测；功能默认不编入正式板级可执行路径。
- CAN CRC/格式/填充/位错误无法用合法 bxCAN 发送 API 制造；菜单返回 `MC_ERR_UNSUPPORTED`。
- `docs/protocol-rules/protocol_rules.yaml` 仍为成员 C 草案，需根据 FPGA 端新增监听器能力再冻结。

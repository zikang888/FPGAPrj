# I2C/CAN 被动监听接口（2026-10-21）

> 2026-10-24 更正：本文件的初版被动 CAN 接线已被 `fix/fpga_waveform`
> 的主动第二节点实现替代。以当前 `top.xdc`、`create_bd.tcl` 和 RTL 为准：
> **W8 是输出，接第二只 SN65HVD230 的 TXD；AA11 是输入，接第二只收发器
> 的 RXD。不得把 W8 与 STM32 PD1 推挽输出直接相连。** I2C AA6/V8 仍为
> 被动输入。下文保留接口演进背景，涉及旧 CAN 输入接线的条目不再适用。

本版本把 I2C 与 CAN 纳入现有的 128-bit 事件流、手动测试会话、快照、
PS 计数器和触摸屏页面。四路监听器通过公平级联仲裁进入同一个快照缓冲，
FPGA 对所有被监听信号均为输入，不参与 I2C ACK，也不驱动 CAN TX/RX。

## 接线

| 协议 | FPGA | 被监听节点 | 方向 |
|---|---|---|---|
| I2C | AA6 | STM32 PB6 / I2C1 SCL | 输入 |
| I2C | V8 | STM32 PB7 / I2C1 SDA | 输入 |
| CAN | W8 | STM32 PD1 与 SN65HVD230 TXD 之间 | 输入 |
| CAN | AA11 | SN65HVD230 RXD 与 STM32 PD0 之间 | 输入 |

CANH/CANL 是差分总线，绝不能直接接 FPGA IO。要监听真实 CAN，总线侧仍需
SN65HVD230，AA11 必须观察其 RXD；W8 只用于对照本机发送意图并检测位差异。

## I2C 检测范围

- START、重复 START、STOP、每个地址/数据字节及 ACK/NACK。
- 地址 NACK、AT24C256 写周期 busy NACK、SDA 卡低、SCL 卡低、缺 STOP。
- busy NACK 是 EEPROM 正常暂态，单次出现只计数，不提升为总体故障。
- `0x50` 是本项目 AT24C256 地址；busy 分类使用写事务后的 10 ms 窗口。

## CAN 检测范围

- 固定 500 kbit/s、标准 11-bit CAN 2.0A 数据帧。
- 标识符、DLC、数据字节、CRC-15、位填充、ACK、分隔符和 EOF。
- 可报告 ACK、bit、stuff、CRC 和 form 错误。
- bus-off 是 CAN 控制器的累计状态，单靠无状态被动线旁听不能可靠证明，
  因此寄存器保留但 PL 不虚构该结果。
- 扩展帧、远程帧和 CAN-FD 不在本版本承诺范围内。

## 触摸屏操作

在 HOME 选择 I2C 或 CAN 后进入 SELF TEST，点击 `NEW TEST / RESET`，再让
STM32 产生对应通信；点击 `END & SAVE` 冻结本轮。EVENTS 只显示所选协议，
ERRORS 显示 PL 寄存器的真实累计值。I2C busy NACK 单独显示为暂态；CAN
BUS OFF 保持 `--`，表示被动监听器不能得出该结论，而不是“已测且为 0”。

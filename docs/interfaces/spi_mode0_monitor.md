# SPI Mode 0 被动监听器接口

## 状态

第一阶段 RTL、自检仿真和内部快照链路仿真均通过。板级 BD 已实例化
`spi_mode0_monitor`，并把 AA8、AB10、AB9、AA7 四个物理输入接入
`multi_protocol_core` 的正式通用外部事件入口。实板 SPI 联调仍需按
`docs/hardware/spi_board_test.md` 完成。

## 时钟假设

监听器把 `SCLK/CS_N/MOSI/MISO` 双触发同步到 100 MHz PL 系统时钟后做边沿检测。
为保证每个高、低电平都能被可靠观察，第一阶段规定：

```text
SPI SCLK <= 25 MHz
SPI mode = 0（CPOL=0、CPHA=0）
bit order = MSB first
```

如果主办方测试要求更高的 SPI 频率，应改用 SCLK 时钟域采样、异步 FIFO 跨域，
不能直接提高这里声明的上限。

## 事件类型

监听器沿用 `register_map.md` 中的 128 位统一事件格式，并通过
`evt_valid/evt_ready/evt_data/evt_trigger` 传输：

- 仅在 `evt_valid && evt_ready` 时完成一次事件传输。
- `evt_valid=1 && evt_ready=0` 时保持数据和触发位不变。
- 模块内部带一个事件保持寄存器。
- 外部持续反压导致新事件无法进入保持寄存器时，增加
  `dropped_event_count`，不会静默丢失。

| event type | 含义 | flags | payload length | trigger |
|---:|---|---|---:|---:|
| `0x00` | CS 拉低，事务开始 | `0` | 0 | 0 |
| `0x01` | 收到一个全双工字节 | `{MISO[7:0], MOSI[7:0]}` | 2 | 0 |
| `0x02` | CS 拉高，事务正常结束 | `0` | 0 | 0 |
| `0x3F` | CS 拉高时存在不足 8 bit 的残帧 | bit 数 | 0 | 1 |

公共字段：

- `protocol = 2`：SPI。
- `direction = 3`：全双工。
- `channel`：模块参数 `CHANNEL`。
- `transaction_id`：每次 CS 下降沿递增，同一事务内所有事件相同。
- `timestamp`：事件产生时的 64 位 PL 系统时间戳。

## 自检覆盖

`spi_mode0_monitor_tb.sv` 覆盖：

1. ready/valid 反压期间事件保持稳定。
2. `00/FF/55/AA` 全双工黄金字节。
3. `0x9F + JEDEC ID` 事务。
4. 100 字节确定性压力事务。
5. 异步相位偏移和 SCLK 中途停顿。
6. CS 下降沿 START、字节 DATA、CS 上升沿 END。
7. transaction ID 跨事务递增。
8. 4 bit 残帧生成 `FRAME_ERROR` 并触发。
9. 消费者跨事务持续反压时，无法缓存的事件进入丢弃计数。

## 板级数据路径

监听器的 ready/valid 输出已经连接到 `multi_protocol_core` 的
`ext_evt_*` 入口。虚拟事件源继续作为自检入口，两者经过唯一的
`event_arbiter_2` 后进入同一 `event_snapshot_buffer`；没有增加第二套缓存或显示路径。
`multi_protocol_core` 导出的 64 位 PL 时间戳同时供 SPI 监听器使用，保证真实事件
和虚拟事件处于同一时间基准。

当前实现是只读监听，不会驱动或干扰 STM32 与目标从设备之间的 SPI 总线。
主动应答、故障注入和协议字段匹配属于后续独立功能，不能复用这四个输入端口直接实现。

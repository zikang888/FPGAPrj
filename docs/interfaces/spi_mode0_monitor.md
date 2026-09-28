# SPI Mode 0 被动监听器接口

## 状态

RTL、自检仿真和内部快照链路仿真均通过。平台版本 3 已将监听器接入
`multi_protocol_core` 的正式外部事件入口，并分配 AC820 P7 扩展口管脚。
尚未完成的是实物接线、STM32 流量和三方对照，因此不能宣称实板联调通过。

## 已冻结的板级接口

| 信号 | AC820 P7 信号 | Zynq 管脚 | 方向 |
|---|---|---:|---|
| SCLK | B13_L5_P | U12 | 仅输入 |
| CS_N | B13_L5_N | U11 | 仅输入，内部弱上拉 |
| MOSI | B13_L6_P | U10 | 仅输入 |
| MISO | B13_L6_N | U9 | 仅输入 |

STM32 真值节点为立创天空星 STM32F407VGT6，存储器是外接 W25Q128 模块，
不是天空星板载 Flash。SPI1 数据线可使用 PA5=SCLK、PA6=MISO、PA7=MOSI；
外接模块的 CS 由成员 B 选择一个可用 GPIO。若板载 W25Q128 已焊接并与 PA4
相连，就不能再让外接模块共用 PA4 片选，否则两个器件会同时响应；只有确认
板载器件未装、已断开或能够始终保持未选中时，外接模块才可使用 PA4。

FPGA 四个输入并联在实际总线上，其中 U11 必须接“外接模块 CS”，与成员 B
最终采用的 STM32 GPIO 同网，不要求一定是 PA4。天空星、外接模块与 FPGA
三者共地；FPGA 不得驱动这些信号。外接模块使用 3.3 V，WP/HOLD 应保持高电平。

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
4. 固定种子的 100 字节伪随机压力事务。
5. 异步相位偏移和 SCLK 中途停顿。
6. CS 下降沿 START、字节 DATA、CS 上升沿 END。
7. transaction ID 跨事务递增。
8. 4 bit 残帧生成 `FRAME_ERROR` 并触发。
9. 消费者跨事务持续反压时，无法缓存的事件进入丢弃计数。

## 实板联调输入

成员 B 只需按冻结的信号角色产生 Mode 0、MSB first 流量，并告知外接模块
实际 CS GPIO；首测 SCLK 建议 1 MHz，稳定后再逐步提高且不超过 25 MHz。
首个黄金事务为 `9F 00 00 00`；W25Q128 常见响应示例是 `FF EF 40 18`，但
验收以实物芯片读出的 JEDEC ID 为准。

天空星官方 SPI-FLASH 示例可用于参考 PA5/PA6/PA7 复用和收发流程，但其示例
配置为 `CPOL_High + CPHA_2Edge`（Mode 3）。本项目监听器按 Mode 0 验收，
成员 B 必须改为 `CPOL_Low + CPHA_1Edge`，不能原样照搬该时序配置。

监听器输出和 AXI 虚拟源经过唯一的 `event_arbiter_2` 后进入同一个
`event_snapshot_buffer`，没有增加第二套缓存或显示路径。

由于 Vivado 2018.3 的 Block Design Module Reference 不接受 SystemVerilog
文件作为引用顶层，`spi_mode0_monitor_bd.v` 仅作为语法包装层；实际协议逻辑
仍全部位于经过自检的 `spi_mode0_monitor.sv`。

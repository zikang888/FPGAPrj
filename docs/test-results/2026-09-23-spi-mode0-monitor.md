# SPI Mode 0 被动监听器第一阶段测试

## 测试结论

通过。独立 RTL 模块已完成协议采样、ready/valid 输出、统一事件编码、
残帧故障触发和显式丢弃计数。SPI 监听器已在仿真中通过
`event_arbiter_2` 接入唯一的 `event_snapshot_buffer`，核心也已提供正式的
通用外部事件入口；当前尚未做板级引脚分配，正式 BD 中该入口暂时绑低。

## 被测文件

```text
fpga/rtl/protocol/spi_mode0_monitor.sv
fpga/sim/protocol/spi_mode0_monitor_tb.sv
```

## 工具

```text
Vivado Simulator 2018.3
xvlog -> xelab -> xsim
```

## 输入语料

测试语料已经扩展为：

```text
00 / FF / 55 / AA
9F + JEDEC ID (EF 40 18)
100-byte deterministic stress transaction
CS interrupted after 4 bits
SCLK long pause
asynchronous phase offset
consumer backpressure
```

## 已验证行为

1. SPI 协议编号固定为 2。
2. ready/valid 反压期间事件数据和触发位保持稳定。
3. 正常事务产生 START、DATA、END。
4. DATA 事件的 `flags={MISO,MOSI}`。
5. JEDEC ID、100 字节事务、异步相位和长暂停保持正确。
6. transaction ID 按 CS 事务递增。
7. 4 bit 残帧产生 `event_type=0x3F`、`flags=0x0004` 和 trigger。
8. 持续反压造成的不可缓存事件进入 `dropped_event_count`。

仿真输出：

```text
PASS: SPI Mode-0 ready/valid, golden corpus, pause, phase, error and stress test
PASS: SPI waveform through ready/valid arbiter to triggered snapshot
PASS: multi_protocol_core AXI, virtual and external snapshot end-to-end test
```

## 当前边界

- 系统采样时钟为 100 MHz。
- 第一阶段限定 SPI SCLK 不高于 25 MHz。
- Mode 0：CPOL=0、CPHA=0。
- MSB first。
- 尚未验证真实 FPGA 管脚电气输入。
- 尚未验证单片机与 FPGA 的真实帧格式。

## 下一步准入条件

在接入正式工程前，由单片机侧提供：

1. SCLK、CS_N、MOSI、MISO 对应 FPGA 管脚。
2. SPI 模式、最大时钟和 bit order。
3. 正常帧定义和至少一组黄金测试向量。
4. 应触发故障快照的异常帧规则。

满足上述条件后，将 SPI 监听器的 ready/valid 端口接入已验证的通用外部入口，
再运行原有快照测试、SPI 测试、全量实现、时序和实板联合测试。

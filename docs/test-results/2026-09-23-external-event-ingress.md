# 外部事件入口与统一仲裁链路测试

## 结论

通过独立 RTL 仿真。`multi_protocol_core` 已从单一虚拟事件脉冲升级为：

```text
AXI virtual event --\
                     event_arbiter_2 -> event_snapshot_buffer -> AXI window
external ready/valid /
```

两个事件源共用唯一仲裁器、快照缓存和 AXI 读取窗口。当前正式 BD 将外部入口
绑低，以便在真实协议管脚尚未冻结时继续生成可用的 LCD/AXI 镜像。

## 接口

```text
ext_evt_valid
ext_evt_ready
ext_evt_data[127:0]
ext_evt_trigger
ext_evt_dropped_count[31:0]
```

生产者在 `valid=1 && ready=0` 时必须保持数据和触发位稳定；只在
`valid && ready` 同时为 1 的时钟沿完成传输。

## 覆盖项

1. 原 AXI 虚拟事件触发 20 条快照，触发索引为 3。
2. ACK 后重新 ARM，外部事件触发 17 条快照，触发索引为 0。
3. 外部首条和末条事件通过 AXI 快照窗口逐字读取并校验。
4. 版本更新为 `0x00010002`，能力位更新为 `0x00000003`。
5. 无并发输入时仲裁冲突计数保持为 0。
6. 仿真脚本用 PASS 文本判定，避免 XSim 在 `$fatal` 后返回 0 造成假通过。
7. 外部生产者丢包计数经 `0x0038` 原值读回，非零时置位
   `CAPTURE_STATUS[3]`；测试值 7 已通过端到端校验。

## 仿真证据

```text
PASS: multi_protocol_core AXI, virtual and external snapshot end-to-end test
```

## 干净工程回归与实现

五组自检测试全部通过：

```text
PASS: event_snapshot_buffer_tb
PASS: event_arbiter_2_tb
PASS: multi_protocol_core_tb
PASS: spi_mode0_monitor_tb
PASS: spi_snapshot_path_tb
SIMULATION_COMPLETED
```

Vivado 2018.3 隔离工程完成综合、布局布线、DRC 和 bitstream：

| 指标 | 结果 |
|---|---:|
| WNS | +3.365 ns |
| TNS | 0.000 ns |
| WHS | +0.036 ns |
| THS | 0.000 ns |
| DRC Errors | 0 |
| Slice LUTs | 4,272 / 53,200 (8.03%) |
| Slice Registers | 7,231 / 106,400 (6.80%) |
| BRAM Tile | 5.5 / 140 (3.93%) |
| DSP | 0 / 220 |

DRC 仍有 AXI VDMA 自带 BRAM 的两条 advisory：`REQP-165` 和 `REQP-181`，
与此前平台基线类型相同。候选 BIT/HDF/ELF 位于
`artifacts/candidates/2026-09-23-readyvalid`，尚未替换已上板基线。

核心端到端测试还覆盖了协议事件与 ARM 命令重叠的边界：ARM 生效期间
`ext_evt_ready` 保持为 0，事件在缓存进入 active 后才完成握手，因此不会被
提前消费而静默丢失。

## 尚未完成

- 候选包 LCD、触摸、D0、D1 的板级回归。
- 真实 SPI 管脚约束与板级联调。

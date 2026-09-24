# 2026-09-23 事件快照离线闭环验证

## 验证范围

- `event_snapshot_buffer`：环回覆盖、触发定位、16 条触发后事件、ACK 和重新 ARM。
- `multi_protocol_core`：AXI-Lite 控制、虚拟事件、元数据及 `0x6000` 快照窗口。
- 完整 Vivado 综合、布局布线、时序、DRC 和 bitstream。
- PS standalone 应用与本次 HDF 配套编译。

## 结果

| 项目 | 结果 |
|---|---|
| 缓冲区 RTL 仿真 | PASS |
| AXI/快照端到端仿真 | PASS |
| 综合/布局布线 | PASS |
| 时序 | PASS，WNS `+3.133 ns`，WHS `+0.036 ns` |
| DRC | 0 Error，2 Advisory |
| LUT / FF | 4260 / 7231 |
| BRAM Tile / DSP | 5.5 / 0 |
| BIT/HDF | PASS |
| PS 应用编译 | PASS |

两条 DRC Advisory 来自 AXI VDMA 内部同步 FIFO 的 WRITE_FIRST 模式，并非
新增事件缓冲区错误。实现报告没有未布通网络，所有用户时序约束均满足。

## 自检预期

PS 启动后 ARM，写入 8 条触发前虚拟事件、第 9 条触发事件和 16 条触发后
事件。预期 `SNAPSHOT_COUNT=25`、`TRIGGER_INDEX=8`，随后读取索引 5 至 12
的 8 条事件并显示在 LCD。完成读取后发送 ACK。

## 尚需实板确认

- JTAG 下载 BIT/ELF 和串口启动信息。
- LCD 画面、GT911 触摸坐标、D1（P21）/D0（P20）LED。
- 真实 SPI 电气输入；该接口尚未替代虚拟事件源。

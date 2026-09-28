# 成员 A 第一周验收记录

## 基线

- 工程：`D:\Vivado\Project\Multi_protocol`
- 分支：`fpga_NumberA`
- 工具：Vivado 2018.3
- 日期：2026-09-26

评审文档中的旧工程路径仅作为历史说明，本记录以用户指定的上述工程为准。

## 本次实际执行

从工程根目录运行：

```powershell
& 'D:\Xilinx\Vivado\2018.3\bin\vivado.bat' -mode batch -source fpga/build/run_sim.tcl
```

结果：

```text
PASS: event_snapshot_buffer_tb
PASS: event_arbiter_2_tb
PASS: multi_protocol_core_tb
PASS: spi_mode0_monitor_tb
PASS: spi_snapshot_path_tb
SIMULATION_COMPLETED
```

随后运行完整构建：

```powershell
& 'D:\Xilinx\Vivado\2018.3\bin\vivado.bat' -mode batch -source fpga/build/build_bitstream.tcl
```

结果：

```text
BUILD_DONE
WNS = 1.615 ns, TNS = 0.000 ns
WHS = 0.036 ns, THS = 0.000 ns
DRC = 0 Error（2 条 VDMA BRAM WRITE_FIRST Advisory）
Bitstream = Multi_protocol.runs/impl_1/multi_protocol_bd_wrapper.bit
HDF = Multi_protocol.sdk/multi_protocol_bd_wrapper.hdf
```

## 覆盖与结论

SPI testbench 已覆盖：

- `00/FF/55/AA` 双向黄金字节。
- JEDEC ID：MOSI `9F 00 00 00`，MISO `FF EF 40 18`。
- 固定种子的 100 字节伪随机全双工事务。
- CS 在 4 bit 后释放，生成 `FRAME_ERROR` 和 trigger。
- 事务起始相对 PL 时钟的异步相位偏移。
- SCLK 在字节中途长时间停顿。
- ready/valid 反压下事件保持稳定。
- 无法缓存的事件进入 dropped 计数，而非静默丢失。
- SPI 事件经唯一仲裁器进入唯一快照缓存。

结论：成员 A 第一周的软件可执行项通过，SPI 监听器已接入正式 Block Design，
U12/U11/U10/U9 管脚已冻结，完整工程能够生成 Bitstream 和 HDF。LCD、触摸和
PS 业务代码未修改。尚未完成且不应冒充完成的是外接 W25Q128 实板 SPI 联调及
CAN 物理通路确认；它们需要成员 B 的 STM32 真值日志及实物核对。

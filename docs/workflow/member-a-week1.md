# 成员 A 第一周执行与理解手册

## 1. 本周边界

第一周只完成并冻结以下内容：

1. 128 位事件 ABI、事件编号、SPI flags 和 ready/valid 语义。
2. 与 AXI、LCD 和具体 FPGA 管脚无关的 SPI Mode 0 被动监听 RTL。
3. 可自动判定 PASS/FAIL 的 testbench。
4. 公共仲裁器、快照缓冲和 SPI 监听器的仿真回归。
5. CAN 物理通路 go/no-go 的工程侧证据整理。

第一周不改 LCD/触摸、不新建第二套 FIFO 或寄存器，也不把“仿真通过”表述为
“实板 SPI 已联调”。2026-09-26 已冻结 P7 管脚并进入第二周板级集成；STM32
接线和 JEDEC 真值日志仍由成员 B 提供。

## 2. 当前实现位置

| 内容 | 文件 |
|---|---|
| SPI 监听器 | `fpga/rtl/protocol/spi_mode0_monitor.sv` |
| SPI 自检 | `fpga/sim/protocol/spi_mode0_monitor_tb.sv` |
| SPI 到快照链路自检 | `fpga/sim/protocol/spi_snapshot_path_tb.sv` |
| 两源仲裁器 | `fpga/rtl/common/event_arbiter_2.sv` |
| 唯一快照缓存 | `fpga/rtl/common/event_snapshot_buffer.sv` |
| AXI 与外部事件入口 | `fpga/rtl/top/multi_protocol_core.v` |
| 全量仿真入口 | `fpga/build/run_sim.tcl` |
| 事件 ABI | `docs/interfaces/register_map.md` |
| SPI 接口说明 | `docs/interfaces/spi_mode0_monitor.md` |

## 3. 先理解数据如何走

```text
SCLK/CS_N/MOSI/MISO
  -> 双触发器同步与边沿检测
  -> 8 bit MOSI/MISO 移位寄存器
  -> START / DATA / END / FRAME_ERROR 事件
  -> evt_valid/evt_ready
  -> event_arbiter_2
  -> event_snapshot_buffer
  -> AXI 快照窗口
  -> PS/LCD
```

SPI Mode 0 的空闲 SCLK 为低电平，监听器在上升沿采样 MOSI/MISO，先收
MSB。CS 下降沿开始一个事务并递增事务号；每 8 个上升沿产生一个 DATA；CS
上升沿正常结束。如果 CS 在不足 8 bit 时上升，就产生带 trigger 的
FRAME_ERROR。

ready/valid 可理解为“一手交数据，一手接数据”：只有 `valid && ready` 的
那个时钟沿才真正成交。接收方暂时不 ready 时，发送方必须持续举着 valid，
并保持 data/trigger 不变。监听器只有一个事件保持寄存器，若反压期间又出现
新事件，无法缓存的事件会累加到 `dropped_event_count`，因此不会静默丢失。

## 4. 自动验收

在工程根目录运行：

```powershell
& 'D:\Xilinx\Vivado\2018.3\bin\vivado.bat' -mode batch -source fpga/build/run_sim.tcl
```

最终必须看到：

```text
PASS: event_snapshot_buffer_tb
PASS: event_arbiter_2_tb
PASS: multi_protocol_core_tb
PASS: spi_mode0_monitor_tb
PASS: spi_snapshot_path_tb
SIMULATION_COMPLETED
```

其中 SPI 自检覆盖 `00/FF/55/AA`、`9F + EF 40 18`、固定种子的 100 字节
伪随机数据、CS 在 4 bit 后结束、异步相位、SCLK 长暂停和消费者反压。

如果希望用 GUI 看波形，在 Vivado 的 Sources 中找到某个 `*_tb`，右键
`Set as Top`，然后在 Flow Navigator 中选择 `Run Simulation -> Run
Behavioral Simulation`。自动验收仍以 `run_sim.tcl` 的五组全通过为准。GUI
切换仿真顶层会改写 `Multi_protocol.xpr`；若没有主动改工程设置，退出 Vivado
后执行 `git restore -- Multi_protocol.xpr` 即可清掉这类界面状态变化。

## 5. CAN 第一周闸门

目前只能给出“暂不进入正式功能”的结论：

- `create_bd.tcl` 没有启用 PS CAN0/CAN1。
- 当前 XDC 没有 CAN TX/RX 管脚。
- 仓库无法证明载板已连接 CAN 收发器、终端电阻和合适电平。

成员 B 需要实物核对 MIO/EMIO 可达管脚、收发器型号（例如 SN65HVD230）、
3.3 V 电平、CANH/CANL 和两端 120 欧终端。上述信息齐全后才把结论改为 GO；
否则 CAN 保持扩展功能，不影响 SPI 主闭环。

## 6. 第一周交付判据

- [x] 事件 ABI 和 SPI 事件语义已写入版本控制文档。
- [x] SPI Mode 0 纯 RTL 已实现。
- [x] SPI testbench 自动判定 PASS/FAIL。
- [x] 计划要求的边界和随机语料均覆盖。
- [x] SPI 经 ready/valid 仲裁进入唯一快照缓存的仿真通过。
- [x] 原 LCD/触摸/AXI 代码未被改写。
- [x] FPGA 监听管脚已冻结：U12/U11/U10/U9，正式 BD 接入。
- [ ] 真实 STM32 SPI 三方对照：属于第二周，等待成员 B 接线和真值日志。
- [ ] CAN 物理通路：等待成员 B 实物核对，当前按 NO-GO 管理。

## 7. 提交前检查

```powershell
git status --short
git diff --check
```

只提交 `fpga/rtl`、`fpga/sim`、`fpga/build`、`docs` 等源文件。不要提交
`Multi_protocol.sim`、`Multi_protocol.ip_user_files`、`.Xil`、runs、SDK Debug
或 Eclipse metadata。切换分支前关闭 Vivado/SDK，避免锁文件和工程界面状态
形成无意义差异。

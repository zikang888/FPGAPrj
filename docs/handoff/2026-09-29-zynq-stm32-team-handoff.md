# 2026-09-29 队友交接：AC820 Zynq + 天空星 F407 首次 SPI 联调

> 先读本页，再碰板子。当前仓库分支是 `codex/fpga-b-closure`，**尚未合入主线**。
> 本页记录的是 2026-09-28 晚上的状态；“编译/仿真通过”不代表新镜像或 STM32 已实板通过。

## 一眼看懂当前状态

| 项目 | 已有内容 | 实际验证边界 |
|---|---|---|
| Zynq PL | SPI Mode-0 被动监听、128 位统一事件、仲裁、256 事件快照、AXI 窗口、D1/视频链路 | 新 RTL 五组 Vivado 仿真通过，BIT 已实现；**新 BIT 未上板** |
| Zynq PS | HOME / SELF TEST / EVENTS 三页、触摸像素滚动、虚拟 25 事件自检、`ARM SPI`/`WAIT SPI`/`SHOW DEMO` 真实捕获入口 | 新 ELF 对新 HDF 编译通过；**新组合未做 LCD/触摸实测** |
| STM32F407 | 跨平台协议执行器、HAL 适配、JEDEC `9F000000`、10 次一致性读、JSONL 真值日志；还含 UART/I²C/CAN 测试代码 | 协议执行器宿主单测通过；**没有 CubeMX/HAL 生成的 F407 完整工程或可烧录 HEX/ELF** |
| 双板 SPI | 立创·天空星 F407VGT6 高配核心板板载 W25Q128 → AC820 P7 被动监听 | **尚未接线，没有真实 MISO、双板事件或日志比对结果** |

上次对正在运行的**旧 A-map 虚拟演示镜像**做过只读 JTAG：CPU0 Running，PL ID `4D505254`、版本 `00010003`、25 条虚拟事件就绪、丢包 0。这个结果不是新镜像的验收，更不是 STM32 SPI 验收。

## 先找这些文件

- 唯一用于本轮首次联调的匹配镜像：[`../../candidates/numberA_0928_numberC_p7_A_live_spi/`](../../candidates/numberA_0928_numberC_p7_A_live_spi/README.md)。目录中 BIT、HDF、PS ELF 的 SHA-256 已列出；**三件套必须一起使用**，不要混用旧 A-map 或 C-map 镜像。
- FPGA 引脚约束：[`../../fpga/constraints/top.xdc`](../../fpga/constraints/top.xdc)；SPI 监听 RTL：[`../../fpga/rtl/protocol/spi_mode0_monitor.sv`](../../fpga/rtl/protocol/spi_mode0_monitor.sv)。
- PS 主循环 / 捕获 / UI：[`../../software/src/main.c`](../../software/src/main.c)、[`../../software/src/capture_demo.c`](../../software/src/capture_demo.c)、[`../../software/src/platform_ui.c`](../../software/src/platform_ui.c)。
- F407 说明与代码：[`../../stm32_f407/README.md`](../../stm32_f407/README.md)、[`../../stm32_f407/STM32CubeMX配置.md`](../../stm32_f407/STM32CubeMX配置.md)、[`../../stm32_f407/examples/main_integration.c`](../../stm32_f407/examples/main_integration.c)；`common/` 是可宿主测试的逻辑，`hal/` 是 STM32F4 HAL 适配。
- 更细的接线与上板步骤：[`../hardware/spi_board_test.md`](../hardware/spi_board_test.md)；本次构建与未测事项：[`../test-results/2026-09-28-live-spi-preboard.md`](../test-results/2026-09-28-live-spi-preboard.md)。协议规则唯一真源是 [`../protocol-rules/protocol_rules.yaml`](../protocol-rules/protocol_rules.yaml)，规则所有者为成员 C，不要为让测试通过临时改 ABI/阈值。

## 硬件接线：按核心板**背面丝印**认孔

用户确认是**单独的**天空星 STM32F407VGT6 高配核心板，不插筑基底板；仍需看实物确认 W25Q128 已焊装。以下左右均指用户给的**背面朝上、USB 口朝下**照片。右侧双列排针从最上方 `REF | A02` 算第一行；左/右孔一旦翻面会反过来。

| F407 背面丝印孔位 | 照片位置 | AC820 P7 | FPGA 管脚 / 信号 |
|---|---|---|---|
| `GND` | 左侧底部 `3V3 | GND` 或 `5V0 | GND` 行的**右孔** | 板上 GND | 共地，**先接** |
| `A04` = PA4 | 右侧第 3 行 `A03 | A04` 的**右孔** | P7-2 | U11 / CS_N |
| `A05` = PA5 | 右侧第 4 行 `A05 | A06` 的**左孔** | P7-1 | U12 / SCLK |
| `A06` = PA6 | 同一行的**右孔** | P7-4 | U9 / MISO |
| `A07` = PA7 | 右侧第 5 行 `A07 | C04` 的**左孔** | P7-3 | U10 / MOSI |

两板各自正常供电，**不要互接 3V3 或 5V 电源脚**；FPGA 四根线仅输入，不驱动 MISO。不要再给同一 CS 并联第二颗外置 Flash。F407 背面照片不能证明 AC820 P7 的 1 脚方向；**P7 也必须按 AC820 实物丝印/手册核对**，确认后才上电。

## 明天建议的执行顺序

1. **先完成 F407 可烧录工程。** 用 STM32CubeMX/现有 STM32F4 HAL 工程生成最小配置：SPI1 PA5/PA6/PA7，主机全双工、Mode 0、8 位 MSB-first、约 1 MHz；PA4 为上电默认高电平的推挽 GPIO **软件 CS**；USART1 PA9/PA10 作为独立 115200 JSONL 日志口。加入 `stm32_f407/common/src`、`hal/src` 及各自头文件路径，在生成的 `main.c` USER CODE 中接入示例；`MX_GPIO_Init()`、`MX_SPI1_Init()`、`MX_USART1_UART_Init()` 后调用 `MemberC_Init()`，可控地调用 `MemberC_RunSmokeTests()`。不要拿仓库中的示例文件覆盖 CubeMX `main.c`。先单板确认 UART 日志与板载 Flash JEDEC ID；首读非全 `00/FF` 也要与实物型号核对。
2. **断电接五线并复核。** 先 GND，再 CS/SCLK/MOSI/MISO；双方电源脚不互接。逐线用丝印与 AC820 P7 方向复核，必要时用万用表确认 GND。
3. **冷启动并只下载一次 Zynq 新候选。** 用本页所指的候选 BIT/HDF/ELF，在 Vivado/SDK 中从该 HDF 生成/选用匹配 PS 初始化；确认下载器实际选择的是候选目录。仓库根目录的 `download_jtag.tcl` **默认引用根目录旧构建输出**；`fpga/build/zynq_jtag_board_test.tcl` 虽支持指定 BIT/ELF，仍引用根目录 `ps7_init.tcl`，核对前不要直接照跑。不要写 boot Flash。先确认三页、25 条虚拟事件、触摸滚动和 D1；新镜像未经过这些实板检查。
4. **先武装 Zynq，再启动 STM32 流量。** 在 EVENTS 点 `ARM SPI`，应出现 `WAIT SPI`；随后复位/启动 F407 执行 JEDEC 测试。首字节 MOSI `9F` 会触发；硬件再收 16 条事件才冻结。无其他流量时，三个完整四字节 JEDEC 事务足够形成快照，典型为 18 条事件、触发索引 1；以实际寄存器和日志为准。屏幕出现真实 SPI 事件后，点 `SHOW DEMO` 应恢复虚拟事件。
5. **逐字节对账。** F407 JSONL 应记录每笔 `tx=9F000000` 和实际 `data`（四字节 RX）；PL 协议号应为 2，START/DATA/END 顺序正确，DATA 的 `flags[15:8]` 是 MISO、`flags[7:0]` 是 MOSI。F407 `txn` 与 PL 事务 ID 是各自本地计数，**不要求数字相等**；按顺序、字节与时间对应。同笔四个 DATA 的 MOSI/MISO 和 F407 日志逐一比，检查 `EXT_DROPPED` 与快照 `DROPPED` 为 0。
6. **若卡住先留证据。** 保存 F407 JSONL、Zynq UART、屏幕照片、JTAG 只读寄存器结果和接线照。只读脚本为 [`../../fpga/build/zynq_jtag_readonly_status.tcl`](../../fpga/build/zynq_jtag_readonly_status.tcl)。此前用户报告**第二次下载会卡在色块变换**，原因尚未定位；不要无记录地反复下载/复位。若 `WAIT SPI` 不变，先查 F407 是否真的发出 9F、CS 是否完整、P7 是否接对，再看捕获状态和丢包数。

## 目前不要误判为已完成

- 新 BIT/HDF/ELF 已匹配编译，但未在 Zynq 上下载验证；五组仿真通过，WNS `+3.118 ns`、DRC `0 Error/2 Advisory`。STM32 宿主单测通过，**不是 F407 HAL 编译或实板通过**。
- F407 的 SPI 之外虽有 UART/I²C/CAN 代码，相关硬件接线和跨板验收未完成；先聚焦 JEDEC 首闭环。
- 最新屏幕滚动“响应慢、触发不及时”的具体复现尚未拿到。当前代码已有逐主循环像素拖动和局部刷新，但新镜像的触摸手感、帧耗时及全链路回归尚未实测；请单独记录现象，不要把编译通过当作交互验收。
- 根目录的 `Multi_protocol.xpr` 和两个 `gen_run.xml` 曾被 Vivado 打开后自动重排，工作树里可能显示未提交修改；这些**没有进入推送提交**。不要把它们误当作本轮 RTL 改动。

# Vivado / Vitis 2026.1 离线迁移候选版本

本分支以 `fix/fpga_waveform` 的 `0d9fde5b312a62feed08525b0c1c31f4385e7f81` 为基线，迁移目标为 ACZ702 + AC820、`xc7z020clg484-2`。2026-10-24 完成离线构建；用户明确未连接 FPGA，因此本候选版本尚未通过实板验收。

## 工作区与打开方式

- 新源码：`D:\FPGA_MUCPrj\migration_work\FPGAPrj_2026_1`，分支 `migration/vivado-vitis-2026.1`。
- 新工程：`D:\FPGA_MUCPrj\migration_build\2026.1\pl\Multi_protocol.xpr`。
- 新 Vitis 工作区：`D:\FPGA_MUCPrj\migration_build\2026.1\vitis`。
- 配套候选包：`D:\FPGA_MUCPrj\migration_build\2026.1\candidate`。
- 官方文档：`D:\FPGA_MUCPrj\docx\AMD_Official`；此前的 `DOCS` 资料仍保留。

双击本源码目录下 **`01_Open_Vivado_2026_1.cmd`** 打开新版工程。仓库原有 `01_Open_Vivado.cmd`、SDK/2018.3 脚本和跟踪的旧 XPR 是历史入口；新版入口使用本说明中的文件。原 `D:\FPGA_MUCPrj\Multi_protocol`、固定审查副本及本机其他 FPGA 工程未用于新版写入或升级。

## 离线检查结果

| 项目 | 结果 |
|---|---|
| Vivado | 2026.1，SW Build 6511674，目标器件与综合许可实际通过 |
| Vitis | 2026.1，SW Build 6497934，Cortex-A9 standalone / SDT |
| RTL | 八项 XSIM 回归通过，各项日志单独保存 |
| 宿主逻辑 | 11 项 C 测试及 UI 预览、按键、历史、滚动检查通过 |
| 硬件产物 | 从源码重建 BIT，导出 fixed、include_bit XSA；包内 BIT 与独立 BIT 逐字节一致 |
| ARM 软件 | Hello World、业务 ELF、FSBL 均成功编译；业务程序 `-O3 -g1` |
| 内部时序 | WNS 0.830 ns，TNS 0；WHS 0.036 ns，THS 0 |
| CDC | 87 个已报告端点均 safe，unsafe / unknown 为 0 |
| 总线偏斜 | 三组约束通过，最小余量 9.133 ns |
| DRC | 0 Error / Critical Warning；VDMA BRAM 有两项 WRITE_FIRST advisory |
| 外部时序 | 尚未完成 LCD / CAN 输出时序预算；不能将内部时序通过扩展成整机验收 |

## 迁移内容

1. 为 2026.1 新建受路径边界保护的构建目录；综合并行任务为 2、工具线程为 4，适配本机 16 GB 内存。
2. VTC 从 6.1 改为目录中的 6.2，保留 800×480 Custom 参数；两处常量改成 inline HDL。其余总线、地址映射、RTL、XDC 保持基线。
3. PS7 的归一化参数与固定基线 BD 完全一致。实际像素时钟为 **32.727272 MHz**，与原 BD 一致；旧 Tcl 中 33.333336 MHz 是被工具重新计算的派生值，未据此改变分频。
4. HDF 导出改为 XSA；Python API 创建平台、BSP 和应用，采用实际支持的 `empty_application` 模板。
5. 新增 `platform_bsp_compat.h`，SDT 初始化使用基址，旧流程保留 Device ID；GPIO 使用 BSP 中断 ID / parent 和官方 interrupt wrapper；SDT 时间源头文件改为 `xiltimer.h`。
6. 新 BSP 已生成自定义核 `0x40000000` 的宏，无需虚构驱动或手工补 Device ID。VDMA / VTC 为 `0x43000000` / `0x43C00000`。
7. DDR 基址 `0x00100000`；帧 0=`0x01100000`，帧 1=`0x01220000`，预留至 `0x01340000`。应用链接限制在前 16 MiB，heap / stack 各 64 KiB；实际 ELF LOAD 段与帧缓冲无重叠。
8. 修正新版 GCC 指出的事件标签缓冲区可能未初始化问题。未修改厂商生成的驱动/FSBL 告警代码。
9. 本机 Vitis Python 客户端的 Windows dispose 只终止 cmd 包装进程；构建脚本仅清理自身创建的服务进程树，以释放本工作区锁。

## 重建

在新源码目录执行：

```powershell
.\tools\migrate_2026_1.ps1 -Step all
```

也可分别使用 `-Step sim`、`pl`、`ps`、`host`。`pl` 每次从源码重建 BD 和运行，不使用旧 2018.3 DCP / BIT / BSP。需要重新补充审查报告时：

```powershell
Set-Location D:\FPGA_MUCPrj\migration_build\2026.1
& E:\AMDDesignTools\2026.1\Vivado\bin\vivado.bat -mode batch -source D:\FPGA_MUCPrj\migration_work\FPGAPrj_2026_1\fpga\build\audit_2026_1.tcl -log logs\audit.log -journal logs\audit.jou
```

源码提交后，在新源码目录执行打包工具；它核对仿真、时序、CDC、BSP、BIT/XSA 配套关系、ELF 内存和旧工程元数据，然后生成带 SHA256 清单的候选目录及 ZIP：

```powershell
& C:\Users\dell\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe .\tools\package_2026_1.py
```

## 连接板卡后的验证

本轮未运行 JTAG 下载，也未接触 QSPI/SD 启动介质。`program_2026_1` 入口已做离线文件和命令语法检查，实际板上加载顺序仍需首次验证。先核对板型、接线、电源与 JTAG 链，避免多目标歧义。

只检查文件哈希和调试入口、不连接硬件：

```powershell
.\tools\program_2026_1.ps1 -PreflightOnly
```

连接且核对 ACZ702 后，使用配套候选文件进行首次 JTAG 加载：

```powershell
.\tools\program_2026_1.ps1
```

解压候选 ZIP 后，也可运行包内的 `program_2026_1.ps1`。加载会重配置 PL 并初始化 PS；不写入 Flash。随后依次检查：

1. UART1 115200 输出，SYS_ID=`0x4D505254`、VERSION=`0x00010008`、BUILD_ID=`0x20261021`、CAPABILITIES=`0x000001FF`；scratch、LED、时间戳。
2. LCD 800×480、Video Out locked、VDMA status、双缓冲、GT911 四角触摸和页面按键。
3. SPI 100 笔四字节 JEDEC：START=100、DATA=400、END=100、EVENT=600，丢失/重复/顺序错误为 0。
4. UART 115200 8N1、I2C 100 kHz、CAN 500 kbit/s 标准帧的正常与错误事件；会话、冻结、re-arm、历史、20 ms 空闲冻结。

旧分支已有的 UART 仅 RX、I2C EEPROM `nack_or_mismatch` 和 CAN 附带错误事件仍需如实对账，不把它们写成迁移后已修复。完成短回归后再进行压力与长时间运行。需要独立 SD 启动时，再制作并验收 BOOT.BIN。

## 报告和限制

`reports/timing.rpt`、`drc.rpt`、`cdc.rpt`、`bus_skew.rpt`、`methodology.rpt`、`ip_status_final.rpt`、`io.rpt` 和 `memory_verification.json` 保存真实检查依据。早期 `ip_status.rpt` 在 module reference 打开前生成，有 unresolved 提示；以打开 BD 后生成的 `ip_status_final.rpt` 为最终状态，所有引用已 up-to-date。

未补入未经屏幕规格/板级延迟核实的 output delay；methodology 报告保留 20 项 TIMING-18（19 个 LCD 输出和 CAN_TX）。输入同步器、视频 FIFO CDC 均通过结构检查；时钟无公共主时钟、厂商 XPM 同时钟同步器告警，以及无实测翻转活动的功耗估算限制已保留在原始日志中。

候选 `manifest.json` 固定源码提交、工具版本、文件哈希和验收边界。该包的状态是“离线构建验证通过，未连接开发板”，不能作为已完成实板验收的发布版本。

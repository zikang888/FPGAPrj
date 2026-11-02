# member C · 最新源码的 Vivado / Vitis 2026.1 迁移版

本轮日期：2026-11-02。源码基线是 GitHub 仓库 `zikang888/FPGAPrj` 的 **`codex/ui-four-protocol-20261023` / `c5f44ff57ff1b551ba32569f4a2103a1b1cf35be`**（2026-11-01 15:59:12 +08:00）。它包含 `fix/fpga_pl` 的中文工作台以及最新异常事务保留和保存回放功能。

**本轮独立重建、九项 RTL 回归、宿主检查、BIT/XSA 和 ARM 构建已通过。本轮没有连接 FPGA / STM32，尚未进行新镜像实板验收。** 2026-10-24 的触摸、切页和协议实测结果仅属于上一版；上游 2018.3 的实板记录也不等于本轮 2026.1 镜像验收。请其他成员使用匹配文件进行交叉验证。

内部时序：WNS=0.738 ns、WHS=0.026 ns、TNS/THS=0；87 个已报告 CDC 端点均 safe。配套镜像与下载入口见 [本轮离线候选文件](releases/vivado-vitis-2026.1-memberC-20261102/README.md)。

## 保留的最新版功能

- 中文五页工作台、协议页签、历史手势和波形保持。
- TESTS 的异常事务保留模式：正常事务累计计数并释放临时空间，异常事务保存，后续正常流量不覆盖。容量仍为 256 条事件、最近 8 轮 RAM 历史。
- 单次捕获保留原有正常轨迹模式；已保存的异常事务可以回放。
- I2C busy NACK 作为 INFO，不加入异常存档；停用的 UART parity/baud 和 CAN bus-off 项不重新启用。
- 平台 VERSION=`0x00010009`，CAPABILITIES=`0x000003FF`；BUILD_ID 仍为上游定义的 `0x20261021`，具体源码身份以清单中的 commit 为准。

生产 RTL 和 XDC 不做迁移性改写。迁移集中在 2026.1 的工程/IP 创建、SDT BSP 初始化、计时与中断、xil_printf 的 ARM32 参数，以及隔离构建和交付检查。

## 路径与入口

| 内容 | 本机路径 |
|---|---|
| 新源码 | `D:\FPGA_MUCPrj\migration_work\FPGAPrj_2026_1_latest_20261102` |
| 新构建 | `D:\FPGA_MUCPrj\migration_build\2026.1-latest-20261102` |
| 新工程 | 新构建目录中的 `pl\Multi_protocol.xpr` |
| 新 Vitis workspace | 新构建目录中的 `vitis` |
| 候选镜像 | 新构建目录中的 `candidate` |
| 上一轮迁移 | `migration_work\FPGAPrj_2026_1` 和 `migration_build\2026.1`，保持原样 |

原 `Multi_protocol` 工程、2018.3 安装和上一轮已测迁移版本保留。请使用 **`01_Open_Vivado_2026_1.cmd`** 打开本轮工程；仓库继承的旧 XPR / SDK 入口及 `03_Program_Tested_Release.cmd` 仍属于旧版流程。

从新源码目录重建：

```powershell
.\tools\migrate_2026_1.ps1 -Step all
```

可分别执行 `-Step sim`、`pl`、`ps`、`host`、`audit`；工具路径可用 `-ToolRoot` 指定，宿主 GCC 用 `-HostCompiler` 指定。默认使用 `E:\AMDDesignTools\2026.1`、`D:\MinGW\MinGW\bin\gcc.exe`。输出目录与 10 月 24 日版本分离。

PS 构建会导入 `.c` / `.h` / **`.inc`**，包含最新 `ui_a_views.inc` 与 `saved_waveform_views.inc`，并核对 DDR 帧缓冲与 ELF LOAD 段不重叠。

## 验证与交付

RTL 回归现在是 **9 项**：原八项加 `error_retention_tb`。上游核心已升级 ABI，但 AXI 测试台仍使用旧 1.8 / 0x1FF 预期；本轮修正为 1.9 / 0x3FF，保留其余功能断言，并将新异常保留测试纳入统一入口。首次失败日志单独保留。

宿主回归包括 16 项基础检查、保存回放检查和生产 UI 渲染/触摸动作回归。UI 图片是宿主预览，不能作为本轮实屏证据。

源码提交后可打包：

```powershell
python .\tools\package_latest_2026_1.py
.\tools\program_2026_1.ps1 -PreflightOnly
```

打包器核对独立测试日志、内部时序、CDC / bus skew、PS7 参数、最新 RTL/XDC 不变、包括 `.inc` 的编译副本、ELF/XSA/初始化配套及旧工程保护，再生成带 SHA256 的 `candidate` 和离线 ZIP。最终结果和数值保存在新构建目录的 `verification.json` 与 [本轮记录](docs/test-results/2026-11-02-latest-vivado-2026.1-migration.md)。

## 连接板卡后的交叉验证

先重新枚举线缆和串口，核对唯一目标。`tools/program_2026_1.ps1` 加载候选组，不写 QSPI / SD。若使用本轮随仓库交付的镜像目录，则执行该目录中的下载包装器，它会从同目录读取 manifest 和配套文件。

按顺序确认：

1. 新 ID / VERSION / CAPABILITIES、scratch 和时间戳，再检查 LCD / GT911、中文页面与切换。
2. 单次捕获的四协议正常波形，以及正常/错误统计。
3. 正式 TESTS 中四协议各 1000 笔、第 500 笔异常不会被后续正常流量覆盖；容量满、缺 END、SPI Short / Extra / MISO、I2C busy INFO 等场景。
4. 停止保存、异常事务上一条/下一条、历史重开、返回单次捕获时不篡改实时缓存。
5. 压力与持续运行、外部时序和独立启动（如需要）。

注意新版 TESTS 正常流量只计数，不应照搬旧版“SPI 600 个事件必须保留末 256 条”的验收预期。先前本机 2026.1 hw_server 有目标枚举阻塞；已知兼容路径是 2026.1 XSDB + 2018.3 hw_server，需在本轮硬件现场重新确认。LCD / CAN 外部时序预算未用假定 output delay 消除。

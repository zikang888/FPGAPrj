# 外部 FPGA 工作流迁入本机（2026-10-15）

## 来源与处理范围

用户提供 `fpga_memory_lite(1).zip` 和 `fpga_skills(1).zip`。原件已复制到 `C:\Users\11914\Documents\Codex\fpga-workflow-imports`，以免微信临时目录清理后丢失。前者包含历史知识、证据、SQLite 索引与 Python 检索脚本；后者包含 `fpga-workflow`、`fpga-design`、`fpga-xilinx`、`summary-writer` 和大型 `scope-debug-pro` 技能资料。技能 ZIP 内有多个同名顶层 `SKILL.md`，不能直接整体解压到一个技能目录，否则会相互覆盖。

已按本机实测环境整理并安装 `C:\Users\11914\.codex\skills\fpga-workflow`，保留核心阶段门槛、同源硬件交接链、JTAG 与 QSPI 分离、可验证性要求。通用设计／示波器资料仍保存在原始归档中，未把引用不完整的通用技能整包直接启用。历史 SQLite 索引仍属旧电脑快照，不把旧绝对路径或项目“verified”状态视为本机事实。

## 路径核对

| 原工作流写法 | 本机核实结果 |
| --- | --- |
| `D:\FPGATask` | 不存在；当前项目在 `D:\fpga_class\FPGAPrj\integration_AB_week2_C` |
| `C:\Xilinx\Vivado\2018.3` | 不存在；Vivado 在 `D:\Vivado2018.3\Vivado\2018.3` |
| `C:\Xilinx\SDK\2018.3` | 不存在；SDK/XSCT 在 `D:\Vivado2018.3\SDK\2018.3` |
| 旧知识库默认从其父目录扫描项目 | `scripts/common.py` 硬编码 `WORKSPACE_ROOT = ROOT.parent`；只改 `config/source_rules.json` 中的路径不会让旧索引正确迁移 |
| 当前工程 `Multi_protocol.runs/impl_1/*.bit` | 当前工作树不存在；已发布 BIT/HDF/`ps7_init.tcl` 同在 `Multi_protocol.sdk/platform_hw` |

当前 HDF/BIT/初始化文件哈希与 `docs/test-results/2026-10-08-ab-week2-c-board-blocker.md` 的记录一致。SDK 验证工作区的 HDF 和 `ps7_init.tcl` 哈希也与发布目录一致。

## 对工程脚本的修正与验证

- `fpga/build/zynq_jtag_board_test.tcl` 默认改用本机存在的 `platform_hw` BIT/初始化文件；自定义 BIT 需显式配对初始化脚本；加入不连接硬件的 `ZYNQ_PREFLIGHT_ONLY=1`。已观察到 `ZYNQ_JTAG_PREFLIGHT_DONE`。
- `software/build_ps_app.tcl` 可识别 GUI 导出的 `platform_hw/system.hdf`，按同源选择 BIT；在替换 SDK 生成项目之前先暂存 HDF/BIT；加入 `MULTI_PROTOCOL_PREFLIGHT_ONLY=1`。已观察到 `PS_BUILD_PREFLIGHT_DONE`，解析出的 HDF、BIT、SDK workspace 均为本机实际路径。**没有执行会替换 SDK 工程的完整重建**。
- `README.md` 更新本机工具路径、交接位置、预检方法和 LCD 帧缓冲格式。
- 注意：当前 XSCT 在 Tcl `error` 或 `exit 1` 后，外层批处理仍可能报告退出码 0。必须检查成功标记和错误文本，不能只看进程退出码。

## 当前烧录链状态

旧 ARM GCC 在隔离进程内报 DLL 重定位错误；以正常权限调用同一个本机 GCC 后，`software/src/platform_ui.c` 成功编译并链接到新的 `platform_app.elf`（SHA-256 `444CF4466D27F90738E9A204B896B4CA207F1F53A8AD0330DC5FEDD0782627B3`）。

正常权限下 XSCT 可连接 JTAG；首次只读探测出现 PS DAP AP transaction error，同源 BIT＋初始化＋新 ELF 的测试脚本按安全检查在下载前停止。用户将 AC820/Zynq 单独重新上电后，低速只读 JTAG 探测显示 APU、两颗运行中的 Cortex-A9 与 `xc7z020`。随后同源 BIT＋`ps7_init.tcl`＋新 ELF 的易失性下载完成，XSCT 输出 `ZYNQ_JTAG_PL_FIRST_TEST_DONE`，PL 寄存器读得 `SYS_ID=4D505254`、`VERSION=00010004`、`CAPABILITIES=0000000F`。用户现场确认新版 HOME、EVENTS 滚动、ERRORS 切换均正常，无花屏或闪屏。未写 QSPI；STM32 连续传输压力与 VDMA 状态仍未复测。

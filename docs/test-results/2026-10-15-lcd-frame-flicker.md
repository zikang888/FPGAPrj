# LCD 花屏／闪屏排查与修复（2026-10-15）

## 现象与原因

数据传输触发状态局部刷新、或页面切换后继续局部刷新时，LCD 可能短暂显示旧像素或撕裂画面。

`software/src/platform_ui.c` 原双缓冲路径有两个风险：

1. `XAxiVdma_StartParking()` 只提出换帧请求，代码却立即按“已切换”更新软件帧号，并用固定 34 ms 判断旧帧已安全。固定时间不能证明 VDMA 已经切换；在换帧延迟时，CPU 可能改写仍被扫描的帧。
2. 切换后会将本次脏区域 `memcpy` 到备用帧，但没有把这次复制写回 D-cache。下次若只刷新另一个区域，VDMA 会从 DDR 读到备用帧旧内容，于是两帧局部内容不一致，呈现交替闪烁／花屏。

## 修复

- 只在 `XAxiVdma_CurrFrameStore()` 确认新帧成为当前扫描帧后，才向旧帧复制脏区域；不再以 34 ms 代替硬件确认。
- 复制后立即 `Xil_DCacheFlushRange()` 同步备用帧的脏区域。后续局部刷新即使发生在另一位置，两帧的已完成内容也一致。
- `StartParking` 失败时不交换软件帧号，保留待绘制状态供下次调用重试。
- VDMA 启动前清零并写回两块帧缓冲，避免首次显示未初始化的 DDR 内容。

## 验证状态与实板复测

- 已核对 SDK 驱动 `XAxiVdma_CurrFrameStore()` 读取 PARKPTR 的当前读帧字段，不是所请求的参考帧字段。
- 已执行 `git diff --check`，无补丁空白错误。
- 已用本机 Arm Compiler 6 对 `platform_ui.c` 执行 `-fsyntax-only -Wall -Wextra -Werror`，通过；此检查采用 Cortex-M4 解析模式，仅验证 C 语法／告警，不等同于 Cortex-A9 构建。
- 旧 ARM GCC 在隔离进程内启动报 Windows 错误 623；在本机正常权限下启动成功。用现有 SDK BSP 对 `platform_ui.c` 重新编译、链接成功，新 ELF 为 `.sdk_ui_redesign_validation/platform_app/Debug/platform_app.elf`，SHA-256 `444CF4466D27F90738E9A204B896B4CA207F1F53A8AD0330DC5FEDD0782627B3`。
- 首次 JTAG 诊断出现 PS DAP AP transaction error，安全脚本在下载前停止。AC820/Zynq 单独重新上电后，250 kHz 只读探测重新枚举到两颗运行中的 Cortex-A9。
- 随后通过 JTAG 完成同源 BIT、`ps7_init.tcl`、新 ELF 的易失性下载；日志依次出现 `BITSTREAM_PROGRAMMED`、`PS_INITIALIZED`、`DOWNLOAD_ELF`、`RUN_CPU0`、`ZYNQ_JTAG_PL_FIRST_TEST_DONE`。PL 寄存器读数：`SYS_ID=4D505254`、`VERSION=00010004`、`CAPABILITIES=0000000F`。未写 QSPI。
- 用户现场确认新版 HOME 页面显示正常，切换 HOME／EVENTS／ERRORS 并滚动事件时无花屏、闪屏。此项证明本轮人工可见的交互回归通过；尚未记录两轮连续切换、STM32 连续 SPI 数据压力、VDMA MM2S 状态与当前读帧号，不把这些扩展项记为通过。

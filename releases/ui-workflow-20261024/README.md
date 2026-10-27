# 四协议易用性 UI 候选包

状态：**离线编译和回归通过，尚未进行本轮实板验证。不是已验收的上板发布版。**

本包包含一套配对文件，使用时不要混入其他目录的同名文件：

- `multi_protocol_bd_wrapper.bit`：来自队友 `fix/fpga_waveform` 提交 `0d9fde5`。
- `system.hdf`：与上述 BIT 一同导出的硬件描述。
- `ps7_init.tcl`：同一 `platform_hw` 的 PS 初始化文件。
- `platform_app.elf`：本次 UI 源码在新生成的匹配 BSP 上编译的 Cortex-A9 程序。
- `manifest.json`：以上4个文件及全部应用源码的 SHA256。
- `preview/`：实际 C 绘图代码的主机端预览，不是实板照片。

本地源码和工程：`D:\fpga_class\FPGAPrj\ab_new_board_test_20261017`。

本次没有改变用户修改中的 `tools/project.ps1` 或旧下载入口。
旧的 `03_Program_Tested_Release.cmd` / `program_session_candidate.ps1` 不指向本包，
不要用它们来判断是否已下载这版 UI。后续上板必须显式选择本包配对的
BIT、PS初始化和ELF，再核对启动指纹：

`PS READY: FOUR PROTOCOL WORKFLOW UI 20261023`

功能操作和验证边界见 `../../docs/interfaces/ui_workflow_20261024.md`。

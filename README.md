# Zynq-7020 Multi Protocol Platform

本工程适用于 Vivado/SDK 2018.3 和 `xc7z020clg484-2`。从 2026-10-18 起统一使用 `build/vivado` 和 `build/sdk` 作为开发工作区。完整目录说明见 [PROJECT_PATHS.md](PROJECT_PATHS.md)。

## 克隆后使用

1. 双击 `01_Open_Vivado.cmd` 打开完整 Vivado 工程；首次使用会从源码生成 BD 和顶层 wrapper。
2. 双击 `02_Open_SDK.cmd` 打开包含 `platform_hw/platform_bsp/platform_app` 的 SDK 工作区。
3. SDK 中展开 `platform_app/repo_src` 编辑 C/H 源码。源码实际位于 `software/src`。
4. 直接下载已实板验证的发布版本，双击 `03_Program_Tested_Release.cmd`。它核对 BIT/HDF/init/ELF 的 SHA-256 后执行易失性 JTAG 下载。

根目录旧 `Multi_protocol.xpr`、根目录 SDK 元数据及 `_validation_build` 下的项目仅保留作历史参考。后续开发使用以上两个固定入口。不要通过 Vivado 默认的 `<Local to Project>` 再创建另一套 SDK workspace；若从 Vivado Launch SDK，Workspace 显式选择仓库的 `build/sdk`。

也可在仓库根目录使用 PowerShell。`Prepare` 只创建缺少的工作区；`BuildPl` 重建硬件；`BuildPs` 使用新生成的 BIT/HDF 配对重建软件；硬件尚未重建时使用仓库中已测交接文件：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools/project.ps1 -Action Prepare
# 需要重建硬件和软件时，先关闭对应 Vivado/SDK GUI：
powershell -NoProfile -ExecutionPolicy Bypass -File tools/project.ps1 -Action BuildPl
powershell -NoProfile -ExecutionPolicy Bypass -File tools/project.ps1 -Action BuildPs
```

`BuildPs` 重建前会备份 SDK 生成的 `platform_app/src` 到 `build/backups`。业务代码始终放在 `software/src`，不要在生成目录保存唯一副本。工具日志统一放在 `build/logs`。

发布版入口固定使用 `releases/uart-20261018/platform_app.elf` 与 `Multi_protocol.sdk/platform_hw` 的已测硬件交接文件；它不会自动把本地开发产物当作已验收发布。开发版可在 SDK 中编译、Program FPGA 并运行 `platform_app`，硬件平台选择同一工作区的 `platform_hw`。

## PS 源码与分支协作

`software/src` 是唯一的 PS 业务源码目录。SDK 工程中的 `platform_app/repo_src` 链接到它：

- 在 SDK 的 `repo_src` 中编辑 C/H 文件，就是在修改 Git 跟踪的 `software/src`。
- 拉取或切换分支后，对 `platform_app` 执行 Refresh/Build，即会使用该分支的 PS 源码。
- `platform_app/src` 只保存 SDK 生成的链接脚本等文件，不要在其中另建业务源码副本。

建议切换分支、拉取或合并前先关闭 Vivado/SDK，完成后重新打开并刷新工程。

## 主要路径

- Vivado 工程：`build\vivado\Multi_protocol.xpr`
- 开发用 Block Design：`build\vivado\Multi_protocol.srcs\sources_1\bd\multi_protocol_bd\multi_protocol_bd.bd`，由 `fpga/build/create_bd.tcl` 生成
- FPGA 源码：`fpga\rtl`
- FPGA 约束：`fpga\constraints`
- PS 源码：`software\src`
- SDK workspace：`build\sdk`
- 本机新综合 Bitstream（生成后才存在）：`build\vivado\Multi_protocol.runs\impl_1\multi_protocol_bd_wrapper.bit`
- 当前硬件交接 BIT/HDF/PS 初始化：`Multi_protocol.sdk\platform_hw`
- 重新构建的 PS ELF：`build\sdk\platform_app\Debug\platform_app.elf`
- 本机 Vivado/SDK 2018.3：`D:\Vivado2018.3\Vivado\2018.3`、`D:\Vivado2018.3\SDK\2018.3`

## 当前硬件配置

- 器件：`xc7z020clg484-2`
- LCD：800×480、24 位帧缓冲（每像素 3 字节），VDMA + VTC
- 触摸：GT911，I2C0 地址 `0x14`
- 自定义 AXI 外设基地址：`0x40000000`
- D0/P20：PL 心跳灯
- D1/P21：`LED_CTRL.bit0` 控制灯

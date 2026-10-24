# Zynq-7020 Multi Protocol Platform

> **member C · Vivado / Vitis 2026.1 迁移版本（2026-10-24）**
>
> 本分支 `migration/vivado-vitis-2026.1` 是从 Vivado/SDK 2018.3 迁移到 Vivado/Vitis 2026.1 的版本。member C 已完成本机实板验证并确认：**触控正常、切换页面正常、协议监听与显示正常**；SPI 100 笔对账及 CAN 正常回环通过。
>
> **请其他成员在各自板卡和环境上再做交叉验证，并在 PR 中反馈结果，交叉验证完成后再决定合入。** 复测步骤和结果模板见 [member C 交叉验证说明](docs/integration/2026-10-24-member-c-migration-cross-validation.md)；[配套板测镜像](releases/vivado-vitis-2026.1-memberC-20261024/README.md)、[迁移入口](README_MIGRATION_2026_1.md)、[实板证据](docs/test-results/2026-10-24-vivado-2026.1-board.md) 和 [2026 skill](skills/vivado-vitis-2026/SKILL.md) 已随分支提交。
>
> 当前边界：UART 为 RX-only；I2C EEPROM 测试仍出现 busy NACK；本机下载使用 2026.1 XSDB + 2018.3 hw_server 兼容路径。协议功能正常的确认不代表这些完整闭环和新版服务端问题已解决。以下原有 2018.3 使用说明保留供历史工程参考；本迁移分支请从上述新版入口开始。

接口、接线、集成说明和实板测试记录统一从 [docs/README.md](docs/README.md) 进入。

本工程适用于 Vivado/SDK 2018.3 和 `xc7z020clg484-2`。Vivado 工程与 SDK 工作区统一放在仓库根目录，完整目录说明见 [PROJECT_PATHS.md](PROJECT_PATHS.md)。

## 克隆后使用

1. 双击 `01_Open_Vivado.cmd` 打开完整 Vivado 工程；首次使用会从源码生成 BD 和顶层 wrapper。
2. 双击 `02_Open_SDK.cmd` 打开包含 `platform_hw/platform_bsp/platform_app` 的 SDK 工作区。
3. SDK 中展开 `platform_app/repo_src` 编辑 C/H 源码。源码实际位于 `software/src`。
4. 下载当前根目录中已经编译并实板验证的 BIT/HDF/ELF，双击 `03_Program_Tested_Release.cmd`。它与 SDK 图形界面的 Program FPGA + Run As → Launch on Hardware 使用同一组文件。

根目录 `Multi_protocol.xpr` 是唯一日常 Vivado 工程，`Multi_protocol.sdk` 是与之配套的唯一 SDK workspace。Vivado 的 Export Hardware 保持 `<Local to Project>`，Launch SDK 的 Exported location 和 Workspace 也保持 `<Local to Project>` 即可。首次克隆请先双击 `02_Open_SDK.cmd`，它会生成本机专用的 BSP、Eclipse 元数据和 ELF；此后从 Vivado 默认 Launch SDK 会打开同一工作区。

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

- Vivado 工程：`Multi_protocol.xpr`
- 开发用 Block Design：`Multi_protocol.srcs\sources_1\bd\multi_protocol_bd\multi_protocol_bd.bd`，由 `fpga/build/create_bd.tcl` 生成
- FPGA 源码：`fpga\rtl`
- FPGA 约束：`fpga\constraints`
- PS 源码：`software\src`
- SDK workspace：`Multi_protocol.sdk`
- 本机新综合 Bitstream（生成后才存在）：`Multi_protocol.runs\impl_1\multi_protocol_bd_wrapper.bit`
- 当前硬件交接 BIT/HDF/PS 初始化：`Multi_protocol.sdk\platform_hw`
- 重新构建的 PS ELF：`Multi_protocol.sdk\platform_app\Debug\platform_app.elf`
- 工具脚本自动查找 `D:\Xilinx` 或 `D:\Vivado2018.3` 下的 Vivado/SDK 2018.3

## 当前硬件配置

- 器件：`xc7z020clg484-2`
- LCD：800×480、24 位帧缓冲（每像素 3 字节），VDMA + VTC
- 触摸：GT911，I2C0 地址 `0x14`
- 自定义 AXI 外设基地址：`0x40000000`
- D0/P20：PL 心跳灯
- D1/P21：`LED_CTRL.bit0` 控制灯

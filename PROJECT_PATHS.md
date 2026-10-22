# 项目入口与路径

仓库根目录就是唯一工程根目录，不再使用嵌套的 `build/vivado` 或 `build/sdk` 开发副本。

| 操作 | 推荐入口 | 实际位置 |
|---|---|---|
| 打开 Vivado | `01_Open_Vivado.cmd` | `Multi_protocol.xpr` |
| 打开 SDK | `02_Open_SDK.cmd` | `Multi_protocol.sdk` |
| 生成比特流 | Vivado GUI 或 `tools/project.ps1 -Action BuildPl` | `Multi_protocol.runs/impl_1/multi_protocol_bd_wrapper.bit` |
| 编辑 PL 源码 | Vivado Sources 或编辑器 | `fpga/rtl` |
| 编辑约束 | Vivado Constraints 或编辑器 | `fpga/constraints` |
| 编辑 PS/UI 源码 | SDK 的 `platform_app/repo_src` | `software/src` |
| 硬件交接文件 | Vivado Export Hardware：`<Local to Project>` | `Multi_protocol.sdk/platform_hw` |

## Vivado 与 SDK 默认操作

1. 打开根目录 `Multi_protocol.xpr`。
2. Generate Bitstream。
3. File → Export → Export Hardware，勾选 Include bitstream，Export to 保持 `<Local to Project>`。
4. File → Launch SDK，Exported location 和 Workspace 都保持 `<Local to Project>`。
5. SDK 中编译 `platform_app`，Program FPGA 时选择 `platform_hw`，再运行 `platform_app`。

首次克隆没有 Eclipse 的本机 `.metadata` 和自动生成的 BSP。先双击 `02_Open_SDK.cmd`；脚本会在 `Multi_protocol.sdk` 创建/导入 `platform_hw`、`platform_bsp`、`platform_app`，以后即可直接使用 Vivado 的默认 Launch SDK。

## Git 中保留什么

- 保留：RTL、约束、仿真、Block Design、XPR、PS 业务源码、SDK 项目描述、经过验证的 `platform_hw` BIT/HDF/init 文件。
- 忽略：`runs`、缓存、仿真临时文件、SDK `.metadata`、BSP、Debug 目标文件和日志。

SDK 的 `platform_app/repo_src` 是指向 `software/src` 的相对链接，因此换目录、拉取分支后仍然使用该分支的 PS 源码。

# 项目入口与路径（2026-10-18）

本机项目根目录：`D:\fpga_class\FPGAPrj\ab_new_board_test_20261017`。

## 日常操作

| 要做什么 | 根目录入口 | 实际位置 |
|---|---|---|
| 打开 Vivado、生成比特流 | `01_Open_Vivado.cmd` | `build/vivado/Multi_protocol.xpr` |
| 打开完整 SDK、编辑与编译 C 代码 | `02_Open_SDK.cmd` | `build/sdk` |
| 下载已经实板验收的版本 | `03_Program_Tested_Release.cmd` | `releases/uart-20261018/platform_app.elf` 与已测交接文件 |
| 修改 FPGA 逻辑 | Vivado Sources 或编辑器 | `fpga/rtl` |
| 修改引脚约束 | Vivado Constraints 或编辑器 | `fpga/constraints` |
| 修改 PS 主程序和 UI | SDK 的 `platform_app/repo_src` | `software/src` |
| 查看实板记录与截图 | 文件或编辑器 | `docs/test-results/2026-10-18-uart-merge-board.md` |

`build/sdk` 应有 `platform_hw`、`platform_bsp`、`platform_app`。如果 SDK 记住了旧工作区，使用 File → Switch Workspace → Other，选 `build/sdk`。`platform_app/src` 存放链接脚本；主要 C 代码在 `repo_src`。

## 开发产物和已测发布

开发工作区可以重建，Git 不跟踪 `build`。先用 `tools/project.ps1 -Action Prepare` 或双击入口在本机生成。准备完成表示工程与应用可打开，并不代表在新目录完成了综合/上板。

硬件重建：`tools/project.ps1 -Action BuildPl`。新 BIT/HDF 位于 `build/vivado`。随后执行 `-Action BuildPs`，软件构建自动选取这套新 BIT/HDF，ELF 位于 `build/sdk/platform_app/Debug`。修改 BD 时也应维护 `fpga/build/create_bd.tcl`，因为从源码重建会按这个脚本生成 BD。

已验收发布的 BIT/HDF/init 固定在 `Multi_protocol.sdk/platform_hw`，已验收 ELF 在 `releases/uart-20261018`。发布版下载入口会检查四个文件的哈希；当前版本是 SPI + UART 被动 RX，UART TX 尚无回显，I2C/CAN 监听未启用。

## 保留的历史目录

- 根目录 `Multi_protocol.xpr` 及其旧 runs/SDK：历史工程快照，不再作为日常打开入口。用户的本地修改保留。
- `_validation_build/uart_merge`：2026-10-18 实板验收时使用的构建与 SDK，保留作回退与证据。
- `candidates`、旧 `releases`：历史候选与发布，不是当前开发工作区。

本次整理没有移动这些旧目录。以后只使用根目录 01/02/03 入口，可以避免同名工程和 SDK 工作区混用。

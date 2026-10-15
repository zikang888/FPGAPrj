# Zynq-7020 Multi Protocol Platform

本工程适用于 Vivado/SDK 2018.3 和 `xc7z020clg484-2`。仓库采用“源码可重建”协作方式：跟踪 RTL、约束、Tcl、Block Design、PS 业务源码和当前发布用硬件平台；不跟踪 Vivado runs、IP output products、SDK 元数据、BSP 和 Debug 编译产物。

## 克隆后使用

1. 使用 Vivado 2018.3 打开仓库根目录的 `Multi_protocol.xpr`。
2. 首次打开后对 Block Design 执行 `Generate Output Products`，然后运行 `Generate Bitstream`。也可以在 Vivado Tcl Console 执行 `source fpga/build/build_bitstream.tcl` 完成同样的重建。
3. 执行 `File -> Export -> Export Hardware`，勾选 `Include bitstream`，`Export to` 选择 `<Local to Project>`。
4. 执行 `File -> Launch SDK`，`Exported location` 和 `Workspace` 都选择 `<Local to Project>`。
5. 首次克隆没有机器相关的 Eclipse `.metadata`。如果 SDK 中没有自动显示工程，先关闭 SDK，再运行下方的 `software/build_ps_app.tcl`；脚本会在本机重新创建 `platform_hw`、`platform_bsp`、`platform_app` 和 workspace 元数据。
6. 执行 `Xilinx -> Program FPGA`，硬件平台选择 `platform_hw`，随后运行 `platform_app`。

如果 SDK workspace 尚未生成或硬件平台变化较大，可在仓库根目录运行。先用预检确认本机输入，再取消预检进行重建；重建会替换生成的 `platform_hw`、`platform_bsp`、`platform_app`，应先保存其中未入库的工作：

```powershell
$env:MULTI_PROTOCOL_PREFLIGHT_ONLY = '1'
& 'D:\Vivado2018.3\SDK\2018.3\bin\xsct.bat' '.\software\build_ps_app.tcl'
Remove-Item Env:MULTI_PROTOCOL_PREFLIGHT_ONLY
# 确认看到 PS_BUILD_PREFLIGHT_DONE 且 HDF/BIT 来自同一硬件平台后：
& 'D:\Vivado2018.3\SDK\2018.3\bin\xsct.bat' '.\software\build_ps_app.tcl'
```

本机当前的硬件交接文件位于 `Multi_protocol.sdk\platform_hw`：`system.hdf`、`multi_protocol_bd_wrapper.bit`、`ps7_init.tcl`。`software/build_ps_app.tcl` 会优先使用新综合生成的 SDK 根目录 HDF/BIT；若不存在，则使用这组三件套。自定义 HDF 必须同时指定对应的 `MULTI_PROTOCOL_BIT`。脚本先临时保全交接文件，再替换 SDK 生成工程。

仅做易失性 JTAG 上板时，先构建新的 ELF，然后设置 `ZYNQ_TEST_ELF`，运行 `fpga/build/zynq_jtag_board_test.tcl`。该脚本默认选择上述同目录 BIT 与 `ps7_init.tcl`；如通过 `ZYNQ_TEST_BIT` 改用其他 bit，还必须显式给出匹配的 `ZYNQ_TEST_INIT`。设置 `ZYNQ_PREFLIGHT_ONLY=1` 可只检查文件路径，不连接硬件、不下载。判断预检是否成功应看 `ZYNQ_JTAG_PREFLIGHT_DONE` 标记；此版本 XSCT 在 Tcl 报错时也可能返回进程退出码 0。

## PS 源码与分支协作

`software/src` 是唯一的 PS 业务源码目录。SDK 工程中的 `platform_app/repo_src` 是指向它的相对链接：

- 在 SDK 的 `repo_src` 中编辑 C/H 文件，就是在修改 Git 跟踪的 `software/src`。
- 拉取或切换分支后，对 `platform_app` 执行 Refresh/Build，即会使用该分支的 PS 源码。
- `platform_app/src` 只保存 SDK 生成的链接脚本等文件，不要在其中另建业务源码副本。

建议切换分支、拉取或合并前先关闭 Vivado/SDK，完成后重新打开并刷新工程。

## 主要路径

- Vivado 工程：`Multi_protocol.xpr`
- Block Design：`Multi_protocol.srcs\sources_1\bd\multi_protocol_bd\multi_protocol_bd.bd`
- FPGA 源码：`fpga\rtl`
- FPGA 约束：`fpga\constraints`
- PS 源码：`software\src`
- SDK workspace：`Multi_protocol.sdk`
- 本机新综合 Bitstream（生成后才存在）：`Multi_protocol.runs\impl_1\multi_protocol_bd_wrapper.bit`
- 当前硬件交接 BIT/HDF/PS 初始化：`Multi_protocol.sdk\platform_hw`
- 重新构建的 PS ELF（生成后才存在）：`Multi_protocol.sdk\platform_app\Debug\platform_app.elf`
- 本机 Vivado/SDK 2018.3：`D:\Vivado2018.3\Vivado\2018.3`、`D:\Vivado2018.3\SDK\2018.3`

## 当前硬件配置

- 器件：`xc7z020clg484-2`
- LCD：800×480、24 位帧缓冲（每像素 3 字节），VDMA + VTC
- 触摸：GT911，I2C0 地址 `0x14`
- 自定义 AXI 外设基地址：`0x40000000`
- D0/P20：PL 心跳灯
- D1/P21：`LED_CTRL.bit0` 控制灯

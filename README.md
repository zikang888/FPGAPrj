# Zynq-7020 Multi Protocol Platform

本工程适用于 Vivado/SDK 2018.3 和 `xc7z020clg484-2`。仓库采用完整工程协作方式，提交 Vivado 工程、Block Design、生成结果和当前 SDK workspace；只忽略日志、锁文件、缓存及临时验证/备份目录。

## 克隆后使用

1. 使用 Vivado 2018.3 打开仓库根目录的 `Multi_protocol.xpr`。
2. 按需要对 Block Design 执行 `Generate Output Products`，然后运行 `Generate Bitstream`。
3. 执行 `File -> Export -> Export Hardware`，勾选 `Include bitstream`，`Export to` 选择 `<Local to Project>`。
4. 执行 `File -> Launch SDK`，`Exported location` 和 `Workspace` 都选择 `<Local to Project>`。
5. SDK 中应看到 `platform_hw`、`platform_bsp` 和 `platform_app`。
6. 执行 `Xilinx -> Program FPGA`，硬件平台选择 `platform_hw`，随后运行 `platform_app`。

如果 SDK workspace 尚未生成或硬件平台变化较大，可在仓库根目录运行：

```powershell
& '<你的 Xilinx SDK 2018.3 安装目录>\bin\xsct.bat' '.\software\build_ps_app.tcl'
```

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
- Bitstream：`Multi_protocol.runs\impl_1\multi_protocol_bd_wrapper.bit`
- HDF：`Multi_protocol.sdk\multi_protocol_bd_wrapper.hdf`
- ELF：`Multi_protocol.sdk\platform_app\Debug\platform_app.elf`

## 当前硬件配置

- 器件：`xc7z020clg484-2`
- LCD：800×480 RGB565，VDMA + VTC
- 触摸：GT911，I2C0 地址 `0x14`
- 自定义 AXI 外设基地址：`0x40000000`
- D0/P20：PL 心跳灯
- D1/P21：`LED_CTRL.bit0` 控制灯

# Zynq-7020 Multi Protocol Platform

正式工程根目录：

```text
D:\Vivado\Project\Multi_protocol
```

工程采用单层结构，不再使用 `_clean_build_*` 嵌套工程。

## 日常图形化流程

1. 使用 Vivado 2018.3 打开 `Multi_protocol.xpr`。
2. 在 Flow Navigator 中运行 Generate Bitstream。
3. 执行 `File -> Export -> Export Hardware`，勾选 `Include bitstream`，`Export to` 选择 `<Local to Project>`。
4. 执行 `File -> Launch SDK`，`Exported location` 和 `Workspace` 都选择 `<Local to Project>`。
5. SDK 中应看到 `platform_hw`、`platform_bsp` 和 `platform_app`。
6. `Xilinx -> Program FPGA` 时选择 `platform_hw`，随后运行 `platform_app`。

## 主要路径

- Vivado 工程：`Multi_protocol.xpr`
- FPGA 源码：`fpga\rtl`
- 约束：`fpga\constraints`
- PS 源码：`software\src`
- Local 硬件导出及 SDK workspace：`Multi_protocol.sdk`
- Bitstream：`Multi_protocol.runs\impl_1\multi_protocol_bd_wrapper.bit`
- HDF：`Multi_protocol.sdk\multi_protocol_bd_wrapper.hdf`
- ELF：`Multi_protocol.sdk\platform_app\Debug\platform_app.elf`

`Multi_protocol.sdk_build` 是旧的独立 workspace，当前流程不再引用它。

## 可复现构建

```powershell
& 'D:\Xilinx\Vivado\2018.3\bin\vivado.bat' -mode batch -source '.\fpga\build\create_project.tcl'
& 'D:\Xilinx\Vivado\2018.3\bin\vivado.bat' -mode batch -source '.\fpga\build\build_bitstream.tcl'
& 'D:\Xilinx\SDK\2018.3\bin\xsct.bat' '.\software\build_ps_app.tcl'
& 'D:\Xilinx\SDK\2018.3\bin\xsct.bat' '.\download_jtag.tcl'
```

## 当前硬件配置

- 器件：`xc7z020clg484-2`
- LCD：800×480 RGB565，VDMA + VTC
- 触摸：GT911，I2C0 地址 `0x14`
- 自定义 AXI 外设基地址：`0x40000000`
- D0/P20：PL 心跳灯
- D1/P21：`LED_CTRL.bit0` 控制灯

## Git

建议跟踪源码、Tcl、XDC、文档和 `Multi_protocol.xpr`，并排除 Vivado/SDK 生成目录。提交前确认工程根目录存在 `.git`。

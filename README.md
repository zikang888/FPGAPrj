# Zynq-7020 Multi Protocol Platform

本工程适用于 Vivado/SDK 2018.3 和 `xc7z020clg484-2`。仓库保存可复现的工程源文件，不提交综合结果、SDK workspace 和工具缓存。

## 克隆后首次使用

1. 使用 Vivado 2018.3 打开仓库根目录的 `Multi_protocol.xpr`。
2. 如果 Vivado 提示 IP/Block Design 尚未生成，右键 `multi_protocol_bd.bd`，执行 `Generate Output Products`，然后执行 `Create HDL Wrapper`。
3. 在 Flow Navigator 中运行 `Generate Bitstream`。
4. 执行 `File -> Export -> Export Hardware`，勾选 `Include bitstream`，`Export to` 选择 `<Local to Project>`。
5. 在仓库根目录运行：

   ```powershell
   & '<你的 Xilinx SDK 2018.3 安装目录>\bin\xsct.bat' '.\software\build_ps_app.tcl'
   ```

   这一步会在被 Git 忽略的 `Multi_protocol.sdk` 中创建 `platform_hw`、`platform_bsp` 和 `platform_app`。

6. 执行 `File -> Launch SDK`，`Exported location` 和 `Workspace` 都选择 `<Local to Project>`。
7. 在 SDK 中执行 `Xilinx -> Program FPGA`，硬件平台选择 `platform_hw`，随后运行 `platform_app`。

## 日常修改后的图形化流程

已完成首次初始化后，只需按需重新生成 Bitstream、以 `<Local to Project>` 导出硬件，然后在 SDK 中重新生成 BSP/应用并烧录。

## 主要内容

- Vivado 工程：`Multi_protocol.xpr`
- Block Design：`Multi_protocol.srcs\sources_1\bd\multi_protocol_bd\multi_protocol_bd.bd`
- FPGA 源码：`fpga\rtl`
- FPGA 约束：`fpga\constraints`
- 仿真：`fpga\sim`
- 可复现构建脚本：`fpga\build`
- PS 源码：`software\src`
- PS 工程生成脚本：`software\build_ps_app.tcl`
- JTAG 下载脚本：`download_jtag.tcl`

以下目录由工具生成并被 `.gitignore` 排除：

- `Multi_protocol.runs`
- `Multi_protocol.cache`
- `Multi_protocol.sdk`
- Vivado/SDK 日志、缓存、验证目录和本机临时文件

## Tcl 全自动构建

在安装了 Vivado/SDK 2018.3 的终端中运行：

```powershell
& '<Vivado 2018.3 安装目录>\bin\vivado.bat' -mode batch -source '.\fpga\build\create_project.tcl'
& '<Vivado 2018.3 安装目录>\bin\vivado.bat' -mode batch -source '.\fpga\build\build_bitstream.tcl'
& '<Xilinx SDK 2018.3 安装目录>\bin\xsct.bat' '.\software\build_ps_app.tcl'
& '<Xilinx SDK 2018.3 安装目录>\bin\xsct.bat' '.\download_jtag.tcl'
```

## 当前硬件配置

- 器件：`xc7z020clg484-2`
- LCD：800×480 RGB565，VDMA + VTC
- 触摸：GT911，I2C0 地址 `0x14`
- 自定义 AXI 外设基地址：`0x40000000`
- D0/P20：PL 心跳灯
- D1/P21：`LED_CTRL.bit0` 控制灯

生成的 BIT/HDF/ELF 如需提供给不安装开发工具的使用者，建议作为 GitHub Release 附件发布，不要提交到源码仓库。

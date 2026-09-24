# Zynq-7020 Multi Protocol Platform

第一阶段目标是验证 ACZ702 + AC820 平台链路：

- PS/DDR/AXI
- 800×480 RGB LCD 与 VDMA/VTC
- GT911 触摸
- PL 固定ID、版本、scratch和LED寄存器
- 100 MHz PL主时钟与64位时间戳

## 工具链

- Vivado/SDK 2018.3
- Part: `xc7z020clg484-2`

## 构建顺序

```powershell
& 'D:\Xilinx\Vivado\2018.3\bin\vivado.bat' -mode batch -source '.\fpga\build\create_project.tcl'
& 'D:\Xilinx\Vivado\2018.3\bin\vivado.bat' -mode batch -source '.\fpga\build\run_sim.tcl'
& 'D:\Xilinx\Vivado\2018.3\bin\vivado.bat' -mode batch -source '.\fpga\build\build_bitstream.tcl'
& 'D:\Xilinx\SDK\2018.3\bin\xsct.bat' '.\software\build_ps_app.tcl'
& 'D:\Xilinx\SDK\2018.3\bin\xsct.bat' '.\download_jtag.tcl'
```

最后一个命令需要开发板通过JTAG连接。

## 第一阶段验收

- 串口出现 `PS READY`、`PL ID OK`、`SCRATCH OK`、`TOUCH READY`。
- LCD显示PL ID、版本、scratch和触摸状态。
- 点击屏幕按钮切换P15 LED。
- P20心跳灯闪烁。

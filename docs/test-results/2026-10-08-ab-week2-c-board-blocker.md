# A+B 第二周 + STM32F407 整合候选：上板状态（2026-10-08）

## 候选与静态结果

- 分支：`codex/fpga-ab-week2-c-integration`，基线 `origin/fpga_AB_2week_merge` 的 `689b653`。本分支引入完整 STM32F407 Keil/CubeMX/HAL 工程；不覆盖既有 Vivado 自动修改。
- 候选 BIT：`Multi_protocol.sdk/platform_hw/multi_protocol_bd_wrapper.bit`，SHA-256 `DD67841E76288C949A322B640060BB14F9EF78A8CC08C2B42E9D0DFF87B9EC9B`。
- 配套 HDF：`Multi_protocol.sdk/platform_hw/system.hdf`，SHA-256 `771B86BD8E3AF781A05F0D07B9308FFDFB425577637BA8FDD9E5965B119EE3BC`；同目录 `ps7_init.tcl` SHA-256 `47D35117FE590757D5F887986AE68B1E64F5CDCFC7EEB480825AF9543BF91399`。
- PS ELF：`.sdk_validation/platform_app/Debug/platform_app.elf`，SHA-256 `CBD37DACEA0A553AE1110061D7DC1B9C59BE21AD4AECEDA387797CFA3BAD9A63`。该构建产物须与上述 HDF/BIT 配套使用，不是单独提交的启动镜像。
- 整合目录现有 Keil 构建日志记录 `0 Error(s), 0 Warning(s)`；STM32 宿主测试与 Vivado 五项回归此前通过。这些是静态/仿真证据，不能替代本候选的实板验收。

## 本次 AC820 上板观察

用户确认仅对 AC820/Zynq 断电重上电，STM32 与五根 SPI 接线保持不变。冷启动后的只读 JTAG 枚举能看到两颗 A9；此时 PL 尚未配置，DONE=0，AXI 读超时。随后使用 1 MHz JTAG 对上述候选进行一次易失性 BIT→PS 初始化→ELF 下载尝试：BIT 传输完成，但在 PS 初始化之前，目标枚举即变为 `DAP (JTAG port open error. AP transaction error, DAP status 30000021)`，找不到 A9 目标。因而 `ps7_init`、ELF 下载和 CPU0 运行均**没有执行**；不能把脚本进程退出码 0 当作成功。

BIT 下载后的 Vivado 配置只读检查：DONE_PIN=1、DONE_INTERNAL=1、EOS=1、CRC_ERROR=0。250 kHz 只读 JTAG 枚举仍为同一 DAP AP 事务错误。用户确认屏幕**只有背光**，没有 HOME / SELF TEST / EVENTS 页面。当前证据表明 PL 已配置但 PS 调试通路未恢复；尚不能将原因归咎于 SPI 线、屏幕或 PS 应用代码，也不能宣称整合候选实板通过。已停止重复下载，未写启动 Flash。

## 验收边界与恢复后步骤

本候选的 `multi_protocol_core` 实例使用 `POST_TRIGGER_EVENTS=4`。正常 `9F 00 00 00` 触发后，快照预期只包含**一笔 6 事件**（START、4 DATA、END）；2026-10-06 旧镜像的三笔/18 事件是历史结果。A+B 新版另有不依赖快照深度的 PL SPI 全局统计。PS 页面和 AXI `SYS_ID=4D505254`、`VERSION=00010004`、`CAPABILITIES=0000000F` 都须在 DAP 恢复并成功启动 ELF 后重新实测，不能从 DONE=1 推断。

恢复 PS JTAG 后，先确认三页 UI、D1、25 条虚拟自检和 `ARM SPI`；再按 `docs/hardware/spi_board_test.md` 清空 PL 统计，使用 STM32 USART1（此前机器实测为 COM4，必须先用 `help` 重新确认）逐字节间隔约 15 ms 发送 `spi jedec 100`。同一轮应取得 STM32 `passed=100 failed=0` 且每笔 JEDEC 为 `FF EF 40 18`；PL 应为 `events=600 starts=100 data=400 ends=100`，外部丢弃和各错误计数均为 0，脚本输出 `SPI_ACCEPTANCE_PASS`。还须保留同轮串口日志、PL 寄存器/快照以及 LCD 观察；未取得这些证据前不要标注新版板测通过。

接线：独立天空星 F407 高配核心板**板载** W25Q128；PA4→AC820 P7-2（CS）、PA5→P7-1（SCLK）、PA7→P7-3（MOSI）、PA6→P7-4（MISO），两板共地、各自供电，不互接 3V3。FPGA 四条线均为输入，不并接第二颗外置 Flash。

# STM32 最新多协议工程接入 C 分支（2026-10-15）

## 代码来源与已完成

- 先将 C 集成分支已提交的修复和上板记录推送至远端 `9e6e970`。
- 获取 `origin/memberC/stm32-f407` 的 `6c5a8bf`，仅同步
  `stm32_f407/` 子树到当前 C 分支，形成独立提交 `f20923c`。原工作树
  里其他未提交的 Vivado BD/XPR 和生成目录未覆盖、未纳入提交。
- 同步内容包括 SPI、UART、I²C、CAN 的 STM32 编排接口、串口命令、
  20 项故障菜单、OLED、HAL 适配和主机测试。`mc_faults.c` 中部分
  CAN 故障明确标为 `EXTERNAL_ONLY`，并非本机软件已经能主动注入。
- `software/src/stm32_fault_bridge.h` 把 20 个 STM32 case ID 映射到
  PS `ErrorCode`，`software/tests/stm32_fault_bridge_test.c` 将两端真实
  源码一起编译，逐项验证编号一致。这个映射不从“注入成功”推导
  “FPGA 已检出”，不会伪造 UI 错误计数。

## 验证

本机 Vivado 2018.3 附带的 MinGW GCC 6.2.0 以 `-std=c99 -Wall
-Wextra -Wpedantic -Werror` 分别在 `-O0`、`-O2` 下完成：

| 测试 | O0 | O2 |
| --- | --- | --- |
| STM32 `test_protocol_runner.c`（真实公共源） | 通过 | 通过 |
| PS `error_model_test.c`（20 项映射与缺测语义） | 通过 | 通过 |
| `stm32_fault_bridge_test.c`（跨端真实源编号对账） | 通过 | 通过 |

新增 `fpga/rtl/protocol/uart_8n1_monitor.sv` 作为**尚未接入 BD**的
USART3 TX 被动监听候选。Vivado 2018.3 的 `xvlog`、`xelab`、`xsim`
已通过三次迭代；最终测试覆盖两个连续 8N1 字节的 START/DATA/END
分组、错误停止位触发、短低电平毛刺不产生虚假 START、ready/valid
反压时事件保持稳定，输出 `UART_MONITOR_PASS`。仿真使用缩短的
16 clock/bit 参数，生产参数预定为 100 MHz/115200；尚未综合、
进入 BD、生成 BIT 或上板，因此 **UART 仍是 OFFLINE**。

尚未在本机重新编译 Keil/HAL 固件；主机测试不能替代目标机编译。
当前 Windows 串口枚举仅见蓝牙 COM7/8/11/12，没有识别到 STM32
日志口，且 UART/I²C/CAN 尚未接到 AC820，故本轮没有执行这些协议的
物理联调或 FPGA 实时显示验收。

## 管脚证据与下一道门槛

`D:\AC820+SOC+FPGA开发板管脚资源定义表.xlsx` 的 SHA-256 为
`055D5AF5211DB11CB6A0BD347ABEFA7FDE4976C93EDF64E1A1D89B00E90AE722`。
唯一工作表的 104–139 行确认 W5、AA9、AA6、V8、W8、AA11 均属于
P7 通用扩展球位，却**没有给实体排针编号**。接线候选、数字侧方向
和电气禁区见 `docs/hardware/stm32_multi_protocol_wiring_review.md`。

正式的 UART/I²C/CAN 双板闭环还需要：P7 球位到排针针号确认；
对应输入监听 RTL、BD、XDC、事件 ABI 测试；新 BIT/HDF/BSP/ELF
同源构建；STM32 实际发送与 FPGA 事件/错误逐笔对账。当前发布 BIT
只提供 SPI 真监听，UI 其他三个协议保持 `OFFLINE` 才是正确状态。

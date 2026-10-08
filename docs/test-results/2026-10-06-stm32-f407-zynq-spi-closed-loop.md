# STM32F407 ↔ Zynq SPI 双板闭环（2026-10-06）

## 范围与状态

本记录是 2026-10-06 旧 C/Zynq 镜像（`VERSION=0x00010003`、触发后 16 事件）的历史实板联调，不是 2026-10-08 A+B 第二周整合候选的验收记录。双板 SPI 数据路径曾在一次重新武装后的独立测试中验证。随后整合工作区补回第一周已有的 SPI TX/RX 真值日志和 JEDEC 异常检测，并完成重新编译；下述实板结果对应补回前的已烧录固件，补回后的固件还需要队友重新烧录复验。

## 实测结果

- STM32F407 板载 W25Q128，USART1 命令口为 `COM4`、115200 baud。串口命令 `spi jedec 3` 需要逐字节间隔发送；整行快速发送曾漏字符，不作为通过证据。
- 独立测试的 3 笔 SPI 命令字节均为 `9F 00 00 00`，STM32 逐笔记录的接收字节均为 `FF EF 40 18`，结果 3/3 通过。
- Zynq 触发后冻结 18 条真实事件，每笔由 `START`、4 个 `DATA`、`END` 构成；三笔的 MOSI/MISO 与 STM32 记录逐字节一致。触发位置为 1，`EXT_DROPPED=0`、本轮 `DROPPED_COUNT=0`。
- 此前一轮测试中曾出现带错误帧的快照和非零 dropped 计数；该结果不是本次独立重新武装测试的通过证据，不能混用。

## 整合后静态与单元验证

- Keil ARMCC 5.06 update 2 编译 `sky_star_protocol_node.uvprojx`：`0 Error(s), 0 Warning(s)`，生成 HEX；程序大小 `Code=19302 RO-data=1386 RW-data=24 ZI-data=3696`。
- Vivado 2018.3 自带 MinGW GCC 使用 `-std=c11 -Wall -Wextra -Werror` 编译并运行 `stm32_f407/tests/test_protocol_runner.c`：`STM32F407 protocol runner tests passed`。该测试覆盖 JEDEC 正常值、全 00/全 FF、SPI 超时、日志失败、TX/RX 字段，以及其他协议基本路径。
- 本轮未重新综合或生成 FPGA bitstream；本次实板结果不能替代 A+B 第二周镜像的验收。原 Vivado 工程在本地有自动改动，不属于 STM32 固件变更。

## 成果入口

- Vivado 工程：仓库根目录 `Multi_protocol.xpr`。
- STM32F407 Keil 工程：`stm32_f407/firmware/Projects/MDK-ARM/sky_star_protocol_node.uvprojx`。
- FPGA 既有交接说明：`docs/handoff/2026-09-29-zynq-stm32-team-handoff.md`。
- 本次只证明 SPI/JEDEC 端到端捕获链路；其他协议和长期稳定性不在通过范围内。

## 队友复验步骤

1. 使用 Keil 打开上述 `.uvprojx`，重新编译并通过 ST-Link 将新生成的 HEX 下载到独立天空星 STM32F407VGT6；两板分别供电、共地，不把两板 3V3 电源相连。
2. 保持 STM32 PA4→AC820 P7-2、PA5→P7-1、PA7→P7-3、PA6→P7-4，四条线在 FPGA 侧均是输入。
3. 以下仅用于复现当时的旧 C/Zynq 镜像结果：使用已配套的 Zynq bitstream/ELF 启动 LCD，在 EVENTS 页点 `ARM SPI`，确认显示 `WAIT SPI`。A+B 第二周镜像请按 `docs/hardware/spi_board_test.md` 的 100 笔计数验收，不能套用下述 18 事件预期。
4. 打开 STM32 USART1 对应串口（本次实测为 `COM4`，具体电脑须重新核对），设置 115200、8N1。发送 `spi jedec 3` 加回车；现有轮询/回显实现对整行高速发送可能漏字符，建议逐字节间隔约 15 ms。不要仅凭串口号猜测设备，应先发 `help` 确认。
5. 期待 3 笔 JEDEC 均为 `FF EF 40 18`，SUMMARY 为 3/3；FPGA 冻结 18 条事件，逐笔 START、4 DATA、END，MOSI/MISO 与 STM32 JSONL 的 `tx`/`data` 对账，且本轮两个 dropped 计数为 0。若任一项不符，保留串口日志和快照，不宣称通过。

其他协议（UART/I²C/CAN）及故障注入仍需按各自外设与连线逐项上板验收，不纳入此 SPI 闭环结论。

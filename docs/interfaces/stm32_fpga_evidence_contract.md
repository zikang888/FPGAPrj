# STM32 动作与 FPGA 检测的证据边界

日期：2026-10-13。用于成员 C 的 STM32 真值日志与 Zynq 事件页面对账。

| 状态 | 证据来源 | 能说明什么 |
|---|---|---|
| STM32 已执行 | STM32 USART1 JSONL 的 `case`、`txn`、`tx`/`data`、`result` | 固件运行了动作；对于发波形用例，`result=0` 只说明 STM32 API 完成 |
| STM32 已收到 | SPI/UART/I²C/CAN 的实际 RX、ACK/NACK 或控制器状态 | MCU 自己观察到的响应，不能代替 FPGA 监听 |
| PL 已检测 | Zynq AXI 的协议事件、错误计数、时间戳和原始记录 | FPGA 在其已接入的监听器上检测到对应线级事件 |
| 跨端对账通过 | 同轮原始日志与 PL 事件按命令/字节序列比对，必要时加独立逻辑采集 | 该用例在限定的线路与规则下闭环 |

当前生产 FPGA 管脚仅接入四根 SPI 旁听线。STM32 的 PC6 `TEST_SYNC` 已输出脉冲，但还没有对应 FPGA 输入、XDC 和时间戳逻辑；USART1 真值日志当前送往电脑串口终端，并未直接接入 Zynq。因此 **不得**用 `PC6` 或串口日志推断 PL 已检测，也不能把两边本地 `transaction_id` 数值视为相同。

正常 `spi jedec N` 的启动探测为独立 `case=1000`，应在 FPGA ARM 前完成；随后 `case=1001` 才是 N 笔计数事务。启动探测若失败，不进入 N 笔测试。JSONL 的 SPI `data` 是 RX，`tx` 是 MOSI 发送字节，两者须同轮与 PL 的 MISO/MOSI 对账。

Zynq `ERRORS` 页现有 `origin=NONE` 显示 `--` 的语义应保留。无实际来源的错误项不能因 STM32 发过某个用例就改成“PL 已检测”；要显示 STM32 用例执行状态，必须先增加一条经过核对的物理/软件输入链路并保存关联证据。

# STM32 串口与 SPI 证据链回归修复

日期：2026-10-13。分支：`memberC/stm32-f407`。

## 修复

- USART1 改为中断接收与 512 字节单生产者/单消费者缓冲，收到换行后才回显整行。溢出或 UART 错误时丢弃不完整命令，避免误执行。
- 启动时最多三次读取板载 Flash 的实际 JEDEC ID，拒绝全 `00`/全 `FF`。探测记录为 `case=1000`；后续 `spi jedec N` 以实际 ID 为基线，正常情况下恰好执行 N 笔 `case=1001`。
- SPI JSONL 的 `data` 是实际 RX，新增 `tx` 保存 MOSI；正常事务和短/长故障事务均保留两方向。成功传输后若日志输出失败，测试返回失败。
- PC6 同步脉冲和 USART1 日志仍是 STM32 侧证据；当前 FPGA 尚无这些输入，不能将 `result=0` 视为 PL 检测通过。

## 本地验证

```text
Host CMake/Ninja + CTest: 1/1 PASS
Keil ARMCC 5.06 update 2: 0 Error(s), 0 Warning(s)
Code=26598 RO-data=2574 RW-data=60 ZI-data=5260
```

主机测试覆盖实际 ID、全 `00`/全 `FF`、SPI 超时、日志失败、TX/RX 字段、快速整行入队和故障用例分派。未进行本版 STM32 烧录、OLED 观察或双板波形验收；先前其他镜像的上板记录不可算作本版通过。

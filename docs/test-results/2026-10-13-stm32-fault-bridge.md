# A+B+C 集成候选：STM32 故障菜单移植与证据边界

日期：2026-10-13。基线：`codex/fpga-ab-week2-c-integration` 提交 `8f4e4a9`。
本候选在该基线上逐项移入 STM32 故障菜单、SSD1306 OLED、HAL 波形钩子和 USART1 中断接收；未整仓合并无共同祖先的 STM32 分支。

## 保留的旧修复

- SPI `mc_probe_spi_jedec()` 及全 `00`/全 `FF` 无效读拒绝；启动最多三次探测，探测 `case=1000` 与 `spi jedec N` 的 N 笔 `case=1001` 分开。
- SPI JSONL 的 `data` 是实际 RX，`tx` 是实际 MOSI；日志失败向测试结果传播。
- USART1 不在每个收到的字符后阻塞发送；当前改为中断接收缓冲、整行回显。队列溢出或接收错误时丢弃该行并报告。

## 新增范围

- 20 个稳定的错误用例索引与 case ID；其中 MCU 能独立输出的波形/事务已接入。
- OLED 选项页与 PA0 短按/长按；USART1 的 `fault list/select/run` 命令。
- Zynq ERRORS 页明确标示 STM32 执行日志仍在外部串口、PL 检测仅指已测量计数；未把 STM32 `result=0` 映射成 FPGA 通过。
- PC6 同步输出存在，但当前 FPGA XDC 没有同步输入；USART1 日志未直接接入 Zynq。

## 本地验证

```text
STM32 host CMake/Ninja + CTest: 1/1 PASS
Keil ARMCC 5.06 update 2: 0 Error(s), 0 Warning(s)
Code=26610 RO-data=2574 RW-data=60 ZI-data=5260
PS 纯 C 宿主测试: 7/7 PASS
```

本记录没有实板烧录、OLED 可视检查、故障波形/PL 对账或 Zynq ELF 构建结果；本机没有 SDK 2018.3 可执行程序，PS 页面改动只完成源码与宿主侧检查。原 A+B+C 基线的历史实测不自动覆盖本候选。重新上板时先核对 BIT/HDF/ELF、STM32 HEX 与接线，再用同一轮 STM32 JSONL 和 PL 事件计数验收。

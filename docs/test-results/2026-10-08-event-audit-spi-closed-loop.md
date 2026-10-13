# 新 PS 事件审计版 SPI 双板闭环（2026-10-08）

测试分支：`codex/fpga-ab-week2-c-integration`。C 端快照审计改动来自
`bc8e430`（整合后 `77f3921`），两轮宿主检查记录来自 `07dca1e`
（整合后 `b12d511`）。本次 PS ELF 由相同 HDF 在独立 SDK 工作区
`.sdk_validation_event_audit` 构建，SHA-256 为
`99A92F5D52DD6D42905C39402E0C01A554A17B76385F732ED572361B6E93A337`。
PL 保持板上原配置，JTAG 下载并运行上述 ELF；没有重刷 BIT/启动介质。

## 两轮整合检查

1. Clang、GCC 两种宿主编译器的严格 C99 事件审计测试均通过；原事件
   显示测试和像素滚动测试也通过。
2. 全新 SDK 工作区构建 BSP 和 PS 应用，得到 `PS_BUILD_DONE`。JTAG
   下载 ELF 后回读 `SYS_ID=4D505254`、`VERSION=00010004`、
   `CAPABILITIES=0000000F`、`SNAPSHOT_COUNT=25`。用户确认 EVENTS 页
   出现 `ERR 0`，25 条虚拟事件可正常滚动，无遮挡。

## 真实 SPI 第 1 轮：10 笔

使用 STM32F407 板载 W25Q128、两板现有共地及四线监听接线。先清空 PL
SPI 统计，再由 STM32 USART1/COM4 发送 `spi jedec 10`。STM32 回显
和总结为 `iterations=10 passed=10 failed=0`，每笔 MISO 为
`FF EF 40 18`。同一轮 PL 统计为 `events=60`、`starts=10`、
`data=40`、`ends=10`；frame、boundary、duplicate、sequence 错误和
external dropped 均为 0，检查器输出 `SPI_ACCEPTANCE_PASS`。

## 真实 SPI 第 2 轮：100 笔

再次清空 PL 统计，发送 `spi jedec 100`。STM32 回显完整命令并输出
100 条事务日志，均含 `data=FFEF4018`、`result=0`；总结为
`iterations=100 passed=100 failed=0`，序号 127 至 226。PL 同轮统计
`events=600`、`starts=100`、`data=400`、`ends=100`，上述错误及
external dropped 均为 0，输出 `SPI_ACCEPTANCE_PASS`。

## 同笔事务的快照字节对账

经 EVENTS 页 `ARM SPI` 后发送一笔 `spi jedec 1`；STM32 事务号 227
（`0xE3`），返回 `FF EF 40 18`，结果通过。只读 JTAG 快照状态 READY，
`COUNT=6`，六条记录事务号均为 `0xE3`：

| 索引 | 类型 | `word1` | 含义 |
| ---: | --- | --- | --- |
| 0 | START | `20C00000` | SPI 事务开始 |
| 1 | DATA | `20C1FF9F` | MISO FF，MOSI 9F |
| 2 | DATA | `20C1EF00` | MISO EF，MOSI 00 |
| 3 | DATA | `20C14000` | MISO 40，MOSI 00 |
| 4 | DATA | `20C11800` | MISO 18，MOSI 00 |
| 5 | END | `20C20000` | SPI 事务结束 |

全局统计随之变为 `events=606`、`starts=101`、`data=404`、
`ends=101`，错误与 external dropped 仍为 0。用户目视确认 EVENTS 页
同步显示这 6 条 SPI（START、4 条 DATA、END），且 `ERR 0` 正常。

## 正式迭代压力回归：1000 笔

清空 PL SPI 统计后发送 `spi jedec 1000`；命令完整回显。STM32 输出
1000 条事务日志，序号 228 至 1227，全部 `data=FFEF4018`、
`result=0`，总结为 `iterations=1000 passed=1000 failed=0`。
同轮 PL 输出 `events=6000`、`starts=1000`、`data=4000`、
`ends=1000`，frame、boundary、duplicate、sequence 错误及 external
dropped 全为 0，检查器输出 `SPI_ACCEPTANCE_PASS`。

测试期间先前的单次 6 事件快照保持冻结，因此快照 `DROPPED_COUNT`
增加到 `0x1770=6000`，`CAPTURE_STATUS=0xA`。这仅表示冻结的快照
不再收后续事件；**不能解释为 SPI 外部生产者丢了 6000 条**：全局
SPI 计数恰好覆盖 6000 条，`EXT_DROPPED=0`。结束后须重新运行虚拟
自检，以清除快照状态。`DROPPED_COUNT=6000` 是 JTAG 寄存器回读，
不能断言屏幕曾显示 6000；PS UI 使用缓存的快照状态。

测试结束后通过 JTAG 重新下载同一 ELF，启动时自动运行虚拟自检。
恢复后的只读回读：A9 运行、`SNAPSHOT_ID=7`、`SNAPSHOT_COUNT=25`、
`TRIGGER_INDEX=20`、`DROPPED_COUNT=0`、`EXT_DROPPED=0`，
`CAPTURE_STATUS=0x2`。只重载 PS ELF，仍未重刷 BIT/启动介质。

## 排错发现与未覆盖项

直接把整条命令一次性写入串口时，STM32 回显 `spi jedec 0`，仅执行
1 笔；重复复现。改为逐字节间隔约 15 ms 后，`10` 和 `100` 均完整
回显并按预期执行。`mc_board_app_poll` 当前每收一个字节就同步发送一个
回显字节，疑似导致连续输入时 UART overrun；这是**尚待 B 端修复和
复测的串口命令可靠性问题**，不能把 paced-host workaround 当作固件修复。

当前记录未做 2 小时连续运行、SPI 不完整字节故障
注入，也未证明 UART/I²C/CAN 的 PL 事件链路。仅更换 ELF 的板测不等于
完整 BIT/HDF/ELF 重烧录验收。

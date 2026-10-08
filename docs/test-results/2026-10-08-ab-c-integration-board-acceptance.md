# A+B+C 整合版上板复测（2026-10-08）

本记录接续 `2026-10-08-ab-week2-c-board-blocker.md`，不覆盖其中失败事实。
工作区为 `integration_AB_week2_C`，分支 `codex/fpga-ab-week2-c-integration`。
BIT/HDF 仍是 A+B 第二周发布配对；PS ELF 因虚拟自测修复而重编，SHA-256 为
`33B9F1AC50E192F936AF1409E6E8644F65A312A9ABB10813296455BDE6C9402D`。
ELF 是本地 `.sdk_validation/platform_app/Debug/platform_app.elf` 构建产物，
需从本提交源码和配套 HDF 重建，未将调试构建目录提交 Git。

## 启动故障与受控对照

失败轮次在 PL 尚未配置（`DONE=0`）时先读 `0x40000000`，首笔 AXI 读超时，
随后 DAP 报 AP transaction error `30000021`；BIT 虽能配到 `DONE=1`，
PS 初始化和 ELF 没有执行，LCD 只有背光。用户仅将 AC820 断电重上电，
STM32 与接线不动。冷启动后只枚举 JTAG，看到 DAP、A9 #0/#1；
随后以 1 MHz JTAG 按 BIT -> `ps7_init` -> ELF 顺序执行，三个阶段均成功。
AXI 读回 `SYS_ID=4D505254`、`VERSION=00010004`、`CAPABILITIES=0000000F`，
CPU0 运行；用户确认 LCD 回到正常页面。此对照强烈支持“过早读未配置 PL
地址导致本次 DAP 错误链”的判断，但不把它泛化为所有 DAP 错误的唯一原因。

中途板状态再次变化，统计读取超时；只读配置检查确认 `DONE=0`，
JTAG 仍能枚举 DAP/A9。重新执行完整三阶段下载后，`DONE=1`、`EOS=1`、
`CRC_ERROR=0`，页面再次正常。用户未说明中途的具体手动动作，
因此不能进一步断言 `DONE` 下降的直接触发原因。

## SELF TEST 修复

新版 PL `POST_TRIGGER_EVENTS=4`，原 PS 虚拟演示在索引 8 触发后仍写入
至索引 24，导致快照仅 13 条、`DROPPED_COUNT=12`，SELF TEST 显示
`CORE DROP: FAIL`。`software/src/capture_demo.c` 将虚拟触发移到索引 20，
保留 25 条演示事件，触发后恰好还有四条。PS ELF 重编并仅重载 ELF 后，
寄存器实测 `SNAPSHOT_COUNT=25`、`TRIGGER_INDEX=20`、`DROPPED_COUNT=0`；
用户确认 SELF TEST 通过、EVENTS 仍可滚动查看 25 条。

## 真实双板 SPI

F407 独立高配核心板的板载 W25Q128、USART1 COM4 与 AC820 P7 被使用，
接线见 `docs/hardware/spi_board_test.md`。COM4 上 `help` 命令实际返回。
用户在 LCD 点 `ARM SPI` 并确认 `WAIT SPI` 后，首次 `spi jedec 3`：

- STM32：第一笔 `FF FF FF FF`，错误；后两笔 `FF EF 40 18`，通过，
  汇总 `passed=2 failed=1`。不能把该轮判为通过。
- FPGA：18 事件 = 3 START + 12 DATA + 3 END，外部丢弃和协议错误为 0。
  冻结快照为第一笔的 6 事件，DATA 中 MOSI `9F 00 00 00`、MISO 全 `FF`，
  与 STM32 失败日志一致。这定位为该笔实测 MISO 数据异常，非 LCD 误显示。

下一轮清零全局 SPI 统计，`spi jedec 10`：STM32 `passed=10 failed=0`，
每笔 `FF EF 40 18`；FPGA `events=60 starts=10 data=40 ends=10`，
各错误/外部丢弃为 0，脚本 `SPI_ACCEPTANCE_PASS`。

最终再次清零全局 SPI 统计，`spi jedec 100`：STM32 日志解析到 100 条，
事务号 14 至 113，100 条均为 `FF EF 40 18`，
`SUMMARY ... iterations=100 passed=100 failed=0`。同一轮 FPGA 统计
`events=600 starts=100 data=400 ends=100`，`dropped=0`，
`frame_errors=boundary_errors=duplicates=sequence_errors=0`，
脚本 `SPI_ACCEPTANCE_PASS`。这证明该轮 100 笔跨板监听及计数闭环通过。
首次三笔中的首笔全 FF 是仍需定位的偶发问题；不得用后续通过掩盖。

注意：PL 的 `DROPPED_COUNT` 还统计快照冻结后到来的事件，
多笔命令时可能非零；它不等于全局 SPI 统计的外部事件丢失计数。
本次 100 笔验收以清零后同轮全局计数与 STM32 日志为准。

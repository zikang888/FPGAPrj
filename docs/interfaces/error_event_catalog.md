# 错误事件接入目录（A/B/C 集成，2026-10-17）

依据队友提供的《错误事件列表.md》整理。列表是候选用例，不表示 FPGA
已经具备全部检测能力；本文件不改变 128-bit 事件 ABI。新增 SPI
语义计数器见寄存器表；`docs/protocol-rules/protocol_rules.yaml` 仍是草案。

`software/src/error_model.h` 给出 20 个稳定的软件 `ErrorCode`、来源
`ErrorOrigin` 和累计计数 `ErrorObservation`。`origin=NONE` 意味着未接入，
UI 必须显示 `--`，不能显示“0/正常”。有真实来源且 count=0 才表示
“已监测、当前为零”。生产者通过 `error_model_report()` 提供一个当前
复位周期内的累计计数，再让 PS UI 刷新；不得把普通 DATA 的 flags、
任意 ERROR 事件或 STM32 串口文本擅自映射成具体错误类别。

| 类别 | `ErrorCode` 范围 | 接入所需证据 | 当前状态 |
| --- | --- | --- | --- |
| SPI 半字节结束 | `ERROR_SPI_PARTIAL_BYTE` | PL `SPI_FRAME_ERROR_COUNT` (`0x004C`)；CS 上升时余 1–7 bit | **已接入**，ERRORS 显示真实计数 |
| SPI 事务过短、多余字节 | `ERROR_SPI_SHORT_TRANSACTION`、`ERROR_SPI_EXTRA_BYTES` | PL `0x0068/0x006C`；仅对 `0x9F` JEDEC 命令要求恰好 4 字节 | **已接入**，ERRORS 显示真实计数 |
| SPI 返回异常 | `ERROR_SPI_RESPONSE_MISMATCH` | PL `0x0070`；仅对已约定的 W25Q128 JEDEC 响应 `EF 40 18` 作比对，不是 SPI 物理错误位 | **已接入**；正常实板无误报和 RTL 故障注入已验证，真实坏响应注入仍待验证 |
| UART 停止位、Break、波特率不匹配、少字节/超时、校验位 | 对应 `ERROR_UART_*` | UART PL 接收与故障规则；少字节需事务长度/超时；校验位需先退出 8N1 配置 | 未接入；8N1 下不得报 parity error |
| I²C 地址 NACK、写周期忙 NACK、SDA/SCL 卡低、缺 STOP | 对应 `ERROR_I2C_*` | 地址/ACK 采样、受控超时与开漏总线状态规则 | 未接入；忙 NACK 是暂时状态，仅计数不自动判全局故障 |
| CAN ACK、位、填充、CRC、格式、bus-off | 对应 `ERROR_CAN_*` | 收发器/总线监测或 CAN 控制器状态，及受控故障注入 | 首版扩展，未接入 |

ERRORS 页另显示现有独立诊断：`EXTERNAL EVENT LOSS` (`0x0038`)、
SPI 事件检查 BND/DUP/SEQ (`0x0050/0x0054/0x0058`) 和**当前快照**的
通用 ERROR 事件数。SPI JEDEC 语义计数器与这些通用统计相互独立；
不把其它命令或器件的响应误判成 W25Q128 的错误。
`CORE REJECTED` 是冻结快照拒收的 INFO，仍在 SELF TEST，而不是通信
故障；不能把它计入错误总数。

接入下一项的顺序：批准该故障的字段/时间阈值和正常反例；增加
PL 或 PS 的实际证据来源及可重复注入；为 `ErrorCode` 报告累计计数和
来源；添加正常、故障、边界测试；最后才把 UI 的 `--` 变成数值。
`error_model_has_fault()` 会让已接入且非零的故障影响总体状态；
`ERROR_I2C_BUSY_NACK` 被明确排除，须另有超时规则才能升级为故障。
STM32 最新 `mc_faults.c` 的 20 个 case ID 与 `ErrorCode` 的一一对应由
`software/src/stm32_fault_bridge.h` 和主机测试锁定。映射只表示“发起了
哪个用例”，**不表示 FPGA 检出故障**；STM32 JSONL 中 `result=0` 也可能
仅说明注入动作成功。没有独立 PL/PS 证据时，不能据此向
`error_model_report()` 写入非零计数或把 UI 的 `--` 改成 `0/PASS`。

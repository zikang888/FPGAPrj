# PS EVENTS 通用事件视图（C 侧交付）

本模块只解码并显示现有 `docs/interfaces/register_map.md` 定义的 128-bit
事件字，不改变 PL→快照→PS 的正式数据路径、寄存器 ABI、触发规则或滚动逻辑。
生产入口仍是 `CaptureDemoCache.event_word[index][0..3]`。`event_view.h`
无 Xilinx 依赖，可对同一组原始 word 做宿主回归。

| 字段 | 来源 | EVENTS 行的处理 |
|---|---|---|
| protocol `[63:60]` | word1 `[31:28]` | VIRT/UART/SPI/I2C/CAN；其他值为 UNKN |
| event type `[53:48]` | word1 `[21:16]` | START/DATA/END/ERROR；保留扩展码显示为 EXTxx |
| flags `[47:32]` | word1 `[15:0]` | 保留原始十六进制；ERROR 行用红色显示 |
| transaction ID `[23:0]` | word0 `[23:0]` | 原始十六进制 |
| timestamp `[127:64]` | word3:word2 | 现有列表继续显示低 32 位 |

解码层还保留 channel、direction、payload length 和完整 64 位 timestamp，
供后续验收与详情视图使用。只有已定义的 SPI DATA（`protocol=2`、
`event_type=1`、`payload_length=2`）允许将 flags 拆为 MISO `[15:8]`
与 MOSI `[7:0]`；不得把这种含义套用到 UART/I2C/CAN。成员 C 的
`docs/protocol-rules/protocol_rules.yaml` 仍标记为 draft，本文不新增协议
专用 flags 或错误阈值。

在仓库根目录可用 Vivado 2018.3 随附的 MinGW GCC 运行：

```text
gcc -std=c99 -Wall -Wextra -Wpedantic -Werror software/tests/event_view_test.c -o event_view_test
event_view_test
```

宿主测试覆盖五种协议 ID、未知协议、通用 START/DATA/END/ERROR、未知扩展
事件码、128-bit 各字段、SPI TX/RX 拆分及错误事件不得误判为 SPI DATA。
现有 `pixel_scroll_test` 也须继续通过，PS 工程须用配套 HDF 生成 ELF。

## UART/I²C 接入前的快照审计接口

`software/src/event_audit.h` 的 `event_audit_snapshot()` 消费连续的
`count × 4` 个原始 word 和 trigger index；`CaptureDemoCache` 缓存触发
索引后，EVENTS 页在每次切换快照时只统计一次，并在页眉显示该快照的
`ERR` 总数。行内 `ERROR` 类型仍为红色，原始 flags 不被改写。
审计结果按协议 ID 给出总事件、START/DATA/END/ERROR 数；另计未知协议、
保留扩展类型、64 位时间戳逆序，以及仅对已定义 SPI DATA 的长度异常。
ERROR 代表捕获到了故障事件，不会被误报为快照元数据损坏。

`software/tests/event_audit_test.c` 用混合 UART/I²C 原始事件和 ERROR、
未知扩展事件验证上述计数，也覆盖无效 count/trigger、未知协议及
时间戳逆序。样例里的 UART/I²C flags 只是原始数值，**不定义**字节、
地址、ACK/NACK 或错误子类。UART 的空闲间隔边界和 I²C 的重复 START
尚无已批准的 PL 编码约定，因此审计器不会强行套用 SPI 的六事件序列。
运行方式与上面的 `event_view_test` 相同，只需改为
`software/tests/event_audit_test.c`。

验收边界：当前板测仅证明 SPI 监听与 100 笔 JEDEC；UART/I2C/CAN 的 PL
输入、物理引脚、事件产生及故障注入尚未在此分支实现或上板验证。
后续接入时，应从 PL 快照窗口提供同 ABI 的 UART/I²C 黄金事件语料与
故障注入语料，逐 word 对账并在 LCD 查看协议名、页眉 ERR、行内 ERROR、
原始 flags 和事务号；再依据成员 C 批准的协议字段语义增加专项检查。
不能只凭本宿主测试宣称这些协议链路完成。CAN 是否进入首版由独立
电气/资源评审决定。

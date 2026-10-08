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

验收边界：当前板测仅证明 SPI 监听与 100 笔 JEDEC；UART/I2C/CAN 的 PL
输入、物理引脚、事件产生及故障注入尚未在此分支实现或上板验证。
后续接入时，应从 PL 快照窗口提供同 ABI 的黄金事件语料，逐 word 对账
并在 LCD 查看协议名、ERROR 标记、flags 和事务号；不能只凭本宿主测试
宣称这些协议链路完成。CAN 是否进入首版由独立电气/资源评审决定。

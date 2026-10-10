# HOME 协议选择接口（2026-10-10）

HOME 上的 SPI / UART / I2C / CAN 四个标签是**运行时界面选择**，不是
可编程硬件多路复用器。`software/src/ui_protocol_select.h` 定义选择状态、
触摸矩形及可用性判定；`PlatformUiStatus.selected_protocol` 保存当前选择，
上电默认 SPI。选择保留到本次 PS 应用重启为止，不写入 Flash。

| 标签 | 当前 PL 状态 | HOME 行为 |
| --- | --- | --- |
| SPI | 匹配 PL 的 `CAPABILITIES[2]=1` 时显示 `PL READY` | 显示真实 SPI 字节轨迹；中央区域和 EVENTS 页允许 ARM SPI |
| UART | `NOT WIRED` | 显示监听器未连接，不武装 SPI，也不虚构 UART 波形 |
| I2C | `NOT WIRED` | 同上 |
| CAN | `NOT WIRED` | 同上；CAN 仍是首版扩展项 |

顶部 `PLATFORM READY/CHECK` 表示板级健康，不表示所选协议已接入；
`SPI CAPTURE` 是当前唯一真实监听器的状态。EVENTS 页面仍显示统一
快照里的**所有**协议事件，不随 HOME 标签暗中过滤；当选择非 SPI
协议时，EVENTS 的 SPI 武装按钮显示 `SELECT SPI` 并禁止点击。

未来接入 UART/I²C/CAN 时，先批准对应 PL 能力位、输入引脚、事件 ABI
和故障规则，再实现真实 listener 与抓取路径，最后更新
`ui_protocol_live()` 和 HOME 专属呈现。仅修改标签为 `PL READY` 不算
协议完成。`software/tests/ui_protocol_select_test.c` 覆盖标签边界、
间隙、无效触摸和 SPI 能力位门控。

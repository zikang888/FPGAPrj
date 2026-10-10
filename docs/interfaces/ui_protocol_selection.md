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
`SPI CAPTURE` 是当前唯一真实监听器的状态。所有页面页眉显示
`VIEW <协议>`；非 SPI 的页眉状态为 `OFFLINE`。SELF TEST 中
`BOARD HEALTH` 仍检查公共硬件，右下角另标所选监听器是否接入，
避免把板级 READY 当作协议可用。

EVENTS 对真实快照按事件 ABI 协议 ID 过滤，滚动范围和 `MATCH` 数量
只统计所选协议；SPI 的虚拟自检快照单独标为 `DEMO`，并不被说成
真实 SPI 事件。未接入的协议明确显示无实时事件，禁用 SPI 武装按钮。
ERRORS 对 SPI 展示已连接的检测项；对 UART/I²C/CAN 显示检测器未
连接，不把未测量误写成零错误。`GLOBAL EXTERNAL LOSS` 单独标注为
全局计数，不代表所选协议的诊断结果。

未来接入 UART/I²C/CAN 时，先批准对应 PL 能力位、输入引脚、事件 ABI
和故障规则，再实现真实 listener 与抓取路径，最后更新
`ui_protocol_live()` 和 HOME 专属呈现。仅修改标签为 `PL READY` 不算
协议完成。`software/tests/ui_protocol_select_test.c` 覆盖标签边界、
间隙、无效触摸和 SPI 能力位门控。

# CAN LIVE 使用：实时叠加、发送位错误、Bus-off

日期：2026-10-22。故障版须开启 `MC_ENABLE_CAN_FAULTS` 和 `MC_ENABLE_CAN_LIVE`；默认版禁用。当前构建脚本的 can_fault 配置包含 LIVE，下载以 [最新发布目录](../../stm32_f407/firmware/releases/README.md) 为准，旧 acfa7fe 固件没有 LIVE。

## 1. 必须增加的连线

| 信号 | 接线 | 说明 |
|---|---|---|
| PD1 / CAN1_TX | 原收发器 A TXD；另并一根跳线到 **PA1** | PD1 仍由 bxCAN 驱动；PA1 是 SOF 输入，不能作为第二个输出 |
| PD0 / CAN1_RX | 原收发器 A RXD | 真实总线读回；保留原接法 |
| **PA2** | **第二只 SN65HVD230 I 的 TXD** | 独立注入器；不能与 PD1 并接到同一个 TXD |
| I TXD 上拉 | 10 kΩ→3.3 V | MCU 未配置/退出后仍保持释放 |
| I VCC/GND | 3.3 V / 公共地 | Rs 按手册/模块原理图配置为正常高速模式 |
| I CANH/CANL | 原 CAN 主干 H/L | I 位于中间不启用额外 120 Ω，整条主干仅两端各一只 |
| 逻辑分析仪 | PD1、PA1、PA2、PD0，及 GND | 观察真正的 SOF、脉冲与实际 RXD，不直连 CANH/L |

PA1/PA2 是当前固件未占用的 MCU 信号名，不是 FPGA 球位或排针针号；接之前核对天空星实物排针和扩展负载。代码要求这两脚处于未配置输入态，已配置 AF/上下拉等资源时返回忙，不能覆盖原 UART/ADC/按键配置。

台架中 A 是唯一主动发送者，B 正常应答但不主动发送或回传，C 被动监听，I 只注入一次短脉冲。不要在未知外部流量、仲裁竞争或 CPU 调试暂停状态下使用本定时方案。

## 2. 命令与按钮

| 操作 | 行为 / 判定 |
|---|---|
| `can live start disturb 100 100 20` | 500 kbit/s，100 次请求，目标间隔 100 ms，每第 20 帧叠加脉冲；只将同步/脉冲完成作为该场景执行结果，CAN 反应另看日志 |
| `can live start bit 10 100` | 每帧 DATA 隐性位叠加显性，须本帧 TX 错误＋LEC 位错误证据才通过；缺 ACK 不通过 |
| `can live start busoff 64 100` | 最多 64 次受控发送错误，观察真实 BOFF 后提前结束并恢复；未达到则失败 |
| `can live status` | 查看次数、脉冲、位错误、BOFF、恢复前后 ESR 和恢复返回码 |
| `can live stop` | 停止、释放 I、终止请求、恢复外设配置；长按 PA0 同样停止 |
| `can live recover` | 恢复失败后重试；运行中相当于停止 |
| `fault run 15`（原 CAN BIT） | 执行一次 LIVE bit，500 kbit/s；精简版已从屏幕隐藏，底层不改 |
| `fault run 19`（原 CAN BUS OFF） | 启动最多 64 次、100 ms 间隔的 Bus-off 用例；不是一帧就保证 Bus-off；精简版已从屏幕隐藏 |

语法：`can live start disturb|bit|busoff COUNT PERIOD_MS [EVERY]`。disturb/bit 的 COUNT=1～10000，PERIOD=50～60000 ms，EVERY=1～60000，省略为 1。busoff 的 COUNT=32～128、PERIOD=50～1000 ms，EVERY 必须为 1；起始 TEC/REC 须为零、未处于 warning/passive/BOFF，避免把历史状态当作本轮结果。未满足时返回验证错误，可先建立正常基线或复位后检查。

上电不自动注入。默认版所有 LIVE start 返回不支持；故障版也必须显式触发。菜单 16/17/18 仍使用 RAW，与本后端不是同一实现。

## 3. 同步和目标位

真实 CAN1 发送标准 ID `0x321`、DLC 8，负载为大端 run（4 字节）＋frame（4 字节）。按合法位图/位填充计算 DATA 中第一个隐性位，避免把正常仲裁或 ACK 覆盖误判为位错误。

PD1 的 SOF 下降沿经跳线进入 PA1/TIM2_CH2，硬件启动内部计数，非 HAL 调用后软件延时。TIM2=84 MHz，每位 168 tick；PA2 反相 PWM2 在目标位 25%～90% 输出低电平，覆盖代码配置的约 85.7% 采样点。

SOF IRQ 在一位时间内关闭 slave 重触发，并检查 PD1 确为显性；迟到、合并 CC/UIF 或假边沿立即取消。CC3 IRQ 采参考电平，更新 IRQ 强制释放。Timer 中断延迟和收发器传播必须通过实板采集验证；软件模型不能替代定时测量。

## 4. 日志：分清执行与真正的错误状态

| 证据 | 含义 |
|---|---|
| `kind=can_live`、injected=1 | 同步与单次 PWM 完成，不单独证明总线故障 |
| bit_error=1、tx_error=1、first_lec=4/5 | 本次发送期间捕获到真实控制器的位错误和 TX 错误；无 ACK 的 LEC=3 不满足 |
| esr / tsr | 帧期间采样/中断捕获的控制器寄存器；ESR 中有 TEC/REC、warning/passive/BOFF |
| sof_irq_ticks | SOF IRQ 时的硬件计数偏移；不是用它作为 PWM 起点 |
| gpio | 位0：PD1 高；位1：PD0 实际总线显性；位2：PA2 低。是 IRQ 时的诊断快照，不替代波形 |
| busoff=1 | 帧日志中实际 ESR.BOFF 为 1；单纯无流量或发错 N 次不能代替 |
| `kind=can_live_end` | 保存 run、脉冲/位错误次数、busoff_seen、esr_before、esr_after、recovered、restore |
| recovered=1、restore=0 | 捕获 BOFF 后释放注入器，完成真实控制器恢复且 BOFF 已清除；不是直接改 ESR 状态 |
| `pl=unwired` | 本功能只说明 MCU/台架证据，尚不能说明 FPGA 已检测 |

disturb 的 PASS 指场景执行；bit 的 PASS 指位错误证据命中；busoff 的 DONE 需要本轮 BOFF 证据且恢复成功。耗尽次数但没 BOFF 为 ERROR，恢复失败保留资源锁。手动 recover 成功后历史 ERROR 可以保留，需同时看 held=0、restore=0 和 recovered。

## 5. 兼容与退出

LIVE 独占 CAN1、TIM2 和 CAN1_SCE/TIM2 IRQ；开始前拒绝正在发送/接收、已有 IER/IRQ/TIM2/PA1/PA2 配置。与 can test、RAW、旧测试命令互斥。默认启动不启用这些 IRQ/引脚，不改 Core/IOC 或旧协议编排。

每次单次发送关闭自动重发、自动 Bus-off 恢复。失败/停止先释放 I，再中止请求。BOFF 后锁存真实状态，临时启用控制器恢复流程并限时等待，最后恢复原 Init/IRQ/引脚/时钟。总线仍故障导致恢复超时，不会无限重试；修复台架后用 recover 或复位重新检查。

首次按 normal 基线→disturb 单次→bit 单次→间歇→busoff 顺序，保留四路波形、同轮 JSONL 和源提交。完整资源方案见 [规划](can_live_injection_plan.md)，构建/模型验证见 [记录](../test-results/2026-10-22-can-live.md)。本版尚未完成实板故障和 FPGA 检测验收。

bit 测试本身会增加 TEC。切换到 busoff 前要重新确认零计数基线，必要时先复位并重新记录运行号；没有达到该条件而返回验证错误是预期行为，不会偷偷清空计数来伪造起点。

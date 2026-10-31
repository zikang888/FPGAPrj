# STM32 四协议正常流量中插入偶发错误

日期：2026-10-30。目标：天空星 STM32F407VGT6，分支 `memberC/stm32-f407`。需要烧录包含所需功能的固件；发布情况见 [HEX 目录](../../stm32_f407/firmware/releases/README.md)。2026-10-31 菜单调整及 UART SHORT TXN、I2C BUSY NACK 混合模式需要包含本次变更的新固件。未完成实板/FPGA 验收。

## 1. 流量与边界

原单次发送保留；新增统一混合调度器，一轮只运行一种协议、一种错误。注入是**替换该位置的正常事务**，不是在总数之外额外追加错误。例：1000 个事务，第 500 个错误＝499 个正常＋1 个错误＋500 个正常。

| 协议 | 混合模式正常背景 | 可混入错误（原 fault 索引） | 硬件前提 |
|---|---|---|---|
| SPI | 一笔 `9F 00 00 00`，复用 case 1001，对比已探测 JEDEC ID | Partial 0、Short 1、Extra 2 | W25Q128；FPGA 并接 PA4～PA7 且保持输入；short/extra 需要已知 4 字节预期 |
| UART | USART3 按原一轮正常内容发送 `00 01 02 03 04 05 06 07`，**不等回送** | Bad Stop 4、Break 5、Short TXN 7 | PD8→对端 RX、共地；仍为 115200 8N1，错误结束后复用原恢复逻辑 |
| I2C | 读 AT24C256 0x50、0x0100 起 16 字节，**不写 EEPROM、不比较旧内容** | Address NACK 9、Busy NACK 10、Missing STOP 13 | PB6 SCL/PB7 SDA、3.3 V 上拉；0x50 必须 ACK、0x51 应无设备；Busy NACK 错误槽写 `0x0120` 为 `0xA5`（需预留测试区），随后 ACK 轮询；缺 STOP 保持 30 ms 后恢复 |
| CAN | bxCAN 标准 ID 0x321、DLC 8、500 kbit/s、一次发送请求，不等应用层 echo | Stuff 16、CRC 17；Form 18 仅串口混合模式 | PD0/PD1＋收发器、正确终端、另一个正常 ACK 节点；故障位置复用 PD1 RAW，需 CAN 故障版 |

这里的 `index` 是 **1 起始逻辑事务位置**，不是所有协议通用的“线上帧号”。UART 正常槽含 8 个字节帧；I2C 读含寻址/重复 START，NACK 钩子含基线探测和目标探测；CAN 错误帧可能引起其他节点错误标志。不能把一个注入槽机械等同于 FPGA 只能输出一条事件。

原正常菜单里的 UART ECHO、I2C 写读验证和 CAN ECHO **行为不改**；以上无回送/只读策略仅用于混合背景。原 20 个底层故障、冻结 case ID、协议 YAML、引脚/速率和 HAL 后端均不改；屏幕显示 11 个错误；混合模式另保留隐藏的 CAN Form 索引 18 的串口入口，共支持 12 个错误。

CAN 正常槽和错误槽分别启动一个原 normal/RAW 单帧会话，完成并恢复外设后才进入下一槽；不同时占用 CAN1/PD1。要求受控实验总线空闲、RX FIFO 无遗留帧，ACK 节点不要自动 echo 或主动持续广播。该实现是有间隔的混合序列，**不是无缝高速实时叠加**；没有新增硬件或启用原先关闭的宏。

## 2. 屏幕操作

四协议母菜单 → 选择错误 → 进入“运行方式”页（进入不发送）。PA0 短按切换、长按至少 0.8 s 确认，需稳定松手 30 ms 才能再次确认。

| 运行方式 | 一次确认后的行为 |
|---|---|
| SINGLE | 原错误动作一次；旧串口 `fault run N` 也仍直接单次执行 |
| ONE IN 100 | 总计 100 个事务，仅第 50 个注入 |
| ONE IN 1000 | 总计 1000 个事务，仅第 500 个注入 |
| EVERY 100 | 总计 1000 个事务，第 100/200/…/1000 个注入，共 10 次 |
| RANDOM 5 SEED 1 | 总计 1000 个事务，恰好 5 个不同位置注入；seed=1 可复现 |
| NORMAL 1000 | 对应协议 1000 个正常事务，零注入，供误报基线测试 |
| BACK | 返回错误列表，不发送 |

预设 GAP 为 100 ms。正常 6 项入口和各协议 BACK 不变。默认版拒绝 CAN 混合注入并给出 `-5`，**在发送第一个正常槽之前拒绝**；CAN 的 NORMAL 1000 可在默认版运行。

运行页含：协议、RUNNING/DONE/STOPPED/ERROR、DONE 完成/总数、INJ TRY 尝试/计划数、LOCAL FOK 本地故障动作成功数、BAD 本地失败数、当前 IDX 与 NORMAL/FAULT、RUN 与最近 R。`PHYSICAL/PL UNVERIFIED` 表示物理效果和 FPGA 检出尚未由本屏验证。

长按停止，结束后短按回运行方式页（串口启动则回原菜单）。恢复失败保持锁定，短按不退出，长按重试。DONE 置 PB2 LED，启动/失败清零；LED 不代表逐帧发送或 FPGA 命中。

## 3. 串口精确配置

USART1 115200 8N1，原 PA9/PA10。语法：

```text
mix start N TOTAL GAP MODE VALUE [SEED]
mix status
mix stop
mix recover
```

- N：上表 12 个原错误索引之一，协议由其决定；CAN Form 18 虽从屏幕隐藏，仍可通过串口混合模式执行。
- TOTAL：1～10000 个逻辑事务；GAP：100～60000 ms。
- MODE=`normal`：VALUE 必须为 0；`once`：VALUE 是 1～TOTAL 的注入位置；`every`：VALUE 是注入间隔；`random`：VALUE 是精确注入次数。
- SEED 只允许 random 使用，范围 1～4294967295，省略为 1；不是不可复现的硬件随机。固定种子不等于与现场随机故障具有相同统计分布。
- random 用固定 xorshift32 和剩余位置抽样，不重复，完整执行时次数恰好等于 VALUE。提前停止/本地错误时可能未到达全部计划位置。

四协议示例：

```text
mix start 0 1000 100 once 500
mix start 4 1000 100 once 500
mix start 9 1000 100 once 500
mix start 17 1000 100 once 500
```

分别为 SPI Partial、UART Bad Stop、I2C Address NACK、CAN CRC。其他模式示例：

```text
mix start 5 1000 100 every 100
mix start 13 1000 100 random 5 12345
mix start 16 1000 100 normal 0
```

**GAP 定义**：上一槽操作与其完成日志结束后，到下一槽启动之前的最小空闲间隔。因此不是精确每 100 ms 上线一帧；实际启动间隔还包括操作、日志、OLED 和主循环耗时。USART1 JSONL 为阻塞发送，日志会降低吞吐；本版优先可追溯，不能据预设推算精确总时长。调度器不会积压补发：即使主循环晚了，也最多推进当前一槽。

## 4. 停止、恢复与兼容

整轮运行一直持有混合测试锁，**即使处于正常槽之间的空闲 GAP** 也拒绝旧 SPI/UART/I2C/CAN 测试或另一混合运行；只能 `mix status/stop/recover`。原 CAN test/RAW/LIVE 会话未退出时，也拒绝启动混合模式。

同步 SPI/UART/I2C 单槽仍复用有界原函数，期间不能抢占；按键/命令在它返回后处理。CAN 通过原非阻塞会话轮询，RAW DMA/IRQ 按原机制结束。任何本地操作、恢复或日志失败都会停止本轮，不跳过失败继续跑。恢复失败继续锁住资源，重试成功后才能另开测试，不自动续跑原计划。

主动停止状态 STOPPED，R=-6 表示用户取消，不表示成功执行完全部事务。异步在途槽记 `slot_cancel`，不计成已完成或成功。恢复后的 ERROR 保留原执行失败，`held=0` 才表示资源可再使用。

## 5. 日志和 FPGA 对齐

新独立记录类型 `kind=mixed`，不改变旧 JSONL/case 映射。phase 有 begin、slot_begin、slot_end、slot_cancel、end、status。普通 runner/故障及 CAN 子会话继续输出原记录，不能同时把新旧两类相加为两次注入。

| 字段 | 含义 |
|---|---|
| run / index / total | 本次开机混合运行号、1 起始逻辑槽号、总数；复位后 run 重新开始 |
| fault_index / fault_case | 所选故障与冻结 case ID；不是每个正常槽也执行了该错误 |
| mode / value / seed / gap_ms | 模式 0=normal、1=once、2=every、3=random，完整计划参数 |
| fault_slot / planned / attempts | 该槽是否计划错误、计划错误总数、实际调用故障后端的尝试数；后端拒绝也算尝试，不等同线级故障 |
| fault_ok / normal_ok / failed / cancelled | 本地动作成功计数、本地正常成功、本地操作失败、在途取消；日志失败另看最终 result/state |
| dispatch_ms / started_ms / ended_ms / logged_ms | 调度决策、调用后端前、后端返回/异步结束、输出该条日志时的 MCU 毫秒；slot_begin 的 started_ms=0 表示尚未调用。不是精确的物理首边沿/最后边沿时间 |
| runner_first_txn / runner_next_txn | 本槽前后的旧 runner 事务 ID 范围 [first,next)；UART TX/I2C只读用 mixed_io，不占用旧 runner ID |
| can_child_run / can_backend | CAN 子会话号和 0=normal/1=RAW 后端；slot_end 可与本槽之间的 can_session/can_raw 记录对齐 |
| state / held / result / restore | 状态 0=IDLE、1=RUNNING、2=DONE、3=STOPPED、4=ERROR，锁定与返回码 |
| physical_verified / pl_verified | 固定 false，本地代码不冒充外部采集或 FPGA 证据 |

UART TX 和 I2C 只读另输出 `kind=mixed_io`，含 run、index、operation、data、result；data 是发送内容或读回缓冲，result 失败时不视为有效数据。

验证建议：先零注入，再单个指定位置，再每 100 个，再固定 seed 随机；每次保存串口原始文本、逻辑分析仪波形、FPGA 原始事件及 HEX 来源。SPI/UART/I2C 复用原 PC6 同步脉冲，CAN 子会话没有新增同步脉冲。MCU 与 FPGA 时钟不共基准，必须利用采集信号或人工对齐，不能直接减两边原始时间戳。

## 6. 离线核对工具

仓库根目录执行（MCU 原始终端日志可包含旧 JSONL 和命令回显）：

```powershell
./stm32_f407/tools/check_mixed_capture.ps1 -McuLog ./mcu.log -RunId 1
```

工具重放正常/指定/周期/随机计划，检查实际日志注入位置，输出计划位置、本地故障成功位置、是否完整结束。不要把不同 MCU 复位周期的同一 run 混在一个文件里；无 end/提前停止不标成完整通过。

可提供**离线归一化的错误事件** JSONL，格式如下。这是比较工具输入，不是修改 FPGA 现有事件 ABI，也不代表本分支实现了 FPGA 解码器：

```json
{"run":1,"index":500,"fault_index":0}
```

```powershell
./stm32_f407/tools/check_mixed_capture.ps1 -McuLog ./mcu.log -RunId 1 -FpgaErrors ./fpga_errors.jsonl
```

未提供物理确认时，comparison=`intent_only_NOT_detection_accuracy`：matched/missing/unexpected 只是与本地意图对照，不是真实检出率。独立波形确认后，以同格式整理 `confirmed_errors.jsonl`，再提供 `-ConfirmedErrors ./confirmed_errors.jsonl`，工具按用户提供的物理确认集合核对匹配、缺失、额外及重复报告。工具自身不测量波形，`physical_verified_by_this_tool` 始终 false。

归一化时先按成员 C 的规则确定一事务允许哪些事件、一故障引发多个底层事件如何合并；不能用“计数刚好相等”替代位置和类型匹配。FRAME_ERROR/CRC 等位图到 fault_index 的映射须使用实际 FPGA 规则，不自行假设。

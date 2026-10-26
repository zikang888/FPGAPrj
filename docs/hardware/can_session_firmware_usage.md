# CAN 场景会话固件使用说明（第一阶段）

日期：2026-10-22。对应 `memberC/stm32-f407`，实现范围来自 [CAN 故障复现规划](can_real_fault_reproduction_plan.md) 阶段 1。

本页描述第一阶段 `can test` 的周期发送、ACK/回传检查、位率失配和停止/恢复，该后端本身不使用额外 GPIO/TIM/DMA。第二阶段新增独立 `can raw` 后端，详见 [GPIO 位流说明](can_gpio_bitstream_usage.md)；它在故障版使用 TIM1/DMA 和 PD1，PB0/PB1 未启用。原 case ID/含义保持不变，成员 C 的规则仍待冻结。

可直接烧录的默认/故障 HEX 及校验值见 [版本发布目录](../../stm32_f407/firmware/releases/README.md)。历史 `5d788f8` 仅有默认版；新发布同时提供两个配置。

## 1. 命令与硬件条件

通过 USART1（PA9 TX、PA10 RX、115200 8N1），输入命令并以换行结束：

| 命令 | 作用 / 条件 |
|---|---|
| `can test start normal 100 100` | 500 kbit/s，100 帧，目标发送间隔至少 100 ms。需要收发器和一个正常 ACK 节点；不要求应用回传 |
| `can test start echo 100 100` | 同上，但要求对端将 ID `0x321`、DLC 8 的负载原样回传；检查内容和超时 |
| `can test start noack 10 100` | 检查每次发送是否采样到 ACK 错误；须自行让所有其他控制器静默/退出应答，并保留正确终端；默认未启用 |
| `can test start bitrate 100 100 20` | 每第 20 帧，A/STM32 临时改为 250 kbit/s；下一帧回到 500 kbit/s；B 保持 500 kbit/s。记录实际错误，不预设必为 CRC；默认未启用 |
| `can test status` | 查看状态、提交数、完成数、通过/失败、故障槽和恢复结果 |
| `can test stop` | 停止会话，中止尚未结束的请求，并恢复 CAN 参数 |
| `can test recover` | 恢复失败后重试释放；运行中输入则相当于停止 |

语法：`can test start normal|echo|noack|bitrate COUNT PERIOD_MS [EVERY]`。COUNT=1～10000；PERIOD_MS=50～60000；EVERY 仅用于 bitrate，省略为 20，范围 1～60000。多余参数、负数、超界或非法字符会被拒绝。每帧超时为 `min(PERIOD_MS/2, 40 ms)`，发送和回传共用该窗口。

会话由主循环轮询调度，串口日志、屏幕刷新及 CAN 重新配置会产生延迟；间隔是目标最小调度间隔，**不是精密硬件定时承诺**。延迟后不会突发补发。CAN 帧内位时序由 bxCAN 产生，不依赖主循环延时。

### 默认故障开关

默认工程仅启用 normal/echo。noack/bitrate 返回 `-5`，不会提交帧或改变 CAN 配置。硬件按规划连接并确认后，在 Keil 的 C/C++ Preprocessor Symbols 中保留现有 `USE_HAL_DRIVER,STM32F407xx`，追加 `MC_ENABLE_CAN_FAULTS` 并重新编译。此宏也会开启已有单次 `CAN NO ACK` 钩子，应一并了解原菜单行为。实验命令可用不代表项目规则中的 `can.enabled` 已被批准开启。

## 2. 原逻辑的兼容方式

| 资源 / 功能 | 兼容处理 |
|---|---|
| SPI1、USART3、I²C1、原单次菜单 | 空闲时按原方式使用；会话持有资源期间拒绝其他测试命令和按钮触发，避免阻塞调度或重复操作 CAN |
| CAN 邮箱 / 接收 FIFO | 开始前要求三个发送邮箱空闲、FIFO0/FIFO1 无待收数据、无遗留 FIFO0 overrun；不会抢占旧用例的未完成请求 |
| CAN 中断 | 当前采用轮询，只在 IER=0 时接管；后续有其他 CAN IRQ 用户时返回忙，不会偷偷关闭其通知 |
| 原 CAN 参数 | 保存 CAN Init 配置和 IER；会话使用单次发送、关闭自动 Bus-off 恢复；正常结束、停止和错误退出均尝试恢复 |
| 恢复失败 | 保持资源锁，屏幕显示 `RESTORE FAILED`；仅允许会话控制命令，防止旧测试在未知配置上执行；可重试 recover，持续失败需排查硬件并复位 |
| 动态状态 | 配置恢复不代表 TEC/REC、历史错误或外部节点状态被还原；这些动态结果仍需记录和检查 |
| TIM / DMA / 新 GPIO / CubeMX | 本次不占用新资源，不修改 `.ioc`、`main.c` 或现有 IRQ 配置 |

会话拥有 FIFO0 时会消费接收到的帧，用于清理本会话数据或检查回传，因此该时段不能同时运行另一套 CAN 接收任务。恢复后原 CAN 回环可继续使用，但对端需回到正确位率与正常模式。

## 3. 按钮与可见标志

- 2026-10-27 起使用四协议母/子菜单：短按切换，长按进入/执行/BACK；CAN 子菜单包含 NORMAL TX（1 帧会话）、NORMAL ECHO（原 case 4001）及 6 个原错误事件。`NORMAL N FAULT M` 是触发尝试次数，不代表成功发帧数。详见 [菜单操作](stm32_fault_menu_oled.md)。
- 会话通过串口启动；OLED 显示 `RUNNING/DONE/STOPPED/ERROR`、运行号、`REQ` 提交请求数、完成数、PASS/FAIL、`SLOTS` 和最近返回码。
- 会话运行时长按 PA0 停止，短按不执行原故障。会话结束后短按返回原菜单；恢复失败时长按重试恢复。
- `REQ` 仅代表调用发送提交成功；确认成功上总线需看 TXOK/ACK 或独立波形。`SLOTS` 表示调度到了故障槽，不代表已测量的有效物理故障数。
- 屏幕显示 `PL NOT CONNECTED`。FPGA 检测数没有物理输入时不显示推测值。

## 4. 日志与结果含义

每帧一条独立 JSONL，`kind=can_session`，字段包括 `mode/run/frame/ms/observed_ms/bitrate/fault_slot/submitted/tx/rx/transport/result/cancel/esr/tsr/rf0r/first_lec/fifo_overrun/backend/pl`。

| 字段 / 情况 | 含义 |
|---|---|
| 固定帧 | 标准 ID `0x321`、DLC 8；前四字节为大端 run，后四字节为大端 frame，用于区分旧回传 |
| `ms` / `observed_ms` | MCU 调度提交时间 / 最近采样控制器状态的时间；非精确帧起点或 PL 硬件时间 |
| `transport=0` | normal/bitrate 表示控制器报告 TXOK；echo 还要检查回传；`submitted=1` 单独不能证明 TXOK |
| noack 的 `result=0` | 已提交、发送未成功、采样到 ACK 错误（LEC=3），且无取消/后端错误；表示预期故障命中，不是正常通信成功 |
| bitrate 的 `result` | 保留实际传输结果；没有把任意失败直接算作故障注入“通过”。250 kbit/s 槽可能报错或没有预想错误，须看原始采集 |
| echo | 内容不匹配为 `-4`，超过窗口为 `-3`；ACK 成功不等于应用回传成功 |
| `esr/tsr/rf0r` | 帧期间采样到的寄存器快照；`fifo_overrun` 锁存本帧观察到的 overrun，`first_lec` 是轮询首先观察到的错误，不是完整错误历史 |
| 停止中的帧 | 记录 `result=-6`，不计入正常完成/通过；因此提交数可以大于完成数 |
| `restore` / `held` | 状态行中的配置恢复返回码 / 是否仍持有资源；结束时有任一恢复错误不可按正常完成验收 |
| `pl=unwired` | 尚无 CAN PL 检测证据；MCU 返回码不能作为 FPGA 检测结果 |

状态 `DONE` 表示次数执行完并已恢复，不代表所有帧通过；需同时看 PASS/FAIL。日志输出失败、配置/后端失败或观察到 BOFF 会终止会话并尝试恢复。软件错误为 `-1` 参数、`-2` IO、`-3` 超时、`-4` 验证、`-5` 不支持、`-6` 忙/取消。

## 5. 首轮台架步骤

1. 先按 [规划接线表](can_real_fault_reproduction_plan.md#4-接线与器材) 接 A/B/C；I 本阶段不需要。确认 3.3 V、共地、两端终端、B 正常 500 kbit/s。逻辑分析仪接收发器 RXD，不能接 CANH/L。
2. 启动采集后运行 `can test start normal 10 100`，核对 10 个请求与控制器 TXOK；再运行 echo，核对 B 的应用回传。
3. 会话中输入旧命令，确认只提示忙；用 `can test stop` 或长按停止，确认恢复后旧 `spi jedec 1`、`can loop 1` 等仍可用。
4. 启用宏后，让 B 静默，运行 noack；完成后把 B 恢复正常再复测 normal。固件不能自动切换外部 B 的模式。
5. B 保持 500 kbit/s，运行 bitrate，核对每第 N 帧为 250 kbit/s、其他帧 500 kbit/s；检查停止/结束后均恢复原参数。
6. 留存同轮串口日志、逻辑采集和固件版本。本版本尚无实板烧录或 FPGA CAN 验收记录。

首轮不要同时启用外部 GPIO 干扰、缺终端和位率失配，先让每项单独可复现、可恢复。

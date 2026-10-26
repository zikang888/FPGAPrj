# STM32F407 正常/错误事件分级菜单与 SSD1306 OLED 接线

状态：初版实现于 2026-10-12；2026-10-27 改为四协议母菜单，增加正常测试入口，随后按用户图片将屏幕错误项精简为 10 项；底层 20 个故障和串口保留。已完成主机测试，尚未烧录或完成波形实测。新界面须烧录 [最新发布 HEX](../../stm32_f407/firmware/releases/README.md)，旧 HEX 不会自动更新。协议规则由成员 C 维护，详见 `docs/protocol-rules/protocol_rules.yaml`。

## OLED 选择

参考资料是用户指定的 `SSD1306-Revision_1.1.pdf`。该控制器支持 4 线 SPI，D0 为 SCLK、D1 为 SDIN；D/C 低表示命令、高表示显示数据。当前驱动按 **128×64、7 针、4 线 SPI、内部电荷泵** 模块编写。模块的实际针脚顺序和供电电压应以模块丝印/原理图为准，SSD1306 芯片手册不规定成品模块排针顺序。

| OLED 模块信号 | 天空星 STM32F407 | 说明 |
|---|---|---|
| GND | GND | 公共地 |
| VCC | 3.3 V | 先核对模块是否支持 3.3 V 供电 |
| SCLK / D0 | PB13 | 软件 SPI 时钟 |
| SDA / DIN / D1 | PB15 | 软件 SPI 数据 |
| CS | PB12 | 低有效 |
| DC / D-C | PC4 | 命令/数据选择 |
| RES / RST | PC5 | 低有效复位 |

OLED 使用独立 GPIO 软件 SPI，不占用连接板载 W25Q128 的 SPI1 PA4～PA7。驱动位于 `stm32_f407/app/src/mc_oled.c`，按页寻址写入 1024 字节画面。

## 选择和触发

- 母菜单 `PROTOCOL SELECT`：SPI、UART、I2C、CAN 四项。PA0 短按切换，长按（至少 800 ms）进入子菜单；导航不发送。按下与松开均作 30 ms 稳定消抖，建议短按 100～300 ms。
- 子菜单：先列正常测试，再列该协议的错误事件，最后一项为 `BACK`。短按选下一项（自动翻页、循环），长按执行所选测试一次；选 `BACK` 长按返回母菜单，不发送。
- 同一次持续长按最多确认一次：长按进入子菜单后，必须稳定松开至少 30 ms 再长按才执行，不会直接连发；上电一直按住时须先松手才启用按键。没有定时循环发送的新模式；需要多轮时仍用原串口命令的 count。
- USART1 115200 8N1：`fault list`、`fault select N`、`fault run`、`fault run N`。N 为 0～19。
- `fault select N` 对可见事件定位到对应子菜单，对隐藏事件返回其协议母菜单；均不会执行。`fault run` 仍执行最后选定的故障（包括隐藏项），正常菜单选择不会将它改成另一故障。下面的索引始终是原串口故障索引，不是新屏幕行号。
- `NORMAL N FAULT M` 分别显示本次开机正常菜单触发尝试次数、故障触发尝试次数（含串口故障触发），不代表成功帧数。导航不会增加计数，复位后清零。
- 同步测试先显示 `RUNNING PLEASE WAIT`，完成显示 `LOCAL OK R 0` / `LOCAL ERROR R -N`；不支持显示 `DISABLED/NEEDS HW`。运行很短时可能看不清 RUNNING，可核对累计计数和 USART1 的 JSONL/SUMMARY。PB2 LED 在正常测试开始时清零，最终成功置位，失败清零；LED 不是逐帧脉冲。
- CAN NORMAL TX、RAW/LIVE 使用独立会话页：显示 RUNNING/DONE/STOPPED/ERROR、REQ、DONE、PASS/FAIL。长按停止；完成后短按回原子菜单，不切到下一项；恢复失败时短按不退出，长按重试恢复。见 [CAN 会话使用说明](can_session_firmware_usage.md)。
- 测试沿用原日志：普通 runner 输出含 case ID 的 JSONL/SUMMARY，CAN TX/RAW/LIVE 输出独立会话记录，不新分配 case ID。`0` 或 `LOCAL OK` 只表示本地动作/对应比较完成，不能表示 FPGA 检出。I²C NACK 与 CAN ACK 探测检查本地状态；`-5` 表示当前路径不支持。

## 正常测试子项

| 母菜单 | 子项 | 一次确认执行内容 | 对端/注意事项 |
|---|---|---|---|
| SPI | NORMAL JEDEC | case 1001：一笔 `9F 00 00 00`，比较缓存的实物 ID | W25Q128；上电原有 case 1000 探测最多 3 次不变；若缓存无效，本次先重新探测，探测失败不执行 1001 |
| SPI | NORMAL PATTERN | case 1002：一次原有确定性字节模式事务 | 复用 SPI1 与原 CS；成功只表示本地传输完成，不校验 Flash 内容 |
| UART | NORMAL ECHO | case 2001：USART3 发送 8 字节，然后收 8 字节比较 | PD8→对端 RX，PD9←对端 TX；也可隔离外部驱动后本地 TX/RX 回环。缺少回送会超时，不能据此说未发送 |
| I2C | NORMAL EEPROM | case 3001：0x50、0x0100 起写 16 字节、等待就绪、读回比较 | AT24C256、3.3 V 上拉；会覆盖 0x0100～0x010F，必须预留为测试区 |
| CAN | NORMAL TX | `normal 1 100` 会话：提交 1 帧，500 kbit/s、标准 ID 0x321、8 字节，不要求应用层回送 | 必须有收发器、正确终端与另一正常节点 ACK；不是无对端物理回环。不新增冻结 case ID |
| CAN | NORMAL ECHO | case 4001：发送 1 帧后接收同 ID/数据并比较 | 对端须主动发送回送帧；ACK 不等于应用层 echo |

每个协议均保留其原有引脚、速率和测试格式；未新增协议规则或启用原先关闭的故障宏。CAN Bus-off 已从屏幕隐藏，原串口 `fault run 19` 的最多 64 次有界尝试逻辑保留。

## 与旧代码的隔离

纯菜单状态与映射在 `common/src/mc_ui_menu.c`，消抖/长按锁存在 `common/src/mc_button.c`，实际发送仍在原 runner、fault hooks、CAN 会话后端；规范 Keil 工程已加入新源文件。`mc_faults.c`、20 个故障 ID、协议规则、HAL 引脚初始化和接收环形缓冲不改。CAN 持有资源或恢复未成功时，仍阻止其他测试进入。两个新板级主机测试分别编译默认和故障宏配置，调用真实 `mc_board_app.c`、模拟按键和 I/O 验证，不等价于电气/时序实测。验证见 [本次记录](../test-results/2026-10-27-hierarchical-menu.md)。

## 屏幕保留的错误事件（仅图片中的 10 项）

| 母菜单 | 屏幕错误项 | 原串口索引 |
|---|---|---|
| SPI | PARTIAL BYTE、SHORT TXN、EXTRA BYTE | 0、1、2 |
| UART | BAD STOP、BREAK | 4、5 |
| I2C | ADDR NACK、NO STOP（图片中的 missing STOP） | 9、13 |
| CAN | STUFF ERROR、CRC ERROR、FORM ERROR | 16、17、18 |

正常测试 6 项、四协议母菜单、BACK 和按键方式均不变。SPI MISO CHECK，UART BAUD OFFSET/SHORT TXN/PARITY，I2C BUSY NACK/SDA LOW/SCL LOW，以及 CAN NO ACK/BIT/BUS OFF 仅从屏幕隐藏，不删除实现、不改用例编号或串口权限。CAN 屏幕错误项仍需故障版 HEX 和 RAW 接线；默认版不会因为可见而启用故障宏。

## 后台保留清单（20 项，并非屏幕显示清单）

| 索引 | 事件 | 当前执行方式/前提 |
|---:|---|---|
| 0 | SPI PARTIAL BYTE | PA5/PA7 临时切 GPIO，发 4 bit 后 CS 上升，再恢复 SPI1 |
| 1 | SPI SHORT TXN | JEDEC ID 事务只发 2 个完整字节，需 FPGA 知道预期 4 字节 |
| 2 | SPI EXTRA BYTE | JEDEC ID 事务发 5 个完整字节，需 FPGA 知道预期 4 字节 |
| 3 | SPI MISO CHECK | 仅能观测和比较真实 MISO，STM32 不会凭软件制造 Flash 输出损坏 |
| 4 | UART BAD STOP | PD8 临时 GPIO 输出停止位低电平，再恢复 USART3 |
| 5 | UART BREAK | PD8 保持低电平 13 位时间，再恢复 USART3 |
| 6 | UART BAUD OFFSET | 以 96000 baud 发 `55`，再恢复 115200；对端预期保持 115200 |
| 7 | UART SHORT TXN | 约定 8 字节时只发 3 字节，需对端事务长度/超时规则 |
| 8 | UART PARITY | 8N1 基线没有校验位，列为不可执行 |
| 9 | I2C ADDR NACK | 先确认 `0x50` ACK，再探测 `0x51` NACK |
| 10 | I2C BUSY NACK | 向 EEPROM 写 1 字节，立即 ACK 轮询，记录实际 NACK 次数；若无 NACK 返回 `-4` |
| 11 | I2C SDA LOW | 需 PC7 经限流电阻接 SDA，并启用 `MC_ENABLE_I2C_FAULT_LINKS` |
| 12 | I2C SCL LOW | 需 PC8 经限流电阻接 SCL，并启用 `MC_ENABLE_I2C_FAULT_LINKS` |
| 13 | I2C NO STOP | 开漏 GPIO 发地址后保持 SCL 低 30 ms，再发 STOP 恢复总线 |
| 14 | CAN NO ACK | 需收发器且无其他节点应答；启用 `MC_ENABLE_CAN_FAULTS` 后单次发送并恢复重发设置 |
| 15 | CAN BIT | 新 LIVE 故障版：独立收发器＋PD1→PA1/PA2，同步叠加，单次检测真实发送位错误 |
| 16～18 | CAN STUFF/CRC/FORM | 默认版仍不支持；新故障版由板级菜单转到 PD1 RAW 后端，单次 500 kbit/s |
| 19 | CAN BUS OFF | 新 LIVE 故障版：最多 64 次、100 ms 间隔；只凭真实 BOFF 判目标达到，再恢复；默认/旧 RAW 版不支持 |

RAW 的接线、串口命令和两个编译开关见 [GPIO 位流使用说明](can_gpio_bitstream_usage.md)。本版复用 PD1 和现有收发器，先暂停 bxCAN，再 GPIO 播放并恢复；不启用 PB0/PB1。`mc_faults.c` 和旧 case ID 不改，故障版板级菜单 16～18 改派到独立 `kind=can_raw` 会话，不能据其完成结果报告 PL 检出。

LIVE 接线/第三个编译开关见 [LIVE 使用说明](can_live_injection_usage.md)。15/19 已从屏幕隐藏；串口 `fault run 15` / `fault run 19` 仍派发独立 LIVE 后端，要求增加收发器 I；不要照 RAW 仅一个收发器的接法使用。

## FPGA 配合

- 现有 SPI 监听器只对索引 0 的残帧有线级 `FRAME_ERROR` 触发。索引 1/2 要求对端知道测试用例的期望长度。
- UART、I²C、CAN 的新增事件必须由对应监听器/PS 分析逻辑实现，STM32 只能产生或观察总线条件。
- `TEST_SYNC` PC6 在每次用例前输出 1 ms 脉冲；如 FPGA 未接同步输入，按测试顺序和日志 `case_id` 对齐。
- CAN 项目规则仍是 `enabled: false`。完成收发器、终端和 PS/EMIO 接线核对后，由成员 C 决定是否启用。

## 恢复与保护

- SPI 残帧结束后拉高 PA4 并恢复 PA5/PA7 到 SPI1 AF5。
- UART 位级故障结束后将 PD8 拉高并恢复 USART3 AF7。
- I²C 延迟 STOP 最长 30 ms，之后发送 STOP 并重新初始化 I²C1。
- PC7/PC8 故障连线默认关闭；启用时只能开漏下拉，不允许推挽输出高。
- CAN 单次无 ACK 探测默认关闭；启用时使用一次发送且恢复正常自动重发设置。

资料来源：SSD1306 Rev 1.1，第 17～18 页（4 线 SPI），第 30～31 页（页寻址与显示 RAM）；嘉立创天空星官方引脚资料及本项目 CubeMX `.ioc`。

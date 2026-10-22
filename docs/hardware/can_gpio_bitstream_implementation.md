# CAN GPIO 位流后端实施方案

日期：2026-10-22；范围：经典 CAN 标准数据帧、合法/CRC/填充/格式错误语料。此文档规定本次实现边界，结果以对应构建和测试记录为准。

## 1. 接线与角色

第一版复用已核对的 PD1，而不是启用未核实板级负载的 PB0/PB1：

| 信号 | 接法 | 作用 |
|---|---|---|
| STM32 PD1 | 现有 SN65HVD230 D/TXD | 正常模式为 CAN1 AF9，RAW 会话临时为 GPIO 推挽 |
| STM32 PD0 | 同一收发器 R/RXD | 正常 CAN1 接收；RAW 期间从 GPIO IDR 检查总线空闲 |
| 模块 VCC/GND | 3.3 V / 公共地 | 按模块原理图确认 Rs 为正常工作模式 |
| CANH/CANL | 双绞主干 H/L，两端各 120 Ω | 沿用原 CAN 台架，不直接连接 MCU 或普通逻辑分析仪 |
| FPGA / 逻辑分析仪 | 从收发器 RXD 旁听；另采 PD1 | RXD 是实际总线，PD1 是预期发送位参考 |
| 其他 CAN 控制器 | 首先配置 Silent，且不主动发送 | 先得到完整独立语料；再以正常节点观察错误响应 |

RAW 发送器不执行 CAN 仲裁、同步接收或自动重发，只能在专用、无其他主动发送者的台架使用。普通接收节点可在 ACK/错误标志阶段改变实际总线；原始输出完成不等于总线上整帧原样出现。此后端没有 TEC/REC/Bus-off 状态机。

## 2. 资源和互斥

| 资源 | 分配 / 冲突处理 |
|---|---|
| TIM1 | 内部计时，不输出到 GPIO AF；使用更新 DMA 请求。要求进入前 TIM1 时钟和相关 IRQ 未被其他用户占用 |
| DMA2 Stream5 Channel6 | TIM1_UP→GPIOD BSRR，32-bit、存储器自增、有限 NORMAL 传输；只更新 PD1 位 |
| DMA2_Stream5 IRQ | 完成或错误时停止请求并释放 PD1；主循环随后处理日志/恢复，不在 IRQ 打印 |
| DMA2 控制器 | 首版严格要求进入前时钟关闭/无其他使用者；拒绝与未来 SPI/UART/ADC DMA 共享，避免误覆盖配置 |
| PD1 | 保存该脚 MODER/OTYPER/OSPEEDR/PUPDR/AF/ODR，退出恢复；不修改 PD8/PD9 等同端口其他脚 |
| CAN1 | 保存 Init 和 IER，要求无待发/待收/IRQ 用户后停止；RAW 与 bxCAN 会话/旧测试互斥 |
| 缓冲 | 静态 word 数组，必须位于 DMA 可访问的 SRAM，拒绝 CCM/越界地址 |

依据：[ST RM0090](https://www.st.com/resource/zh/reference_manual/DM00031020.pdf) 的 DMA2 请求映射、GPIO BSRR、TIM1 更新章节；[ST AN4678](https://www.st.com/resource/en/application_note/an4678-full-duplex-spi-emulation-for-stm32f4-microcontrollers-stmicroelectronics.pdf) 说明 TIM＋DMA＋GPIO BSRR/IDR 的可行架构。TIM1_UP 对应 DMA2 Stream5/Channel6；不使用 DMA1 访问 GPIO。

## 3. 位流与错误制造

| 模式 | 制造方法 | 预期检查 |
|---|---|---|
| valid | SOF、11-bit ID、RTR/IDE/r0、DLC、8 字节数据、CRC-15、位填充、delimiter/ACK/EOF/IFS | 除无主动应答时 ACK 为隐性外，其余字段合法 |
| crc | 修改 CRC-15 的一个位，再对变化后的内容重新生成正确位填充 | 不出现更早的填充错误；接收端计算 CRC 不一致 |
| stuff | 在已知填充位位置将反向填充位改回前一位的值 | 填充区出现连续第六个同值位，记录 wire bit 索引 |
| form | 把 ACK delimiter 从隐性改成显性 | 在固定格式位置出现异常；避开 EOF 判定例外 |

标准 CRC 多项式 `0x4599`、初值 0，覆盖去填充的 SOF 至数据结束；按 MSB first 输出。填充范围覆盖 SOF 至 CRC sequence。错误类别定义参考 [Microchip CAN Bus Errors](https://developerhelp.microchip.com/xwiki/bin/view/applications/can/overview/errors/)。

每帧尾部增加隐性保护位，DMA 的最后输出一定为高。首位先写入，再在每个 TIM1 更新输出下一位。DMA 正常完成 IRQ 停止 TIM1；即使主循环暂时延迟，有限 DMA 序列也在尾部释放总线。错误、中止和恢复路径均需关闭 DMA 请求并拉高 PD1；无法确认硬件停止时保持资源锁。

支持 125 kbit/s 和 500 kbit/s；在 HCLK=168 MHz、APB2=84 MHz 配置下，TIM1=168 MHz，PSC=0，ARR 分别为 1343/335。实际 GPIO 更新延迟和收发器波形必须上板采集，编译和主机测试不证明电气时序合格。

## 4. 命令与结果

规划命令：`can raw start valid|crc|stuff|form BITRATE COUNT PERIOD_MS [EVERY]`，例如 `can raw start crc 500000 100 100 20`：所有帧都由 GPIO 发送，每第 20 帧为 CRC 错误，其他为合法语料。它不是 bxCAN 正常帧中途叠加干扰。

使用独立 RAW 会话和 `kind=can_raw` 日志；沿用 stop/status/recover、有限次数和执行计数。记录计划模式、实际帧模式、bitrate、位数、目标错误位和 DMA 状态；`result=0` 只说明 DMA 输出完成，`pl=unwired` 不冒充 FPGA 检测。

默认版禁用 `MC_ENABLE_CAN_FAULTS` 与 `MC_ENABLE_CAN_RAW_GPIO`；故障版同时启用。宏只允许功能，仍需明确 start 命令才输出，不在启动时自动播放错误帧。默认版与故障版分别编译、校验、归档，不能共用同名 HEX。

## 5. 验证与后续边界

主机验证合法语料的 CRC/去填充、三类错误定位、尾部释放、容量边界、命令参数、每 N 帧、互斥、中止和恢复。ARM 完整编译两个配置，保留原协议回归。台架先 125k、再 500k，先 valid、再单次错误、最后间歇错误。

RAW 不实现任意真实帧中的实时覆盖，也没有控制器 TEC/REC/Bus-off。后续已新增独立 [LIVE 实现](can_live_injection_usage.md)，使用 PA1/PA2 和第二只收发器，在本节点已知帧中叠加并读取真实状态；PB0/PB1 仍不使用，RAW 的输出不能当作 LIVE 的位错误证据。

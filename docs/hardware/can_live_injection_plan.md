# CAN 实时叠加、发送位错误与 Bus-off 实施方案

日期：2026-10-22。接续 PD1 RAW；本文规划独立收发器 I 的 LIVE 后端，不把 GPIO 输出完成当作已确认位错误或 Bus-off。

## 1. 接线与同步

| 连接 | 用途 |
|---|---|
| PD1→原收发器 A TXD，PD0←A RXD | A 由真实 bxCAN 发合法帧，提供 TX/RX 与错误状态 |
| **PD1 另用跳线→PA1/TIM2_CH2** | 捕获本节点 SOF 下降沿，硬件启动 TIM2；未接线时超时报错，不能用 HAL 调用时刻代替 SOF |
| **PA2/TIM2_CH3→独立 SN65HVD230 I 的 TXD** | 输出一次显性脉冲；I TXD 加 10 kΩ 到 3.3 V 以在未配置/断开时释放 |
| I 的 CANH/L/GND | 与 A/B/C 并入同一主干；3.3 V 供电、共地，只有物理两端 120 Ω |
| 逻辑分析仪 | 同时采 PD1、PA1、PA2、PD0；不要接 CANH/L |

PA1/PA2 在当前 IOC 未占用，芯片 AF1 为 TIM2_CH2/CH3；需按天空星实物排针丝印确认这两个 IO 没有连接其他扩展负载。不猜 FPGA 针号，不借用原 PA0 按键、OLED 或 I²C 故障脚。

台架只有 A 主动发起帧；B 正常 ACK、但不主动发帧或做应用回传；C 被动监听；I 仅施加脉冲。未知外部流量/仲裁将破坏预先计算的位位置，不用于任意真实网络。

## 2. 三种模式

| 模式 | 制造方式 | 成功证据 |
|---|---|---|
| disturb | 每 N 帧在已知 DATA 隐性位叠加显性脉冲 | SOF 同步、PWM 脉冲完成；控制器反应另记录，不强称目标错误命中 |
| bit | 同上，要求真实发送节点检测到不一致 | 有效同步/脉冲＋该次 TX 错误＋SCE 中断捕获 LEC=4/5，单纯缺 ACK 不通过 |
| busoff | 每次都制造上述发送位错误，有限次数重复 | 真实 ESR.BOFF，记录恢复前 ESR/TEC/REC；次数耗尽仍无 BOFF 则失败，不推测已 Bus-off |

默认 500 kbit/s，ID `0x321`、DLC 8、负载 run/frame。按经典 CAN 合法位图选 DATA 中第一个隐性位（避开仲裁/ACK），TIM2=84 MHz、每 bit=168 tick，显性窗口为目标位的 25%～90%，覆盖 A 的约 85.7% 采样点。收发器和输入同步延迟必须实测，代码计算不替代波形验收。

## 3. 资源与退出

- 独占 TIM2 和 CAN1_SCE/TIM2 IRQ，拒绝已有 IRQ、待发/待收、TIM2 时钟用户；与 RAW、can test、旧测试互斥。
- TI2FP2 下降沿硬件触发、PWM2 反相输出、OPM。SOF 触发 IRQ 立即关闭后续 slave 触发，计数继续；要求 IRQ 延迟小于 1 bit 且 PD1 仍为显性，否则释放并报同步错误。即使计数器回零，也检查合并的 CC/UIF 标志拒绝迟到。更新 IRQ 强制释放并停表。
- CC3 IRQ 记录脉冲时 GPIO 参考；SCE IRQ 锁存 LEC、ESR、位错误和 BOFF，防止之后错误/成功帧覆盖第一原因。
- A 关闭自动重发和自动 Bus-off 恢复，每次只提交一个请求；总次数/每帧超时受限，支持停止。故障解除后显式恢复配置并等待 BOFF 清除；不能恢复时持锁并允许重试。
- Bus-off 从真实状态确认，不修改 ESR 伪造，不用纯 ACK 错误代替。日志分离 output / bit_error / BOFF / recovered。
- 默认版关闭 LIVE 宏；故障版允许，但必须接线后显式命令/菜单才开始，启动不自动干扰。

依据：[ST 芯片引脚数据](https://github.com/STMicroelectronics/STM32_open_pin_data/blob/master/mcu/STM32F407V%28E-G%29Tx.xml)、[RM0090](https://www.st.com/resource/en/reference_manual/dm00031020.pdf)、[Kvaser 错误计数/ACK 例外](https://kvaser.com/can-protocol-tutorial/)。这是台架实现，不用于外部运行中的车辆或设备网络。

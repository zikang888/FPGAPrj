# CAN GPIO 位流使用与接线

日期：2026-10-22。默认版禁用 RAW；CAN 故障版同时开启 `MC_ENABLE_CAN_FAULTS`、`MC_ENABLE_CAN_RAW_GPIO`。固件下载统一从 [发布目录](../../stm32_f407/firmware/releases/README.md) 选择。

## 1. 接线：本版复用 PD1，不接 PB0/PB1

| 模块信号 | 天空星 / 采集端 |
|---|---|
| SN65HVD230 VCC、GND | 3.3 V、公共地；Rs/工作模式以模块原理图为准 |
| D / TXD | PD1；同一时刻只由 bxCAN 或 GPIO 中的一者驱动 |
| R / RXD | PD0；逻辑分析仪/FPGA 可在逻辑侧并联输入 |
| CANH / CANL | 两根独立的双绞主干线，H 对 H、L 对 L，物理两端各 120 Ω |
| 逻辑分析仪 | 一路采 PD1（预期输出），另一路采 PD0/RXD（实际总线），并接 GND |

本版 RAW 是独占位流发生器，不执行 CAN 仲裁。先让其他控制器 Silent 且不发送，核对完整语料；若需要正常接收器 ACK 或错误响应，再单独切换节点模式。FPGA 若仅旁听不提供 ACK，合法 RAW 帧的 ACK 槽保持隐性是已知条件，不能因此误判 CRC/填充错误。

不需要为本版额外购买收发器 I，不把 PB0/PB1 接到已有 TXD，不把 CANH/L 接 GPIO。旧规划中独立 I 与额外 GPIO 是后续 LIVE 干扰方案，当前实现使用 A 的现有收发器。

## 2. 确认固件版本

USART1 115200 8N1 启动信息新增：

```text
BUILD rev=源提交前7位 CAN_FAULTS=1 CAN_RAW_GPIO=1 RAW_TX=PD1
```

默认版两个开关均为 0；手工 Keil 构建未定义 `MC_BUILD_REV` 时显示 `0000000`。脚本构建会填入真实源提交。开关为 1 只允许命令/按键触发，启动不会自动发送错误位流。

## 3. 命令与菜单

| 操作 | 作用 |
|---|---|
| `can raw start valid 125000 1 100` | 125 kbit/s，发一个合法标准帧语料 |
| `can raw start crc 125000 1 100` | 发一个 CRC 不匹配语料；重新执行正确位填充 |
| `can raw start stuff 125000 1 100` | 将一个真实填充位改错，形成可定位的填充违规 |
| `can raw start form 125000 1 100` | ACK delimiter 输出显性位 |
| `can raw start crc 500000 100 100 20` | 500 kbit/s，共 100 帧，每第 20 帧为错误 CRC，其余由 GPIO 输出合法帧 |
| `can raw status` | 当前 RAW 会话计数、状态、锁和恢复结果 |
| `can raw stop` / `can raw recover` | 中止/重试恢复；运行中长按 PA0 也可停止 |
| 故障菜单索引 16 / 17 / 18 | 故障版显示 `RAW READY PD1`；长按分别播放一次 stuff / crc / form，固定 500 kbit/s |

语法：`can raw start valid|crc|stuff|form BITRATE COUNT PERIOD_MS [EVERY]`。BITRATE 仅 125000/500000，COUNT=1～10000，PERIOD_MS=50～60000，EVERY=1～60000，省略为 1。`EVERY` 表示每第 N 帧为目标错误；valid 模式始终合法。全部帧均由 GPIO 播放，不是 bxCAN 帧上叠加干扰。

标准 ID `0x321`、DLC 8；负载为大端 run（4 字节）＋frame（4 字节）。运行号/帧号能重建预期 TX，避免把不同帧混淆。先 125k、单帧采集，再 500k 和间歇播放。

索引 15 位错误和 19 Bus-off 不由 RAW 实现，新 LIVE 故障版已通过 [独立后端](can_live_injection_usage.md) 提供，需额外接线；旧 acfa7fe 不包含 LIVE。`mc_faults.c`、case ID 与 PS 20 项映射保持不变；板级菜单 16～18 使用 RAW，日志仍为独立记录类型，不把它记成 PL 检测。

## 4. 输出结果和互斥

- `CAN RAW PD1` 页面显示 RUNNING/DONE/STOPPED/ERROR、REQ、完成数、PASS/FAIL、故障槽；长按停止，完成后短按返回。
- `REQ` 表示提交了 DMA；RAW 的 PASS/`result=0` 表示输出完成，不能证明收发器或 FPGA 正确收到错误。
- 日志 `kind=can_raw`，含 run/frame、实际帧 mode、bitrate、预期 tx、位数、fault_bit、crc15、dma_flags/dma_result、取消结果和 MCU 时间；`rx=null`、`meaning=output_only`、`pl=unwired`。
- `fault_bit` 从 SOF 起按 0 计数，无故障为 -1；`crc15` 是正确 CRC 基线，crc 模式线上 CRC 的最低位被翻转。
- TIM1 更新 DMA2 Stream5/Channel6 写 GPIOD BSRR，只修改 PD1；DMA 缓冲位于 SRAM。每帧保护尾部为隐性，完成/错误 IRQ 释放 PD1，主循环再恢复 AF9 与 CAN。
- RAW 与 `can test`、旧测试互斥。TIM1、DMA2 时钟/IRQ 或原 CAN 邮箱/FIFO 已有用户时拒绝接管；恢复失败保留锁，可重试 recover。活动位流不刷新 OLED、不输出逐位日志。
- 开始前需观察到持续总线空闲，否则拒绝输出；这不是运行中的仲裁检测，台架不得有其他主动发送器。

## 5. 构建两个配置

在仓库根目录运行（Keil 路径可通过 `-Keil` 指定）：

```powershell
& .\stm32_f407\firmware\build_profiles.ps1 -Profile all -Release
```

脚本要求固件源文件和构建脚本已提交，生成临时 MDK 工程；不改规范 `.uvprojx` 的默认宏。输出分别在 `Projects/MDK-ARM/profile_default/`、`profile_can_fault/`。只有 0 error / 0 warning 且 HEX 存在才判通过。分发文件须有对应配置、源提交、SHA-256，不能将两种 HEX 同名覆盖。

详细资源规划见 [实施方案](can_gpio_bitstream_implementation.md)。目前编译/主机验证不替代实际位宽、接线、错误分类与停止恢复的上板验收。

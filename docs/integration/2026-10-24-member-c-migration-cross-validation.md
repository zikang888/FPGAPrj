# member C：Vivado / Vitis 2026.1 迁移版本交叉验证

日期：2026-10-24。提交成员：**member C**。分支：`migration/vivado-vitis-2026.1`。来源：`fix/fpga_waveform` 的 `0d9fde5b312a62feed08525b0c1c31f4385e7f81`。

## member C 的当前结论

这是从 Vivado/SDK 2018.3 迁移至 **Vivado/Vitis 2026.1** 的版本，保留 Zynq-7020、ACZ702 + AC820、800×480 LCD / GT911 和四协议功能。

member C 已在本机实板确认：**触控正常、切换页面正常、协议监听与显示正常。** 自动测试同时验证了 SPI 100 笔对账、UART RX、CAN 正常回环、会话保存和四协议 HOME 快照。触控与页面反馈来自 member C 的人工操作；计数和图像来自 JTAG / 串口证据。

**请其他成员在独立环境中再做交叉验证，在本分支的 PR 中反馈，通过后再讨论合入。** 当前状态不等于其他成员已经验收，不自动合并到其他分支。

## 使用哪一组文件

- 新版开发入口：[README_MIGRATION_2026_1.md](../../README_MIGRATION_2026_1.md)。
- 首轮复测优先使用 [本轮板测镜像](../../releases/vivado-vitis-2026.1-memberC-20261024/README.md)，包含相互匹配的 BIT、include_bit XSA、ELF、PS 初始化、SHA256 清单和下载脚本。
- 测试明细：[2026-10-24 实板记录](../test-results/2026-10-24-vivado-2026.1-board.md)。
- 已记录 [2026 版 skill](../../skills/vivado-vitis-2026/SKILL.md)。如需在 Codex 中复用，可复制整个 `skills/vivado-vitis-2026` 目录到自己的 Codex skills 目录；reference 中的绝对路径是 member C 本机历史环境，请按实际安装调整。

不要混用旧发布目录的 ELF/HDF 和本迁移版 BIT。原 `01_Open_Vivado.cmd` / `02_Open_SDK.cmd` 等属于 2018.3 入口；新版使用 `01_Open_Vivado_2026_1.cmd` 与新版脚本。首次只读枚举自己的串口和 JTAG 目标，COM3 / COM6 是 member C 的现场编号。

## 请其他成员复测

| 项目 | member C 结果 | 请交叉验证的内容 |
|---|---|---|
| 启动与平台 | ID / 版本 / scratch / 时间戳通过 | 匹配文件加载，PS / UI READY 与寄存器读回 |
| LCD / GT911 | 显示稳定，触控正常，切页正常 | HOME / EVENTS / ERRORS / HISTORY 切换、四角定位、滑动与历史重开 |
| SPI | 100 passed / 0 failed；100 START / 400 DATA / 100 END / 600 EVENT；错误为零 | 清计数后的同轮对账、事务顺序、HOME MOSI/MISO |
| UART | 8 字节 / 10 事件，`00..07`，无 stop / break / short 错误 | RX 监听、HOME 显示；当前 RX-only 不提供完整回环 |
| I2C | 25 事件，1 次 busy NACK，EEPROM 命令未通过 | 监听、错误归因，以及 EEPROM busy 后的重试/时序 |
| CAN | 2 帧 / 20 事件，ID=0x321、DLC=8，matched，本轮无错误 | 收发/回环、数据、统计、HOME 显示 |
| 会话 | 四次保存，history=4；SPI 600 事件保留末 256 条、dropped=0 | ARM / FREEZE / ACK / re-arm、过滤、保存和重开 |
| 工具与稳定性 | 8 RTL / 11 宿主测试通过；内部时序通过 | 2026.1 重建、独立环境下载、持续运行和故障场景 |

进行 SPI 100 笔测试时先 `protocol spi`、`test start`，再清计数并发流量，最后 `test stop`；HOME 会在 20 ms 空闲后冻结，不能用于全量压力计数。保留 256 条事件是环形容量策略，需与 600 的全量计数分别对账。

## 已知边界需要继续核验

- 2026.1 hw_server 在 member C 本机目标枚举阻塞；实际成功路径是 **2026.1 XSDB + 2018.3 hw_server**。请反馈其他环境是否能用完整 2026.1 调试链路。不要同时让多个服务端争用同一根线缆。
- UART TX 回传尚未实现；I2C EEPROM busy NACK 未闭环。协议监听与显示正常的确认不表示这两项已解决。
- LCD / CAN 外部时序预算、长时间稳定性、完整故障注入和独立 SD 启动仍待验证。

## 反馈格式

请在 PR 回复以下信息，异常尽量附串口日志、PL 计数、图片或具体复现步骤：

```text
验证成员：
分支 / commit：
板卡 / 屏幕 / STM32 固件版本：
Vivado / Vitis / hw_server 版本：
使用配套镜像或自行重建：
触控 / 切页 / 四角 / 滑动：
SPI / UART RX / I2C / CAN：
会话保存 / 历史重开：
持续运行时间：
发现的问题与证据：
结论：通过 / 有条件通过 / 未通过
```

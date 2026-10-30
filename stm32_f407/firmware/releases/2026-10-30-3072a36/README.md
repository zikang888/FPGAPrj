# 四协议混合正常/错误流量固件：2026-10-30 / 3072a36

仅用于天空星 **STM32F407VGT6**，不是仓库其他分支的 F103 固件。

| 下载 | 配置与范围 |
|---|---|
| [默认版 HEX](sky_star-default-3072a36.hex) | SPI/UART/I2C 混合注入、四协议纯正常基线；CAN 故障宏关闭，CAN 注入在首槽前拒绝 |
| [CAN 故障版 HEX](sky_star-can-fault-3072a36.hex) | 上述功能＋CAN Stuff/CRC/Form 混合注入；CAN_FAULTS/RAW_GPIO/LIVE 均保持原故障配置开启 |

## 新增功能

- 四协议正常背景中替换指定位置为错误，支持纯正常、指定一次、每 N 次、固定 seed 随机 K 个不同位置。总数包含错误槽，不额外追加。
- 屏幕：四协议 → 原 10 个错误之一 → SINGLE / ONE IN 100 / ONE IN 1000 / EVERY 100 / RANDOM 5 SEED 1 / NORMAL 1000 / BACK。
- 运行页显示完成/总数、注入尝试/计划数、本地成功/失败、当前槽、运行号/结果；长按停止，恢复失败锁定并允许重试，完成后短按返回。
- CLI：`mix start N TOTAL GAP normal|once|every|random VALUE [SEED]`、`mix status|stop|recover`。如 `mix start 17 1000 100 once 500`，在 1000 个 CAN 事务中第 500 个为 CRC 错误（需故障版）。
- 新 mixed/mixed_io 元数据关联槽位与旧 runner/CAN 日志；提供离线计划与归一化 FPGA 结果核对工具，不把本地 R=0 当成物理确认或 FPGA 命中。

原正常 6 项、20 个后台 fault ID、单次 fault CLI、协议规则、引脚/速率、HAL 后端均保留。UART 混合背景只发送不等 echo，I2C 混合背景只读而不写 EEPROM；原单次正常测试不变。GAP 是完成和日志后的最小空闲间隔，不是精确帧周期。CAN 是有间隔的 normal/RAW 切换，不是无缝注入。

CAN 混合错误沿用 PD0/PD1＋收发器与 ACK 节点的 RAW 接线，不需要为本功能增加 LIVE 的 PA1/PA2 连线；LIVE 原命令若另行使用仍须其原接线。I2C_FAULT_LINKS 在两个配置中都关闭；混合模式不包含该连线错误。

完整操作、帧/事务边界和核对步骤见 [使用说明](../../../../docs/hardware/stm32_mixed_traffic.md)。必须烧录本次新 HEX 才有混合模式，历史发布不覆盖。

## 构建与校验

固件干净源提交：[`3072a36790db1ebd3ead2e21f91a3a8d3582177d`](https://github.com/zikang888/FPGAPrj/commit/3072a36790db1ebd3ead2e21f91a3a8d3582177d)。使用 `build_profiles.ps1 -Profile all -Release`、Keil ARMCC 5.06 update 2，两配置均 **0 error / 0 warning**。启动 `BUILD rev=3072A36`。发布提交另含离线工具的物理确认边界补充，不影响已构建 MCU 源码。

| 校验项 | 默认版 | CAN 故障版 |
|---|---|---|
| Code / RO / RW / ZI | 37970 / 5310 / 116 / 6836 | 46002 / 6198 / 116 / 8092 |
| HEX 文件字节数 | 122112 | 147193 |
| SHA-256 | `D392CF6A038F7BCC263A2C297CC5D2EC8225F9C37E44367B877BBBB9725F79B9` | `1F6D562E54A436D670C032A2547F1FAE9A6C9CDA5E1603FDE08169B63BD85A4E` |

按 HEX 自带地址烧录，起始 0x08000000；机器可读 [manifest.json](manifest.json)。仓库根目录：

```powershell
./stm32_f407/firmware/verify_release.ps1 -Directory ./stm32_f407/firmware/releases/2026-10-30-3072a36
```

当前环境 **15/15 主机测试通过**，包括实际板级应用的默认/故障模式模拟、全部 10 种错误夹杂、停止与恢复、随机重放和离线核对；见 [验证记录](../../../../docs/test-results/2026-10-30-mixed-traffic.md)。未烧录、未采集实板波形、未验证 FPGA 检出，不据本地成功码声称物理错误或 FPGA 验收已通过。

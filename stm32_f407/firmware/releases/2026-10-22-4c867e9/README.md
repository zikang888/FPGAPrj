# CAN LIVE 故障固件发布：2026-10-22 / 4c867e9

| 下载 | 配置 | 功能 |
|---|---|---|
| [CAN 故障版 HEX](sky_star-can-fault-4c867e9.hex) | CAN_FAULTS=1、CAN_RAW_GPIO=1、CAN_LIVE=1 | 保留 RAW，加实时叠加、发送位错误检查、真实 Bus-off 观察和恢复 |
| [默认版 HEX](sky_star-default-4c867e9.hex) | 三个 CAN 故障宏均关闭 | 保留原测试和 normal/echo；不接管 RAW/LIVE 资源 |

目标：天空星 STM32F407VGT6；不是 F103 固件。源提交：[`4c867e9087bfac55792f872375e7af945024bf80`](https://github.com/zikang888/FPGAPrj/commit/4c867e9087bfac55792f872375e7af945024bf80)。两个配置从该干净提交使用 `build_profiles.ps1 -Profile all -Release` 完整构建；发布提交可以不同，不能用发布提交号推断重新编译。

| 项目 | 默认版 | CAN 故障版 |
|---|---|---|
| Code / RO / RW / ZI | 32590 / 3954 / 92 / 5924 | 40634 / 4842 / 92 / 7180 |
| HEX 文本字节数 | 103093 | 128211 |
| SHA-256 | `5198D43692C94D17748203C6682C71339722C065D27187781E800F9C550F425C` | `F3EE60B1783D2F9D5F3F0330097F90DFB05D109EC505EDB6FBA76C811C36075E` |
| 预处理符号 | USE_HAL_DRIVER、STM32F407xx、MC_BUILD_REV=0x4c867e9 | 左侧符号＋MC_ENABLE_CAN_FAULTS、MC_ENABLE_CAN_RAW_GPIO、MC_ENABLE_CAN_LIVE |
| 编译 | ARMCC 5.06 update 2，0 error / 0 warning | ARMCC 5.06 update 2，0 error / 0 warning |
| 起始地址 | 0x08000000，按 HEX 地址烧录 | 同左 |
| I²C 故障连线宏 | 关闭 | 关闭 |

故障版启动行可核对 `rev=4C867E9` 和三个开关均为 1；上电不自动注入。

## 新增连线与操作

保留 PD1→原收发器 A TXD、PD0←A RXD。另接：

- **PD1→PA1**：SOF 硬件同步跳线。
- **PA2→第二只收发器 I 的 TXD**，I 的 TXD 加 10 kΩ 上拉到 3.3 V。
- I 的 H/L 并到原主干，共地，正常 3.3 V 供电；中间节点不再加终端。

B 正常 ACK，但不主动发送或回传；逻辑分析仪同时采 PD1/PA1/PA2/PD0。不要把 PA2 与 PD1 并到同一个 TXD，不直接连接 CANH/L 到 GPIO。

```text
can live start disturb 100 100 20
can live start bit 10 100
can live start busoff 64 100
can live status
can live stop
can live recover
```

这些命令分开执行，不作为自动脚本连续提交。Bus-off 开始前要求零 TEC/REC，先前 bit 测试会增加计数，应重新建立基线或复位并记录。故障版菜单 15 单次 bit，19 最多 64 次/100 ms 的 busoff；16～18 保持 RAW。

Bus-off 只有在真实 ESR.BOFF 及注入/位错误证据满足时才算达到；次数耗尽未达到会失败。释放 I 后进行限时恢复，保存恢复前后 ESR；失败持锁。disturb 的输出成功不等于位错误，bit 的位错误不等于 PL 检出。

## 验证范围

主机 9/9，通过生成/判定、真实适配源寄存器模型、退出和恢复测试；两个配置完整 ARM 编译通过，HEX 地址/记录/校验值检查通过。**尚未烧录或完成物理时序、实际 Bus-off 与 FPGA CAN 检测验收。**

[接线与全部参数](../../../../docs/hardware/can_live_injection_usage.md) · [实施方案](../../../../docs/hardware/can_live_injection_plan.md) · [验证记录](../../../../docs/test-results/2026-10-22-can-live.md)。可用 `firmware/verify_release.ps1 -Directory firmware/releases/2026-10-22-4c867e9`（从 stm32_f407 目录）校验。

# CAN GPIO 位流固件发布：2026-10-22 / acfa7fe

| 下载 | 配置 | 用途 |
|---|---|---|
| [CAN 故障版 HEX](sky_star-can-fault-acfa7fe.hex) | CAN_FAULTS=1，CAN_RAW_GPIO=1 | 本次故障检测台架使用；无 ACK、位率失配、GPIO 合法/CRC/填充/格式语料 |
| [默认版 HEX](sky_star-default-acfa7fe.hex) | CAN_FAULTS=0，CAN_RAW_GPIO=0 | 原测试和 normal/echo 会话；RAW 不允许输出 |

目标是天空星 STM32F407VGT6，不适用于仓库的 F103 控制板/接收板。两个版本均包含相同提交的源代码，以宏分离能力，**上电不会自动发送错误位流**。必须用命令或故障版菜单触发。

## 来源与构建

源提交：[`acfa7fe88f3df760dd1c43e527750615b98f9ccd`](https://github.com/zikang888/FPGAPrj/commit/acfa7fe88f3df760dd1c43e527750615b98f9ccd)。
完整构建命令：`stm32_f407/firmware/build_profiles.ps1 -Profile all -Release`。
工具链：Keil ARMCC 5.06 update 2；两个配置均 0 error / 0 warning。启动 BUILD 行显示 `rev=ACFA7FE` 和对应开关。

| 项目 | 默认版 | CAN 故障版 |
|---|---|---|
| Code / RO / RW / ZI | 31826 / 3594 / 88 / 5688 | 36582 / 3926 / 84 / 6836 |
| HEX 文件字节数 | 99927 | 114216 |
| SHA-256 | `E91A7CD8CACDC3AFE9FC731D8ABC62FA9A46CE729479F2082515D6F59379EA36` | `C800BE737E333560BB1DC2742469195673B5DD31ABAF0E7EC8CE7A046382DAD5` |
| 用户宏 | USE_HAL_DRIVER、STM32F407xx、MC_BUILD_REV=0xacfa7fe | 左侧宏＋MC_ENABLE_CAN_FAULTS、MC_ENABLE_CAN_RAW_GPIO |
| I²C 故障连线宏 | 关闭 | 关闭 |
| Flash 起点 | 0x08000000 | 0x08000000 |

源提交是编译依据，后续添加发布文件的 Git 提交号可以不同。Intel HEX 包含地址信息，按 HEX 地址烧录；文件字节数是文本长度，不是 Flash 占用。Git 按二进制保存，以维持 CRLF 和校验值。

## 快速使用故障版

接线保持 PD1→收发器 TXD，PD0←RXD，3.3 V、共地和正确终端。第一轮把其他控制器置为 Silent 且不发送，从 125k 单次 RAW 开始：

```text
can raw start valid 125000 1 100
can raw start crc 125000 1 100
can raw start stuff 125000 1 100
can raw start form 125000 1 100
can raw status
```

故障版菜单 16/17/18 长按可在 500k 播放一次对应 RAW 语料；会话长按停止。索引 15 位错误、19 Bus-off 仍不支持制造，不能据此推断已实现全部 CAN 故障。

RAW 会暂停 bxCAN，临时复用 PD1，使用 TIM1＋DMA2 Stream5/Channel6；退出恢复，忙资源拒绝接管。它不是在线仲裁节点，也不是在另一帧上叠加干扰，`result=0` 仅指输出完成，不能代替总线/FPGA 检测。

详情：[接线与使用](../../../../docs/hardware/can_gpio_bitstream_usage.md)、[实施方案](../../../../docs/hardware/can_gpio_bitstream_implementation.md)、[验证记录](../../../../docs/test-results/2026-10-22-can-raw-profiles.md)。主机测试 6/6，已完整 ARM 构建；尚无本版烧录、物理波形或 PL CAN 验收。

可在本机运行 `firmware/verify_release.ps1 -Directory firmware/releases/2026-10-22-acfa7fe`（从 `stm32_f407` 目录）校验两个文件。

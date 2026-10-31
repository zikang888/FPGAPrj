# STM32F407 固件发布目录

只用于天空星 STM32F407VGT6，不能用于仓库其他 STM32F103 分支。以每个发布目录的源提交、配置和 SHA-256 为准。

**源码更新提示（2026-10-31）：** 下方最新已发布 HEX 仍是 2026-10-30 版，不包含恢复 UART SHORT TXN、I2C BUSY NACK 和隐藏 CAN FORM 的菜单调整，也不支持 UART SHORT TXN、I2C BUSY NACK 混合模式。新源码需重新构建后烧录；本次构建受本机 Keil 链接器代码大小限制，尚无对应新 HEX。

| 发布 | 配置 | 说明 |
|---|---|---|
| [2026-10-30 / 3072a36](2026-10-30-3072a36/README.md) | 最新已发布默认版＋CAN 故障版（旧菜单） | 四协议正常背景混入错误：指定/周期/可复现随机、纯正常基线、屏幕预设/进度/停止与离线核对 |
| [2026-10-27 / 1487034](2026-10-27-1487034/README.md) | 历史默认版＋CAN 故障版 | 按图片仅显示 10 个错误，正常项不变；其他错误仅从屏幕隐藏，底层/串口保留 |
| [2026-10-27 / 89283c6](2026-10-27-89283c6/README.md) | 历史默认版＋CAN 故障版 | 四协议母菜单、6 个正常入口、原 20 个故障子项、BACK 与消抖；保留 CAN RAW/LIVE |
| [2026-10-22 / 4c867e9](2026-10-22-4c867e9/README.md) | 历史默认版＋CAN 故障版 | LIVE 叠加、位错误与真实 Bus-off/恢复；原平铺菜单，接线分 RAW/LIVE |
| [2026-10-22 / acfa7fe](2026-10-22-acfa7fe/README.md) | 历史默认版＋CAN 故障版 | noack/bitrate 和 PD1 RAW；菜单 16～18，不含 LIVE |
| [2026-10-22 / 5d788f8](2026-10-22-5d788f8/README.md) | 旧默认版 | 第一阶段 CAN 会话；CAN 故障宏关闭；保留为历史产物 |

默认版与 CAN 故障版的差别、RAW 命令和按键见 [GPIO 位流使用说明](../../../docs/hardware/can_gpio_bitstream_usage.md)。发布 HEX 的 CRLF 按二进制保留，下载后按对应 manifest 校验。

LIVE 另需第二只收发器和 PA1/PA2 连线，详见 [LIVE 使用说明](../../../docs/hardware/can_live_injection_usage.md)；不能只照 RAW 的接法运行 LIVE。

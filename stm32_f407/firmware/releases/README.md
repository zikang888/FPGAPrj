# STM32F407 固件发布目录

只用于天空星 STM32F407VGT6，不能用于仓库其他 STM32F103 分支。以每个发布目录的源提交、配置和 SHA-256 为准。

| 发布 | 配置 | 说明 |
|---|---|---|
| [2026-10-22 / acfa7fe](2026-10-22-acfa7fe/README.md) | **默认版＋CAN 故障版** | 当前版本：故障版开启 noack/bitrate 和 PD1 RAW 位流；支持菜单 16～18 |
| [2026-10-22 / 5d788f8](2026-10-22-5d788f8/README.md) | 旧默认版 | 第一阶段 CAN 会话；CAN 故障宏关闭；保留为历史产物 |

默认版与 CAN 故障版的差别、RAW 命令和按键见 [GPIO 位流使用说明](../../../docs/hardware/can_gpio_bitstream_usage.md)。发布 HEX 的 CRLF 按二进制保留，下载后按对应 manifest 校验。

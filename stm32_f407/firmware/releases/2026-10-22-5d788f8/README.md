# 天空星 STM32F407 默认固件发布：2026-10-22

下载：[sky_star_protocol_node-default-5d788f8.hex](sky_star_protocol_node-default-5d788f8.hex)（GitHub 页面中点击 Raw/Download raw file 保存）。

| 项目 | 内容 |
|---|---|
| 源代码分支 | `memberC/stm32-f407` |
| 源代码提交 | [`5d788f8482698bfc2a4c2c5e44c2deb0fd6c572e`](https://github.com/zikang888/FPGAPrj/commit/5d788f8482698bfc2a4c2c5e44c2deb0fd6c572e) |
| 目标硬件 | 天空星 STM32F407VGT6；128×64 SSD1306 7 针 SPI OLED |
| 编译器 | Keil ARMCC 5.06 update 2；完整默认工程，0 error / 0 warning |
| Program Size | Code=30886、RO=3362、RW=72、ZI=5512 |
| 文件大小 | 96576 字节（Intel HEX 文本长度，不是 Flash 占用大小） |
| SHA-256 | `70BB21B652013607D09ADF9A70B48C2857047A6E81560F4F3153E7514D0224C3` |
| 应用 Flash 起点 | `0x08000000`；Intel HEX 含地址信息，按 HEX 地址烧录 |
| 默认预处理符号 | `USE_HAL_DRIVER,STM32F407xx` |
| 故障开关 | `MC_ENABLE_CAN_FAULTS`、`MC_ENABLE_I2C_FAULT_LINKS` 均未定义 |
| 验证 | 主机测试 4/4；默认完整 Keil 构建通过；尚无本版实板烧录或波形验收 |

本 HEX 是源代码提交 `5d788f8` 的既有构建输出原样归档。后续文档/发布提交号可以不同，不能用发布提交号推断 HEX 重新编译过。此目录不作为可变的 `latest.hex`，后续不同代码或配置须使用新的发布目录和校验值。

包含原 SPI/UART/I²C/CAN 测试、单次菜单、OLED 计数，以及 CAN normal/echo 周期会话。noack/bitrate 返回不支持；需要启用时按 [CAN 会话说明](../../../../docs/hardware/can_session_firmware_usage.md) 重新构建并使用不同的发布名称，不能把本默认 HEX 当作已开启故障配置。

原单次 SPI/UART GPIO 故障钩子可由菜单触发，默认关闭的是上述 CAN/I²C 可选宏，不是关闭整个错误菜单。PB0/PB1、CAN GPIO 位流注入尚未实现。外设接线见 [主接线文档](../../../../docs/hardware/member_c_stm32f407_implementation.md)。

本分支不包含 FPGA 的 BIT/HDF/ELF。本 HEX 不会更新 FPGA，也不会使尚未接入的 UART/I²C/CAN 自动具有 PL 检测能力。历史集成候选的兼容性见 [检查记录](../../../../docs/test-results/2026-10-22-branch-doc-release-audit.md)。

Windows 本地校验：

```powershell
Get-FileHash -Algorithm SHA256 -LiteralPath .\sky_star_protocol_node-default-5d788f8.hex
```

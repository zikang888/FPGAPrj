# OLED 精简错误菜单固件：2026-10-27 / 1487034

仅用于天空星 **STM32F407VGT6**，不是 F103 固件。

| 下载 | 配置 |
|---|---|
| [默认版 HEX](sky_star-default-1487034.hex) | 三个 CAN 故障宏关闭；正常测试和显示白名单可用，RAW 错误仍不支持 |
| [CAN 故障版 HEX](sky_star-can-fault-1487034.hex) | CAN_FAULTS / CAN_RAW_GPIO / CAN_LIVE 开启；屏幕 CAN 三项错误走原 RAW 后端 |

屏幕只保留用户图片中的 **10 个错误**：SPI partial/short/extra；UART bad stop/Break；I2C address NACK/missing STOP；CAN stuff/CRC/form。正常测试 6 项、四协议母菜单、BACK 和按键方式不变。

其余 10 个错误仅从屏幕隐藏；底层实现、20 个原 fault 索引、串口命令、板级应用、引脚与规则不改。选择隐藏串口索引时屏幕返回其协议母菜单；串口 `fault run N` 仍可按原条件执行。两个版本 I2C_FAULT_LINKS 均保持关闭。详见 [菜单与接线](../../../../docs/hardware/stm32_fault_menu_oled.md)。

干净源提交：[`148703487da5c05e8f76de51061e7de9afcee585`](https://github.com/zikang888/FPGAPrj/commit/148703487da5c05e8f76de51061e7de9afcee585)，使用 `build_profiles.ps1 -Profile all -Release`。两配置 ARMCC 5.06 update 2 均 0 error / 0 warning，启动 `BUILD rev=1487034`。

| 校验项 | 默认版 | CAN 故障版 |
|---|---|---|
| Code / RO / RW / ZI | 34086 / 4230 / 96 / 5952 | 42134 / 5118 / 96 / 7200 |
| HEX 文件字节数 | 108088 | 133227 |
| SHA-256 | `853D4D4640DFCC0B111B3372B673D262F96ED5D431EE2B8CEB38CBD6CC51DB93` | `657EE1031864885DC17AE01C809C825322A210215206965D1C84AF48BD18453B` |

按 HEX 自带地址烧录，起始 0x08000000；机器可读配置见 [manifest.json](manifest.json)。仓库根目录执行：

```powershell
./stm32_f407/firmware/verify_release.ps1 -Directory ./stm32_f407/firmware/releases/2026-10-27-1487034
```

13/13 主机测试通过；本次范围与兼容性核对见 [验证记录](../../../../docs/test-results/2026-10-27-oled-fault-whitelist.md)。未实板烧录、未测量屏幕/波形、未验证 FPGA 检出。本地成功码不代表 PL 已识别。旧版 HEX 完整保留，必须烧录本版才有精简列表。

# PA0 消抖修复固件（2026-10-27 / faa5703）

本发布基于原已发布固件，只修复按键消抖；**不含并行开发中的分级菜单**。修复分支：`fix/stm32-button-debounce`；源提交 [faa5703](https://github.com/zikang888/FPGAPrj/commit/faa570380a028662f426ffc57f6af06332921dc7)。

| 下载 | 用途 |
|---|---|
| [默认版 HEX](sky_star-default-faa5703.hex) | 三个 CAN 故障宏关闭，保留原普通协议测试 |
| [CAN 故障版 HEX](sky_star-can-fault-faa5703.hex) | 开启 CAN_FAULTS / CAN_RAW_GPIO / CAN_LIVE，保持原接线要求 |

仅用于天空星 STM32F407VGT6；起始地址 0x08000000，按 HEX 地址烧录。与 F103 固件不兼容。I²C 辅助故障连线宏仍关闭，引脚不变。

按下和松开均连续稳定 30 ms 才确认；长按 800 ms 触发一次后锁定到稳定松开，松开不补短按。上电已经按住时，必须先松开再操作。事件执行/菜单逻辑不变。

构建：从上述干净源提交运行 `build_profiles.ps1 -Profile all -Release`，两个配置均为 ARMCC 5.06 update 2、0 error / 0 warning。主机测试 10/10 通过；尚未进行实板烧录、按键或协议波形验证。完整清单见 [manifest](manifest.json)，实板步骤见 [消抖验收记录](../../../../docs/test-results/2026-10-27-button-debounce.md)。

| 配置 | HEX 字节数 | SHA-256 |
|---|---:|---|
| 默认版 | 103437 | `15A4A7EBF3DBC331DD646EABC55CB4F489E141497DEB30C036E286FB95B97F77` |
| CAN 故障版 | 128547 | `B6A341EA7E23181EB0C2474D8506D4878EFBD11E9C40E70E9B8F62520E9EF399` |

下载后可用 `verify_release.ps1 -Directory <本目录>` 校验 SHA-256、Intel HEX 记录、Flash 地址和启动向量。旧发布文件保留，不覆盖。

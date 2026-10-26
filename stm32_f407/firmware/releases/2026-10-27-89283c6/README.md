# 四协议正常/故障分级菜单固件：2026-10-27 / 89283c6

目标：**天空星 STM32F407VGT6**，不是其他分支的 F103 固件。

| 下载 | 配置 | 功能 |
|---|---|---|
| [默认版 HEX](sky_star-default-89283c6.hex) | CAN_FAULTS=0、CAN_RAW_GPIO=0、CAN_LIVE=0 | 新分级菜单、6 正常测试入口、保留原非 CAN 受限故障；不启用 RAW/LIVE |
| [CAN 故障版 HEX](sky_star-can-fault-89283c6.hex) | 三个 CAN 故障宏均开启 | 同样的新菜单，保留 NO ACK、RAW 16～18、LIVE 15/19；必须按相应文档接线 |

两个版本的 `MC_ENABLE_I2C_FAULT_LINKS` 仍关闭；菜单出现 SDA LOW/SCL LOW 不表示已启用。没有改变协议规则、20 个原故障 ID、引脚、速率或日志 ABI。

## 使用

- 母菜单 SPI/UART/I2C/CAN，短按切换，长按 0.8 s 进入；进入不发送。
- 子菜单先列 NORMAL，再列该协议错误事件，最后 BACK；长按执行一轮或返回。需松开至少 30 ms 再次确认，不连续发送。
- 正常入口：SPI JEDEC/PATTERN、UART ECHO、I2C EEPROM、CAN TX/ECHO。
- 同步测试显示 RUNNING 后显示 LOCAL OK/ERROR 和结果码，记录 NORMAL/FAULT 尝试数。CAN TX/RAW/LIVE 使用原会话页，可长按停止；恢复失败继续锁住资源。
- UART ECHO 需对端回送；I2C 写测试区 0x0100～0x010F；CAN TX 需另一正常节点 ACK，CAN ECHO 另需应用层回送。启动原有 JEDEC 探测不变。
- 操作和全部前提见 [OLED 菜单与接线](../../../../docs/hardware/stm32_fault_menu_oled.md)。RAW 接线见 [说明](../../../../docs/hardware/can_gpio_bitstream_usage.md)，LIVE 需要另加收发器 I，见 [说明](../../../../docs/hardware/can_live_injection_usage.md)。

## 可追溯构建

干净源提交：[`89283c63e0bf04cffb38fcc57cfe14b914910bad`](https://github.com/zikang888/FPGAPrj/commit/89283c63e0bf04cffb38fcc57cfe14b914910bad)。在该提交执行 `build_profiles.ps1 -Profile all -Release`，两配置均 **0 error / 0 warning**；启动 `BUILD rev=89283C6`。发布提交与源提交不同是正常的，HEX 没有从带未提交源码的工作区生成。

| 项目 | 默认版 | CAN 故障版 |
|---|---|---|
| Code / RO / RW / ZI | 34042 / 4218 / 96 / 5952 | 42090 / 5106 / 96 / 7200 |
| HEX 文本字节数 | 107937 | 133063 |
| SHA-256 | `2106E0EE58D322B993208FB1EBA8A20ACAD0F54A8BC9928B3B1AE3B45B7F58CB` | `C66603B99D79F46262E0FB748EA9619913B1D60C5B0387BBD086064EED9966F4` |
| 烧录地址 | 按 HEX 自带地址，起始 0x08000000 | 同左 |

机器可读配置见 [manifest.json](manifest.json)。下载后从仓库运行：

```powershell
./stm32_f407/firmware/verify_release.ps1 -Directory ./stm32_f407/firmware/releases/2026-10-27-89283c6
```

校验 SHA-256、大小、Intel HEX 校验和/范围/重叠/EOF 与向量表。13 项主机测试全部通过，其中两项调用实际板级应用模拟按键与外设；见 [验证记录](../../../../docs/test-results/2026-10-27-hierarchical-menu.md)。**未烧录、未实板验证、未验证 FPGA 检出**；本地 R 0/PASS 不等于 PL 检测通过。旧发布完整保留，烧录本目录新 HEX 后才有新菜单。

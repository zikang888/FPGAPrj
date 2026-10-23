# HOME 四协议波形实板验证（2026-10-23）

## 环境

- FPGA/PS 工程：`D:\Vivado\FPGAPrj`，分支 `fix/fpga_waveform`
- Zynq PS 控制台：COM26，115200 8N1
- STM32 控制台：COM60，115200 8N1
- 下载：当前 `platform_hw` BIT/HDF + 新构建 `platform_app.elf`
- 屏幕证据：通过 JTAG 只读导出 800x480 RGB888 双帧缓冲核对

## 结果

| 协议 | STM32 命令 | PS 自动快照 | HOME 显示 | 结论 |
| --- | --- | --- | --- | --- |
| SPI | `spi jedec 1` | id=2, count=6 | MOSI `9F 00 00 00`；MISO `FF EF 40 18` | 通过 |
| UART | `uart loop 1` | id=3, count=10 | `00 01 02 03` 四个 8N1 帧 | RX 监听/显示通过；因 FPGA TX 未回传，STM32 loopback 报超时 |
| I2C | `i2c eeprom 1` | id=4, count=25 | SCL/SDA；`A0 01 00 B9` 与 ACK | 监听/显示通过；本轮 STM32 EEPROM 操作返回 `nack_or_mismatch` |
| CAN | `can loop 1` | id=5, count=24 | ID `0x321`、DLC 8、数据 `00 01 02 03 ...` | 通过，STM32 loopback matched |

四个页面都从实际冻结快照生成，不使用 DEMO 数据。SPI、UART、I2C、CAN
两个帧缓冲内容一致，说明 VDMA 当前页与备用页均完成更新。

CAN 快照在首个正确帧之后还包含 ACK/Form/Stuff 错误及第二笔回传数据，因此
页面的 `PLATFORM CHECK` 是真实事件审计结果，不是 HOME 绘图假告警。

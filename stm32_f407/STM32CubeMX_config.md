# STM32CubeMX 配置清单

目标芯片：STM32F407VGT6。以下是建议映射，最终必须对照天空星原理图与排针复核。

| 功能 | 外设/引脚 | 配置 |
|---|---|---|
| SPI Flash | SPI1 PA5/PA6/PA7 | Master、Full Duplex、Mode 0、MSB First，84 MHz/64=1.3125 MHz |
| SPI CS | PA4 GPIO Output | 上电默认高电平 |
| I²C EEPROM | I2C1 PB6/PB7 | 100 kHz，开漏；总线只保留一组有效上拉 |
| UART 测试链路 | USART3 PD8/PD9 | 115200、8N1、无流控 |
| 真值日志/命令 | USART1 PA9/PA10 | 115200、8N1，连接独立 USB-UART/DAP-Link |
| CAN | CAN1 PD0/PD1 | Normal mode，500 kbit/s，AF9，BS1=11TQ、BS2=2TQ、Prescaler=6 |
| 同步标记 | PC6 | 推挽输出，接 FPGA 纯输入 |
| 用户 LED | PB2 | 推挽输出 |
| 用户按键 | PA0 | 下拉输入，按下为高 |

## 必要设置

- 打开 `USE_FULL_ASSERT` 便于联调。
- CAN 接收滤波器第一阶段可全接收，但正式测试要记录 ID 范围。
- I²C EEPROM 写入后通过 ACK polling 等待内部写周期结束，代码适配层已使用 `HAL_I2C_IsDeviceReady`。
- SPI、UART、I²C、CAN 的被测链路不能与真值日志复用同一个 UART。
- 所有 GPIO 初始电平先设置，再初始化为输出，避免上电毛刺误选中 Flash。

完整工程已生成并接入 `common`、`hal`、`app`。直接打开：

```text
firmware/Projects/MDK-ARM/sky_star_protocol_node.uvprojx
```

重新运行 CubeMX 会保留 `main.c` 的 USER CODE，但可能重写 Keil 工程分组；重新生成后应确认 `Application/MemberC` 四个源文件和三个 Include Paths 仍存在。

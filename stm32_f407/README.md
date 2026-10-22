# STM32F407 多协议真值节点（成员 C）

本目录保存天空星 STM32F407VGT6 的完整多协议测试工程，目标是给 Zynq 平台产生可重复的
SPI、UART、I²C、CAN 流量和独立 JSONL 真值日志。

## 目录

```text
stm32_f407/
├── common/       # 与 STM32 HAL 解耦的协议测试和日志代码
├── hal/          # STM32F407 HAL 回调适配
├── app/          # 串口命令、CAN过滤器、按键和板级应用
├── firmware/     # CubeMX、HAL/CMSIS、Core 和 Keil MDK-ARM 完整工程
├── tests/        # 电脑端 fake-platform 单元测试
├── CMakeLists.txt
└── STM32CubeMX_config.md
```

协议规则的唯一真源不在代码目录，而在：

```text
docs/protocol-rules/protocol_rules.yaml
```

规则所有者是成员 C。A/B 可以评审，但实现不得私自覆盖协议参数、事件 ABI、
异常定义、用例编号或验收阈值。

## 当前支持

- SPI `0x9F` JEDEC ID 读取；发送 `9F 00 00 00`，期望值由实物器件确认。
- 上电先探测实物 JEDEC ID（用例 1000，最多重试 3 次），拒绝全 `00`/全 `FF`；正常 `spi jedec N` 用探测到的 ID 比对并执行恰好 N 笔测试事务。
- SPI 固定字节模式。
- UART 双向回环。
- AT24C256 写入、ACK polling、读回比较。
- CAN 标准帧回环。
- JSONL 真值日志与本地事务号。
- SPI JSONL 同时记录 `data`（实际 RX）和 `tx`（实际发送），日志失败会反馈到测试结果。
- 20 项可选择错误事件菜单；PA0 短按切换、长按触发，USART1 也可用 `fault` 命令控制。
- 128×64 SSD1306 4 线 SPI OLED 页面，使用 PB12/PB13/PB15、PC4/PC5。
- USART1 使用中断接收缓冲，整行回显；连续快速发送不再逐字节阻塞发送。
- 可选同步脉冲接口。
- SPI 残帧、UART 错误停止位/Break 的 GPIO 波形钩子已绑定；CAN 故障版提供 RAW 错误语料，实时位错误仍需独立同步注入。

完整 Keil 工程入口：

```text
stm32_f407/firmware/Projects/MDK-ARM/sky_star_protocol_node.uvprojx
```

CubeMX 配置入口：

```text
stm32_f407/firmware/sky_star_protocol_node.ioc
```

工程已使用 Keil ARMCC 5.06 update 2 实际编译，结果为 0 error、0 warning。

## 电脑端测试

```powershell
cmake -S stm32_f407 -B stm32_f407/build -G Ninja
cmake --build stm32_f407/build
ctest --test-dir stm32_f407/build --output-on-failure
```

主机测试只验证协议编排、比较和日志逻辑，不等价于 HAL 编译或实板通过。

可烧录文件见 [版本化 HEX 发布目录](firmware/releases/README.md)，
其中记录来源提交、默认配置和 SHA-256；不要把旧集成分支中的构建输出当成本版固件。

## 与当前 FPGA 候选连接

SPI 第一闭环固定为 STM32 主机、W25Q128 从机、FPGA 被动监听：

| 信号 | STM32F407 | AC820 P7 | FPGA |
|---|---|---|---|
| CS_N | PA4 | P7-2 | U11，输入 |
| SCLK | PA5 | P7-1 | U12，输入 |
| MOSI | PA7 | P7-3 | U10，输入 |
| MISO | PA6 | P7-4 | U9，输入 |

三方共地，使用 3.3 V 逻辑。FPGA 不驱动这四根线。

天空星当前配置固定为：

| 功能 | 天空星引脚 | 参数 |
|---|---|---|
| 板载 W25Q128 | PA4/PA5/PA6/PA7 | CS/SCK/MISO/MOSI，SPI1 Mode 0，1.3125 MHz |
| FPGA UART 测试 | PD8/PD9 | USART3，115200 8N1 |
| 日志与命令 | PA9/PA10 | USART1，115200 8N1 |
| 外接 AT24C256 | PB6/PB7 | I²C1，100 kHz |
| 外接 SN65HVD230 | PD0/PD1 | CAN1 RX/TX，500 kbit/s |
| 用户 LED | PB2 | 成功点亮，失败熄灭 |
| 用户按键 | PA0 | 短按切换错误事件，长按执行 |
| 同步脉冲 | PC6 | 已配置输出；FPGA 侧输入尚未接入，不能当作已有同步链路 |
| OLED | PB12/PB13/PB15、PC4/PC5 | 128×64 SSD1306 4 线 SPI |

错误事件和 OLED 接线详见 [菜单接线说明](../docs/hardware/stm32_fault_menu_oled.md)。

USART1 命令：

```text
spi jedec [count]
spi probe
spi pattern [count]
uart loop [count]
i2c eeprom [count]
can loop [count]
all
help
fault list
fault select 0
fault run
```

## CAN 场景会话（2026-10-22）

新增 `can test start normal|echo|noack|bitrate COUNT PERIOD_MS [EVERY]` 和
`can test status|stop|recover`。默认仅 normal/echo 可用，故障场景沿用
`MC_ENABLE_CAN_FAULTS` 显式开关。会话与旧命令互斥，结束恢复 CAN 配置；未占用新 GPIO/TIM/DMA。
完整说明：[CAN 场景会话固件使用说明](../docs/hardware/can_session_firmware_usage.md)。

## CAN GPIO 位流（故障配置）

`can raw start valid|crc|stuff|form BITRATE COUNT PERIOD_MS [EVERY]` 支持 125k/500k，
使用 TIM1＋DMA2 Stream5/Channel6，暂时复用 PD1，并与 bxCAN/旧测试互斥。
故障版菜单 16/17/18 可单次播放；默认版禁用 RAW，不分配新硬件资源。
构建：`firmware/build_profiles.ps1 -Profile all -Release`。
详见 [接线和使用](../docs/hardware/can_gpio_bitstream_usage.md)、[资源实施方案](../docs/hardware/can_gpio_bitstream_implementation.md)。

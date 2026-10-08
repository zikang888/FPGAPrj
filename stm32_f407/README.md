# STM32F407 多协议真值节点（成员 C）

本目录保存天空星 STM32F407VGT6 的完整多协议测试工程。它从
`test/fpga_NumberC-A-full-integration` 建立，目标是给 Zynq 平台产生可重复的
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
├── STM32CubeMX_config.md  # 完整工程的配置说明
└── STM32CubeMX配置.md     # 第一周的旧接入说明，保留供追溯
```

协议规则的唯一真源不在代码目录，而在：

```text
docs/protocol-rules/protocol_rules.yaml
```

规则所有者是成员 C。A/B 可以评审，但实现不得私自覆盖协议参数、事件 ABI、
异常定义、用例编号或验收阈值。

## 当前支持

- SPI `0x9F` JEDEC ID 读取；发送 `9F 00 00 00`，期望值由实物器件确认。
- SPI 固定字节模式。
- UART 双向回环。
- AT24C256 写入、ACK polling、读回比较。
- CAN 标准帧回环。
- JSONL 真值日志与本地事务号。
- 可选同步脉冲接口。
- SPI 残帧、UART 错误停止位的板级扩展钩子；默认不绑定，防止误驱动。

完整 Keil 工程入口：

```text
stm32_f407/firmware/Projects/MDK-ARM/sky_star_protocol_node.uvprojx
```

CubeMX 配置入口：

```text
stm32_f407/firmware/sky_star_protocol_node.ioc
```

整合工程已使用 Keil ARMCC 5.06 update 2 实际编译，结果为 0 error、0 warning。
`examples/` 是第一周的旧接入示例；上板以 `firmware/` 和 `app/` 为准。
SPI JSONL 日志同时保留实际 RX `data` 与发送字节 `tx`，供 FPGA 快照逐字节对账。

## 电脑端测试

```powershell
cmake -S stm32_f407 -B stm32_f407/build -G Ninja
cmake --build stm32_f407/build
ctest --test-dir stm32_f407/build --output-on-failure
```

主机测试只验证协议编排、比较和日志逻辑，不等价于 HAL 编译或实板通过。

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
| 用户按键 | PA0 | 按下执行一次 SPI JEDEC 测试 |
| 同步脉冲 | PC6 | 输出到 FPGA 可选同步输入 |

USART1 命令：

```text
spi jedec [count]
spi pattern [count]
uart loop [count]
i2c eeprom [count]
can loop [count]
all
help
```

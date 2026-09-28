# STM32F407 多协议真值节点（成员 C）

本目录保存天空星 STM32F407VGT6 的多协议测试代码。它从
`test/fpga_NumberC-A-full-integration` 建立，目标是给 Zynq 平台产生可重复的
SPI、UART、I²C、CAN 流量和独立 JSONL 真值日志。

## 目录

```text
stm32_f407/
├── common/       # 与 STM32 HAL 解耦的协议测试和日志代码
├── hal/          # STM32F407 HAL 回调适配
├── examples/     # CubeMX main.c 的 USER CODE 接入示例
├── tests/        # 电脑端 fake-platform 单元测试
├── CMakeLists.txt
└── STM32CubeMX配置.md
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
- JSONL 真值日志与本地事务号；SPI 记录同时包含实际 RX `data` 和 TX `tx`。
- 可选同步脉冲接口。
- SPI 残帧、UART 错误停止位的板级扩展钩子；默认不绑定，防止误驱动。

这不是完整的 CubeMX 生成工程。`hal/` 需要加入 STM32CubeMX/Keil 工程，初始化
代码仍由 CubeMX 生成。实际板型、排针、时钟、CAN 滤波器和收发器必须在上板
前复核。

SPI 初次联调先调用 `MemberC_Init()`，再调用 `MemberC_RunSmokeTests()`；后者先
读取实物 JEDEC ID，再连续读 10 次核对一致性。读到全 `00`/全 `FF` 会报校验失败。
首次读值仍须人工对照实物 Flash 型号，不应把“重复一致”当作芯片型号认证。
当前接入示例针对已焊装板载 W25Q128 的天空星 F407VGT6 高配版，使用 PA4
GPIO 软件片选。CubeMX 中必须把 PA4 配成默认高电平的推挽输出；其他板型或未焊装
Flash 的版本不能直接照搬。

## 电脑端测试

```powershell
cmake -S stm32_f407 -B stm32_f407/build -G Ninja
cmake --build stm32_f407/build
ctest --test-dir stm32_f407/build --output-on-failure
```

主机测试只验证协议编排、比较和日志逻辑，不等价于 HAL 编译或实板通过。

## 与当前 FPGA 候选连接

SPI 第一闭环固定为 STM32 主机、**板载** W25Q128 从机、FPGA 被动监听；
不要再并联同 CS 的第二颗外置 Flash：

| 信号 | STM32F407 | AC820 P7 | FPGA |
|---|---|---|---|
| CS_N | PA4，软件 GPIO 输出 | P7-2 | U11，输入 |
| SCLK | PA5 | P7-1 | U12，输入 |
| MOSI | PA7 | P7-3 | U10，输入 |
| MISO | PA6 | P7-4 | U9，输入 |

三方共地，使用 3.3 V 逻辑。FPGA 不驱动这四根线。
P7 的物理编号和排针朝向仍需对照实物丝印复核。引脚依据见
[立创官方 SPI-FLASH 教程](https://wiki.lckfb.com/zh-hans/tkx/tkx-stm32f407vxt6/beginner/spi.html)。

# CAN 场景会话第一阶段验证记录

日期：2026-10-22；分支：`memberC/stm32-f407`；修改前基线：`a5c6296`。

## 修改范围

新增独立 `mc_can_session` 状态机、HAL 适配和 `can test` 命令；normal/echo 默认可用，noack/bitrate 需要显式定义 `MC_ENABLE_CAN_FAULTS`。加入 OLED 进度和原菜单触发计数，空闲时保留原按键功能，会话期间长按停止。运行期间拒绝旧测试并在退出时恢复 CAN 配置；恢复失败保持锁，允许重试。

未修改原协议 runner、原 JSONL 日志实现、20 项故障分派、CAN case ID/规则、CubeMX 引脚、Core 初始化或 IRQ 文件；未新增 GPIO/TIM/DMA 占用。新的 `can_session` 日志为独立记录类型。

## 主机验证

命令：`cmake -S . -B build -G Ninja`、`cmake --build build`、`ctest --test-dir build --output-on-failure`（在 `stm32_f407` 目录）。GCC 使用 `-Wall -Wextra -Wpedantic -Werror`。

| 测试 | 结果 / 覆盖 |
|---|---|
| `mc_protocol_tests` | PASS；保留的 SPI/UART/I²C/CAN 编排、故障分派、SPI 实际 ID/TX/RX、串口缓冲回归 |
| `mc_can_session_tests` | PASS；周期/每 N 帧调度、不突发补发、run/frame 数据、ACK 证据区分、回传匹配与超时、时间回绕、参数校验、重复启动拒绝、停止、日志失败、后端失败、Bus-off 退出、恢复失败与重试 |
| `mc_can_hal_default_tests` | PASS；未开启故障宏时拒绝故障模式和 250k 请求；忙邮箱/FIFO/IER/遗留 overrun 拒绝接管；三个邮箱完成位；保存/恢复参数；中止超时、恢复失败/BOFF 保持锁；JSON 缓冲和输出失败 |
| `mc_can_hal_enabled_tests` | PASS；同一真实适配源文件，开启宏的配置；额外核对 250k 切换与参数恢复 |

HAL 测试通过小型硬件模型编译真实适配源文件，覆盖调用/寄存器处理和错误路径；模型不能证明 CAN 电气行为、实际控制器时序或实物接线正确。

## ARM 编译

Keil ARMCC 5.06 update 2 默认配置完整工程构建通过：

```text
0 Error(s), 0 Warning(s)
Code=30886 RO-data=3362 RW-data=72 ZI-data=5512
```

本地生成文件：`stm32_f407/firmware/Projects/MDK-ARM/sky_star_protocol_node/sky_star_protocol_node.hex`。
SHA-256：`70BB21B652013607D09ADF9A70B48C2857047A6E81560F4F3153E7514D0224C3`。
原构建路径属于忽略的输出目录。后续将同一 SHA-256 的 HEX 原样归档到 [版本发布目录](../../stm32_f407/firmware/releases/2026-10-22-5d788f8/README.md) 并提交，默认配置未改变。链接器静态调用图报告最大已知栈 1432 字节，工程栈 2048 字节；报告含函数指针/未知项，不作为运行期栈水位实测。

另使用 ARMCC 对 `mc_can_session_hal.c` 和已有 `mc_stm32f407_hal_port.c` 定义 `MC_ENABLE_CAN_FAULTS` 编译，确认显式开启路径的真实 HAL 接口可编译。此项是源文件编译检查，不是该配置的完整链接或上板验证。

## 人工检查与未覆盖项

- 核对旧协议实现/规则/引脚/IRQ 不在本次修改范围；MDK 工程中新增两个源文件，CMake 中接入新增测试。
- 检查说明文档相对文件链接和表格列数、`git diff --check`。
- 尚未烧录 STM32、未观察 OLED、未连接真实 CAN B 节点、未采集故障波形、未构建或验收 CAN FPGA 检测逻辑。
- 第一阶段不含 GPIO 位流、实时显性注入、自动控制外部 B、自动 Bus-off 制造、CRC/填充/格式注入。后续按规划阶段推进，不能把菜单占位作为已实现功能。

台架步骤和当前命令见 [CAN 会话使用说明](../hardware/can_session_firmware_usage.md)。

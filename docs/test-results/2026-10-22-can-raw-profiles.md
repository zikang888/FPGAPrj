# CAN GPIO 位流与双配置固件验证

日期：2026-10-22。源码从 `6e85f49` 增量开发；最终发布目录记录已提交源码的精确版本和两种 HEX 校验值。

## 功能和兼容边界

- 新增 `mc_can_raw` 生成器与 TIM1/DMA2 Stream5/Channel6 后端，复用 PD1/现有收发器；旧协议 runner、truth logger、`mc_faults.c`、Core/IOC、冻结规则均不改。
- 新增 `can raw` 命令，使用既有有限会话调度与停止/恢复；内部会话 submit 接口增加实际帧 mode 参数，调用者和测试同步更新，非正式事件 ABI。
- 原菜单 16/17/18 仅在 RAW 配置下由板级应用改派到独立 RAW 会话，原 case ID/PS 映射不变；default 仍按原分派行为。
- 旧 `can test` 命令行为和参数不变；两个后端及旧测试互斥。默认版 RAW 回调为空，启动不触碰 TIM/DMA/GPIO；故障版需要明确 start/菜单触发。
- GPIO 位流不是仲裁参与者、不是实际另一帧中的同步叠加干扰，不能用于宣称发送位错误或 Bus-off 已制造。

## 主机测试

`cmake --build stm32_f407/build`、`ctest --test-dir stm32_f407/build --output-on-failure`：6/6 PASS，GCC 使用 `-Wall -Wextra -Wpedantic -Werror`。

| 测试 | 覆盖 |
|---|---|
| mc_protocol_tests | 原 SPI/UART/I²C/CAN 编排与故障分派、实际 JEDEC ID/TX/RX、命令缓冲回归 |
| mc_can_session_tests | 原会话调度/证据/退出/错误路径，新增 RAW 每 N 帧 mode 切换与位率验证 |
| mc_can_hal_default_tests | 原 CAN HAL 默认关闭和配置恢复模型 |
| mc_can_hal_enabled_tests | 原 CAN HAL 显式开启、250k 切换和恢复模型 |
| mc_can_raw_tests | CRC-15/CAN `123456789→0x059E` 参考向量；独立多项式长除法和去填充器；DLC 0～8、00/FF/55/AA 负载、合法/CRC/填充/格式和尾部释放、参数边界；验证全部 1～10000 帧号固定负载有可破坏填充位 |
| mc_can_raw_disabled_tests | 默认关闭 RAW 时无法开始，回调为空、资源未持有 |

某些任意语料没有填充位可改，生成器返回验证错误、不提交 DMA；不能为了凑错误假称注入成功。固定运行号/帧号语料包含零高字节，完整帧号范围已测有填充机会。

这些测试验证生成器和软件控制流，不模拟 TIM/DMA/GPIO 的实际时序。启用的 RAW 寄存器后端完成 ARM 编译/链接与人工退出路径检查，尚未做实物执行。

## 完整 ARM 构建与发布流程

`build_profiles.ps1` 从规范 MDK 工程机械生成无 BOM 的临时项目，独立目录完整构建：

| 配置 | 宏 | 预期能力 |
|---|---|---|
| default | 原宏＋MC_BUILD_REV；两个 CAN 故障宏关闭 | 原测试、normal/echo、可查询 RAW 但不允许输出 |
| can_fault | 原宏＋MC_BUILD_REV＋MC_ENABLE_CAN_FAULTS＋MC_ENABLE_CAN_RAW_GPIO | noack/bitrate、RAW 和菜单 16～18 |

两个配置均要求 0 error / 0 warning；不是单个源文件编译。Release 模式要求固件源代码和构建脚本已提交；启动 BUILD 行包含源提交前七位与两个开关。具体 Program Size、HEX 长度和 SHA-256 以 [发布目录](../../stm32_f407/firmware/releases/README.md) 为准。

链接器 map 已确认 RAW context 位于 DMA 可访问 SRAM，DMA2_Stream5 向量解析到新后端，而不是默认弱处理函数。静态栈报告带函数指针未知项，不作为运行期水位证明。原引脚和 TIM/IRQ 不在 default 启动时重新分配；RAW 会话显式接管后才配置。

发布时分别校验 Intel HEX 记录长度/校验和/地址/EOF/向量、文件 SHA-256，以及 Git blob 字节不被行尾转换。保留旧 `5d788f8` 默认 HEX，不同配置使用不同文件名。

## 未完成的实板验收

未烧录、未观察实际位宽/收发器延迟、未测 DMA 错误或停止在真实硬件上的恢复、未接入 CAN PL 识别。台架先按 [使用说明](../hardware/can_gpio_bitstream_usage.md) 进行 125k valid→单错→500k→间歇测试，并同时采 PD1/RXD。`result=0` 仍只表示输出完成，不能当作 FPGA 检出。

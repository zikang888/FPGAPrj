# STM32 文档、历史分支与 HEX 发布检查

日期：2026-10-22。当前固件源提交：`memberC/stm32-f407` 的 `5d788f8`。
本次只修订成员 C 分支文档并归档既有 HEX，不改变固件源代码、宏、外设资源或原测试规则。

## 1. 分支范围与结论

通过 `git ls-remote --heads` 列出远端分支，fetch 后重点检查与本固件有关的四条历史/协作分支，不声称已逐个审查全部 FPGA 实验分支。

| 分支 / 本次检查提交 | 核对内容 | 结果与处理 |
|---|---|---|
| `codex/fpga-ab-week2-c-integration` / `8830069` | `stm32_f407/`、PS `stm32_fault_bridge.h`、接线/错误目录 | 其 STM32 子树与 `5d788f8^` 完全一致；新会话是该代码基线上的增量。旧 runner/logger、HAL 适配、20 项分派、Core/IOC 对比当前仍相同 |
| `codex/stm32-faults-bridge` / `a135719` | 旧故障菜单移植候选及 runner/logger 差异 | 与成员 C 无共同祖先；它不是最新集成基线。存在历史重构/文档差异，不把两条分支整仓合并；原 20 项分派与板级适配未被本轮新会话重写 |
| `STM32_control_board` / `d2faf81` | README、IOC、主程序和模块清单 | `STM32F103C8T6`＋FreeRTOS、I²C OLED、三键参数菜单、`$...*CRC` 串口参数协议；不是 F407 真值节点，不能复用 HEX 或直接覆盖工程 |
| `STM32_receive_board` / `7c9e698` | README、IOC、模块清单 | 同属独立 F103 板工程；不作为 F407 HAL/启动文件/引脚/固件来源 |

最新集成分支来源与接线状态：[10/15 接入记录](https://github.com/zikang888/FPGAPrj/blob/8830069ea10712050f62de7e42c37ab7d027ea07/docs/test-results/2026-10-15-stm32-all-protocol-integration.md)、[接线核对](https://github.com/zikang888/FPGAPrj/blob/8830069ea10712050f62de7e42c37ab7d027ea07/docs/hardware/stm32_multi_protocol_wiring_review.md)。UART 监听候选只完成仿真，未接入发布 BIT；正式 BIT 仍仅 SPI，不能将预留球位理解为实体排针已确认或其他协议已检测。

## 2. 具体差异与修订

| 发现 | 影响 | 本轮处理 |
|---|---|---|
| 主接线 SPI 示例将 dummy MOSI 写为 `FF`，代码实际为 `00` | 对账时误判正常发送字节 | 改为 `9F 00 00 00`；RX 和 ID 明确取实物读数 |
| 主文档称 GPIO 故障钩子默认未启用 | 与已可执行的 SPI 残帧/UART 单次钩子矛盾 | 标明这些钩子已绑定、需主动触发；CAN/I²C 可选宏仍默认关闭 |
| 主文档把旧工程磁盘路径作为当前状态，PS 文件写得像本分支存在 | 混淆干净 STM32 分支与 FPGA 集成分支 | 指向核对过的集成分支，PS/PL 标为跨端职责 |
| PC6 表格像已接入 FPGA，日志示例缺 TX，声称自动输出完整版本头 | 误以为有同步/版本/发送证据 | 标为未接入；补 TX/RX 字段；版本由发布清单和人工采集记录 |
| 规划起点表仍以“当前”描述第一阶段待办 | 容易误以为 CAN 会话尚未实现 | 明确历史基线，链接已实现会话说明 |
| 根 README 仍显示 1/1，目录树指向不存在的中文配置文件名 | 测试数和导航失准 | 更新为 4/4、实际 `STM32CubeMX_config.md`，增加发布/使用入口 |
| 集成分支规则版本仍为 `1.0.0-draft-repo-abi`、SPI 初始频率 1 MHz；成员 C 为 `1.1.2-draft-fault-menu`、1.3125 MHz | 合入时可能把新规则回退；代码与旧规则不一致 | 当前成员 C 规则保持不动；集成时单独评审/同步规则，不能让旧文件覆盖；CAN 仍 `enabled:false` |
| F103 板使用 PB6/PB7 的 I²C OLED，F407 使用独立 SPI OLED；串口用途也不同 | 误用接线/驱动/固件 | 根 README 与 HEX 说明明确目标和配置，不混用工程 |
| 原 HEX 只在忽略的 Keil 输出目录 | GitHub 没有可下载固件 | 原样复制到版本化发布目录，附 manifest、源提交、宏和 SHA-256；`.gitattributes` 禁止 HEX 行尾转换 |

## 3. 源码和接口核对

- `git diff --quiet origin/codex/fpga-ab-week2-c-integration 5d788f8^ -- stm32_f407` 返回 0：最新集成的 STM32 子树正是新会话之前的基线。
- 对比最新集成与 `5d788f8` 的 `mc_faults.c`、`mc_protocol_runner.c`、`mc_truth_log.c`、`mc_stm32f407_hal_port.c`、`firmware/Core` 和 `.ioc`，返回 0：这些旧实现和引脚未被新会话覆盖。
- 将当前 `mc_faults.c` 的 case ID 按顺序与最新 PS `stm32_fault_bridge.h` 的映射比对，20/20 一致；新会话没有复用/改变旧 case ID。
- 新 JSONL 使用 `kind=can_session`，没有正式 `case` 字段。未来接入串口解析器需先按记录类型分流；旧 20 项映射不能将会话记录直接换成 PL 错误计数。
- 本次不合并或推送修改到其他分支。上述是源码差异、映射和文档检查，不是整仓合并成功、PS ELF 重新构建或双板联调结论。

## 4. 固件归档与验证

发布路径：[`2026-10-22-5d788f8`](../../stm32_f407/firmware/releases/2026-10-22-5d788f8/README.md)。

| 检查 | 结果 |
|---|---|
| 来源和配置 | 源提交 `5d788f8` 的现有完整 Keil 构建；CAN/I²C 可选故障宏关闭 |
| HEX 文件 | 96576 字节；原始输出与归档副本 SHA-256 相同 |
| SHA-256 | `70BB21B652013607D09ADF9A70B48C2857047A6E81560F4F3153E7514D0224C3` |
| Intel HEX | 2148 条记录、34320 个 Flash 数据字节；长度/每行校验/Flash 地址/无重叠/EOF 通过；初始 SP=`0x200015D0`、复位向量=`0x0800025D`；不是烧录验证 |
| 主机回归 | 4/4 通过；本轮文档/发布不改变代码行为 |
| ARM 构建 | 沿用同一源提交已完成的 0 error / 0 warning 构建，没有用别的分支 HEX 替代 |
| 文档 | 检查本分支活动 Markdown 的相对文件链接、表格列数、`git diff --check`；历史测试记录保留历史结果 |
| Git 归档 | 检查 HEX 在暂存区被跟踪，Git blob 字节与原 HEX 一致；没有把整个生成目录提交 |

尚未完成的 GPIO CAN 注入、PL 接入、实板烧录/波形验收继续按规划推进；本次发布没有扩大功能声明。

# PS 通用事件显示整合验证（2026-10-08）

整合分支 `codex/fpga-ab-week2-c-integration` 纳入 C 端提交 `24a114b`
（cherry-pick 后为 `ec2fe7e`）。仅修改软件事件视图与 UI 文本，不改变 PL、
约束或 STM32 固件。

## 已验证

- `software/tests/event_view_test.c` 使用 Clang、C99、`-Wall -Wextra
  -Wpedantic -Werror` 编译并执行：`event view tests passed`。
- `software/tests/pixel_scroll_test.c` 用相同选项执行：
  `pixel_scroll_test PASS`。
- SDK 2018.3 在隔离工作区 `.sdk_validation_event_view` 构建
  `software/src`，输出 `PS_BUILD_DONE`，ELF 链接成功。
- 构建输入 HDF：`Multi_protocol.sdk/platform_hw/system.hdf`，SHA-256
  `771B86BD8E3AF781A05F0D07B9308FFDFB425577637BA8FDD9E5965B119EE3BC`。
- 构建输出 ELF：`.sdk_validation_event_view/platform_app/Debug/platform_app.elf`，
  SHA-256 `18D815FAC362D27BD838A568A101C1F78D7FAE5F31C01C4B51CD5D07370C9F60`。

## 尚未验证

UART/I²C/CAN 仍需各自 PL 事件源、真实接线、故障注入与端到端对账。

## 两轮 debug 检测补充

**第 1 轮——边界与异常输入。** 在 `event_view_test.c` 中补充全部
16 个协议 ID × 64 个事件类型的组合检查，验证 ERROR 仅在 `0x3F`、
未知类型保留 `EXTxx`、类型文本在 8 字节缓冲区内终止且不越界；另用全
1 的 128-bit 事件验证所有字段的最大值，以及无效 SPI 事件不改写调用者
输出字节。用 Vivado 随附 Clang、严格 C99 和警告即错误编译运行，结果
`event view tests passed`。未发现产品代码缺陷。

**第 2 轮——独立编译器与原功能回归。** 换用 Vivado 随附 MinGW64 GCC
6.2，以 `-O2 -std=c99 -Wall -Wextra -Wpedantic -Werror` 重新编译运行
事件视图测试和原像素滚动测试，结果分别为 `event view tests passed`、
`pixel_scroll_test PASS`。此前已在独立 SDK 工作区完成 PS ELF 的完整
BSP/应用构建。第一次直接运行 GCC 时因其运行时目录未加入 `PATH`，
编译进程退出 1；补齐该工具目录后两项测试通过，这是本机工具环境问题，
不是程序修复。

以上两轮是软件侧检测；后续追加的实板回归见下节。

## 新 ELF 实板回归（追加）

板上已有 PL 正在运行，JTAG 只读先验回读为 `SYS_ID=4D505254`、
`VERSION=00010004`、`CAPABILITIES=0000000F`，A9 双核可见。使用
`fpga/build/zynq_jtag_elf_only_smoke.tcl` 对 CPU0 停机、下载本记录的
ELF、恢复运行；脚本打印 `Successfully downloaded` 和
`ZYNQ_ELF_ONLY_SMOKE_DONE`。3 秒后回读上述三个 PL 寄存器仍一致，
`SNAPSHOT_COUNT=25`。此流程**没有重写 BIT、启动介质或 PS 初始化**，
因此只证明新 PS 软件运行于当前板上兼容的 PL，不等于完整三件套重烧录。

**第 1 轮板测——启动和事件页。** 用户在 ELF 下载后目视确认正常页面、
EVENTS 滚动与事件文字正常。随后独立 JTAG 只读回读显示 A9 运行、
`SNAPSHOT_COUNT=25`、`TRIGGER_INDEX=20`、`DROPPED_COUNT=0`、
`EXT_DROPPED=0`。

**第 2 轮板测——交互和状态回归。** 用户确认 SELF TEST 的 CORE DROP 为
PASS/0；点击 D1 两次，屏幕状态与实体 LED 每次同步切换。再一次独立
JTAG 只读回读显示 A9 仍运行、`LED_CTRL=0`（两次点击后恢复）、
`SNAPSHOT_COUNT=25`、`DROPPED_COUNT=0`、`EXT_DROPPED=0`。

该回归不覆盖 UART/I²C/CAN 的真实协议流量，也未重新跑 SPI 100 笔压测。

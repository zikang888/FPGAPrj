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

这个 ELF **尚未下载上板**；触摸交互与屏幕布局仍需实板回归。HDF 可用于
软件编译验证，但本记录未重新生成或校验与之配对的 BIT，也不把它当作
可直接烧录的完整发布包。UART/I²C/CAN 仍需各自 PL 事件源、真实接线、
故障注入与端到端对账。

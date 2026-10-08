# PS 通用事件视图与快照审计：两轮 debug 检测（2026-10-08）

范围：独立工作树 `codex/ps-generic-events`，基于整合分支
`a5706cd`。本记录覆盖 C 侧纯 ABI 解码、UART/I²C 原始事件接入后的
通用审计/ERROR 显示，以及原像素滚动回归；不修改 PL、F407、引脚或
协议规则草案。测试期间未占用 JTAG，未下载此版本 ELF。

## 第 1 轮：ABI 边界和异常输入

使用 Vivado 2018.3 随附 MinGW GCC 6.2.0，对
`software/tests/event_view_test.c` 和
`software/tests/event_audit_test.c` 分别以
`-std=c99 -Wall -Wextra -Wpedantic -Werror` 编译并运行。
在工作树根目录使用的命令形式：

```powershell
$cc = 'D:\Vivado2018.3\Vivado\2018.3\tps\mingw\6.2.0\win64.o\nt\bin\gcc.exe'
& $cc -std=c99 -Wall -Wextra -Wpedantic -Werror software/tests/event_view_test.c -o "$env:TEMP\event_view_test.exe"
& "$env:TEMP\event_view_test.exe"
& $cc -std=c99 -Wall -Wextra -Wpedantic -Werror software/tests/event_audit_test.c -o "$env:TEMP\event_audit_test.exe"
& "$env:TEMP\event_audit_test.exe"
git diff --check
```

- `event_view tests passed`：五种协议 ID、未知协议、128-bit 字段、
  START/DATA/END/ERROR、保留扩展码、仅 SPI DATA 的 MISO/MOSI 拆分。
- `event audit tests passed`：混合 UART/I²C 事件及 ERROR、未知协议、
  时间戳逆序、SPI DATA 长度异常、空/越界元数据，以及 256 条快照
  上限和最后一条为触发 ERROR 的边界。
- `git diff --check` 无错误。

初测时严格 C99 编译指出 `uint32_t (*)[4]` 与带 `const` 的数组指针
限定不兼容；审计入口改为连续 `count × 4` 个 word 的
`const uint32_t *`，调用点传入首 word，并复跑全部用例通过。
该修复不改变 AXI word 顺序或事件 ABI。

## 第 2 轮：干净 SDK 构建和原功能回归

- 用相同严格编译参数重跑 `software/tests/pixel_scroll_test.c`：
  `pixel_scroll_test PASS`。
- 确认 `.sdk_event_audit_round2` 原先不存在，再设置
  `MULTI_PROTOCOL_HDF=Multi_protocol.sdk/platform_hw/system.hdf`、
  `MULTI_PROTOCOL_SDK_WS=.sdk_event_audit_round2`，运行
  `xsct.bat software/build_ps_app.tcl`。最终输出 `PS_BUILD_DONE`，生成
  `platform_app/Debug/platform_app.elf`；程序大小 text=115968、
  data=2104、bss=33920 字节，ELF SHA-256
  `077D30117ED4A622AFBFB247849601263F836C726CE7384F6B816EF372C4B3B7`。
  SDK 在新建应用项目时曾输出 `make clean: No rule to make target clean`，
  后续实际编译、链接及 ELF 生成成功；不能仅凭该清理提示认定构建失败。
- 构建过程只写入隔离的 `.sdk_event_audit_round2`，没有碰已板测整合
  工作树、JTAG、COM4 或用户正在运行的板子。

SDK 构建的关键命令（先确认验证目录不存在）：

```powershell
$env:PROCESSOR_ARCHITECTURE = 'AMD64'
$env:MULTI_PROTOCOL_HDF = 'D:\fpga_class\FPGAPrj\ps_generic_events_worktree\Multi_protocol.sdk\platform_hw\system.hdf'
$env:MULTI_PROTOCOL_SDK_WS = 'D:\fpga_class\FPGAPrj\ps_generic_events_worktree\.sdk_event_audit_round2'
& 'D:\Vivado2018.3\SDK\2018.3\bin\xsct.bat' 'software\build_ps_app.tcl'
```

## 尚未完成的验收

两轮均为宿主/SDK 静态验证，**不是上板闭环**。真实 UART/I²C 事件源、
线缆、错误注入及 LCD 可视性要等 PL 端产生符合统一 128-bit ABI 的
样例、成员 C 批准协议专用 flags 含义后再验收。当前 UI 只可靠显示
协议名、通用类型、原始 flags、事务号、时间戳和 ERROR 数；不能据此
声称 UART/I²C/CAN 已实测通过。

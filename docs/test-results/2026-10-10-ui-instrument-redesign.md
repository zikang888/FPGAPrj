# 仪器化 LCD 页面改版与验证（2026-10-10）

## 页面及数据含义

底栏为 HOME / SELF TEST / EVENTS / ERRORS。原 D1 触摸按钮移除；上电仍将
`REG_LED_CTRL` 写 0，但不再由 UI 操作 D1。HOME 去掉与 EVENTS 页重复的事件数、
触发索引和 `CORE REJECTED` 卡片，集中显示监测状态、数据来源和外部丢失数。
在 DEMO 来源时点 HOME 中央提示，或在 EVENTS 点 ARM SPI，可武装一次真实 SPI
快照；采到数据后来源为 REAL SPI。EVENTS 保留原像素滚动和原始事件详情。

HOME 的 `SPI BYTE TRACE` 只在真实快照含同一事务的 START、四条有效 SPI
DATA 和 END 时，从 DATA 的 MOSI/MISO 字节重建 32 位数字电平图，并列出
4 个十六进制字节。`DECODED - NOT SAMPLED` 是刻意保留的限制说明：横轴是
字节/位次序，不是真实采样时间，也没有模拟电压、边沿宽度或时钟抖动信息。
虚拟事件不会伪装成总线波形。要做电气时序波形，需要另建 PL 采样数据路径。

ERRORS 显示 PL 寄存器 `EXT_DROPPED` (`0x0038`)、SPI FRAME/BOUNDARY/
DUPLICATE/SEQUENCE (`0x004C`/`0x0050`/`0x0054`/`0x0058`)、当前快照的
ERROR 事件数，以及 `CORE REJECTED` (`0x1014`)。前六项非零为故障；
`CORE REJECTED` 在一次快照冻结后可能按设计增加，仅作 INFO，不等同于外部
SPI 事务丢失。PL 计数每 0.5 秒轮询，在 HOME、SELF TEST、EVENTS、ERRORS
按页局部刷新。UI 不知道 STM32 串口命令的 pass/fail 统计。

## 第 1 轮：宿主与构建

- Vivado 附带 MinGW GCC 6.2.0，以 C99、`-Wall -Wextra -Wpedantic -Werror`
  编译并运行 `spi_trace`、`ui_counter_semantics`、`event_view`、
  `event_audit`、`pixel_scroll` 五项测试，全部 PASS。事务测试覆盖
  `9F 00 00 00` / `FF EF 40 18` 和缺 END、事务号不一致、无效 DATA。
- SDK 2018.3 隔离工作区 `.sdk_ui_redesign_validation` 完整链接 ARM ELF；
  最新 ELF SHA-256 为
  `919E952A2134DD05991D08652007B3CF8FC4CF4EAE06ED2ACD981A72975DBA4D`，
  text/data/bss 为 107940/2104/33920 字节。`a9-linaro-pre-build-step`
  缺失提示被生成的 makefile 忽略，实际编译链接成功。
- `git diff --check` 无空白错误。未改 PL bitstream、HDF、事件 ABI 或
  STM32 固件；工作树中原有的 `.xpr`、`.bd` 与 STM32 生成文件不属于本次提交。

## 第 2 轮：板端可视化与当前阻塞

- 先前的 ELF-only 下载仅 `stop` + `dow` 时，CPU 落在预取异常向量
  `pc=0x0010000c`，旧帧缓存残留。因此下载脚本在 `dow` 前增加
  `rst -processor`。以当时版本重新下载后，PL 出现新的 25 条 DEMO 快照，
  表明应用重新运行，而不只是 JTAG 报告“下载成功”。
- JTAG 只读导出 800×480 双帧缓存：实际 HOME 和 ERRORS 页面均已目视检查，
  字体、分栏、计数和底栏无明显遮挡；另以**仅改 RAM 的测试注入**放入
  `9F 00 00 00` / `FF EF 40 18` 六事件数据，双缓冲的数字轨迹显示正确。
  注入结果只是渲染器验证，**不是 STM32 实发得到的 JEDEC 回读**。
- 最后把 HOME 提示改为可点击的 `TAP HERE TO ARM SPI`，已重新编译上述最新
  ELF；但正式回刷的 PL 身份寄存器预检先在 `0x40000000` 超时，重试后
  DAP 显示 `AP transaction error, DAP status 30000021`。250 kHz 的
  `rst -system` 也失败。脚本在预检处停止，**最新 ELF 尚未上板**。
  因此板上可能仍停留在测试注入状态，不能把当前 LCD 状态当作正式版。

## 恢复后验收

1. 完整断电并重新上电 AC820/Zynq 板，先只读确认 A9 与匹配 PL ABI：
   `SYS_ID=4D505254`、`VERSION=00010004`、`CAPABILITIES=0000000F`。
2. 用 `fpga/build/zynq_jtag_elf_only_smoke.tcl` 下载上面 SHA-256 的 ELF；
   不能仅以 XSCT 进程退出码判断成功，须看到 `ZYNQ_ELF_ONLY_SMOKE_DONE`、
   新的 25 条 DEMO 快照及正常 HOME 页面。随后确认中央提示可点 ARM SPI。
3. 触摸 ERRORS 检查零故障布局，SELF TEST 和 EVENTS 保持正常滚动；用
   STM32 发一笔真实事务后看 HOME 字节轨迹和 EVENTS 六事件逐项对账。
   先前两笔 STM32 JEDEC 回读为 `FFFEFFFF`、`FFFFFFFF`，与预期不符，
   因此真实回读正确性尚未验收，不能由注入截图代替。

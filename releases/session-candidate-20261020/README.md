# 测试轮次与历史页候选版（2026-10-20）

状态：**离线验证完成，实板验收待进行**。用户确认本轮板子不在，因此没有执行 JTAG 下载或屏幕实板验证。本包中的 BIT、HDF、PS 初始化和 ELF 必须配套使用，哈希见 `manifest.json`。

功能：NEW TEST 开始时清零本轮统计；持续记录所选 SPI/UART，END & SAVE 后冻结并保留结果；历史页回看最近 8 次事件和错误详情。每次最多保留最后 256 条事件，总数和环形覆盖会另外显示。历史在 RAM 中，断电清空。UART 主页增加解码帧示意图，仍不是电气采样波形。

## 下载入口

板子接回后，在仓库根目录双击 `04_Program_Session_Candidate.cmd`，或运行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools/program_session_candidate.ps1
```

只验证文件配对、不连接板子：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools/program_session_candidate.ps1 -PreflightOnly
```

预期 PL VERSION=`0x00010007`，CAPABILITIES=`0x0000007F`。这是 JTAG 临时下载；本包不含 QSPI 启动镜像。旧的 `03_Program_Tested_Release.cmd` 仍指向 10 月 18 日实板验证版本。

## 验证与后续实板门槛

- 六项 RTL 仿真通过，含持续采集、不自动冻结、协议过滤、无触发错误、手动冻结边界、空测试和环形覆盖。
- 实际固件生命周期、快照读取与历史复制的主机回归通过；实际绘制代码与触控命中测试通过，预览不是实板截图。
- Vivado 完整实现、时序和 DRC 通过；新 HDF/BSP 对应的 ELF 已重新编译。
- 实板待验：连续两轮错误 4→0、旧历史不变、重复 UART 错误全部进入本轮、SPI 回归、超过 256 条的标记、触摸滚动、UART 帧图。

操作说明：`docs/interfaces/test_sessions.md`。
离线记录和预览：`docs/test-results/2026-10-20-session-offline.md`。
本机隔离构建工程：`build/session20261020/Multi_protocol.xpr`；对应 SDK：`build/session20261020/SDK`。日常开发入口保持原样。

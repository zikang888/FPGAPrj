# member C · 最新源码的 2026.1 离线迁移候选镜像

日期：2026-11-02。基于 `codex/ui-four-protocol-20261023` / `c5f44ff57ff1b551ba32569f4a2103a1b1cf35be`，包含中文工作台、历史异常回放及长时间采集异常事务保留。

**9 项 RTL、16 项基础宿主检查、保存回放和 UI 回归通过；2026.1 综合/实现/BIT/XSA 与 Vitis BSP/Hello World/业务 ELF/FSBL 构建成功。本轮未连接板卡，此目录是待实板交叉验证的候选文件。**

本目录配套 BIT / include_bit XSA / ELF / ps7_init 和 manifest 来自同轮构建。内部 WNS=0.738 ns、WHS=0.026 ns，TNS/THS=0；PS7 参数与最新基线一致。文件 SHA256、实际构建提交和完整检查结果见 `manifest.json` / `verification.json`。

在仓库根目录预检文件，不连接硬件：

```powershell
.\releases\vivado-vitis-2026.1-memberC-20261102\program_2026_1.ps1 -PreflightOnly -ToolRoot 'E:\AMDDesignTools\2026.1'
```

核实板卡、唯一 JTAG 目标及工具安装路径后，去掉 `-PreflightOnly` 可进行易失性下载。成功标记只说明加载流程完成，还需做平台、LCD/触控与四协议实测。先前本机 2026.1 hw_server 枚举阻塞时的兼容方案是单独运行 2018.3 hw_server，再使用 2026.1 XSDB；本轮未接板，需重新验证，勿让两个服务端争用同一线缆。下载不写 QSPI/SD。

预期平台寄存器：SYS_ID=`4D505254`、VERSION=`00010009`、CAPABILITIES=`000003FF`。不要与旧 1.8 / 0x1FF 版本的 BIT 或 ELF 混用。正式 TESTS 现在只保留异常事务，正常流量只计数，单次捕获仍可看正常轨迹。

请其他成员按 [本轮迁移说明](../../README_MIGRATION_2026_1.md) 与 [验证记录](../../docs/test-results/2026-11-02-latest-vivado-2026.1-migration.md) 交叉验证，反馈 commit、工具/板卡/STM32 固件、平台寄存器、触摸与切页、正常/错误流量、异常保留和保存回放结果。外部时序、完整故障集、长时间稳定性和独立 SD 启动仍待验收。

# 当前 UI：A 版中文工作台（2026-10-30）

源码：software/src。配套下载文件：candidates/ui-workbench-a-20261030/。
已完成 16 项主机检查、生产渲染和触摸回归、ARM 编译及实板下载；用户确认显示与触摸正常。
本轮仅验收新 UI，真实四协议故障注入未重新测试。
下载使用同目录 BIT、HDF、ps7_init.tcl 与 platform_app.elf；文件哈希见 manifest.json。
PL ABI：SYS_ID=4D505254，VERSION=00010008，CAPABILITIES=000001FF。
本轮记录：docs/test-results/2026-10-30-ui-workbench-a.md；界面说明：docs/UI_WORKBENCH_A.md。
JTAG 下载掉电失效，下载重启会清空 RAM 历史，未写 QSPI。
此前实板版本 releases/ui-home-hold-20261027/ 保留，供回退与追溯。
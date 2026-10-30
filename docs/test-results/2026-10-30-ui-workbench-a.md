# 2026-10-30 A 版工作台实板验收

版本：ui-workbench-a-20261030。采用 Vivado SDK 2018.3，以易失性 JTAG 下载配套 BIT、ps7_init.tcl 和新 ELF；未写 QSPI。

## 下载证据

- 配套四文件 SHA256 与 manifest.json 一致；HDF 与构建 BSP 所用硬件平台一致。
- 新 ELF SHA256：BFEFD75AAF1F0D5A4A2AE23FD9D53D40C46A0990DA3639A355456CBB70AD91C1。
- Cortex-A9 #0 可见；系统复位、PL 配置、PS 初始化和 ELF 下载成功；最终恢复 CPU 运行，出现 ZYNQ_JTAG_BOARD_TEST_DONE。
- SYS_ID=4D505254，VERSION=00010008，CAPABILITIES=000001FF，SCRATCH=A5A55A5A。
- 启动后 EXT_DROPPED=0；本轮未执行新一轮协议故障刺激，不将这些初值当作四协议故障回归通过。
- 初次自动启动 hw_server 失败于旧工具临时目录解析；显式以 AMD64 启动 SDK 2018.3 hw_server 后成功。没有因该启动问题操作板卡复位或改系统工具。

## 用户实物确认

下载后请用户检查五项左侧导航、中文清晰度、五页和四协议切换以及历史滚动。
用户回复：“显示与触摸都正常，可以推送”。据此确认本轮界面和触摸验收通过。
本轮未重测真实四协议数据和所有故障注入；保留此前测试结论的适用范围。

## 离线验证

16 项主机检查与生产渲染器／触摸回归通过，ARM 全量编译成功。
预览图片来自生产渲染器的离线测试数据，非实物照片。
CAN 预览 fixture 已同步 ACK 错误数与测试总数，修正后单独重跑渲染和触摸检查通过。

配套位置：candidates/ui-workbench-a-20261030/。下载日志：board/download.log。
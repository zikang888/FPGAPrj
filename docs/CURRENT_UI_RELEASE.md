# 当前 UI 配套版本：ui-home-hold-20261027

本分支当前可复用文件集为 `releases/ui-home-hold-20261027/`，不要仅按同名文件或目录修改时间选下载文件。

- 工具：Vivado / SDK 2018.3。
- 最新 ELF SHA256：`3B584132A3E0FA945BA26091239FD48D8772B6A0D0FCADCF88781261940DCB10`。
- 匹配 BIT、HDF、PS 初始化脚本及 ELF 均在该发布目录，哈希及源码对应关系见 manifest.json。
- PL ABI：SYS_ID 4D505254，VERSION 00010008，CAPABILITIES 000001FF。
- 包含四协议解码轨迹、测试轮次及历史、HISTORY 滑动/松手打开、四项错误删除、点击波形不重采集、等待新数据时保留上一帧。
- 解码轨迹不是原始采样波形；CAN 仅画负载位，不展示完整 STUFF / CRC / ACK 位流。
- 15 项主机检查和生产 UI 渲染/触摸回归通过；最新实板 SPI 两笔 JEDEC 验证等待保留与新帧替换，其他协议的本轮实板流量未逐一重测。
- JTAG 为临时下载，掉电需重载；没有写 QSPI。下载重启清空 RAM 历史。
- STM32 最新远端提交不自动纳入本分支；该分支主要交付 FPGA/PS 代码和已测配套产物。

详细记录：`docs/test-results/2026-10-27-home-waveform-hold.md`、`2026-10-27-history-gesture.md`、`2026-10-27-retired-error-catalog.md`。
开发源码：`software/src/`；主机回归入口：`software/tests/run_session_checks.ps1`。
旧发布保留用于追溯，不代表其中功能声明适用于最新版本。

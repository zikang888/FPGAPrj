# 2026-10-30：四协议混合正常/错误流量与屏幕

分支 `memberC/stm32-f407`；目标 STM32F407VGT6。实现与命令详见 [使用说明](../hardware/stm32_mixed_traffic.md)。

## 范围

- 新增通用 `mc_mixed.h/.c`：纯正常、指定一次、每 N 次、固定种子随机 K 个位置；总数包含错误槽，随机不重复且完整执行恰好 K 次。
- 板级集成四协议全部 10 种白名单错误；CAN normal/RAW 分槽复用，不并发、不改已有 HAL 后端。默认版在首槽前拒绝 CAN 注入，允许 CAN 纯正常。
- 新增错误运行方式页及预设、混合进度/注入/本地结果页、停止和恢复锁；正常 6 项菜单与原 fault CLI 保留。
- 新独立 mixed/mixed_io 元数据；保留旧 runner、fault、CAN JSONL。新增离线计划/归一化 FPGA 结果核对工具，不虚构 FPGA 检出。
- 协议规则、20 个原 fault ID、`mc_faults.c`、runner/logger、CAN 会话与 HAL、Core/IOC、接线和速率不改。UART 混合背景不等 echo，I2C 混合背景只读；原正常单次测试不改。

## 主机验证

```powershell
cmake -S stm32_f407 -B stm32_f407/build -G Ninja
cmake --build stm32_f407/build
ctest --test-dir stm32_f407/build --output-on-failure
```

当前环境 15/15 passed，C 代码 `-Wall -Wextra -Wpedantic -Werror`。其中 PowerShell 检查工具测试仅在 CMake 找到 pwsh/powershell 时加入，非 Windows 环境可能少这一项。

| 检查 | 结果 |
|---|---|
| 原有回归 | 原 13 项继续通过；RAW 按钮测试更新为先进入运行方式页，再选 SINGLE |
| 通用计划 | 10 种错误各 1000 槽第 500 槽注入；normal/every/random、随机精确次数/复现/边界通过 |
| 时序与安全 | 完成相对 GAP、时钟回绕、不补发突发；日志失败拒绝未记录发送；操作失败停止；在途取消不算成功 |
| 真实板级应用模拟 | 默认版覆盖 7 种非 CAN 注入、故障版覆盖全 10 种；正常和错误夹杂，完成后本地计数正确 |
| 背景差异 | UART 无 echo 仍完成混合正常；I2C 混合正常无 EEPROM 写；默认/故障版均可纯正常 CAN |
| 互斥/恢复 | 整轮含 GAP 拒绝旧命令；长按停止；CAN 子会话恢复失败锁住 SPI 等，重试后才解锁 |
| 屏幕/命令 | 进入/BACK 不发、ONE IN 100 参数正确、CLI once/every/random/normal、启动拒绝条件通过 |
| 离线核对 | 指定/随机位置重放、损坏注入日志拒绝、匹配/额外/重复统计及“意图≠物理确认”边界通过 |

默认版及 CAN 故障版开发构建均已通过 ARMCC 5.06 update 2，0 error / 0 warning。正式发布从干净源提交执行 `build_profiles.ps1 -Profile all -Release`，HEX/source/SHA-256 见 [发布目录](../../stm32_f407/firmware/releases/README.md)，不覆盖旧固件。

## 未完成的实板验收

本次未连接或烧录实板。应逐协议执行：NORMAL 1000 零注入误报基线；ONE IN 1000 定位第 500 个逻辑事务；EVERY 100 恢复验证；固定 seed 随机；逐步缩短间隔。同步采集 MCU 日志、原始总线、FPGA 事件。检查真实 SCLK/位宽、I2C STOP 恢复、CAN RX FIFO/终端/ACK 和 RAW 切换空闲间隙、OLED/日志造成的实际时长及按钮响应。

15 项通过不等价于物理错误产生率或 FPGA 检出率。注入成功数、有效物理错误数、FPGA 错误事件数应分别记录；预设 GAP 不是精确帧率，普通 JSONL/屏幕刷新会降低吞吐。

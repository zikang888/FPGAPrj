# 2026-10-27 错误目录收敛

用户确认四项不列入当前功能：I2C SDA STUCK、I2C SCL STUCK、CAN FORM ERROR、CAN TX BIT。

## 修改范围

- ERROR 页删除四项，I2C/CAN 使用两行四卡片布局，取消删除后的空槽。
- main 不再读取/报告相应寄存器；错误模型排除四项，错误总数及保存历史随之更新。
- HISTORY 错误目录、测试结果判断、排查建议、HOME 告警及事件标色使用相同范围。
- STM32 case 3093、3094、4092、4095 不再映射为已支持错误。
- 保留稳定枚举编号、寄存器和 PL 逻辑以兼容已验收 BIT/HDF。若有原始事件，保留为 INFO，不冒充已经验证的错误检测，也不计为错误。
- 历史发布和既有采集证据保持原样，不能把旧版本的 FORM 截图当作新版支持声明。

## 验证

- 14 项主机检查及生产 UI 渲染/触摸回归通过，含 HISTORY 拖动/松手点按。
- 增加退役四项非零计数、STM32 映射拒绝、原始记录 INFO 标记、快照错误总数和保留 STUFF 判定的回归。
- 新 ARM ELF 编译成功，SHA256 `FEE5215E6443A57B67068D2A45FD0B31C493E9730C6AF5FF97ECAA6EE2091514`。
- SDK 旧 makefile 的可选 pre-build helper 缺失警告仍被 make 忽略；实际 ARM 编译、链接和 size 成功，未使用旧 ELF。
- JTAG 下载完成，SYS_ID=4D505254、VERSION=00010008、CAPABILITIES=000001FF 均匹配；串口新程序返回 status，history=0（下载重启后 RAM 历史清空）。
- 帧缓冲核对记录另见发布 README；物理触摸手感不由帧缓冲证明。

源码在 `software/src`，配套产物在 `releases/ui-error-catalog-20261027`。本次不修改 QSPI，不推送远端。

# HOME 波形保留与显式重采集

## 修复

- 取消点击整块波形区域触发采集，只保留右上角 CAPTURE AGAIN。
- 同协议重新采集时保留已完成的上一帧，状态显示 WAIT / PREVIOUS。
- 新快照先读入独立暂存区，完整校验通过后才替换显示缓存。
- 切换协议、开始正式测试仍清除上一上下文，不展示其他协议的旧波形。
- 串口 capture again 与按钮使用同一动作；等待中或正式测试中不可重复触发。
- 保留此前四项错误删除和 HISTORY 手势修复。

## 验证 2026-10-27

- 15 项主机检查及生产 UI 渲染/触摸回归通过。
- 新增 home_trace_hold_test 对四协议验证：波形区点击无动作、按钮显式重采集、等待态波形区域像素完全保持、不在正式测试中显示旧图。
- ARM 编译、JTAG ELF 下载完成；PL ABI 与原匹配链一致。
- 新 ELF SHA256：3B584132A3E0FA945BA26091239FD48D8772B6A0D0FCADCF88781261940DCB10。
- 实板发送两笔 SPI JEDEC，STM32 均读回 FFEF4018，result=0。
- 第一帧与 WAIT / PREVIOUS 阶段的实际板上帧缓冲波形区（y176..407）逐字节相同。
- 第二笔后实际画面恢复 DATA RECEIVED / SNAP 13；寄存器 capture_status=0x12、snapshot_count=6、total=6，确认新快照完成。
- 自动脚本最初因关闭串口期间没有保留 HOME SNAPSHOT READY 回执而停止；随后通过帧缓冲与寄存器独立核对成功。未将缺失回执当作采集失败，也未伪造回执。
- 物理触摸手感本轮未由用户重新确认；触摸命中与缓存保持已分别通过主机及实板证据验证。

配套文件：releases/ui-home-hold-20261027。日志及真实帧缓冲在工作区 board_validation/home-hold-*。
本次更新为易失性 JTAG，不写 QSPI，不推送 Git。下载重启清空 RAM 历史记录。

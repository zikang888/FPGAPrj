# 2026-09-23 平台基线验证

> 本文记录迁移前的平台基线；事件快照版本的当前结果见
> `2026-09-23-event-snapshot-closed-loop.md`。旧 WNS 不代表当前产物。

## 已确认

- Vivado 工程器件为 `xc7z020clg484-2`。
- 小梅哥 5 寸 800×480 RGB 显示链路已合入 VDMA/VTC。
- GT911 板级连接与参考工程一致。
- `impl_1/runme.log` 记录 `write_bitstream completed successfully`。
- `reports/timing.rpt` 记录 WNS `+4.278 ns`，全部用户时序约束满足。

## 本次变更

- 将错误的 `gt9147_*` 软件接口统一为 `gt911_*`。
- 保持 GT911 配置表、复位/地址选择时序、IRQ 安全轮询和坐标边界检查不变。
- 保留现有多协议核心、AXI 地址映射、LCD UI 和 FPGA 实现结果。

## 待板上验收

- 串口依次出现 `PS READY`、`PL ID OK`、`SCRATCH OK`、`TOUCH READY`、`UI READY`。
- LCD 正常显示平台自检页。
- 点击屏幕按钮可切换 D1（P21）LED，D0（P20）心跳灯持续闪烁。

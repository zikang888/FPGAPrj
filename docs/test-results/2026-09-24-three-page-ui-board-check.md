# 三页 UI 候选包板级检查

## 候选包

```text
artifacts/candidates/2026-09-24-ui-pages
```

## 已通过

- SDK 2018.3 重新编译成功，`PS_BUILD_DONE`。
- 候选 BIT、HDF、ELF 通过 JTAG 成功下载。
- PL ID：`0x4D505254`。
- 版本：`0x00010002`。
- 能力：`0x00000003`。
- AXI scratch：`0xA5A55A5A`。
- 快照 ID：1。
- 快照事件数：25。
- 触发索引：8。
- 核心丢包：0。
- 外部生产者丢包：0。
- 串口启动日志包含 `TOUCH READY`、`CAPTURE READY`、`UI READY`。

## 待人工确认

- LCD 主页布局无越界、遮挡和乱码。
- `SELF TEST`、`EVENTS`、`HOME` 三个按钮可以依次切页。
- `EVENTS` 页面显示 8 行事件并高亮触发事件。
- `LED: OFF/ON` 按钮状态与 D1 实际亮灭一致。
- D0 在页面操作期间持续作为心跳灯闪烁。

人工项全部通过前，不得把候选包晋升到 `artifacts/current`。

# 协议选择：软件与实板检查（2026-10-10）

范围：`codex/fpga-ab-week2-c-integration`，仅 PS UI 与接口文档；
不修改 PL BIT、HDF、STM32 固件、寄存器 ABI 或既有 EVENTS 滚动逻辑。

- 七项严格 C99 宿主测试通过：`ui_protocol_select`、`error_model`、
  `spi_trace`、`ui_counter_semantics`、`event_view`、`event_audit`、
  `pixel_scroll`。新测试覆盖四个触摸标签的边界和间隙，以及只有
  `CAPABILITIES[2]` 对应的 SPI 可用。
- SDK 2018.3 隔离工作区完整重新链接 ELF；匹配的 PL 预检读到
  `SYS_ID=4D505254`、`VERSION=00010004`、`CAPABILITIES=0000000F`。
  ELF-only 下载后 `ZYNQ_ELF_ONLY_SMOKE_DONE`，新 DEMO 快照 25 条。
- 从真实板的双帧缓存导出 HOME：SPI 默认高亮且标 `PL READY`，
  UART/I2C/CAN 标 `NOT WIRED`，下方保留 SPI 字节轨迹和 ARM 提示，
  无文字越界。该画面是软件渲染验证，不等于后三种协议已采集。
- 最终 ELF SHA-256 为
  `F50A6F62982CEC9327A6AB18087A5C56385EC35EE9197C4635FD19B1CD622A2D`。
  仅在 PS RAM 暂改选中值为 UART 做第二种布局验证：板上双帧均显示
  UART 高亮、`NOT WIRED`、`PL LISTENER NOT CONNECTED`，没有误画 SPI
  轨迹。之后重新下载该正式 ELF 清除注入，默认 SPI 和 25 条 DEMO
  快照恢复。这个 RAM 测试不等于实体触摸命中测试。
- 另用仅 RAM 注入的已知 6 条 SPI 事务检查缩短后的轨迹布局：
  `TX=9F000000`、`RX=FFEF4018` 的两路波形、HEX 与四个协议标签
  在 HOME 同屏无重叠。这只是渲染样本，不是本次新增的真实总线抓取。
  验证后再次下载上述正式 ELF；`POST_SNAPSHOT_COUNT=0x19`，
  `POST_CAPABILITIES=0x0F`，没有把合成快照留在板上。
- 四个标签的**实体触摸**回归尚待用户观察；不能用帧缓存静态图
  或宿主坐标测试替代触摸命中确认。真实 SPI 抓取链路已在前一轮
  `2026-10-10-ui-instrument-redesign.md` 中用 STM32 JEDEC 验证，
  本次改动在动作入口增加门控，需继续确认选择 SPI 后仍可武装。

设计边界见 `docs/interfaces/ui_protocol_selection.md`。

# HOME 四协议波形

## 使用方式

HOME 上电默认选择 SPI 并自动武装一次捕获。切换 SPI、UART、I2C 或 CAN
标签时，PS 会用对应协议 ID 重新武装 PL 的手动事件缓存。收到至少一个事件后，
若总线连续 20 ms 没有新事件，PS 自动冻结、复制快照并立即重绘 HOME。

波形显示完成后，点击中间波形区域可再次武装。EVENTS 页的
`NEW TEST / END & SAVE` 使用独立的测试会话流程，不与 HOME 一次性捕获混用。

## 显示内容

- SPI：同一事务的四个 MOSI/MISO 字节及按 MSB-first 重构的两条逻辑波形。
- UART：最多四个接收字节的 start、8 data、stop（8N1）逻辑波形。
- I2C：最多四个字节的 SCL/SDA 逻辑轨迹，以及每字节 ACK/NACK。
- CAN：第一笔完整标准数据帧的 ID、DLC、前四个数据字节及数据位逻辑波形。

屏幕统一标注 `DECODED - NOT SAMPLED`：这些图来自 PL 事件中的已解码位/字节，
不是示波器式模拟电压采样，也不保留精确的位间时间比例、CAN 位填充或 CRC 波形。
完整事件、错误原因和时间戳仍在 EVENTS/ERRORS 页面查看。

## 实现与验证

- 采集控制：`software/src/main.c`
- SPI 解码：`software/src/spi_trace.h`
- I2C/CAN 解码：`software/src/protocol_trace.h`
- 绘制：`software/src/platform_ui.c`
- 宿主测试：`software/tests/spi_trace_test.c`、
  `software/tests/protocol_trace_test.c`、`software/tests/ui_session_preview.c`
- 实板记录：`docs/test-results/2026-10-23-home-waveform-four-protocol.md`

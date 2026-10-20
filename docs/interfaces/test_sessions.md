# 测试轮次、事件列表与历史记录

2026-10-20 候选版：已完成离线构建和回归，等待实板验收。旧的实板发布保持在 03 入口；本候选版通过 04 入口下载。

## 屏幕操作

1. HOME 选择 SPI 或 UART，进入 EVENTS。
2. 点 **NEW TEST / RESET**。它保存尚在进行的上一轮，然后清零新一轮的错误和事件统计，启动所选协议的持续记录。页眉显示 RECORD 和 TEST 编号。
3. 让 STM32 发送一个或多个正常/故障测试。页眉 EVENTS 和 ERR 每 200 ms 更新一次；记录过程中页面明确提示结束后打开事件列表。
4. 发送完成后点 **END & SAVE**。硬件冻结这次事件和协议统计，页面显示 SAVED 并展示事件。不会因第一笔触发就提前停止。
5. 在 ERRORS 看本轮结果。切页不会清零；只有 NEW TEST 开始新轮次时清零。
6. 在 EVENTS 点 **HISTORY**。最多保留最近 8 次完成的测试，新记录在上。点一行可回看保存的事件，再点 **ERROR DETAILS** 看那一轮的错误；这些数据不会被之后的新测试修改。

历史保存在 RAM，断电或重新下载 ELF 后清空。它还不是 SD/Flash 持久化日志。

## 什么会显示

- 列表只收集本轮所选协议。它保留协议解析器实际产生的 START、DATA、END、ERROR。
- UART 错误使用 BADSTOP、BREAK、SHORT 标签；DATA/DETAIL 显示字节、LINE LOW 或短事务收到的字节数。
- SPI JEDEC 短/长/错 ID 原来只增加统计，不产生单独 ERROR 记录。界面现在根据保存的完整 START..END 内容，将 END 标为 SHORT、EXTRA 或 BAD ID。它是对实际事务的解释，不会伪造新的 PL 事件。快照缺少 START 时不推断该事务的长度错误。
- TIME US 为相对这次保留列表首条事件的时间，按当前 PL 100 MHz 时钟换算；没有逐位采样波形。HOME 的 SPI/UART 图仍是解码数据的帧示意图，UART 最多展示前 4 帧，完整事件在 EVENTS。
- 单轮保留最近 **256 条**事件。EVENTS 是硬件记录的总数；历史中的 SAVED 是保留条数。超过 256 时显示 **TAIL256**，旧事件被环形覆盖；这与接口传输丢失计数不同。
- 尚未点 NEW TEST 时发送的数据不会进入某个新测试；页面会提示先开始测试。

## 硬件接口（平台 0x00010007 / 能力 0x7F）

- CAPTURE_CTRL `0x1000`：bit0 ARM；bit1 ACK；bit2 旧式软触发；bit3 FREEZE；ARM 同时带 bit4=1 启用手动结束模式，bits19:16 指定协议（1 UART、2 SPI、0 全部）。协议字段需写入对应字节 strobe。
- CAPTURE_STATUS `0x1004`：新增 bit4 表示手动记录；旧 bit0 ACTIVE、bit1 READY、bit2 环形覆盖保持。
- TRIGGER_INDEX `0x1010`：手动模式返回 `0xFFFFFFFF`，表示没有触发标记。手动结束空测试也是有效快照（count=0）。
- CAPTURE_TOTAL `0x101C`：本轮所选协议在快照入口实际接收的总事件数，ARM 清零，冻结后不再增加。
- 手动模式下 SPI/UART 统计也只在所选协议的记录窗口更新。NEW TEST 显式清除统计寄存器；END 后外部流量不再修改本轮结果。
- 旧触发模式继续用于 SELF TEST 和原有接口回归。

## USB 控制台

Zynq 的 PS 串口（115200 8N1，端口号以设备管理器为准）接受以下行命令，执行与触摸相同的动作：

```text
protocol uart
test start
status
test stop
view events
view errors
view history
view home
```

SPI 使用 `protocol spi`。STM32 的 `fault run` / `spi jedec` 等命令仍发给 STM32 自己的控制串口，两者不要混用。

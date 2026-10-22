# I2C/CAN 被动监听集成与验证（2026-10-21）

## 构建结果

- Vivado 2018.3 全量 HDL 回归通过：snapshot、arbiter、core、SPI monitor、
  SPI snapshot、UART、I2C 和 CAN 共八项测试均报告 PASS。
- I2C 仿真覆盖正常 ACK、地址 NACK、busy NACK、缺 STOP和无事件丢失。
- CAN 仿真覆盖标准帧数据、无 ACK 和错误 CRC。
- PS 主机测试全部通过，包含协议选择、会话生命周期、错误模型、事件显示、
  历史记录、滚动及 UI 预览。
- 综合、实现和 bitstream 成功。实现后 WNS `+0.985 ns`、WHS
  `+0.033 ns`，全部时序约束满足；DRC 无 Error/Critical Warning，只有原
  VDMA BRAM write-first 的两条 Advisory。
- SDK 平台、BSP 和 `platform_app.elf` 由本次 HDF/BIT 重建成功，随后通过
  JTAG 下载并启动。

## 实板结果

读取身份寄存器：SYS_ID=`0x4D505254`、VERSION=`0x00010008`、
CAPABILITIES=`0x000001FF`。

I2C 的 `fault run 13` 被 FPGA 捕获为 3 个事件、1 个数据事件和 1 个缺 STOP
错误，证明 AA6/V8 到 PL、事件仲裁、AXI 计数器链路贯通。总线恢复后：

- `fault run 9` 返回 STM32 `result=0`；PL 得到 7 个事件、2 个字节和
  `I2C_ADDRESS_NACK_COUNT=1`。
- `i2c eeprom 1` 得到 25 个事件、20 个字节和 1 次 busy NACK，但 STM32
  本轮仍返回 `nack_or_mismatch`。这说明监听链路正确捕获了 EEPROM 写周期
  的 NACK，同时 STM32 正常用例需要更稳健的 ACK-poll 重试，不能记为
  EEPROM 功能验收通过。

CAN RTL/PS 路径已通过仿真和构建，但本轮实板没有产生可捕获 CAN 帧：当前
STM32 固件未定义 `MC_ENABLE_CAN_FAULTS`，所以 `fault run 14` 返回“需要
外部不应答节点”且不发帧；`can loop 1` 返回 timeout，PL 计数保持 0。
这不是 CAN PL 仿真失败，但也不能宣称 CAN 实物链路已经通过。下一次实板
验收必须先让 STM32 启动信息显示 `CAN started`，并确认 SN65HVD230 供电、
共地、RXD 空闲为高以及总线终端，再执行单节点无 ACK 或双节点正常帧测试。

## 2026-10-21 active-node follow-up

CAN PL was upgraded from a passive listener to a compact active second node at
500 kbit/s. It accepts standard 11-bit data frames, validates stuffing/CRC/form,
ACKs valid peer frames, and automatically echoes the received identifier, DLC
and payload. `CAN_CTRL` (`0x00E0`) uses bit 0 for ACK, bit 1 for auto echo and
bit 2 as a rising-edge diagnostic transmit request. The diagnostic frame is ID
`0x321`, DLC 8, payload `00 01 02 03 04 05 06 07`; software must return bit 2
to zero before requesting another frame. `CAN_STATUS` (`0x00E4`) bit 0 exposes
the synchronized AA11/RXD level.

The active-node RTL simulation passed. Vivado synthesis, implementation,
timing and DRC completed with no errors. On the connected two-transceiver bus,
the diagnostic request produced one decoded frame and ten events with zero ACK,
bit, stuff, CRC and form errors. This verifies FPGA W8 -> transceiver B -> CAN
bus -> transceiver B AA11/RXD and also shows that another node asserted ACK.

The existing STM32 session still returned timeout for `can loop 1`, and the
FPGA counters did not advance after that command. Therefore the STM32 was not
putting a new frame on the bus in that session (most likely stale CAN error/
mailbox state following the earlier no-ACK tests). Reset STM32 after the FPGA
active node is already running, confirm the boot log says `CAN started`, then
repeat `can loop 1` for the final STM32-to-FPGA echo acceptance.

After resetting STM32 while the FPGA node remained active, the boot log did
report `CAN started`. `can loop 1` then passed with the echoed payload
`0001020304050607`. A subsequent `can loop 10` passed all ten iterations with
the expected incrementing payloads and `failed=0`. FPGA `CAN_FRAME_COUNT`
advanced from 3 to 23 during the ten-iteration run, exactly two frames per
iteration (STM32 request plus FPGA echo). Final counters were ACK/bit/stuff/CRC/
form errors all zero and `EXT_DROP=0`. This closes the physical two-node CAN
receive, ACK, transmit, echo and event-pipeline acceptance for the supported
500 kbit/s standard-data-frame subset.

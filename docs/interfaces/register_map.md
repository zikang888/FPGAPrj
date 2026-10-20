# Register Map

Base address: `0x4000_0000`, aperture: 64 KiB.

| Offset | Name | Access | Reset/value |
|---:|---|---|---:|
| `0x0000` | SYS_ID | RO | `0x4D505254` |
| `0x0004` | VERSION | RO | `0x00010007` |
| `0x0008` | BUILD_ID | RO | `0x20261020` |
| `0x000C` | CAPABILITIES | RO | bit0=`event snapshot`, bit1=`external ready/valid ingress`, bit2=`SPI Mode-0 monitor`, bit3=`SPI acceptance statistics`, bit4=`W25Q128 JEDEC semantic checks`, bit5=`UART RX monitor`, bit6=`manual test sessions/filter/freeze` |
| `0x0010` | SYS_CTRL | RW | `0` |
| `0x0014` | SYS_STATUS | RO | bit0=`ready` |
| `0x0018` | IO_MODE | RW | `0` (`OBSERVE`) |
| `0x001C` | IRQ_STATUS | RW1C | `0` |
| `0x0020` | IRQ_ENABLE | RW | `0` |
| `0x0024` | TIMESTAMP_LO | RO | reading latches all 64 bits |
| `0x0028` | TIMESTAMP_HI | RO | latched upper word |
| `0x002C` | SCRATCH | RW | `0` |
| `0x0030` | LED_CTRL | RW | bit0 controls D1 (P21) |
| `0x0034` | EVENT_ARB_STATUS | RO | arbitration contention count |
| `0x0038` | EXT_DROPPED_COUNT | RO | drop count reported by the connected external producer |
| `0x003C` | SPI_EVENT_COUNT | RO | accepted SPI START + DATA + END + FRAME_ERROR events |
| `0x0040` | SPI_START_COUNT | RO | accepted SPI transaction starts |
| `0x0044` | SPI_DATA_COUNT | RO | accepted full-duplex byte events |
| `0x0048` | SPI_END_COUNT | RO | accepted normal transaction ends |
| `0x004C` | SPI_FRAME_ERROR_COUNT | RO | incomplete-byte/frame-error events |
| `0x0050` | SPI_BOUNDARY_ERROR_COUNT | RO | DATA/END without matching START, nested START, or unknown event type |
| `0x0054` | SPI_DUPLICATE_COUNT | RO | exact duplicate 128-bit events accepted consecutively |
| `0x0058` | SPI_SEQUENCE_ERROR_COUNT | RO | non-consecutive transaction ID observed at START |
| `0x005C` | SPI_LAST_TRANSACTION_ID | RO | most recent START transaction ID in bits `[23:0]` |
| `0x0060` | SPI_STATS_STATUS | RO | bit0 transaction open, bit1 last event valid, bit2 last transaction valid, bit3 any parser/statistics error |
| `0x0064` | SPI_STATS_CTRL | WO | write bit0=`1` to clear all SPI acceptance statistics and checker state |
| `0x0068` | SPI_SHORT_TRANSACTION_COUNT | RO | completed `0x9F` transactions containing fewer than four DATA bytes |
| `0x006C` | SPI_EXTRA_BYTE_COUNT | RO | completed `0x9F` transactions containing more than four DATA bytes |
| `0x0070` | SPI_RESPONSE_MISMATCH_COUNT | RO | four-byte `0x9F` transactions whose MISO response bytes are not `EF 40 18` |
| `0x0074` | UART_EVENT_COUNT | RO | accepted UART START + DATA + END + ERROR events |
| `0x0078` | UART_DATA_COUNT | RO | accepted UART byte events |
| `0x007C` | UART_STOP_ERROR_COUNT | RO | stop bit sampled low |
| `0x0080` | UART_BREAK_COUNT | RO | RX continuously low for at least ten bit times |
| `0x0084` | UART_SHORT_TRANSACTION_COUNT | RO | idle gap after 1..7 bytes of an expected eight-byte test transaction |
| `0x0088` | UART_LAST_TRANSACTION_ID | RO | most recently accepted UART transaction ID in bits `[23:0]` |
| `0x008C` | UART_STATS_STATUS | RO | bit3=`any UART error counter is non-zero` |
| `0x0090` | UART_STATS_CTRL | WO | write bit0=`1` to clear UART statistics |
| `0x1000` | CAPTURE_CTRL | WO | bit0=`ARM`, bit1=`ACK`, bit2=`SOFT_TRIGGER`, bit3=`FREEZE`; ARM bit4=`manual`, bits19:16=`protocol filter` (0 all, 1 UART, 2 SPI) |
| `0x1004` | CAPTURE_STATUS | RO | bit0=`active`, bit1=`ready`, bit2=`overwritten`, bit3=`core or external dropped_count != 0`, bit4=`manual mode` |
| `0x1008` | SNAPSHOT_ID | RO | increments for each completed snapshot |
| `0x100C` | SNAPSHOT_COUNT | RO | valid event count, maximum 256 |
| `0x1010` | TRIGGER_INDEX | RO | logical trigger index; `0xFFFFFFFF` for manual, untriggered sessions |
| `0x1014` | DROPPED_COUNT | RO | events rejected outside active capture plus virtual-source queue overflow |
| `0x1018` | VIRTUAL_EVENT | WO | write bit31=`trigger`, bits23:0=`transaction_id` |
| `0x101C` | CAPTURE_TOTAL | RO | total matching events recorded in current session, including overwritten ring entries; ARM resets |

Snapshot data window: `0x6000` through `0x6FFF`. Each event occupies 16 bytes;
word offsets `+0`, `+4`, `+8`, `+12` return bits `[31:0]`, `[63:32]`,
`[95:64]`, `[127:96]` respectively. Logical index 0 is the oldest retained
event. Reads beyond `SNAPSHOT_COUNT` return zero.

Manual mode records until FREEZE regardless of event trigger flags, including
short/error-only traffic. FREEZE includes an accepted event on the same edge.
An empty manual session is valid with count=0; no trigger index is claimed.
Ring retention is limited to the newest 256 events, while CAPTURE_TOTAL keeps
the full count. In manual mode protocol statistics stop at FREEZE and ignore
other protocols. See `test_sessions.md` for the UI lifecycle and history scope.

Event layout:

| Bits | Field |
|---:|---|
| `[127:64]` | 64-bit PL timestamp |
| `[63:60]` | protocol |
| `[59:56]` | channel |
| `[55:54]` | direction |
| `[53:48]` | event type |
| `[47:32]` | flags |
| `[31:24]` | payload length |
| `[23:0]` | transaction ID |

Protocol numbers are frozen as:

| Value | Protocol |
|---:|---|
| `0` | VIRTUAL / platform self-test |
| `1` | UART |
| `2` | SPI |
| `3` | I2C |
| `4` | CAN |

Direction values: `0` unknown, `1` controller to peripheral, `2` peripheral
to controller, `3` bidirectional/full duplex. Common event types are `0x00`
transaction start, `0x01` data, `0x02` transaction end, and `0x3F` frame or
protocol error. Values `0x03..0x3E` are reserved for reviewed extensions.

For SPI data, `flags[15:8]` holds MISO and `flags[7:0]` holds MOSI;
payload length is `2`, direction is `3`, and all events in one CS-low
transaction share a transaction ID. On an incomplete byte, event type is
`0x3F` and `flags[2:0]` is the number of sampled bits.

For UART DATA, `flags[7:0]` is the received byte and payload length is `1`.
UART ERROR uses `flags[15:8]` as the reason: `0x01` bad stop bit, `0x02`
Break, `0x04` short transaction. For bad stop, `flags[7:0]` is the sampled
byte; for short transaction it is the received byte count. UART is fixed to
115200 baud, 8 data bits, no parity, one stop bit. A baud mismatch cannot be
identified uniquely from a passive line and therefore appears as corrupted
DATA and/or bad-stop events; parity error is deliberately unavailable in 8N1.

Protocol listeners use ready/valid transfer semantics. An event is accepted only
when `evt_valid && evt_ready` is true. A producer asserting `evt_valid` while
`evt_ready` is low must keep `evt_data` and `evt_trigger` stable. Arbitration or
producer overflow must be counted; events must never disappear silently.

The SPI statistics block observes only external SPI events that complete the
`ext_evt_valid && ext_evt_ready` handshake. For 100 successful four-byte JEDEC
transactions, after clearing statistics, the expected counters are
`START=100`, `DATA=400`, `END=100`, `EVENT=600`, while external drops, frame
errors, boundary errors, duplicates and sequence errors must all remain zero.
Repeated payload bytes are legal and are not considered duplicates because a
real event carries a distinct timestamp; duplicate detection compares the full
128-bit event.

The JEDEC semantic checker is deliberately command-specific. It activates only
when the first MOSI byte after START is `0x9F`, expects exactly four DATA events,
and checks MISO bytes 1 through 3 against the W25Q128 identity `EF 40 18`.
Short and extra-length transactions are counted only in their length category;
response mismatch is evaluated only when the transaction length is exactly
four bytes. Non-JEDEC SPI traffic does not affect these three counters.

The core exposes one generic external producer port:
`ext_evt_valid/ext_evt_ready/ext_evt_data[127:0]/ext_evt_trigger`, plus
`ext_evt_dropped_count[31:0]` for producer-side loss observability. It and the
AXI virtual self-test source feed the same round-robin arbiter and the same
snapshot buffer. In this integration build the external port is fed by a fair
two-source mux combining the passive SPI Mode-0 and UART RX monitors. The UART
input is W5; AA9 is reserved as FPGA UART TX and is held at the idle-high level,
with no frames transmitted. The legacy C candidate map is P7-38/35/36/33
(CS/SCLK/MOSI/MISO, FPGA AA8/AB10/AB9/AA7) in the legacy candidate only.
The current integration XDC follows A's P7-2/1/3/4 map (FPGA
U11/U12/U10/U9). Check the selected BIT and actual wiring before programming.

All writes honor AXI `WSTRB`. Undefined addresses read as zero and ignore writes.

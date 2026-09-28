# Register Map

Base address: `0x4000_0000`, aperture: 64 KiB.

| Offset | Name | Access | Reset/value |
|---:|---|---|---:|
| `0x0000` | SYS_ID | RO | `0x4D505254` |
| `0x0004` | VERSION | RO | `0x00010003` |
| `0x0008` | BUILD_ID | RO | `0x20260926` |
| `0x000C` | CAPABILITIES | RO | bit0=`event snapshot`, bit1=`external ready/valid ingress`, bit2=`SPI Mode-0 monitor` |
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
| `0x1000` | CAPTURE_CTRL | WO | bit0=`ARM`, bit1=`ACK`, bit2=`SOFT_TRIGGER`; issue as separate commands |
| `0x1004` | CAPTURE_STATUS | RO | bit0=`active`, bit1=`ready`, bit2=`overwritten`, bit3=`core or external dropped_count != 0` |
| `0x1008` | SNAPSHOT_ID | RO | increments for each completed snapshot |
| `0x100C` | SNAPSHOT_COUNT | RO | valid event count, maximum 256 |
| `0x1010` | TRIGGER_INDEX | RO | logical index of trigger event |
| `0x1014` | DROPPED_COUNT | RO | events rejected outside active capture plus virtual-source queue overflow |
| `0x1018` | VIRTUAL_EVENT | WO | write bit31=`trigger`, bits23:0=`transaction_id` |

Snapshot data window: `0x6000` through `0x6FFF`. Each event occupies 16 bytes;
word offsets `+0`, `+4`, `+8`, `+12` return bits `[31:0]`, `[63:32]`,
`[95:64]`, `[127:96]` respectively. Logical index 0 is the oldest retained
event. Reads beyond `SNAPSHOT_COUNT` return zero.

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

Protocol listeners use ready/valid transfer semantics. An event is accepted only
when `evt_valid && evt_ready` is true. A producer asserting `evt_valid` while
`evt_ready` is low must keep `evt_data` and `evt_trigger` stable. Arbitration or
producer overflow must be counted; events must never disappear silently.

The core exposes one generic external producer port:
`ext_evt_valid/ext_evt_ready/ext_evt_data[127:0]/ext_evt_trigger`, plus
`ext_evt_dropped_count[31:0]` for producer-side loss observability. It and the
AXI virtual self-test source feed the same round-robin arbiter and the same
snapshot buffer. In this integration build the external port is connected to
the passive SPI Mode-0 monitor. The legacy C candidate map is P7-38/35/36/33
(CS/SCLK/MOSI/MISO, FPGA AA8/AB10/AB9/AA7) in the legacy candidate only.
The current integration XDC follows A's P7-2/1/3/4 map (FPGA
U11/U12/U10/U9). Check the selected BIT and actual wiring before programming.

All writes honor AXI `WSTRB`. Undefined addresses read as zero and ignore writes.

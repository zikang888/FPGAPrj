# Register Map

Base address: `0x4000_0000`, aperture: 64 KiB.

| Offset | Name | Access | Reset/value |
|---:|---|---|---:|
| `0x0000` | SYS_ID | RO | `0x4D505254` |
| `0x0004` | VERSION | RO | `0x00010000` |
| `0x0008` | BUILD_ID | RO | `0x20260922` |
| `0x000C` | CAPABILITIES | RO | `0` |
| `0x0010` | SYS_CTRL | RW | `0` |
| `0x0014` | SYS_STATUS | RO | bit0=`ready` |
| `0x0018` | IO_MODE | RW | `0` (`OBSERVE`) |
| `0x001C` | IRQ_STATUS | RW1C | `0` |
| `0x0020` | IRQ_ENABLE | RW | `0` |
| `0x0024` | TIMESTAMP_LO | RO | reading latches all 64 bits |
| `0x0028` | TIMESTAMP_HI | RO | latched upper word |
| `0x002C` | SCRATCH | RW | `0` |
| `0x0030` | LED_CTRL | RW | bit0 controls P15 |

All writes honor AXI `WSTRB`. Undefined addresses read as zero and ignore writes.

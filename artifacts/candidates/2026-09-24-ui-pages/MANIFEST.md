# Three-page UI candidate

Status: **candidate; software build, JTAG register checks and UART startup
passed; manual LCD/touch/D1 validation pending**.

This package uses the implementation-verified ready/valid BIT/HDF from
2026-09-23 and a newly rebuilt PS application containing the three-page UI:

- HOME: platform identity, version, capabilities, capture and loss summary.
- SELF TEST: PL ID, version, AXI scratch, GT911, snapshot and drop checks.
- EVENTS: eight snapshot rows with trigger highlighting.
- Persistent bottom navigation and D1 LED toggle on all pages.

| File | Bytes | SHA-256 |
|---|---:|---|
| `multi_protocol_bd_wrapper.bit` | 4,045,685 | `2A0430F522A5690D7C76216AE8EC9D22262875A16D43C26AFB54E0B45FF18331` |
| `multi_protocol_bd_wrapper.hdf` | 377,958 | `A01290D1FE8B0E375A3B4A132458F6F5BF301E4583EF0BFF9A2F35F013E090D7` |
| `platform_app.elf` | 801,768 | `D84C6D7B97C1039BF74A44B95304151F846F2A7D2E31CC78FEC1EEC0935093A8` |
| `ps7_init.tcl` | 34,511 | `47D35117FE590757D5F887986AE68B1E64F5CDCFC7EEB480825AF9543BF91399` |

PS image size: text 133,108 bytes, data 2,104 bytes, BSS 25,280 bytes.

Do not promote this package to `artifacts/current` until LCD, HOME/SELF
TEST/EVENTS touch navigation, D0, D1, UART and snapshot values pass on the
physical board.

Automated board evidence on 2026-09-24:

- BIT, PS initialization and ELF download completed over JTAG.
- `SYS_ID=0x4D505254`, `VERSION=0x00010002`, `CAPABILITIES=0x00000003`.
- `SCRATCH=0xA5A55A5A`, arbitration count and both drop counts are zero.
- Snapshot ID 1, count 25, trigger index 8.
- UART reported `TOUCH READY`, `CAPTURE READY` and `UI READY`.

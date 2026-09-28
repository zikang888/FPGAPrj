# STM32F407 to Zynq SPI first-link contract

This is a handoff for member B's first transmit-only test, not a claim that
STM32 firmware or physical interoperability is complete. The FPGA is a
passive observer of the STM32-to-external-W25Q128 bus.

## Connect the three devices

Use 3.3 V logic and connect STM32, flash module and Zynq grounds together
before signal wiring. Power the flash module according to its board rating;
do not use an FPGA signal pin as a power supply. Connect the FPGA in parallel,
not between the STM32 and the flash:

| Bus net | STM32F407 SPI1 | External W25Q128 | AC820 P7 / Zynq |
|---|---|---|---|
| SCLK | PA5 | CLK | P7-1 / U12 |
| CS_N | B-selected GPIO | CS_N | P7-2 / U11 |
| MOSI | PA7 | DI | P7-3 / U10 |
| MISO | PA6 | DO | P7-4 / U9 |

Member B must identify the actual CS GPIO and check whether the STM32 board's
own flash shares it. Do not select two flash chips at once. Keep the external
flash WP and HOLD inactive (high) according to its module wiring. All four
Zynq pins are inputs; no signal should be driven from the FPGA into the bus.
Confirm the P7 physical pin numbers against the board silkscreen before
powering on: the resource table and XDC establish U12/U11/U10/U9, while
the pin-number interpretation must match the actual connector orientation.

## Minimal firmware behavior

1. Configure SPI1 master, Mode 0 (CPOL=0, CPHA=0), 8-bit, MSB first. Begin
   at 1 MHz; the current FPGA listener is specified only through 25 MHz.
2. Keep CS high at idle. Call `MemberC_Init()` after CubeMX peripheral
   initialization, then `MemberC_RunSmokeTests()` once. It pulls CS low,
   transfers `9F 00 00 00`, returns CS high, probes the mounted part, and
   compares ten subsequent readings with that first nontrivial ID. JSONL
   records contain `tx` (MOSI) and `data` (actual MISO) with the same `txn`.
   Compare the first observed three-byte ID with the actual mounted part;
   ten matching reads do not prove the correct chip was selected.
3. Repeat the transaction at a slow interval (at least 2 us CS-high gap for
   the initial smoke test). Then try `00`, `FF`, `55`, `AA` patterns if the
   external device/test source can provide known MISO bytes.

Expected FPGA event sequence for one four-byte transaction is START,
four DATA events, END, all with the same transaction ID. Each DATA event
stores MISO in `flags[15:8]` and MOSI in `flags[7:0]`. Normal transactions
do not trigger a snapshot. A deliberately interrupted partial byte produces
FRAME_ERROR (`0x3F`) and can trigger capture; do that only after the basic
byte stream works.

The current PS application displays a cached virtual self-test snapshot,
not an automatically refreshed live SPI stream. A later PS capture-control
step is required to arm, read and show external SPI events. Until that is
implemented, validate the RTL path with the existing simulation and inspect
capture registers over JTAG; do not mistake virtual EVENTS rows for B's data.

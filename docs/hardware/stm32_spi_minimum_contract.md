# STM32F407 to Zynq SPI first-link contract

This is a handoff for the first SPI test, not a claim that STM32 firmware or
physical interoperability is complete. For a verified SkyStar STM32F407VGT6
high-end board, use its populated onboard W25Q128. The FPGA is a passive
observer of that bus. Other board variants require a separate pin review.

## Connect the two boards

Power the two boards separately. Use 3.3 V logic, connect STM32 and Zynq
grounds before signal wiring, and do not connect the two 3V3 power rails.
The populated Flash is already on the STM32 board; connect the FPGA in
parallel, not between the STM32 and Flash:

| Bus net | STM32F407 SPI1 / onboard W25Q128 | SkyStar baseboard P1 (if fitted) | AC820 P7 / Zynq |
|---|---|---|---|
| SCLK | PA5 / CLK | P1-8 | P7-1 / U12 |
| CS_N | PA4 GPIO / CS_N | P1-5 | P7-2 / U11 |
| MOSI | PA7 / DI | P1-10 | P7-3 / U10 |
| MISO | PA6 / DO | P1-7 | P7-4 / U9 |
| GND | GND | P1-39 | GND |

Verify the exact STM32 board and populated Flash before wiring. Do not add an
external Flash in parallel on the same CS: two slaves can drive MISO together.
If the core board is installed on the SkyStar baseboard, check PA4/PA5/PA6/PA7
conflicts with its relay, display SPI clock, buzzer, and Ethernet-related
circuits before enabling the test. All four
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
   the initial smoke test). The `00`, `FF`, `55`, `AA` pattern test requires a
   separate controlled test source; do not send arbitrary writes to Flash.

PA4 must be a GPIO output with software CS, initially high; PA5/PA6/PA7 use
SPI1. The board mapping follows the [official SPI-Flash tutorial](https://wiki.lckfb.com/zh-hans/tkx/tkx-stm32f407vxt6/beginner/spi.html)
and [official SkyStar pinout](https://wiki.lckfb.com/zh-hans/web-tool/fdb-pinout/introduce.html).

Expected FPGA event sequence for one four-byte transaction is START,
four DATA events, END, all with the same transaction ID. Each DATA event
stores MISO in `flags[15:8]` and MOSI in `flags[7:0]`. A `9F` command in the
first MOSI byte triggers the normal JEDEC snapshot. A deliberately interrupted partial byte produces
FRAME_ERROR (`0x3F`) and can trigger capture; do that only after the basic
byte stream works.

The PS source now has a separate live capture path: on EVENTS tap `ARM SPI`,
then start/reset STM32. The page says `WAIT SPI` until the `9F` command and
16 subsequent events freeze a snapshot; it then shows real SPI events and
offers `SHOW DEMO` to return to the cached virtual snapshot. The currently
running older JTAG candidate does **not** include this change. Use only a
newly built matched BIT/HDF/ELF for the live test, and do not mistake the
virtual EVENTS rows for STM32 data.

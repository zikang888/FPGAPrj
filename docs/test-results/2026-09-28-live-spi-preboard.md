# Live SPI pre-board closure (2026-09-28)

## Scope and result

This is a software/FPGA preparation result, **not** a two-board acceptance.
The standalone SkyStar STM32F407VGT6 high-end core board is available but is
not wired to the AC820. The currently running Zynq image is the earlier
A-map virtual-demo candidate, not the new live-SPI candidate. It was only
read through JTAG today; no second download, reset, or boot-media write was
attempted because a previous second-download run reportedly hung on color
blocks.

- STM32 protocol runner compiled with Clang `-std=c99 -Wall -Wextra -Wpedantic
  -Werror`; host fake-platform tests passed. This does not compile the HAL
  adapter or prove actual SPI pins.
- Five Vivado 2018.3 simulations passed after adding `9F` first-byte trigger,
  a non-first-byte `9F` negative case, and a JEDEC-to-frozen-snapshot/re-arm
  test. The testbench now models the AXI core's always-draining event sink.
- Isolated Vivado bitstream and HDF built. WNS +3.118 ns, WHS +0.036 ns,
  TNS/THS 0; DRC: 2 Advisory, 0 Error. LUT 4402, FF 7460, BRAM tiles 5.5,
  DSP 0.
- Matching SDK 2018.3 PS ELF built successfully from the new HDF. On EVENTS,
  `ARM SPI` waits without blocking touch scanning, then displays a separate
  real snapshot; `SHOW DEMO` restores the cached virtual snapshot. The
  original three pages, D1, and pixel scrolling remain in source, but this
  new combined image has not yet been visually checked on the board.
- Read-only JTAG on the running old image found CPU0 Running, PL ID
  `4D505254`, version `00010003`, capabilities `7`, virtual snapshot READY
  with count 25 and trigger index 8, and both drop counters 0. This is not
  evidence of real STM32 traffic.

The matched BIT/HDF/ELF and hashes are in
`candidates/numberA_0928_numberC_p7_A_live_spi/README.md`.

## Unfinished before physical acceptance

No STM32CubeF4 HAL/CubeMX-generated project was available locally, so there
is no F407 `.hex`/`.elf` firmware and no F407 HAL build result. The repository
provides the portable protocol runner, HAL adapter, PA4 board-specific USER
CODE example, and CubeMX configuration checklist. The board's W25Q128
population, P1 header orientation, USART1 logger connection, and actual JEDEC
ID must be checked on the device. No MISO waveform, JSONL-to-PL byte match,
physical LCD/touch/LED observation, or second-download hang diagnosis was
completed for the new candidate.

## Tomorrow's cold-start sequence

1. Confirm F407VGT6 high-end core board and populated onboard W25Q128. No
   SkyStar baseboard or second Flash. Verify physical P1 pin-1 orientation.
2. Generate the minimal STM32CubeMX project: SPI1 PA5/PA6/PA7, Mode 0,
   8-bit MSB-first master at about 1 MHz; PA4 push-pull GPIO/software CS,
   initially high; USART1 PA9/PA10 115200 for independent JSONL. Add
   `stm32_f407/common` and `hal` sources/headers and the USER CODE example.
   Call `MemberC_Init()` after GPIO/SPI/UART initialization, then run
   `MemberC_RunSmokeTests()` on a controlled start/reset.
3. With boards unpowered, join GND first: F407 P1-39 to AC820 GND. Then
   PA4/P1-5 to P7-2 CS_N (U11), PA5/P1-8 to P7-1 SCLK (U12), PA7/P1-10 to
   P7-3 MOSI (U10), PA6/P1-7 to P7-4 MISO (U9). Power the boards separately;
   **do not connect 3V3 rails**. Recheck P7 connector orientation.
4. Cold-boot Zynq and download the **matched new** BIT/HDF/ELF once via JTAG.
   Confirm PL ID, version, 25 virtual self-test events, three UI pages,
   touch scrolling, and D1. Avoid an immediate second download until the
   reported color-block hang is understood.
5. On EVENTS tap `ARM SPI` and confirm `WAIT SPI`. Then reset/start F407.
   Confirm first JSONL `9F000000` TX and actual nontrivial RX/JEDEC ID, then
   ten matching reads. After at least three full transactions, expect `LIVE
   SPI`, protocol 2 rows, command byte `9F`, matching MISO bytes, transaction
   boundaries, and zero PL dropped-event counters. Compare each PL byte with
   the same F407 JSONL transaction, not just with a reference ID.
6. Tap `SHOW DEMO`; confirm virtual rows and touch scrolling return. Recheck
   HOME, SELF TEST and D1. Record photos, UART JSONL, JTAG register dump, and
   any capture or display failure before changing code.

Electrical and pin details: `docs/hardware/spi_board_test.md`.

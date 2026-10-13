# STM32F407 to Zynq SPI passive-monitor test

## JTAG startup order for this integration build

After a full AC820 power cycle, do not read the PL AXI window at
`0x40000000` while the FPGA configuration status is `DONE=0`. In the
2026-10-08 board session, that read timed out and subsequent PS DAP accesses
failed; a controlled cold start without the early AXI read completed
BIT -> `ps7_init` -> ELF successfully. This is a strong diagnosis of the
failure sequence, not proof that no power/JTAG fault can produce the same
symptom. Program the matching
`Multi_protocol.sdk/platform_hw/multi_protocol_bd_wrapper.bit`, run
`Multi_protocol.sdk/platform_hw/ps7_init.tcl`, and then download/run the PS
ELF. Vivado's **Program Device** alone does not start the LCD application.
If an AXI timeout has already occurred, first check `DONE` and enumerate
JTAG without touching AXI; do not repeatedly download into a DAP error.

## Electrical connection

The Zynq PL pins are passive 3.3 V inputs. Connect a common ground before
connecting any signal. Do not connect a 5 V SPI source directly.

This table follows NumberA's 2026-09-28 P7 plan and the integration branch's
current `top.xdc`. The earlier C-only candidate uses P7-38/35/36/33 instead.
Do not mix its BIT with the wiring below.

| STM32F407 signal | Zynq signal | Zynq package pin | Direction at Zynq |
|---|---|---|---|
| GND | GND | board ground | reference |
| Flash CS GPIO (same net as flash CS) | SPI_CS_N / P7-2 | U11 | input |
| SPI1 SCK / PA5 | SPI_SCLK / P7-1 | U12 | input |
| SPI1 MOSI / PA7 | SPI_MOSI / P7-3 | U10 | input |
| SPI1 MISO / PA6 (same net as flash DO) | SPI_MISO / P7-4 | U9 | input |

The current two-board setup uses the populated W25Q128 on the standalone
SkyStar STM32F407VGT6 core board, not a second external Flash module. PA4 is
the shared onboard Flash CS net. The FPGA is a high-impedance listener and
never drives MISO. Both boards are powered independently and share only ground
and the four SPI monitor signals; never tie their 3V3 rails together. An
alternative external slave requires a separately reviewed wiring plan.

The PL applies a four-sample CS stability filter after the two-flop
synchronizer. This rejects short ringing/crosstalk pulses on the board-to-board
CS lead without changing the sampled SPI data. The RTL regression contains an
explicit 20 ns CS-high disturbance in the middle of a byte.

## STM32F407 generator requirements

- SPI master, Mode 0: CPOL=0 and CPHA=0.
- MSB first, 8-bit data frames.
- SCLK at or below 25 MHz; start at 1 MHz for the first board test.
- NSS must remain low for the complete transaction and return high between
  transactions.
- Use 3.3 V I/O and a shared ground.
- First golden transaction: MOSI `9F 00 00 00`. Log the actual four MISO
  bytes; the three response bytes after the command should match the mounted
  flash's JEDEC ID, not an assumed value.
- For a controlled test source (rather than the W25Q128), repeat a known byte
  pattern so the captured event order can be checked.
- Generate one deliberate residual frame by raising NSS after four SCLK rising
  edges. This must create event type `0x3F` and assert the snapshot trigger.
- Leave at least 2 us between transactions during the first smoke test.

## Expected FPGA behavior

1. Arm capture through the existing PS application.
2. Normal SPI transactions appear in the existing event list as START, DATA,
   and END events with protocol id 2 and a shared transaction id.
3. The virtual-event screen self-test remains available and shares the same
   arbiter and snapshot buffer.
4. A four-bit residual frame creates a triggered snapshot; the flags field
   reports the residual bit count.
5. `REG_EXT_DROPPED_COUNT` remains zero in the normal smoke test. A non-zero
   value means the event consumer was backpressured long enough to lose a new
   SPI event.

## Second-week 100-transaction acceptance

With XSCT connected to the Zynq, clear the PL counters before starting STM32
traffic:

```tcl
set SPI_STATS_ACTION clear
source fpga/build/zynq_spi_stats.tcl
```

Run `spi jedec 100` on the STM32. Then read and automatically check the PL
result:

```tcl
set SPI_STATS_ACTION check
set SPI_EXPECTED_TRANSACTIONS 100
source fpga/build/zynq_spi_stats.tcl
```

The acceptance result is `SPI_ACCEPTANCE_PASS`, with `events=600`,
`starts=100`, `data=400`, `ends=100`, and every error/drop counter equal to
zero. Save the STM32 UART log and the logic-analyzer export from this same run;
do not compare results from different runs.

The SPI statistics `dropped` field is the external-event loss counter. The
snapshot register `DROPPED_COUNT` has different semantics: it also counts
events arriving after a one-transaction snapshot has already frozen. A
multi-transaction command can therefore produce a nonzero snapshot drop count
while the SPI global statistics still report all transactions with zero loss.

Member A delivers the listener, unique event path, frozen pin map and these PL
counters. Rendering the live transaction on the LCD is the PS/UI integration
owned by member C.

## Scope and safety

This phase only observes Mode-0 traffic. It does not inject faults, emulate a
slave, or decode command-specific fields. Those functions require a separate
electrical and architectural review.

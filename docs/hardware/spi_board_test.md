# STM32F407 to Zynq SPI passive-monitor test

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

The FPGA is a high-impedance listener connected in parallel with the STM32
master and the external W25Q128 module; it never drives MISO. For a two-board
smoke test without a real SPI slave, use a separate test output for MISO and
never connect two push-pull outputs together. If a board-mounted flash shares
the proposed CS GPIO, select another GPIO or isolate that flash first.

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

## Scope and safety

This phase only observes Mode-0 traffic. It does not inject faults, emulate a
slave, or decode command-specific fields. Those functions require a separate
electrical and architectural review.

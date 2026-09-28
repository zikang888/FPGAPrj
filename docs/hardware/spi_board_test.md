# STM32F407 to Zynq SPI passive-monitor test

## Electrical connection

The Zynq PL pins are passive 3.3 V inputs. Connect a common ground before
connecting any signal. Do not connect a 5 V SPI source directly.

This table is the current NumberC wiring, retained for the isolated A+C
integration build. NumberA's 2026-09-28 update instead assigns
CS/SCLK/MOSI/MISO to FPGA U11/U12/U10/U9 (AC820 P7-2/1/3/4).
Do not move wires or program a new bitstream until the team's actual
STM32-to-P7 wiring is confirmed against the selected `top.xdc`.

| STM32F407 signal | Zynq signal | Zynq package pin | Direction at Zynq |
|---|---|---|---|
| GND | GND | board ground | reference |
| SPI_NSS / GPIO chip select | SPI_CS_N | AA8 | input |
| SPI_SCK | SPI_SCLK | AB10 | input |
| SPI_MOSI | SPI_MOSI | AB9 | input |
| SPI_MISO or loopback/test source | SPI_MISO | AA7 | input |

The monitor does not drive MISO. For a two-board smoke test without a real SPI
slave, configure a second STM32 GPIO or peripheral output to generate the MISO
test waveform. Never connect two push-pull outputs together.

## STM32F407 generator requirements

- SPI master, Mode 0: CPOL=0 and CPHA=0.
- MSB first, 8-bit data frames.
- SCLK at or below 25 MHz; start at 1 MHz for the first board test.
- NSS must remain low for the complete transaction and return high between
  transactions.
- Use 3.3 V I/O and a shared ground.
- First golden transaction: MOSI `9F`, with MISO test bytes `EF 40 18` when a
  controlled slave/test source is available.
- Repeat a deterministic counter transaction, for example MOSI `00` through
  `FF`, so the captured event order can be checked.
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

# STM32F407 to Zynq SPI passive-monitor test

This connection applies only after confirming that the STM32 board is the
SkyStar F407VGT6 high-end core board with its SPI1 W25Q128 populated. Its
onboard Flash uses PA4/PA5/PA6/PA7; no external Flash is needed. The SkyStar
baseboard also has a separate SPI2 Flash and other peripherals, so do not
confuse that device or its PE4 CS with the core-board SPI1 Flash.

## Electrical connection

The Zynq PL pins are passive 3.3 V inputs. Power each board from its own
normal supply, connect a common ground before the signals, and do not join
their 3V3 power rails. Do not connect a 5 V SPI source directly.

This table follows NumberA's 2026-09-28 P7 plan and the integration branch's
current `top.xdc`. The earlier C-only candidate uses P7-38/35/36/33 instead.
Do not mix its BIT with the wiring below.

| STM32F407 core-board signal | P1 header number | Zynq signal | Zynq package pin |
|---|---|---|---|
| GND | Use a `GND`-labelled hole; see back-view note below | GND | board ground |
| Flash CS / PA4 GPIO output | P1-5 | SPI_CS_N / P7-2 | U11 input |
| SPI1 SCK / PA5 | P1-8 | SPI_SCLK / P7-1 | U12 input |
| SPI1 MOSI / PA7 | P1-10 | SPI_MOSI / P7-3 | U10 input |
| SPI1 MISO / PA6 (Flash DO) | P1-7 | SPI_MISO / P7-4 | U9 input |

The user's photo is a **back-side view with the USB connector at the
bottom**. On its right-hand two-column header, count rows downward from the
top `REF | A02` row. Connect by the printed GPIO name first:

| Printed row | Inner/left hole | Outer/right hole | Use |
|---|---|---|---|
| Third, `A03 | A04` | A03 | **A04 (PA4)** | CS_N |
| Fourth, `A05 | A06` | **A05 (PA5)** | **A06 (PA6)** | SCLK / MISO |
| Fifth, `A07 | C04` | **A07 (PA7)** | C04 | MOSI |

For ground, use a hole printed `GND`, for example the **inner/right hole**
of either bottom `3V3 | GND` or `5V0 | GND` row on the photo's left header.
These left-header ground holes are not the right-header `P1-39` position; they
are electrically suitable GND points. Do not use the adjacent 3V3/5V0 holes.
The signal P1 numbers above follow the mating-header pin map;
the core-board back silk gives the safer physical identification. Verify the
AC820 P7 orientation separately because the F407 back view cannot establish
which physical end of P7 is pin 1.

The FPGA is a high-impedance listener connected in parallel with the STM32
master and its onboard W25Q128; it never drives MISO. Do not parallel a
second Flash on the same CS, because both slaves may drive MISO. For a two-board
smoke test without a real SPI slave, use a separate test output for MISO and
never connect two push-pull outputs together. If the
core board is installed on the SkyStar baseboard, first check that PA4 relay,
PA5 display clock, PA6 buzzer and PA7 Ethernet-related circuitry are inactive
or electrically compatible. Confirm P1/P7 connector orientation on the actual
boards before attaching wires.

## STM32F407 generator requirements

- SPI master, Mode 0: CPOL=0 and CPHA=0.
- MSB first, 8-bit data frames.
- SCLK at or below 25 MHz; start at 1 MHz for the first board test.
- PA4 must be a GPIO output, initially high, with software CS. NSS must remain
  low for the complete transaction and return high between transactions.
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

1. Boot the matched BIT/HDF/ELF once after a cold power-up. On the EVENTS
   page tap `ARM SPI`; it changes to `WAIT SPI`. Then reset/start the STM32
   generator so the first JEDEC transaction occurs after arming.
2. Normal SPI transactions appear in the existing event list as START, DATA,
   and END events with protocol id 2 and a shared transaction id.
3. The first MOSI `9F` command byte is the normal trigger. The snapshot
   freezes after 16 further events (three four-byte JEDEC transactions are
   sufficient). The button then changes to `SHOW DEMO`; tap it to restore
   the cached virtual-event display. SELF TEST remains virtual throughout.
4. A four-bit residual frame also creates a triggered snapshot; the flags field
   reports the residual bit count.
5. `REG_EXT_DROPPED_COUNT` remains zero in the normal smoke test. A non-zero
   value means the event consumer was backpressured long enough to lose a new
   SPI event.

## Scope and safety

This phase only observes Mode-0 traffic. It does not inject faults, emulate a
slave, or decode command-specific fields. Those functions require a separate
electrical and architectural review.

References: [official SkyStar SPI-Flash tutorial](https://wiki.lckfb.com/zh-hans/tkx/tkx-stm32f407vxt6/beginner/spi.html) and
[official SkyStar P1/baseboard pinout](https://wiki.lckfb.com/zh-hans/web-tool/fdb-pinout/introduce.html).

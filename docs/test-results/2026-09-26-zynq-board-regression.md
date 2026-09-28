# Zynq-7020 standalone board regression

Date: 2026-09-26

Branch: `test/fpga_NumberC-spi-board` at baseline commit `4d00be2`

## Scope and image identity

The STM32F407 stimulus board was unavailable. This run validates the Zynq
board, the new SPI-integrated PL image, the PS application, and the existing
virtual-event path. It does not validate electrical SPI ingress from STM32.

The previously present `Multi_protocol.sdk/platform_app/Debug/platform_app.elf`
was older than the current `software/src/capture_demo.c` and
`software/src/platform_ui.c`; it was not accepted as the software regression
image. The current sources were rebuilt with SDK 2018.3 from the new HDF in an
isolated SDK workspace, without deleting the existing SDK project. The build
reported `PS_BUILD_DONE` and compiled `capture_demo.c`, `main.c`,
`platform_ui.c`, `ps_gpio.c`, `ps_iic.c`, and `touch.c`.

| Image | Path | SHA-256 |
| --- | --- | --- |
| PL BIT | `Multi_protocol.runs/impl_1/multi_protocol_bd_wrapper.bit` | `73A02DCD6A723C9889EE26DA07EDED82B879B287ECDF953AA2C0B9C65D5D1F00` |
| PS ELF | `artifacts/zynq-board-test-sdk-20260926/platform_app/Debug/platform_app.elf` | `921296BE6F2738C76206AD020BC3F60A68847FF8B64CA747FBFF3F1DD451E970` |

The application was loaded over JTAG only; no boot Flash was written. The
test script is `fpga/build/zynq_jtag_board_test.tcl`, with `ZYNQ_TEST_ELF`
pointing to the newly built ELF.

## Automated and serial results

- JTAG identified `Digilent JTAG-SMT2 B1777481ABCD` and `xc7z020`.
- BIT download, PS initialization, and ELF download completed.
- PL system ID `0x4D505254`, version `0x00010002`, capabilities `0x00000003`.
- AXI scratch `0xA5A55A5A`; arbitration count and both drop counters were zero.
- Capture status `0x00000002` (READY), snapshot ID 1, event count 25,
  trigger index 8. Snapshot event word 0 at indices 8 and 24 read as
  `0x00000008` and `0x00000018`.
- COM10 at 115200 baud reported `PS READY`, `PL ID OK`, `SCRATCH OK`,
  `TOUCH READY`, `CAPTURE READY: id=1 count=25 trigger=8 dropped=0`, and
  `UI READY`.
- The compiled source contains `animate_events_scroll` and gesture thresholds
  for `EVENTS_NEXT` / `EVENTS_PREVIOUS`. This establishes source inclusion,
  not physical screen or gesture behavior.

An initial run with the older ELF showed count 25 but READY cleared; the
current source intentionally retains READY for event-window reads. The first
new-ELF run returned zero for scratch and snapshot registers; the cause of
that transient was not conclusively established. Subsequent runs with the
same new ELF produced the complete readback and UART results above.

## Manual checks still pending

- Inspect HOME, SELF TEST, and EVENTS pages on the physical LCD for layout.
- Swipe the EVENTS list in both directions and confirm it can show the full
  0–24 virtual-event range and highlight trigger event 8.
- Check D0 heartbeat and D1 touch-controlled LED on the physical board.
- When STM32F407 is available, run the real SPI Mode-0 and residual-frame
  fault stimulus described in `docs/hardware/spi_board_test.md`.

Until these checks are performed, this is a Zynq JTAG/register/UART pass, not
an end-to-end physical UI or SPI board pass.

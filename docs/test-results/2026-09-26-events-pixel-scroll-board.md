# EVENTS pixel-scroll Zynq regression

Date: 2026-09-26

Branch: `test/fpga_NumberC-spi-board`; baseline commit `4d00be2`.

## Scope and authoritative image

This is the Zynq-only regression for the production EVENTS interaction.
The previous release-only action (`EVENTS_NEXT/PREVIOUS`, fixed 6-row jump and
12 synchronous transition frames) was removed. The production path now uses
the frozen 256-entry snapshot copied once into a 4 KiB PS cache and a
pixel-valued scroll offset. A held finger changes the offset on each GT911
sample; reverse motion follows immediately; the offset is clamped to the
first/last valid pixel. No row snapping or release-only page jump is used.

The UI requests at most one frame per main-loop pass. Pending touch movement
coalesces to the latest offset while the previously displayed VDMA frame
settles. Its 34 ms conservative buffer-settle interval is now non-blocking to
touch scans. During a drag only the EVENTS list region (rows 122–407) is
redrawn/flushed/copied; a full page render refreshes chrome on release or
navigation. HOME, SELF TEST, D1 control, virtual capture and SPI PL ingress
remain in the same application/bitstream path.

Final images loaded over JTAG, without writing boot Flash:

| Image | Path | SHA-256 |
| --- | --- | --- |
| PL BIT | `Multi_protocol.runs/impl_1/multi_protocol_bd_wrapper.bit` | `73A02DCD6A723C9889EE26DA07EDED82B879B287ECDF953AA2C0B9C65D5D1F00` |
| PS ELF | `artifacts/zynq-pixel-scroll-final-sdk-20260926/platform_app/Debug/platform_app.elf` | `89CC3E8F9B17718EDFCFB9C7A286975DD6281FDCDDFACACC7F195D3EBDF12861` |

The existing `Multi_protocol.sdk/platform_app/Debug/platform_app.elf` is stale
and is not the pixel-scroll image. `fpga/build/zynq_jtag_board_test.tcl`
requires `ZYNQ_TEST_ELF` explicitly to prevent silently loading it.

## Baseline timing, measured on Zynq

One temporary measurement build timed the old path at startup using the PS
global timer. These are observed measurements, not assumed estimates:

| Operation | Measured time |
| --- | ---: |
| GT911 idle scan, average of 32 | 128 us |
| AXI read of 8 events, average of 16 | 6 us |
| HOME page drawing | 2,884 us |
| Full-frame cache flush | 1,694–1,763 us |
| VDMA park command | 1–2 us |
| Fixed wait per frame | 34,000 us |
| Full 1,152,000-byte framebuffer copy | 3,420–3,421 us |

The old 12-frame animation therefore spent at least 408 ms in fixed sleeps,
with no GT911 scans during that synchronous call. The measurement probes were
removed from the final source after the baseline run.

## Automated and board evidence

- Vivado-bundled Clang compiled and ran `software/tests/pixel_scroll_test.c`
  with `-Wall -Wextra -Werror`; result: `pixel_scroll_test PASS`.
  Cases cover sub-row 5 px movement, immediate reversal, long drag across
  rows, both boundaries, repeated gesture, empty/short lists, and 256 events.
- SDK 2018.3 rebuilt current `software/src` from the exported HDF in a new
  isolated workspace; `PS_BUILD_DONE`, ELF text 111,604 bytes, data 2,104,
  BSS 29,696. No older SDK application project was overwritten.
- The JTAG script now performs `rst -system` before PL configuration and PS
  initialization. Two consecutive downloads of the final BIT/ELF completed;
  each returned ID `0x4D505254`, version `0x00010002`, capabilities `0x3`,
  scratch `0xA5A55A5A`, capture READY `0x2`, snapshot ID 1, count 25,
  trigger index 8, and zero arbitration/external/core drops. Event indices
  8 and 24 read back as `0x8` and `0x18` in word 0.
- On the second download, COM10 at 115200 baud reported `TOUCH READY`,
  `CAPTURE READY: id=1 count=25 trigger=8 dropped=0`,
  `EVENT CACHE READY: count=25`, and `UI READY`.
- The D1 AXI `LED_CTRL` register read 0, accepted a write/read of 1, and was
  restored to 0 before the PS resumed. The PL timestamp register advanced
  during the same probe. This checks the control path, not the visible LED.
- The user reported on the physical LCD that the scrolling feel is fixed and
  acceptable. This is the human screen/gesture acceptance for the pixel-scroll
  build. The final ELF was rebuilt after extracting identical scroll math into
  a tested header and was then downloaded and electrically regressed; there
  was no separate human observation of that final re-download.

The user also reported a manual power-off during one earlier interrupted
observation; that result is not treated as a software startup failure. The
reported second-download color-block hang did not reproduce in the two
consecutive clean-reset downloads. The previous no-reset sequence is retained
only as historical diagnostic evidence, not as the supported reload path.

## Still open

- Physical D0 heartbeat and visible D1 LED behavior were not observed by the
  automation. Their RTL/AXI paths remain present.
- No automated hardware injection of GT911 coordinates was performed. The
  host test checks scroll math; it is not a substitute for physical touch.
- STM32F407 was absent. Real SPI Mode-0 traffic and residual-frame fault
  capture across the two boards remain to be validated using
  `docs/hardware/spi_board_test.md`.
- No branch merge, push, or overwrite of teammates' work was performed.

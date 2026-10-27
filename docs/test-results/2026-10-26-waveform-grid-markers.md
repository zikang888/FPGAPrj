# 2026-10-26 HOME grid and fault markers

## Scope and version

PS renderer only (`software/src/platform_ui.c`); RTL, BIT and HDF unchanged.
Matched BIT/HDF/init are the `releases/ui-workflow-20261024` set.
The updated ELF is built in `build/ui-workflow-20261023/sdk/platform_app/Debug`.
Exact collected versions and SHA256 hashes are preserved with the evidence,
rather than overwriting the 2026-10-24 release manifest.

## Visible behavior

- Plot spans approximately 608 pixels of an 800-pixel LCD, about 76% width.
- Dashed grid, binary 0/1 lane references, colored lane labels, decoded-bit ticks.
- Axis is BIT INDEX, not microseconds: decoder events do not contain raw sampled
  per-bit timing. CAN view is payload bits only, excluding stuffing/CRC fields.
- UART BAD STOP: highlighted decoded STOP cell and exclamation mark.
- I2C NACK: highlighted ninth bit; prefer the transaction carrying the NACK,
  avoiding the normal address probe that precedes the injected wrong address.
- Faults without a complete decoded waveform show the fault name and explain
  that bit positions/levels were not sampled. No missing electrical waveform is
  synthesized. Error details remain in ERRORS and event times in EVENTS.
- No input, protocol-event generation, capture counter or navigation changes.

## Checks and real hardware results

12 host checks and the production renderer/touch regression passed after the
final correction. ARM SDK 2018.3 GCC build and matched-ABI ELF download passed.
Live framebuffers were read without CPU halt/reset for screenshot collection.

Hardware injection and screenshots cover SPI partial/short/extra, UART bad stop/
break, I2C address NACK/missing STOP, CAN stuff/CRC/form. These are actual board
frames; external logic-analyzer comparison was not performed in this run.
CAN CRC/stuff injections also produced NO ACK, so total errors need not equal
the number of injections.

Normal SPI: JEDEC matched, 6 events / 0 errors. UART: FPGA RX 10 events / 0 errors,
but STM32 loopback timed out (no TX echo); not an end-to-end loopback pass.
I2C: EEPROM_RW failed with nack_or_mismatch; not a successful read/write claim.
CAN: initial capture had 24 events / 4 errors despite STM32 matching. Two final
normal repeats each matched and captured 20 events / 0 errors. Initial discrepancy
is retained and has not been root-caused; do not claim this change fixed CAN RTL.

The final additional SPI JEDEC attempt after fault injections returned FFFFFFFF,
STM32 result=-4 and FPGA 6 events / 1 error. Final UI correctly displayed BAD ID.
It is preserved as an extra failure illustration, not a normal baseline pass.
Whether STM32 pin/peripheral state recovery caused this is unverified.

## Evidence location on this PC

`C:/Users/11914/Documents/Codex/2026-09-22/wo/board_validation/evidence-20261026/`

`README.md`: case index, commands and raw results.
`deliverables/`: selected PNGs and source mapping; `lcd-evidence-20261026.zip`.
`tested-files/`: grid-first-version ELF and original hash list.
`tested-files-markers-v2/`: final marker ELF, renderer source and hashes.

Earlier captures are retained with their original names, including the first I2C
marker version that showed the preceding ACK transaction. Use `*-marker-v2` for
the corrected fault-location illustrations. Actual photos of the physical LCD
and independent logic-analyzer comparison remain pending.

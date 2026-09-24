# NumberC UI integration validation

## Branch model

- Baseline/rollback branch: `fpga_NumberC`, created from `origin/fpga_main`
  commit `bfcd929`.
- Active test branch: `test/fpga_NumberC-ui-integration`.
- Teammate branch `fpga_NumberA` was not modified. At fetch time,
  `origin/fpga_NumberA` and `origin/fpga_main` both pointed to `bfcd929`.

## Integration scope

The repository main branch and the validated local project have identical RTL,
constraints and FPGA build scripts. Integration therefore changes only the PS
business sources below and does not overwrite the Vivado project or generated
hardware files:

- `software/src/capture_demo.c`
- `software/src/capture_demo.h`
- `software/src/main.c`
- `software/src/platform_ui.c`
- `software/src/platform_ui.h`

The migrated functions include the three-page instrument UI, D1 control,
frozen event-window rereads and the experimental EVENTS scrolling interaction.

## Build evidence

SDK 2018.3 rebuilt the application from the repository worktree with `-Wall
-O3`. All application sources compiled and linked successfully.

- text: 119,684 bytes
- data: 2,104 bytes
- BSS: 25,520 bytes

## Repository-hardware JTAG evidence

The board was programmed with the BIT and HDF stored on `fpga_main`, followed
by the ELF built from the NumberC test branch. Automated readback returned:

- `SYS_ID=0x4D505254`
- `VERSION=0x00010002`
- `CAPABILITIES=0x00000003`
- `SCRATCH=0xA5A55A5A`
- `CAPTURE_STATUS=0x00000002`
- snapshot ID 1, count 25, trigger index 8
- arbitration, external-drop and capture-drop counters all zero

This proves that the migrated PS code matches the repository hardware baseline.

## Physical acceptance

After the repository BIT/HDF and NumberC test ELF were loaded together, the
EVENTS page was opened on the physical 800x480 touch display.  Vertical swipe
operation was confirmed to move through the frozen event list.  The physical
scroll gate therefore passed, allowing the test branch to be merged into
`fpga_NumberC`.

# UART RX board-tested JTAG release (2026-10-18)

This is the exact version tested on AC820/Zynq-7020 after merging
`origin/fpga_uart` into the C integration branch. It is for volatile JTAG
download only. QSPI boot was not changed or validated.

## Matched files

| File | Path from repository root | SHA-256 |
|---|---|---|
| PL BIT | `Multi_protocol.sdk/platform_hw/multi_protocol_bd_wrapper.bit` | `3F23632A40125750DC0D08CEB6165646BCE12B6DCDA5DEBE8219C317ACBF3066` |
| HDF | `Multi_protocol.sdk/platform_hw/system.hdf` | `2871B20CA74E55A97B05189EFE9F503795ABEABFC552648544DE47C2AE55235F` |
| PS init | `Multi_protocol.sdk/platform_hw/ps7_init.tcl` | `47D35117FE590757D5F887986AE68B1E64F5CDCFC7EEB480825AF9543BF91399` |
| PS ELF | `releases/uart-20261018/platform_app.elf` | `C67FDC4F30716E4F69ADD31DCFDA1C787E5DC56DECC1464F0392FD6ED5EC010E` |

Use all four as one set. The default build/SDK output path may contain a
different ELF; do not substitute it by filename alone.

## Download with XSCT 2018.3 (PowerShell)

From the repository root, with the board powered and its JTAG connected:

```powershell
$env:PROCESSOR_ARCHITECTURE = 'AMD64'
$env:ZYNQ_TEST_ELF = (Resolve-Path 'releases/uart-20261018/platform_app.elf').Path
$env:ZYNQ_PREFLIGHT_ONLY = '1'
& 'D:\Vivado2018.3\SDK\2018.3\bin\xsct.bat' 'fpga/build/zynq_jtag_board_test.tcl'
# Require ZYNQ_JTAG_PREFLIGHT_DONE, then download:
Remove-Item Env:ZYNQ_PREFLIGHT_ONLY
& 'D:\Vivado2018.3\SDK\2018.3\bin\xsct.bat' 'fpga/build/zynq_jtag_board_test.tcl'
# Require ZYNQ_JTAG_BOARD_TEST_DONE.
```

This script selects the tracked BIT and PS init by default and reads back
SYS_ID, VERSION and CAPABILITIES. Expected VERSION is `0x00010006`; expected
CAPABILITIES is `0x0000003F` (SPI plus UART RX). If `D:\Vivado2018.3` is not
the local installation path, substitute the actual `xsct.bat` path only.

## Hardware scope

- UART: STM32F407 USART3 TX PD8 to FPGA W5; both boards share ground and
  use 3.3 V logic. FPGA AA9 is idle-high and does not provide echo.
- SPI: existing verified W25Q128 JEDEC wiring remains unchanged.
- I2C and CAN may be wired but are not active FPGA listeners in this release.
- For test data and LCD screenshots, see
  `docs/test-results/2026-10-18-uart-merge-board.md`.

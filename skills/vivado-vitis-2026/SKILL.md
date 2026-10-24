---
name: vivado-vitis-2026
description: Migrate and test Vivado/Vitis 2026.1 Zynq-7000 projects on Windows, including isolated PL builds, SDT standalone software, matched artifacts and JTAG board validation. Use for SDK 2018.3 migration or 2026.1 board bring-up.
---

# Vivado / Vitis 2026.1

Use installed 2026.1 tools explicitly; preserve the user's legacy installation and source project. Put regenerated XPR/BD/IP, BIT/XSA, BSP/ELF and logs in a separate build directory. Check the source revision and existing work before changing anything.

## Migration decisions

- Inspect the actual IP catalog before choosing versions. In the verified ACZ702 migration, VTC 6.2 replaced 6.1; preserve Custom 800x480 parameters. Compare normalized PS7 DDR, MIO, voltage and clock settings against the original BD. Derived clock values may be recalculated: the verified pixel clock was 32.727272 MHz.
- Export a fixed XSA with include_bit. Verify its embedded BIT equals the standalone BIT. Use matching PS initialization, XSA and ELF; do not combine historical SDK ELF/HDF with new hardware implicitly.
- Vitis 2026.1 removed XSCT project management. Use its Python API for platform/application builds and XSDB for target debug. Inspect installed APIs and generated BSP instead of inventing replacement commands.
- For SDT builds, LookupConfig generally takes the generated peripheral base address. Inspect driver signatures. GPIO interrupts need the generated interrupt ID, parent and wrapper; use xiltimer.h for the SDT time source. Keep legacy Device ID support conditional if supporting both versions.
- Inspect xil_printf's format implementation as well as C types. The verified 2026.1 Cortex-A9 BSP enables SUPPORT_64BIT_PRINT and consumes a 64-bit argument for a single `l`. Legacy `%lu` with a 32-bit unsigned long corrupts log values and subsequent arguments. For 32-bit fields use `%u`/`%08x` with unsigned int; do not apply this change indiscriminately to standard printf/snprintf. Recheck actual UART output after rebuilding.
- Reserve framebuffer DDR separately from ELF LOAD segments, heap and stack. In the local project, the application uses the first 16 MiB from 0x00100000 and framebuffers start at 0x01100000 and 0x01220000. Verify actual ELF segments after linking.
- On this 16 GB Windows machine, two synthesis jobs and four tool threads were verified. The Vitis Python client can leave its Java service behind; clean only the service tree created by the current invocation, not unrelated processes.

## Board validation

Read [the local project reference](references/fpga-mucprj.md) when working in D:/FPGA_MUCPrj. Re-enumerate COM ports and JTAG targets each session; historical port numbers are not identities. The STM32 `help` response identifies its console.

When board testing is authorized, verify candidate hashes and a single intended Zynq target before volatile BIT/PS/ELF loading. Keep Flash/SD writes outside a JTAG-only test unless requested. Save raw logs, command responses, hardware counters and any framebuffer evidence. Failures and timeouts are evidence, not passes.

On this machine, both 2026.1 Vitis and Vivado hw_server accepted a connection but stalled on target enumeration. The same 2026.1 XSDB client immediately discovered the cable and CPU through a separately started 2018.3 hw_server and successfully loaded 2026.1 BIT/XSA/ELF. This is a verified local fallback, not a general recommendation or proof that 2026.1 hw_server works. Check for a newer recorded resolution before repeating it. Stop only server/client processes created by the current task. Use an external process timeout: a Tcl `after` watchdog did not interrupt the native enumeration stall.

Do not run multiple hardware servers against the same cable concurrently; it can make target discovery transiently empty. Require an explicit final completion marker in XSDB output: an uncaught Tcl error was observed with process exit code zero.

Validate platform ID/version/build/capabilities, scratch read/write with restoration, a progressing timestamp, and the running application. Then check VDMA/frames, touch initialization and actual touch input, protocol traffic and session/history lifecycle. Distinguish framebuffer rendering and touch initialization from physical display/touch acceptance.

For a clean SPI acceptance window, start an active matching capture before clearing counters and issuing traffic: HOME freezes after 20 ms of silence, and manual capture gating affects statistics. Check 100 four-byte JEDEC transfers against START=100, DATA=400, END=100, EVENT=600 and zero parser/semantic errors. Retention of the last 256 events is separate from full counters.

Report internal timing and external interface constraints separately. The local offline build retained LCD/CAN TIMING-18 warnings because output delays lacked verified board/device budgets. Do not eliminate them with invented constraints. UART RX-only behavior, EEPROM NACK and CAN error events are existing baseline limitations to compare, not automatic migration regressions.

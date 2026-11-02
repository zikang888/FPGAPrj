# Latest-source migration, 2026-11-02

The latest FPGA source selected on this date was branch `codex/ui-four-protocol-20261023`, commit `c5f44ff57ff1b551ba32569f4a2103a1b1cf35be`, dated 2026-11-01 15:59:12 +08:00. It descends from `fix/fpga_pl` / `14cafba` and includes the Chinese workbench, saved-error replay and retained abnormal transactions. The repository default `STM32_control_board` is a different subsystem. Check the remote again before treating this historical selection as current.

Source: D:/FPGA_MUCPrj/migration_work/FPGAPrj_2026_1_latest_20261102.
Outputs: D:/FPGA_MUCPrj/migration_build/2026.1-latest-20261102.
The earlier migration and its 2026.1 build directory are preserved.

## Non-obvious changes

- The PS source now uses `ui_a_views.inc` and `saved_waveform_views.inc`. Vitis file import and compiled-source verification must include `.inc` in addition to `.c/.h`.
- The production ABI is VERSION 0x00010009 and CAPABILITIES 0x000003FF. The baseline AXI testbench still expected 1.8/0x1FF; update those exact ABI assertions, not the production register values or other assertions.
- A new `error_retention_tb.sv` existed upstream without being invoked by the eight-test runner. Add it to the runner and preserve a separate log. All nine tests passed in the new 2026.1 run, including each protocol's 1000-transaction early-error retention cases.
- The 16 base host checks, saved-error replay and production UI/touch-action regression passed. The generated UI images are host previews, not hardware evidence.
- Formal TESTS counts normal traffic but only archives abnormal transactions; its 256-event limit retains old errors when full. A clean SPI 100-transfer run can have 600 total events and zero saved abnormal events. Single capture still provides normal decoded traces.
- EEPROM busy NACK is INFO and is excluded from the abnormal archive. Do not restore retired parity/baud/bus-off UI entries during migration.

No JTAG or USB board serial ports were present in this session. Prior 2026-10-24 manual confirmation and upstream 2018.3 board reports do not validate this new 2026.1 image. Consult README_MIGRATION_2026_1.md and docs/test-results/2026-11-02-latest-vivado-2026.1-migration.md in the new source, plus generated verification.json, for final build status and board limitations.

The completed offline build produced BIT/include_bit XSA, BSP, Hello World, application ELF and FSBL. Internal WNS=0.738 ns, WHS=0.026 ns, TNS/THS=0; CDC reported 87 safe endpoints and bus-skew minimum slack 9.301 ns. PS7 parameters matched the latest baseline. External LCD/CAN timing budgets remain open (20 TIMING-18 warnings). Use tools/package_latest_2026_1.py to gate matched artifacts, including compiled `.inc` copies, and preserve the old source/build directories.

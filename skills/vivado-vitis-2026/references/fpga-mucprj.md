# Local project reference

Verified offline migration on 2026-10-24; consult newer board records before assuming live state.

- Workspace: D:/FPGA_MUCPrj.
- Source: migration_work/FPGAPrj_2026_1, branch migration/vivado-vitis-2026.1; offline commit 4af5be5a466bb55796a8873c7d124b38bb884fce.
- Fixed original source: migration_sources/FPGAPrj_latest at 0d9fde5b312a62feed08525b0c1c31f4385e7f81. Original local engineering files are in Multi_protocol; preserve them.
- Tools: E:/AMDDesignTools/2026.1/Vivado/bin/vivado.bat and E:/AMDDesignTools/2026.1/Vitis/bin/{vitis,xsdb,hw_server}.bat. Legacy tools: C:/Xilinx, not the old hardcoded D: paths.
- Outputs: migration_build/2026.1/{pl,sim,vitis,candidate,logs,board}.
- Rebuild: tools/migrate_2026_1.ps1 -Step sim|pl|ps|host|audit|all. These regenerate only isolated migration outputs.
- Package verification: tools/program_2026_1.ps1 -PreflightOnly; volatile download without that switch. Inspect and adapt the loader based on observed target names and actual hardware behavior.
- Key docs: HANDOFF.md, docx/迁移执行记录_2026-10-24.md, README_MIGRATION_2026_1.md in the migration source, docs/interfaces/register_map.md, docs/test-results/2026-10-23-home-waveform-four-protocol.md.
- Official archived documentation: docx/AMD_Official and DOCS/AMD_Official. UG1400 and UG1647 cover Vitis/SDT, UG896/UG994 IP/BD, UG906 timing, UG900 simulation. Installed_API_Examples and Tutorials contain already inspected APIs.

## Register expectations

Base 0x40000000: SYS_ID +0=0x4D505254, VERSION +4=0x00010008, BUILD_ID +8=0x20261021, CAPABILITIES +0xC=0x1FF. SCRATCH +0x2C, LED +0x30, timestamp low/high +0x24/+0x28. SPI stats +0x3C..0x70, UART +0x74..0x90, I2C +0x94..0xB4, CAN +0xB8..0xE4. Capture control/status/count/total at +0x1000/+0x1004/+0x100C/+0x101C; event window +0x6000.

VDMA=0x43000000, VTC=0x43C00000; RGB888 framebuffers at 0x01100000 and 0x01220000, 1,152,000 bytes each for 800x480.

## Console grammar

Both consoles use 115200 8N1. On 2026-10-24, COM3 returned STM32 help, COM6 was initially silent; re-check before reuse. JTAG USB serial B1777481ABCD matches the historical Digilent JTAG-SMT2.

After the new candidate was loaded, COM6 was confirmed as the PS console. Live evidence and the corrected ELF are in migration_build/2026.1/board/20261024. The offline candidate remains historical. Initial live results: SPI 100/100 with counters 100/400/100/600 and no parser errors, UART 8 bytes/10 events with RX-only loopback timeout, I2C 25 events including one busy NACK, CAN loopback matched with 2 frames/20 events and no errors. These are one-run results, not stress qualification.

The board-stage source snapshot is commit 92012009201c40fd85fb181736f847d93bec279e. Read docs/test-results/2026-10-24-vivado-2026.1-board.md in the migration source or DOCS/实板测试记录_2026-10-24.md in the workspace. Reusable helpers: tools/board_2026_1.py (system Python with pyserial; pass --ps and --stm explicitly) and fpga/build/board_2026_1.tcl. The separately packaged board ZIP is migration_build/2026.1/multi_protocol_2026_1_board_20261024.zip.

After the automated run, the user explicitly confirmed stable LCD display and normal touch page switching. These two physical checks passed by user confirmation, recorded in board/20261024/manual_acceptance.json. Four-corner positioning, swipe gestures and history reopening remain unconfirmed.

Verified debug fallback when 2026.1 hw_server stalls: start C:/Xilinx/Vivado/2018.3/bin/hw_server.bat on tcp:127.0.0.1:3121, then run E:/AMDDesignTools/2026.1/Vitis/bin/xsdb.bat. Preserve the actual server version in logs. Do not claim an entirely 2026.1 debug stack.

STM32: help; spi jedec N; uart loop N; i2c eeprom N; can loop N; fault list; fault select N; fault run N. Review fault descriptions before selecting a case.

PS: status; protocol spi|uart|i2c|can; test start; test stop; view home|events|errors|history. Commands share the same handlers as touchscreen actions. Start/stop retains history; HOME capture freezes after 20 ms bus idle.

Existing source helpers in fpga/build include zynq_jtag_probe.tcl, zynq_jtag_low_speed_probe.tcl, zynq_display_readback.tcl, zynq_framebuffer_dump.tcl and zynq_{spi,uart}_stats.tcl. Some target filters and comments refer to XSCT/2018.3; inspect rather than assuming they work unmodified in 2026.1.

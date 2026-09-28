# SPI Mode-0 board-ingress integration result

Date: 2026-09-25

Branch: `test/fpga_NumberC-spi-board`

Baseline: `4d00be2` (`fpga_NumberC`)

## Scope

This change replaces the block-design constants on `ext_evt_*` with the
existing passive `spi_mode0_monitor`, exports the four SPI inputs, applies the
AA8/AB10/AB9/AA7 constraints, and keeps the virtual-event source on the same
two-source arbiter and snapshot buffer.

Vivado 2018.3 does not allow a SystemVerilog file to be the top of a block
design module reference. `spi_mode0_monitor_bd.v` is therefore a logic-free
Verilog adapter around the verified SystemVerilog monitor.

## Simulation

Command:

```text
vivado.bat -mode batch -nolog -nojournal -source fpga/build/run_sim.tcl
```

All five project-defined tests passed:

- `event_snapshot_buffer_tb`
- `event_arbiter_2_tb`
- `multi_protocol_core_tb`
- `spi_mode0_monitor_tb`
- `spi_snapshot_path_tb`

The coverage includes AXI access, virtual and external event arbitration,
ready/valid backpressure, golden SPI byte streams, asynchronous phase and
pause cases, residual-frame triggering, and triggered snapshot capture.

## Implementation

Command:

```text
vivado.bat -mode batch -nolog -nojournal -source fpga/build/build_bitstream.tcl
```

Result:

- Block design validation: PASS
- Synthesis: PASS, 0 errors and 0 critical warnings
- Implementation and routing: PASS, 0 failed or unrouted nets
- Bitstream: PASS
- HDF export: PASS
- Timing: WNS `+1.559 ns`, TNS `0`, WHS `+0.036 ns`, THS `0`
- User timing constraints: all met
- LUT: 4396 / 53200 (`8.26%`)
- Registers: 7459 / 106400 (`7.01%`)
- BRAM tiles: 5.5 / 140 (`3.93%`)
- DSP: 0 / 220 (`0%`)
- Bonded I/O: 28 / 200 (`14%`)

The final DRC report contains no error or critical-warning violations. It has
two advisory items, `REQP-165` and `REQP-181`, both from the existing AXI VDMA
WRITE_FIRST BRAM configuration rather than the SPI ingress.

## Deliverables

- Bitstream: `Multi_protocol.runs/impl_1/multi_protocol_bd_wrapper.bit`
- HDF: `Multi_protocol.sdk/multi_protocol_bd_wrapper.hdf`
- Timing report: `reports/timing.rpt`
- Utilization report: `reports/utilization.rpt`
- DRC report: `reports/drc.rpt`
- Power report: `reports/power.rpt`

SHA-256:

```text
bit 73A02DCD6A723C9889EE26DA07EDED82B879B287ECDF953AA2C0B9C65D5D1F00
hdf E6F7867ED1B7E8CF1C4827840D77925F6B1C4D6692A5E889A25F9DEECF468C5E
```

## Remaining hardware validation

No claim of physical-board success is made in this result. The remaining step
is to wire the STM32F407 according to `docs/hardware/spi_board_test.md`, program
the new bitstream, run normal Mode-0 transactions, and verify both event-list
scrolling and the deliberate four-bit residual-frame trigger on the display.

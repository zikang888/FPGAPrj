# 2026-10-17 UART RX integration verification

## Automated verification

- Vivado 2018.3 block-design validation: passed.
- Six-test HDL regression: passed (snapshot buffer, event arbiter, AXI/core
  including UART counters, SPI monitor, SPI snapshot path, UART monitor).
- UART monitor cases: eight-byte 8N1 transaction, END, bad stop, Break, short
  transaction and ready/valid backpressure all passed.
- PS `platform_app.elf` built with the Xilinx ARM toolchain. Result size:
  text 115260, data 2104, bss 34128 bytes.
- Full synthesis, implementation and bitstream generation: passed.
- Routed timing: WNS 1.158 ns, TNS 0; WHS 0.036 ns, THS 0. All specified timing
  constraints are met.
- DRC: zero errors; two pre-existing VDMA BRAM WRITE_FIRST advisories.
- Slice LUT use: 5242 / 53200 (9.85%).

## Hardware status

No board test was performed in this change because the FPGA was not connected.
The generated bitstream and HDF are ready for later programming. Hardware
acceptance still requires W5/common-ground wiring and STM32 UART traffic.

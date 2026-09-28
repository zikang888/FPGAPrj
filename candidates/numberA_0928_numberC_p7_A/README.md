# A+C P7 integration candidate (Zynq-only tested)

These BIT/HDF/ELF files are a matched set built with Vivado/SDK 2018.3 on
2026-09-28. The current integration XDC follows A's P7 plan. Do not pair
these files with the legacy C-pin candidate.

| File | SHA-256 |
|---|---|
| `multi_protocol_bd_wrapper.bit` | `8F521E8152C64B25C61DA59BAD6C443B7EEF60D7C96F4661D79DCA23FADBCBCF` |
| `multi_protocol_bd_wrapper.hdf` | `D110248F530B0934ADACD9AD3789DC564E4FA7B52938FE96C47E98B6C1A80A56` |
| `platform_app.elf` | `6667D2D96C4701999C905B8A95F89B5E8BF06053B398BFC80CF2EA1FA6EEA1AB` |

SPI CS/SCLK/MOSI/MISO = FPGA U11/U12/U10/U9 = AC820 P7-2/1/3/4.
Vivado's implemented IO report confirms all four are 3.3 V inputs; CS has
an internal pull-up. The FPGA is a listener, not an SPI master or slave.

Five RTL simulations PASS; full build PASS; WNS +1.615 ns, WHS +0.036 ns,
TNS/THS 0; DRC two advisories/no errors; isolated SDK build PASS. Volatile
JTAG programming, AXI self-test, display-DMA readback, and D1 register
readback passed. There has been no physical LCD/touch/LED observation or
STM32-to-FPGA SPI comparison yet. See
`docs/test-results/2026-09-28-numberA-C-p7-A-jtag-board.md`.

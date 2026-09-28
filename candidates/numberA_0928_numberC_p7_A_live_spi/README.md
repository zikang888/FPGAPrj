# A-map P7 live-SPI candidate (2026-09-28)

Matched Vivado 2018.3 / SDK 2018.3 output for the AC820 Zynq-7020. Use these
three files together; do not mix them with `numberA_0928_numberC_p7_A` or the
older C-map candidate. This is an **unflashed, unverified-on-board** candidate.

| File | SHA-256 |
|---|---|
| `multi_protocol_bd_wrapper.bit` | `C6C7157E4ED7B725C8F9A800CC5800301259885D22BE387BDD05C1CC8EDACB46` |
| `multi_protocol_bd_wrapper.hdf` | `6E874DC6A2CC25EAB5F3359B5B2F2962F2B114A5B899EACC4ACC2C250B537096` |
| `platform_app.elf` | `598F1F4FE8D3E8E9BFA939931B58EA32F63CBDE38B35E27A6E4978A54EF401F9` |

The RTL triggers on the first MOSI byte `9F` of each SPI transaction and on
an incomplete byte at CS deassertion. The PS EVENTS page has `ARM SPI`,
`WAIT SPI`, and `SHOW DEMO` states. SELF TEST still displays the cached virtual
snapshot. P7 map: CS_N U11/P7-2, SCLK U12/P7-1, MOSI U10/P7-3, MISO U9/P7-4.

Vivado implementation: WNS +3.118 ns, WHS +0.036 ns, TNS/THS 0; DRC has two
BRAM WRITE_FIRST advisories and no error. Usage: 4402 LUT, 7460 FF, 5.5 BRAM
tiles, 0 DSP. Five FPGA simulations passed, including normal JEDEC-trigger
snapshot and re-arm. PS ELF built successfully against this HDF. STM32 host
tests passed, but no STM32CubeF4 HAL project/binary or physical SPI test is
included. See `docs/test-results/2026-09-28-live-spi-preboard.md`.

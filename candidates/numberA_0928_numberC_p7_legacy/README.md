# A+C integration candidate (not board-accepted)

These three files were rebuilt together with Vivado/SDK 2018.3 on
2026-09-28 from the isolated `test/fpga_NumberC-A-full-integration` branch.
Program the BIT and run this ELF as a pair; the HDF describes this BIT.

| File | SHA-256 |
|---|---|
| `multi_protocol_bd_wrapper.bit` | `AE214195E3BAE6C67F73F3D347DF446B1875D6CFBC613D0AD0C1B985EC7A320F` |
| `multi_protocol_bd_wrapper.hdf` | `E5623B998660D8D89E031D315CB5FE7BAEC532654BEC55DB91B6043B2BFC155E` |
| `platform_app.elf` | `E0AC813D959D19F804845B0067BD883446252CCA2BBFF27B06F382A623492D46` |

The XDC uses C's previous passive SPI pin mapping:
CS/SCLK/MOSI/MISO = AA8/AB10/AB9/AA7 = AC820 P7-38/35/36/33.
Do **not** connect by A's new U11/U12/U10/U9 map with this BIT.
The team's physical wiring choice is still unresolved.

Checks completed: five Vivado simulations PASS; synthesis and bitstream PASS;
WNS +2.049 ns, WHS +0.036 ns, TNS/THS 0; DRC 2 advisories and no errors;
SDK application build PASS. LCD/LED and STM32/W25Q128 physical tests are
not yet performed on this candidate.

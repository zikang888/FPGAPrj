# NumberA 2026-09-28 to NumberC integration record

Source: `origin/fpga_NumberA_0928` at `e35a5725c10cae9a175afd6d9b3ffb5407b384fd`.
NumberC recovery point: `backup/fpga_NumberC-20260928-spi-scroll` at
`241af9609c1dd9f65069c63a3b352f0ac9662524` (also on `origin`).
This is an isolated test branch, not a release or a declaration of board-level
SPI interoperability.

## Applied from A

- Core ABI version `0x00010003`, build `0x20260926`, capabilities `0x7`.
- Register/event ABI clarification and the fixed-seed 100-byte SPI stress test.
- A history is merged, while C's LCD pixel-scroll code and full Vivado/SDK
  project are deliberately retained. A's source-only ignore policy would
  remove those files if its tree replaced C wholesale.

## Pending hardware decision

C's XDC uses AA8/AB10/AB9/AA7 for CS/SCLK/MOSI/MISO and corresponds to
AC820 P7-38/35/36/33. A's XDC uses U11/U12/U10/U9 and corresponds to
P7-2/1/3/4. This test branch currently retains C's map to preserve the
previously tested image and wiring instructions. Reconcile with B's actual
STM32 wiring before any three-board acceptance test. Both maps use passive
3.3 V FPGA inputs, and all devices need common ground.

The A wrapper relocation and port renaming were not applied: the existing C
wrapper and BD script connect the same SPI monitor and can build without
changing physical port names. A's older PS application was not substituted
for C's current touch UI and pixel-scrolling application.

## Verification gates

1. Vivado 2018.3 runs all five RTL testbenches, including SPI-to-snapshot.
2. Rebuild BIT/HDF from this branch and record DRC and WNS.
3. Compile the PS application against the new HDF; confirm LCD and D1 still work.
4. With the chosen pin map and STM32 wiring fixed, compare captured SPI bytes
   against B's source and the external slave on the same transaction.

Passing simulation or timing alone does not satisfy gates 3 and 4.

2026-09-28 verification: gates 1 and 2 passed. All five simulations passed;
implementation reported WNS +2.049 ns, WHS +0.036 ns, TNS/THS 0, and DRC
two advisories/no errors. The PS application was built successfully against
the new HDF in an isolated SDK workspace, satisfying gate 3's compile half.
LCD/D1 physical regression and gate 4 remain untested. The matched test
artifacts and hashes are under `candidates/numberA_0928_numberC_p7_legacy/`.

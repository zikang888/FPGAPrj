# NumberA + NumberC candidate: Zynq-only JTAG board test

Date: 2026-09-28. Test target: Digilent JTAG-SMT2 B1777481ABCD,
Zynq xc7z020. This test used volatile JTAG loading; boot Flash was not
modified. The STM32 board and an SPI slave were not used.

Candidate pair: `candidates/numberA_0928_numberC_p7_legacy/` BIT and ELF.
The test script was run with `ZYNQ_TEST_BIT` and `ZYNQ_TEST_ELF` explicitly
pointing to those files, avoiding the inherited generated project BIT.

## Observations

| Check | Readback | Result |
|---|---|---|
| PL SYS_ID | `0x4D505254` | matches `MPRT` |
| VERSION | `0x00010003` | matches A+C platform 3 |
| CAPABILITIES | `0x00000007` | snapshot, external ingress, SPI monitor |
| PS scratch | `0xA5A55A5A` | application executed AXI read/write |
| Capture status | `0x00000002` | snapshot ready |
| Snapshot count / trigger | `25` / `8` | virtual self-test ran |
| Core / external drops | `0` / `0` | no recorded loss in this test |
| D1 control | `0 -> 1 -> 0` | AXI register readback; returned off |
| VDMA MM2S status | `0x00011000` | running, no error bits in `0x00000FF0` |
| VDMA geometry | stride `2400`, hsize `2400`, vsize `480` | matches 800×480 RGB888 |
| Frame buffers | `0x01100000`, `0x01220000` | matches PS display setup |
| Framebuffer samples | start `0x330B2233`, center `0x102B4010` | nonempty image data |

CPU0 was resumed after each JTAG probe. The newly downloaded application was
left running. Physical LCD image quality, GT911 touch interaction, D0/D1
visible light, and STM32-to-FPGA SPI traffic cannot be established from these
readbacks; they remain board-observation or three-board tests.

The candidate BIT retains C's CS/SCLK/MOSI/MISO pin map
AA8/AB10/AB9/AA7 (AC820 P7-38/35/36/33). A's U11/U12/U10/U9 map is not
equivalent. Do not connect the STM32 until B's chosen wiring is reconciled
with the selected XDC.

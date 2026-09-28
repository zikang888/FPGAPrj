# A P7 pin-map candidate: Zynq-only JTAG test

Date: 2026-09-28. Target: Digilent JTAG-SMT2 B1777481ABCD and xc7z020.
The board was programmed transiently through JTAG with the matched BIT/ELF
in `candidates/numberA_0928_numberC_p7_A/`; boot Flash was not written.
CPU0 was resumed after each probe and the new application was left running.

## Build and implemented pins

- Five Vivado 2018.3 simulations PASS, including 100-byte fixed-seed SPI
  stress and SPI-to-snapshot path.
- Full implementation and bitstream PASS. WNS +1.615 ns, WHS +0.036 ns,
  TNS/THS 0. DRC: two Advisory, zero errors.
- Implemented IO: U12=`SPI_SCLK`, U11=`SPI_CS_N` with pull-up,
  U10=`SPI_MOSI`, U9=`SPI_MISO`; all `INPUT`, `LVCMOS33`.
- SDK 2018.3 built a matched PS ELF from the new HDF in an isolated workspace.

## JTAG readback

| Item | Observed |
|---|---|
| SYS_ID / VERSION / CAPABILITIES | `4D505254` / `00010003` / `00000007` |
| SCRATCH | `A5A55A5A` after PS startup |
| CAPTURE_STATUS / SNAPSHOT_ID | `00000002` / `1` |
| SNAPSHOT_COUNT / TRIGGER_INDEX | `25` / `8` |
| EXT_DROPPED / DROPPED | `0` / `0` |
| D1 register | readback `0 -> 1 -> 0`, restored off |
| VDMA control / status | `00010009` / `00011000`; no error bits |
| Display size | stride 2400, hsize 2400, vsize 480 |
| Frame addresses | `01100000`, `01220000` |
| Framebuffer samples | nonzero, distinct start/center values |

These are electronic readbacks, not a visual LCD/touch/LED inspection.
No STM32 firmware or wiring was present, so no real SPI bytes were observed.
The PS application currently shows a cached virtual self-test snapshot,
not an automatically refreshed live SPI capture; that UI/capture feature
must be implemented before using EVENTS as a three-board acceptance display.

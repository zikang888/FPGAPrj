# STM32 USART1 burst-command regression (2026-10-09)

The old F407 command loop transmitted each received byte synchronously before
reading the next. Direct unpaced `spi jedec 10` previously echoed as
`spi jedec 0` and executed one transaction. The firmware now buffers RX bytes
and echoes the completed line at CR/LF, leaving the command grammar unchanged.

Keil MDK-ARM build: 0 errors, 0 warnings; flash programming/verify reported
`Verify OK`. AXF SHA-256:
`E57A975189163C1E69ADE501766C78B07756DF5558A1909720B027BF6C3800BA`.
After flashing, the F407 was separately power-cycled. COM4 at 115200 returned
the full `help` command list.

Two *unpaced* `SerialPort.Write("...\r")` checks followed:

| Command | Echo/iterations | STM32 result |
| --- | --- | --- |
| `spi jedec 10` | Full echo; 10 executed | 8 passed, 2 failed; first two read `FFFFFFFF`, subsequent eight `FFEF4018` |
| `spi jedec 100` | Full echo; 100 executed | 100 passed, 0 failed; all `FFEF4018` |

Thus the CLI truncation regression is fixed in these checks, but the first two
all-FF SPI reads are a **separate unresolved startup/intermittent hardware
fault**. Do not report the first round as 10/10. The later PL SPI-stat query
showed accumulated counters from prior runs (1144 starts), not a freshly
cleared 110-transaction acceptance window, so it cannot be used as same-run
FPGA verification for these commands.

The F407 image is in volatile/flashed target state, but the new PS LCD ELF was
not yet downloaded at the time of this test. Repeat the two-board counter
comparison with cleared PL statistics after the Zynq AXI/JTAG precheck works.

# Member A week-2 SPI acceptance result

Date: 2026-10-05

Branch used: `fpga_NumberA_2week`

## Delivered PL behavior

- SPI Mode-0 monitor remains a passive listener on U11/U12/U10/U9.
- External SPI events use the existing ready/valid arbiter and unique snapshot
  path.
- Core version is `0x00010004`; capabilities are `0x0000000F`.
- AXI registers at `0x003C` through `0x0064` expose accepted event, START,
  DATA, END, frame-error, boundary-error, duplicate and transaction-sequence
  counts, last transaction ID, status and explicit clear.
- CS is accepted only after four stable synchronized samples. This was added
  after the first board run exposed short CS disturbances that split 20 of 100
  transactions. A 20 ns glitch is now part of the regression corpus.

## Automated verification

The complete Vivado RTL regression passed:

- `event_snapshot_buffer_tb`
- `event_arbiter_2_tb`
- `multi_protocol_core_tb`
- `spi_mode0_monitor_tb`, including the CS-glitch case
- `spi_snapshot_path_tb`

Implementation completed with zero synthesis/implementation errors. Final
timing was WNS `+1.536 ns`, WHS `+0.036 ns`, TNS/THS `0`, and all user timing
constraints were met. Routed DRC contained no errors; the two reported items
are the existing VDMA BRAM WRITE_FIRST advisories (`REQP-165`, `REQP-181`).

Resource summary: 4,224 LUTs as logic (7.94%), 7,861 slice registers (7.39%),
5.5 BRAM tiles (3.93%) and no DSPs.

## Same-run board evidence

The repaired BIT and the rebuilt PS ELF were downloaded over JTAG. Readback
returned:

```text
SYS_ID       = 0x4D505254
VERSION      = 0x00010004
CAPABILITIES = 0x0000000F
SCRATCH      = 0xA5A55A5A
```

After clearing the PL counters, STM32 USART1 received `spi jedec 100` and
reported:

```text
STM32_RECORDS=100
first data=FFEF4018 result=0
last  data=FFEF4018 result=0
SUMMARY protocol=SPI_JEDEC result=0 iterations=100 passed=100 failed=0
```

The PL counter checker then reported:

```text
events=600 starts=100 data=400 ends=100
dropped=0 frame_errors=0 boundary_errors=0
duplicates=0 sequence_errors=0 status=6
SPI_ACCEPTANCE_PASS
```

This proves the STM32 result and FPGA event/count view agree for the same run.
The independent logic-analyzer waveform/export is still a manual shared-team
artifact; it was not fabricated from JTAG data and must be saved when the
logic analyzer is connected.

## Release artifacts

```text
multi_protocol_bd_wrapper.bit
SHA256 16F17835ED646C778D73906563C50D95881CCFD7E60F504135B4B20F467A9FB4

platform_hw/system.hdf
SHA256 161F2A69C1B47426805DB6609F45242CC13F4546ED65FA9723D4510D8270BB69
```

The generated BIT in `Multi_protocol.runs/impl_1` and the tracked release BIT
in `Multi_protocol.sdk/platform_hw` have identical SHA256 values.

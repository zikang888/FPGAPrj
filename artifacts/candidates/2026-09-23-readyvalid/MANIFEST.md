# Ready/valid ingress candidate package

Status: **candidate; simulation and implementation passed; not board-tested**.

Do not copy these files into `artifacts/current` until the matching package has
passed the existing LCD/touch/LED smoke test. The external protocol input is
still tied low in the block design, so this candidate preserves the current
board I/O while validating the new internal event ingress architecture.

| File | Bytes | SHA-256 |
|---|---:|---|
| `multi_protocol_bd_wrapper.bit` | 4,045,685 | `2A0430F522A5690D7C76216AE8EC9D22262875A16D43C26AFB54E0B45FF18331` |
| `multi_protocol_bd_wrapper.hdf` | 377,958 | `A01290D1FE8B0E375A3B4A132458F6F5BF301E4583EF0BFF9A2F35F013E090D7` |
| `platform_app.elf` | 738,872 | `49B978BD257ED1CA130D0A62745496416BE71F49753F441CDF0BD3D92D3F8430` |

PS image size: text 115,028 bytes, data 2,104 bytes, BSS 25,280 bytes.

Implementation evidence:

- Vivado 2018.3 clean isolated rebuild.
- Five self-checking simulations passed.
- WNS `+3.365 ns`, TNS `0.000 ns`.
- WHS `+0.036 ns`, THS `0.000 ns`.
- DRC `0 Errors`; two existing AXI VDMA BRAM advisories (`REQP-165`, `REQP-181`).
- Slice LUTs 4,272 (8.03%), slice registers 7,231 (6.80%), BRAM tiles 5.5 (3.93%), DSP 0.
- External producer loss visibility is included: `ext_evt_dropped_count[31:0]`
  is exposed at AXI register `0x0038`, and contributes to the dropped-status bit.

Matching build workspace:

```text
D:\fpga_class\Multi_protocol\_clean_build_20260923
```

The build workspace is evidence/build output, not an authoritative source tree.
Source remains under `fpga`, `software`, and `docs` in the project root.

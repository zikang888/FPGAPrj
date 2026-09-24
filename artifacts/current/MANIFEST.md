# Current validated package

Build date: 2026-09-23

These three files are a matched D1/P21 set. Do not combine them with files from
an older `Multi_protocol.runs` or SDK workspace.

| File | Bytes | SHA-256 |
|---|---:|---|
| `multi_protocol_bd_wrapper.bit` | 4,045,685 | `9B6CACD7A0E4970F37265C72026DDEF76A0E0ED32A14745323716840195969B2` |
| `multi_protocol_bd_wrapper.hdf` | 377,443 | `5D61B34B54CE9CF51785059E493CCA79B1ED98FEEA212F5A872154D4716A99F4` |
| `platform_app.elf` | 738,736 | `1941CF75E4032030FE14C22FCF112FFCE01DBBDF597BEFE26F076B0A31ECFDA4` |

PS image size: text 115,028 bytes, data 2,104 bytes, BSS 25,280 bytes.

Implementation reports are in `reports/`. The regenerated matching SDK
workspace is `sdk_workspace_d1/`; `download_jtag.tcl` uses its
`platform_hw/ps7_init.tcl`. The older `sdk_workspace/` is retained only as a
pre-remap fallback and must not be used for this D1 build.

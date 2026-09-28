# Number C board-tested backup

This directory preserves the PS ELF used with the current Number C SPI-ingress
bitstream and pixel-scroll UI. The SDK workspace's older
`Multi_protocol.sdk/platform_app/Debug/platform_app.elf` is **not** this release.

| Artifact | Repository path | SHA-256 |
| --- | --- | --- |
| PL BIT | `Multi_protocol.runs/impl_1/multi_protocol_bd_wrapper.bit` | `73A02DCD6A723C9889EE26DA07EDED82B879B287ECDF953AA2C0B9C65D5D1F00` |
| Hardware handoff | `Multi_protocol.sdk/multi_protocol_bd_wrapper.hdf` | `E6F7867ED1B7E8CF1C4827840D77925F6B1C4D6692A5E889A25F9DEECF468C5E` |
| PS ELF | `releases/numberC-20260928/platform_app.elf` | `89CC3E8F9B17718EDFCFB9C7A286975DD6281FDCDDFACACC7F195D3EBDF12861` |

The Zynq-only board regression and pixel-scroll checks are recorded in
`docs/test-results/2026-09-26-zynq-board-regression.md` and
`docs/test-results/2026-09-26-events-pixel-scroll-board.md`.
STM32-to-FPGA physical SPI capture has not yet been accepted. The PS application
still starts by showing a frozen virtual-event self-test snapshot; a real-capture
control path is needed before the EVENTS page can display STM32 traffic.

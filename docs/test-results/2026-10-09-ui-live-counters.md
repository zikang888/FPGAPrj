# LCD live counter semantics and validation (2026-10-09)

The previous LCD used `CaptureDemoSnapshot.dropped_count`, a cached value
from the instant of capture. During the 2026-10-08 1000-transaction SPI run,
JTAG read `DROPPED_COUNT=6000` while the LCD still showed the old value. The
new PS loop samples two AXI registers every 0.5 seconds and redraws only the
affected rows when they change:

| LCD label | AXI register | Meaning | Health impact |
| --- | --- | --- | --- |
| `CORE REJECTED` / `REJ` | `0x1014` | Events refused after a one-shot snapshot freezes, or virtual-source queue overflow | Information only; not equivalent to a lost SPI transaction |
| `EXT LOSS` | `0x0038` | External producer reports event loss | Nonzero sets health to CHECK/ATTENTION |

The header now says `DEMO`, `ARMED`, or `FROZEN` for the visible capture mode.
`EVENTS` retains the snapshot-local `ERR` count. These counters are PL data;
the LCD does **not** yet know the STM32 command summary (`passed`/`failed`),
which remains on its USART1 console. A frozen capture does not automatically
turn into a continuous scrolling log.

## Debug pass 1 — source and host checks

- Confirmed `0x1014` and `0x0038` against the register map and RTL decoder.
- Strict C99 tests passed: `ui_counter_semantics`, `event_view`,
  `event_audit`, and `pixel_scroll`.
- `git diff --check` passed.
- Initial ARM build found one legacy compatibility wrapper still assigning
  `status.dropped_count`; removed that stale assignment and rebuilt.

## Debug pass 2 — target build and board observation

- SDK 2018.3 generated a fresh BSP in `.sdk_live_counter_validation` from the
  existing HDF; ARM application compiled and linked with no C errors. ELF
  SHA-256: `BF1524179320937EBE782D0624F11E2FD126403ADDE0112EC681129D6E821E87`.
- Integrated as `a8bef42` in `codex/fpga-ab-week2-c-integration`.
  The first controlled ELF-only download stopped at its read-only PL ABI
  precheck: A9 #0/#1 were enumerated as Running, but AXI `SYS_ID` at
  `0x40000000` timed out. **No ELF download occurred.** The XSCT wrapper
  returned process code 0 despite printing the Tcl error, so the process code
  is not treated as a pass. LCD counter update and scroll responsiveness
  remain **pending on-board verification** after PL/PS access is restored.

# UART RX passive monitor

## Scope

The PL listens to a 115200 baud, 8N1 line on FPGA pin W5. It does not alter the
STM32 traffic. FPGA pin AA9 is reserved for a later return path and remains at
the UART idle-high level; this revision never transmits a UART frame.

The implementation borrows only the receive-state-machine idea from the
different-board `Lesson/BIG_work` project. Its clock, constraints and pins are
not reused. This project samples with the existing 100 MHz PL clock and uses
the AC820/Zynq-7020 W5 and AA9 constraints.

## Transaction and event rules

- A valid start bit creates START and a new transaction ID.
- Each valid 8N1 frame creates one DATA event; data is in `flags[7:0]`.
- Eight bytes form the current STM32 test transaction. The fifth DATA event is
  the snapshot trigger, so the existing four-post-event buffer includes bytes
  six through eight and END.
- An idle gap of 12 bit times after 1..7 bytes creates ERROR reason `0x04`.
- A low stop-bit sample creates ERROR reason `0x01`.
- RX low for at least ten bit times creates ERROR reason `0x02` (Break).
- Parity is not checked because the agreed format is 8N1.
- Baud mismatch is not claimed as a separately identifiable passive fault; it
  normally manifests as wrong bytes and/or stop-bit errors.

All output uses the common 128-bit ready/valid event ABI. SPI and UART enter a
single two-source arbiter and then the existing unique snapshot buffer. Loss at
either monitor is accumulated in `EXT_DROPPED_COUNT`.

## Board wiring

| FPGA signal | Package pin | Direction now | Connect to |
|---|---:|---|---|
| `UART_RX` | W5 | input with pull-up | STM32 USART3 TX (PD8) |
| `UART_TX` | AA9 | output, constant idle high | STM32 USART3 RX (PD9), optional for now |
| GND | — | — | common ground |

Both boards must use 3.3 V logic and share ground. Do not connect AA9 to any
other actively driven TX output.

## PS/UI behavior

`CAPABILITIES[5]` marks the UART listener live. Select the UART tab, arm a live
capture, then run `uart loop 1` or a UART fault case on the STM32. EVENTS filters
protocol ID 1. ERRORS shows bad stop, Break, short transaction, total UART
events/data bytes, and external event loss. Because FPGA TX is intentionally
disabled, the STM32 `uart loop` command may still report an echo timeout; that
does not mean passive monitoring failed.

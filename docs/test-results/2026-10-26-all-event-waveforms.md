# 2026-10-26: auto-fit and all captured transaction diagrams

Follow-up to waveform grid/markers: HOME now fits the decoded length to the
608px viewport. UART one-frame and I2C one-byte cases no longer occupy one quarter
of the plot. SPI presentation accepts captured short/extra transactions through
`waveform_view.h`; the strict `spi_trace.h` validator remains unchanged.
SPI extra bytes and short-transaction endpoints are marked. No missing byte or
partial-bit electrical level is invented. CAN shows up to all 8 payload bytes.

When a fault has no complete decoded waveform, HOME shows captured event order,
explicitly labeled EVENT SEQUENCE / NOT A SAMPLED WAVEFORM. Host exports include
every transaction from the retained FPGA snapshot with original event timestamps.
They are reconstructed diagrams, not external sampled-waveform evidence.

13 host checks and the production renderer/touch test passed; SDK 2018.3 build
and matched ABI ELF download passed. Read-back screenshots verified auto-fit,
NACK/STOP markers, SPI short/extra and partial event-sequence views.

The four regular tests and all 20 STM32 menu faults were attempted. Six menu
items returned unsupported: SPI MISO CHECK, UART PARITY, I2C SDA LOW, I2C SCL LOW,
CAN BIT ERROR, CAN BUS OFF. SDA/SCL fault injection specifically requires PC7/PC8
open-drain links absent from the supported firmware configuration/connection.
Baud-offset injection was classified as SHORT in the observed FPGA events.

Legacy CAN no-ACK probe left queued RX replies; raw injection then returned
MC_ERR_BUSY. Temporarily suppressing only FPGA echo while reading the queued
replies, and restoring the exact previous control word, enabled the raw backend
again. Recovered stuff/CRC/form captures were saved separately. Single-frame
no-ACK evidence was obtained with ACK+echo temporarily disabled and then fully
restored (CAN control 3). Do not use the unsuccessful legacy no-ACK attempt as
proof of NO ACK detection.

SPI regular JEDEC passed on this run; UART RX captured data but MCU echo timed
out; EEPROM_RW still failed; regular CAN had anomalous events. These results
remain in the coverage sheet and must not be presented as all-protocol pass.

Evidence on this PC:
`C:/Users/11914/Documents/Codex/2026-09-22/wo/board_validation/all-waveforms-20261026/`

28 capture cases, 45 captured transactions. Each case has LCD.png, snapshot.bin,
events.csv, STM32/Zynq logs, and per-transaction SVG/PNG where events exist.
`coverage.csv` lists observed counts and error types; `index.html` is the gallery.
`firmware/` preserves the exact ELF, BIT/HDF/init, updated renderer/header and hashes.
Package: `../all-event-error-waveforms-20261026.zip`.

No QSPI write, STM32 reflash, Git commit or push was performed for this follow-up.

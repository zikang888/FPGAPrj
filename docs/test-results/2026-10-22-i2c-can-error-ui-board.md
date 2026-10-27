# 2026-10-22 I2C/CAN error-to-display board test

## Setup

- FPGA/PS image: `D:\Vivado\FPGAPrj`
- STM32 console: COM67, 115200 8N1
- Zynq PS console: COM26, 115200 8N1
- I2C: STM32 I2C1 to AT24C256, FPGA AA6/V8 passive taps
- CAN: two SN65HVD230 transceivers, FPGA W8/AA11 active second node

## I2C physical results

The PS test session was started with `protocol i2c` and `test start`.

| STM32 case | STM32 result | PL result |
|---|---:|---|
| 9, address NACK | 0 | address NACK = 1, events = 7, data = 2 |
| 10, busy NACK | 0 | busy NACK = 16, events = 73, data = 21 |
| 11, SDA stuck low | -5 | not emitted; firmware requires PC7 open-drain link to SDA |
| 12, SCL stuck low | -5 | not emitted; firmware requires PC8 open-drain link to SCL |
| 13, missing STOP | 0 | missing STOP = 1, events = 3, data = 1 |

No external event loss was observed. With cases 9, 10 and 13 accumulated in
one UI session, the PS reported `events=83 errors=18`. The exported live frame
buffer showed `VIEW I2C / ERRORS` with `ADDRESS NACK 1 FAULT`, `BUSY NACK 16`,
`MISSING STOP 1 FAULT`, both stuck-line counters at zero, and event loss zero.
This closes the physical bus -> PL detector -> AXI counters -> PS error model ->
rendered display chain for the three executable I2C error cases.

## CAN physical results

The PS test session was started with `protocol can` and `test start`.
`can loop 10` passed all ten iterations. PL measured exactly 20 frames and 200
events: one STM32 request and one FPGA echo per iteration. ACK, bit, stuffing,
CRC and form counters and external event loss all remained zero. The exported
live frame buffer showed `VIEW CAN / ERRORS`, `NO DETECTED ERRORS`, zero for the
implemented counters, `BIT ERROR --`, and the explicit note `BUS-OFF NEEDS
CONTROLLER STATUS; NOT INFERRED`. The saved PS session reports
`events=200 retained=200 errors=0 tail=0`.

STM32 fault cases 14 through 19 did not inject a CAN fault in this firmware:

- case 14 returned `-5 requires_peer_not_acknowledging` without transmitting;
- cases 15--19 returned `-5 unsupported_or_external`;
- PL counters remained zero for those attempted cases.

Therefore normal CAN receive/ACK/echo and its zero-error display are accepted,
but physical CAN ACK/bit/stuff/CRC/form/bus-off error-to-display acceptance is
not complete. Cases 15--18 need a bus fault injector or dedicated malformed-
frame FPGA diagnostic transmitter. Bus-off additionally requires real CAN
controller TEC/REC state; it cannot be inferred by the current protocol tap.

## Acceptance status

- I2C address NACK, busy NACK and missing STOP: PASS end to end, including the
  rendered touch-display frame buffer.
- I2C SDA/SCL stuck low: BLOCKED by the two missing open-drain injector links.
- CAN normal two-node traffic and zero-error display: PASS.
- CAN error injection/display: NOT TESTED on physical bus because the current
  STM32 firmware reports the cases as unsupported and the PL has no malformed-
  frame injector / full error-confinement controller.

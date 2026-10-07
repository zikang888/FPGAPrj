# Test-only re-arm of the documented snapshot block; does not reset PL or CPU.
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
configparams force-mem-access 1
puts "BEFORE [mrd 0x40001004]"
mwr 0x40001000 0x00000002
mwr 0x40001000 0x00000001
puts "AFTER [mrd 0x40001004]"
configparams force-mem-access 0
disconnect
puts "ZYNQ_SPI_CAPTURE_REARM_TEST_DONE"

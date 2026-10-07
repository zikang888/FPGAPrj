# Inspect the running Zynq system without stopping CPUs, resetting, or writing.
if {[catch {connect -url tcp:127.0.0.1:3121} connection_error]} {
    puts "JTAG_CONNECT_FAILED: $connection_error"
    exit 1
}
set available [targets]
puts "TARGETS_BEGIN\n$available\nTARGETS_END"
if {[string first "ARM Cortex-A9 MPCore #0" $available] < 0} {
    disconnect
    error "ARM Cortex-A9 MPCore #0 not found"
}
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
configparams force-mem-access 1
foreach {label address} {
    SYS_ID 0x40000000
    VERSION 0x40000004
    CAPABILITIES 0x4000000C
    SCRATCH 0x4000002C
    LED_CTRL 0x40000030
    ARB_STATUS 0x40000034
    EXT_DROPPED 0x40000038
    CAPTURE_STATUS 0x40001004
    SNAPSHOT_ID 0x40001008
    SNAPSHOT_COUNT 0x4000100C
    TRIGGER_INDEX 0x40001010
    DROPPED_COUNT 0x40001014
    EVENT_0_WORD_0 0x40006000
} {
    if {[catch {mrd $address} value]} {
        puts "$label READ_ERROR: $value"
    } else {
        puts "$label $value"
    }
}
configparams force-mem-access 0
disconnect
puts "ZYNQ_JTAG_READONLY_STATUS_DONE"

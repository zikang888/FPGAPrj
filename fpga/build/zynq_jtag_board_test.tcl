# Volatile JTAG smoke test for the Zynq-7020 build. Does not write boot media.
set script_dir [file dirname [file normalize [info script]]]
set repo_dir [file normalize [file join $script_dir .. ..]]
set bit_file [file join $repo_dir Multi_protocol.runs impl_1 multi_protocol_bd_wrapper.bit]
if {[info exists ::env(ZYNQ_TEST_BIT)] && $::env(ZYNQ_TEST_BIT) ne ""} {
    set bit_file [file normalize $::env(ZYNQ_TEST_BIT)]
}
if {![info exists ::env(ZYNQ_TEST_ELF)] || $::env(ZYNQ_TEST_ELF) eq ""} {
    error "Set ZYNQ_TEST_ELF to a freshly built ELF; the existing SDK ELF may be stale"
}
set elf_file [file normalize $::env(ZYNQ_TEST_ELF)]
set init_file [file join $repo_dir Multi_protocol.sdk ps7_init.tcl]
foreach path [list $bit_file $elf_file $init_file] {
    if {![file isfile $path]} {error "Missing test input: $path"}
}

connect -url tcp:127.0.0.1:3121
set available [targets]
puts "TARGETS_BEGIN\n$available\nTARGETS_END"
if {[string first "ARM Cortex-A9 MPCore #0" $available] < 0} {
    error "ARM Cortex-A9 MPCore #0 not found"
}
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
puts "STOP_CPU0"
catch {stop}
puts "RESET_SYSTEM_FOR_CLEAN_REDOWNLOAD"
rst -system
after 1000
puts "PROGRAM_BITSTREAM $bit_file"
fpga -file $bit_file
puts "INIT_PS $init_file"
source $init_file
ps7_init
ps7_post_config
configparams force-mem-access 1
foreach {label address} {
    SYS_ID 0x40000000
    VERSION 0x40000004
    CAPABILITIES 0x4000000C
} {
    puts "$label [mrd $address]"
}
configparams force-mem-access 0
puts "DOWNLOAD_ELF $elf_file"
dow $elf_file
puts "RUN_CPU0"
con
after 3000
puts "STOP_CPU0_FOR_READBACK"
stop
puts "CPU_REGISTERS_BEGIN"
puts [rrd]
puts "CPU_REGISTERS_END"
configparams force-mem-access 1
foreach {label address} {
    SYS_ID 0x40000000
    VERSION 0x40000004
    CAPABILITIES 0x4000000C
    SCRATCH 0x4000002C
    ARB_STATUS 0x40000034
    EXT_DROPPED 0x40000038
    SPI_EVENTS 0x4000003C
    SPI_STARTS 0x40000040
    SPI_DATA 0x40000044
    SPI_ENDS 0x40000048
    SPI_FRAME_ERRORS 0x4000004C
    SPI_BOUNDARY_ERRORS 0x40000050
    SPI_DUPLICATES 0x40000054
    SPI_SEQUENCE_ERRORS 0x40000058
    SPI_LAST_TXN 0x4000005C
    SPI_STATS_STATUS 0x40000060
    CAPTURE_STATUS 0x40001004
    SNAPSHOT_ID 0x40001008
    SNAPSHOT_COUNT 0x4000100C
    TRIGGER_INDEX 0x40001010
    DROPPED_COUNT 0x40001014
    EVENT_0_WORD_0 0x40006000
    EVENT_8_WORD_0 0x40006080
    EVENT_24_WORD_0 0x40006180
} {
    puts "$label [mrd $address]"
}
configparams force-mem-access 0
puts "RESUME_CPU0"
con
disconnect
puts "ZYNQ_JTAG_BOARD_TEST_DONE"

# One-shot volatile test when the PS AXI path is unavailable before PL config.
# Pass a matched BIT, ELF and ps7_init.tcl through the environment.
foreach name {ZYNQ_TEST_BIT ZYNQ_TEST_ELF ZYNQ_TEST_INIT} {
    if {![info exists ::env($name)] || $::env($name) eq ""} {
        error "Missing environment variable $name"
    }
    set file($name) [file normalize $::env($name)]
    if {![file isfile $file($name)]} {error "Missing test input: $file($name)"}
}

connect -url tcp:127.0.0.1:3121
set initial_targets [targets]
puts "TARGETS_BEGIN\n$initial_targets\nTARGETS_END"
if {[string first "ARM Cortex-A9 MPCore #0" $initial_targets] < 0 ||
    [string first "JTAG port open error" $initial_targets] >= 0} {
    disconnect
    error "PS DAP unavailable before BIT transfer; stop without programming"
}
puts "JTAG_TARGETS_BEGIN\n[jtag targets]\nJTAG_TARGETS_END"
jtag targets -set -filter {level == 0}
set supported [jtag frequency -list]
set selected 0
foreach candidate $supported {
    if {$candidate <= 1000000 && $candidate > $selected} {
        set selected $candidate
    }
}
if {$selected == 0} {
    set selected [lindex [lsort -integer $supported] 0]
}
jtag frequency $selected
puts "JTAG_FREQUENCY_HZ $selected"
targets -set -filter {level == 0} -index 1
puts "PROGRAM_BITSTREAM $file(ZYNQ_TEST_BIT)"
fpga -file $file(ZYNQ_TEST_BIT)
puts "BITSTREAM_PROGRAMMED"

targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
puts "INIT_PS $file(ZYNQ_TEST_INIT)"
source $file(ZYNQ_TEST_INIT)
ps7_init
ps7_post_config
puts "PS_INITIALIZED"

configparams force-mem-access 1
foreach {label address} {
    SYS_ID 0x40000000
    VERSION 0x40000004
    CAPABILITIES 0x4000000C
} {
    puts "$label [mrd $address]"
}
configparams force-mem-access 0

puts "RESET_CPU0"
rst -processor
puts "DOWNLOAD_ELF $file(ZYNQ_TEST_ELF)"
dow $file(ZYNQ_TEST_ELF)
puts "RUN_CPU0"
con
after 3000
disconnect
puts "ZYNQ_JTAG_PL_FIRST_TEST_DONE"

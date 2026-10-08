# Volatile PS-application smoke test against an already running, compatible PL.
# No BIT, boot-media, or PS-init writes. The caller supplies a freshly built ELF.
if {![info exists ::env(ZYNQ_TEST_ELF)] || $::env(ZYNQ_TEST_ELF) eq ""} {
    error "Set ZYNQ_TEST_ELF to the PS ELF to test"
}
set elf_file [file normalize $::env(ZYNQ_TEST_ELF)]
if {![file isfile $elf_file]} {error "Missing ELF: $elf_file"}

connect -url tcp:127.0.0.1:3121
set available [targets]
puts "TARGETS_BEGIN\n$available\nTARGETS_END"
if {[string first "ARM Cortex-A9 MPCore #0" $available] < 0 ||
    [string first "JTAG port open error" $available] >= 0} {
    disconnect
    error "PS DAP unavailable; no download attempted"
}
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
configparams force-mem-access 1
set sys_id [mrd 0x40000000]
set version [mrd 0x40000004]
set capabilities [mrd 0x4000000C]
puts "PRE_SYS_ID $sys_id"
puts "PRE_VERSION $version"
puts "PRE_CAPABILITIES $capabilities"
if {[string first "4D505254" $sys_id] < 0 ||
    [string first "00010004" $version] < 0 ||
    [string first "0000000F" $capabilities] < 0} {
    configparams force-mem-access 0
    disconnect
    error "Running PL ABI mismatch; no download attempted"
}
configparams force-mem-access 0

puts "STOP_CPU0"
stop
puts "DOWNLOAD_ELF $elf_file"
dow $elf_file
puts "RUN_CPU0"
con
after 3000
configparams force-mem-access 1
puts "POST_SYS_ID [mrd 0x40000000]"
puts "POST_VERSION [mrd 0x40000004]"
puts "POST_CAPABILITIES [mrd 0x4000000C]"
puts "POST_CAPTURE_STATUS [mrd 0x40001004]"
puts "POST_SNAPSHOT_COUNT [mrd 0x4000100C]"
configparams force-mem-access 0
disconnect
puts "ZYNQ_ELF_ONLY_SMOKE_DONE"

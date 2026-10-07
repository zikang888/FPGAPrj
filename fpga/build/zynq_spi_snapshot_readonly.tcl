# Read the frozen SPI snapshot without changing capture state or stopping CPUs.
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
configparams force-mem-access 1
set status [mrd 0x40001004]
set count_raw [mrd 0x4000100C]
puts "STATUS $status"
puts "COUNT $count_raw"
if {![regexp {:\s+([0-9A-Fa-f]+)} $count_raw -> count_hex]} {
    configparams force-mem-access 0
    disconnect
    error "Could not parse snapshot count"
}
scan $count_hex %x count
if {$count > 256} {
    configparams force-mem-access 0
    disconnect
    error "Invalid snapshot count: $count"
}
for {set i 0} {$i < $count} {incr i} {
    set words {}
    for {set j 0} {$j < 4} {incr j} {
        set address [expr {0x40006000 + 16 * $i + 4 * $j}]
        set raw [mrd $address]
        if {![regexp {:\s+([0-9A-Fa-f]+)} $raw -> word]} {
            error "Could not parse event $i word $j: $raw"
        }
        lappend words $word
    }
    puts "EVENT $i [join $words { }]"
}
configparams force-mem-access 0
disconnect
puts "ZYNQ_SPI_SNAPSHOT_READONLY_DONE"

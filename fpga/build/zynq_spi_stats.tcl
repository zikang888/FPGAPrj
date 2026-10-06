# Read or clear the PL-side SPI acceptance counters over XSCT/JTAG.
#
# Clear before a run:
#   set SPI_STATS_ACTION clear
#   source fpga/build/zynq_spi_stats.tcl
# Read and check 100 JEDEC transactions after the STM32 run:
#   set SPI_STATS_ACTION check
#   set SPI_EXPECTED_TRANSACTIONS 100
#   source fpga/build/zynq_spi_stats.tcl

set base 0x40000000
set action read
if {[info exists SPI_STATS_ACTION] && $SPI_STATS_ACTION ne ""} {
    set action $SPI_STATS_ACTION
} elseif {[info exists ::env(SPI_STATS_ACTION)] &&
          $::env(SPI_STATS_ACTION) ne ""} {
    set action $::env(SPI_STATS_ACTION)
}
set expected_transactions 0
if {[info exists SPI_EXPECTED_TRANSACTIONS] &&
    $SPI_EXPECTED_TRANSACTIONS ne ""} {
    set expected_transactions $SPI_EXPECTED_TRANSACTIONS
} elseif {[info exists ::env(SPI_EXPECTED_TRANSACTIONS)] &&
          $::env(SPI_EXPECTED_TRANSACTIONS) ne ""} {
    set expected_transactions $::env(SPI_EXPECTED_TRANSACTIONS)
}

proc read_word {address} {
    return [lindex [mrd -value $address] 0]
}

connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
configparams force-mem-access 1

if {$action eq "clear"} {
    mwr [expr {$base + 0x64}] 0x00000001
    set remaining [read_word [expr {$base + 0x3C}]]
    configparams force-mem-access 0
    disconnect
    if {$remaining != 0} {
        error "SPI statistics clear failed: event_count=$remaining"
    }
    puts "SPI_STATS_CLEARED"
    return
}

array set stats {}
foreach {name offset} {
    dropped        0x38
    events         0x3C
    starts         0x40
    data           0x44
    ends           0x48
    frame_errors   0x4C
    boundary_errors 0x50
    duplicates     0x54
    sequence_errors 0x58
    last_txn       0x5C
    status         0x60
} {
    set stats($name) [read_word [expr {$base + $offset}]]
    puts [format "SPI_STATS %-16s %u" $name $stats($name)]
}

set failures 0
if {$stats(dropped) != 0} {incr failures}
if {$stats(frame_errors) != 0} {incr failures}
if {$stats(boundary_errors) != 0} {incr failures}
if {$stats(duplicates) != 0} {incr failures}
if {$stats(sequence_errors) != 0} {incr failures}
if {($stats(status) & 1) != 0} {incr failures}
if {$stats(starts) != $stats(ends)} {incr failures}
if {$stats(events) !=
    ($stats(starts) + $stats(data) + $stats(ends) + $stats(frame_errors))} {
    incr failures
}
if {$expected_transactions > 0} {
    if {$stats(starts) != $expected_transactions} {incr failures}
    if {$stats(data) != (4 * $expected_transactions)} {incr failures}
    if {$stats(ends) != $expected_transactions} {incr failures}
    if {$stats(events) != (6 * $expected_transactions)} {incr failures}
}

configparams force-mem-access 0
disconnect
if {$action eq "check" && $failures != 0} {
    error "SPI acceptance check failed: failures=$failures"
}
if {$failures == 0} {
    puts "SPI_ACCEPTANCE_PASS"
} else {
    puts "SPI_ACCEPTANCE_ATTENTION failures=$failures"
}


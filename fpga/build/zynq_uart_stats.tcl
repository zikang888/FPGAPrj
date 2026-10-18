# Read or clear the PL passive-UART counters over XSCT/JTAG.
# UART_STATS_ACTION=clear resets the counters. UART_STATS_ACTION=check and
# UART_EXPECTED_TRANSACTIONS=1 verifies one eight-byte 8N1 transaction.

set base 0x40000000
set action read
if {[info exists ::env(UART_STATS_ACTION)] &&
    $::env(UART_STATS_ACTION) ne ""} {
    set action $::env(UART_STATS_ACTION)
}
set expected_transactions 0
if {[info exists ::env(UART_EXPECTED_TRANSACTIONS)] &&
    $::env(UART_EXPECTED_TRANSACTIONS) ne ""} {
    set expected_transactions $::env(UART_EXPECTED_TRANSACTIONS)
}
if {$action ni {read clear check}} {
    error "UART_STATS_ACTION must be read, clear or check"
}
if {![string is integer -strict $expected_transactions] ||
    $expected_transactions < 0} {
    error "UART_EXPECTED_TRANSACTIONS must be a nonnegative integer"
}

proc uart_read_word {address} {
    return [lindex [mrd -value $address] 0]
}

connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
configparams force-mem-access 1
set sys_id [uart_read_word [expr {$base + 0x00}]]
set capabilities [uart_read_word [expr {$base + 0x0C}]]
if {$sys_id != 0x4D505254 || ($capabilities & 0x20) == 0} {
    configparams force-mem-access 0
    disconnect
    error [format "UART monitor not loaded: SYS_ID=0x%08X CAP=0x%08X" \
               $sys_id $capabilities]
}

if {$action eq "clear"} {
    mwr [expr {$base + 0x90}] 0x00000001
    set remaining [uart_read_word [expr {$base + 0x74}]]
    configparams force-mem-access 0
    disconnect
    if {$remaining != 0} {
        error "UART statistics clear failed: event_count=$remaining"
    }
    puts "UART_STATS_CLEARED"
    return
}

array set stats {}
foreach {name offset} {
    events 0x74
    data 0x78
    bad_stop 0x7C
    break 0x80
    short_transaction 0x84
    last_txn 0x88
    status 0x8C
    dropped 0x38
} {
    set stats($name) [uart_read_word [expr {$base + $offset}]]
    puts [format "UART_STATS %-18s %u" $name $stats($name)]
}

set failures 0
if {$action eq "check"} {
    if {$stats(bad_stop) != 0 || $stats(break) != 0 ||
        $stats(short_transaction) != 0 || $stats(dropped) != 0 ||
        ($stats(status) & 8) != 0} {
        incr failures
    }
    if {$expected_transactions > 0 &&
        ($stats(data) != 8 * $expected_transactions ||
         $stats(events) != 10 * $expected_transactions)} {
        incr failures
    }
}
configparams force-mem-access 0
disconnect
if {$action eq "check" && $failures != 0} {
    error "UART acceptance check failed: failures=$failures"
}
if {$action eq "check"} {
    puts "UART_ACCEPTANCE_PASS"
} else {
    puts "UART_STATS_READ_DONE"
}

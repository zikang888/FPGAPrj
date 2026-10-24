set action [lindex $argv 0]
connect -url tcp:127.0.0.1:3121
set cpus [targets -target-properties -filter {name =~ "*Cortex-A9*#0*"}]
if {[llength $cpus] != 1} {error "Expected exactly one CPU0"}
targets -set -filter {name =~ "*Cortex-A9*#0*"}
configparams force-mem-access 1
proc rd {a} {return [lindex [mrd -value $a] 0]}
if {[rd 0x40000000] != 0x4D505254} {error "Wrong platform"}
if {$action eq "platform"} {
    foreach {n a expected} {
        SYS_ID 0x40000000 0x4D505254
        VERSION 0x40000004 0x10008
        BUILD_ID 0x40000008 0x20261021
        CAPABILITIES 0x4000000C 0x1FF
    } {
        set v [rd $a]
        puts [format "REG %s 0x%08X" $n $v]
        if {$v != $expected} {error "Unexpected $n"}
    }
    foreach a {0x4000002C 0x40000030} {
        set old [rd $a]
        set test [expr {$a == 0x4000002C ? 0x5AA5C33C : ($old ^ 1)}]
        mwr $a $test
        set got [rd $a]
        mwr $a $old
        if {$got != $test || [rd $a] != $old} {error "RW/restore failed at $a"}
        puts [format "RW_RESTORE_PASS 0x%08X" $a]
    }
    set t0 [rd 0x40000024]
    after 20
    set t1 [rd 0x40000024]
    if {$t0 == $t1} {error "Timestamp stuck"}
    puts "TIMESTAMP_PROGRESS_PASS $t0 $t1"
    puts "PLATFORM_PASS"
} elseif {$action eq "clear"} {
    foreach a {0x40000064 0x40000090 0x400000B4 0x400000DC} {mwr $a 1}
    foreach a {0x4000003C 0x40000074 0x40000094 0x400000B8} {
        if {[rd $a] != 0} {error "Counter clear failed $a"}
    }
    puts "COUNTERS_CLEARED"
} elseif {$action eq "stats"} {
    foreach {n a} {
        EXT_DROPPED 0x40000038
        SPI_EVENTS 0x4000003C SPI_STARTS 0x40000040 SPI_DATA 0x40000044 SPI_ENDS 0x40000048
        SPI_FRAME 0x4000004C SPI_BOUNDARY 0x40000050 SPI_DUPLICATE 0x40000054 SPI_SEQUENCE 0x40000058
        SPI_SHORT 0x40000068 SPI_EXTRA 0x4000006C SPI_MISMATCH 0x40000070
        UART_EVENTS 0x40000074 UART_DATA 0x40000078 UART_STOP 0x4000007C UART_BREAK 0x40000080 UART_SHORT 0x40000084
        I2C_EVENTS 0x40000094 I2C_DATA 0x40000098 I2C_NACK 0x4000009C I2C_BUSY 0x400000A0
        I2C_SDA 0x400000A4 I2C_SCL 0x400000A8 I2C_STOP 0x400000AC
        CAN_EVENTS 0x400000B8 CAN_FRAMES 0x400000BC CAN_ACK 0x400000C0 CAN_BIT 0x400000C4
        CAN_STUFF 0x400000C8 CAN_CRC 0x400000CC CAN_FORM 0x400000D0 CAN_BUSOFF 0x400000D4
        CAPTURE_STATUS 0x40001004 SNAPSHOT_ID 0x40001008 SNAPSHOT_COUNT 0x4000100C
        CAPTURE_DROPPED 0x40001014 CAPTURE_TOTAL 0x4000101C
    } {puts "STAT $n [rd $a]"}
    set count [rd 0x4000100C]
    for {set i 0} {$i < $count && $i < 256} {incr i} {
        set a [expr {0x40006000+16*$i}]
        puts "EVENT $i [mrd -value $a 4]"
    }
} elseif {$action eq "dump"} {
    set out [file normalize [lindex $argv 1]]
    file mkdir $out
    foreach {n a} {frame0 0x01100000 frame1 0x01220000} {
        set p [file join $out $n.rgb]
        mrd -size b -bin -file $p $a 1152000
        puts "FRAMEBUFFER $p [file size $p]"
    }
} else {error "Unknown action $action"}
configparams force-mem-access 0
disconnect
puts "BOARD_PROBE_DONE $action"
flush stdout
exit

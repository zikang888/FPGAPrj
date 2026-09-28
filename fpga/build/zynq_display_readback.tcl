# Read-only display-path probe; pause CPU briefly for coherent JTAG reads.
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
set stopped [expr {![catch {stop}]}]
configparams force-mem-access 1
foreach {label address} {
    VDMA_CONTROL 0x43000000
    VDMA_STATUS 0x43000004
    VDMA_PARK 0x43000028
    VDMA_FRAME_0 0x4300005C
    VDMA_FRAME_1 0x43000060
    VDMA_STRIDE 0x43000058
    VDMA_HSIZE 0x43000054
    VDMA_VSIZE 0x43000050
    VTC_CONTROL 0x43C00000
    VTC_STATUS 0x43C00004
    FRAME0_START 0x01100000
    FRAME0_CENTER 0x0118CA80
    FRAME1_START 0x01220000
    FRAME1_CENTER 0x012ACA80
} {
    puts "$label [mrd $address]"
}
configparams force-mem-access 0
if {$stopped} {con}
disconnect
puts "ZYNQ_DISPLAY_READBACK_DONE"

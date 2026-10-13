# Read-only framebuffer dump for visual verification of the 800x480 RGB888 UI.
if {![info exists ::env(ZYNQ_FB_OUT)] || $::env(ZYNQ_FB_OUT) eq ""} {
    error "Set ZYNQ_FB_OUT to an existing output directory"
}
set output_dir [file normalize $::env(ZYNQ_FB_OUT)]
if {![file isdirectory $output_dir]} {error "Missing directory: $output_dir"}
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "ARM*#0"} -index 0
configparams force-mem-access 1
set frame_bytes 1152000
foreach {name address} {frame0 0x01100000 frame1 0x01220000} {
    set output_file [file join $output_dir ${name}.rgb]
    puts "DUMP $name $address $output_file"
    mrd -size b -bin -file $output_file $address $frame_bytes
    puts "DUMP_DONE $name [file size $output_file]"
}
configparams force-mem-access 0
disconnect
puts "ZYNQ_FRAMEBUFFER_DUMP_DONE"

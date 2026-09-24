connect -url tcp:127.0.0.1:3121
source D:/fpga_class/Multi_protocol/artifacts/current/sdk_workspace/platform_hw/ps7_init.tcl
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-SMT2 B1777481ABCD"} -index 0
loadhw -hw D:/fpga_class/Multi_protocol/artifacts/current/sdk_workspace/platform_hw/system.hdf -mem-ranges [list {0x40000000 0xbfffffff}]
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*" && jtag_cable_name =~ "Digilent JTAG-SMT2 B1777481ABCD"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-SMT2 B1777481ABCD"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-SMT2 B1777481ABCD"} -index 0
dow D:/fpga_class/Multi_protocol/artifacts/current/sdk_workspace/platform_app/Debug/platform_app.elf
configparams force-mem-access 0
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent JTAG-SMT2 B1777481ABCD"} -index 0
con

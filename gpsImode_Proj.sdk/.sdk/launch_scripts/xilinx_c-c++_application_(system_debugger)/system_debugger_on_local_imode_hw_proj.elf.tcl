connect -url tcp:127.0.0.1:3121
source E:/Lin/vivado_learing/gpsImode_Proj/gpsImode_Proj.sdk/gpsImode_hw2/ps7_init.tcl
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zed 210248686573"} -index 0
loadhw E:/Lin/vivado_learing/gpsImode_Proj/gpsImode_Proj.sdk/gpsImode_hw2/system.hdf
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zed 210248686573"} -index 0
stop
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zed 210248686573"} -index 0
rst -processor
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zed 210248686573"} -index 0
dow E:/Lin/vivado_learing/gpsImode_Proj/gpsImode_Proj.sdk/Imode_HW_Proj/Debug/Imode_HW_Proj.elf
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zed 210248686573"} -index 0
con

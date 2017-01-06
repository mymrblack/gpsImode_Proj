
################################################################
# This is a generated script based on design: gpsImode
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source gpsImode_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7z020clg484-1
   set_property BOARD_PART em.avnet.com:zed:part0:1.3 [current_project]
}


# CHANGE DESIGN NAME HERE
set design_name gpsImode

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]
  set UART [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 UART ]

  # Create ports
  set AluTrigger [ create_bd_port -dir O AluTrigger ]
  set EF1 [ create_bd_port -dir I EF1 ]
  set EF2 [ create_bd_port -dir I EF2 ]
  set ErrFlag [ create_bd_port -dir I ErrFlag ]
  set IrFlag [ create_bd_port -dir I IrFlag ]
  set PPS_IN [ create_bd_port -dir I PPS_IN ]
  set StartDis [ create_bd_port -dir O StartDis ]
  set StartTrigger [ create_bd_port -dir I StartTrigger ]
  set StopDis1 [ create_bd_port -dir O StopDis1 ]
  set StopDis2 [ create_bd_port -dir O StopDis2 ]
  set StopDis3 [ create_bd_port -dir O StopDis3 ]
  set StopDis4 [ create_bd_port -dir O StopDis4 ]
  set StopTrigger1 [ create_bd_port -dir I StopTrigger1 ]
  set StopTrigger2 [ create_bd_port -dir I StopTrigger2 ]
  set StopTrigger3 [ create_bd_port -dir I StopTrigger3 ]
  set StopTrigger4 [ create_bd_port -dir I StopTrigger4 ]
  set StopTrigger5 [ create_bd_port -dir I StopTrigger5 ]
  set StopTrigger6 [ create_bd_port -dir I StopTrigger6 ]
  set StopTrigger7 [ create_bd_port -dir I StopTrigger7 ]
  set StopTrigger8 [ create_bd_port -dir I StopTrigger8 ]
  set Tstart [ create_bd_port -dir O Tstart ]
  set Tstop1 [ create_bd_port -dir O Tstop1 ]
  set Tstop2 [ create_bd_port -dir O Tstop2 ]
  set Tstop3 [ create_bd_port -dir O Tstop3 ]
  set Tstop4 [ create_bd_port -dir O Tstop4 ]
  set Tstop5 [ create_bd_port -dir O Tstop5 ]
  set Tstop6 [ create_bd_port -dir O Tstop6 ]
  set Tstop7 [ create_bd_port -dir O Tstop7 ]
  set Tstop8 [ create_bd_port -dir O Tstop8 ]
  set addr [ create_bd_port -dir O -from 3 -to 0 addr ]
  set csn [ create_bd_port -dir O csn ]
  set data [ create_bd_port -dir IO -from 27 -to 0 data ]
  set oen [ create_bd_port -dir O oen ]
  set rdn [ create_bd_port -dir O rdn ]
  set wrn [ create_bd_port -dir O wrn ]

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]
  set_property -dict [ list \
CONFIG.C_S_AXI_ACLK_FREQ_HZ {100000000} \
 ] $axi_uartlite_0

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.C_S_AXI_ACLK_FREQ_HZ.VALUE_SRC {DEFAULT} \
 ] $axi_uartlite_0

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_0 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_0

  # Create instance: fifo_generator_1, and set properties
  set fifo_generator_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_1 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_1

  # Create instance: fifo_generator_2, and set properties
  set fifo_generator_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_2 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_2

  # Create instance: fifo_generator_3, and set properties
  set fifo_generator_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_3 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_3

  # Create instance: fifo_generator_4, and set properties
  set fifo_generator_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_4 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_4

  # Create instance: fifo_generator_5, and set properties
  set fifo_generator_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_5 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_5

  # Create instance: fifo_generator_6, and set properties
  set fifo_generator_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_6 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_6

  # Create instance: fifo_generator_7, and set properties
  set fifo_generator_7 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_7 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_7

  # Create instance: fifo_generator_8, and set properties
  set fifo_generator_8 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_8 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_8

  # Create instance: fifo_generator_9, and set properties
  set fifo_generator_9 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_9 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_9

  # Create instance: fifo_generator_10, and set properties
  set fifo_generator_10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_10 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_10

  # Create instance: fifo_generator_11, and set properties
  set fifo_generator_11 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_11 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_11

  # Create instance: fifo_generator_12, and set properties
  set fifo_generator_12 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_12 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_12

  # Create instance: fifo_generator_13, and set properties
  set fifo_generator_13 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_13 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_13

  # Create instance: fifo_generator_14, and set properties
  set fifo_generator_14 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_14 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_14

  # Create instance: fifo_generator_15, and set properties
  set fifo_generator_15 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_15 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {17} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {17} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_15

  # Create instance: fifo_generator_16, and set properties
  set fifo_generator_16 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_16 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {32} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {32} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_16

  # Create instance: fifo_generator_17, and set properties
  set fifo_generator_17 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_17 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {32} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {32} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_17

  # Create instance: fifo_generator_18, and set properties
  set fifo_generator_18 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_18 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {32} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {32} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_18

  # Create instance: fifo_generator_19, and set properties
  set fifo_generator_19 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_19 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {32} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {32} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_19

  # Create instance: fifo_generator_20, and set properties
  set fifo_generator_20 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_20 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {32} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {32} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_20

  # Create instance: fifo_generator_21, and set properties
  set fifo_generator_21 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.1 fifo_generator_21 ]
  set_property -dict [ list \
CONFIG.Data_Count_Width {13} \
CONFIG.Full_Threshold_Assert_Value {8190} \
CONFIG.Full_Threshold_Negate_Value {8189} \
CONFIG.Input_Data_Width {32} \
CONFIG.Input_Depth {8192} \
CONFIG.Output_Data_Width {32} \
CONFIG.Output_Depth {8192} \
CONFIG.Read_Data_Count_Width {13} \
CONFIG.Write_Data_Count_Width {13} \
 ] $fifo_generator_21

  # Create instance: myImode_0, and set properties
  set myImode_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:myImode:1.0 myImode_0 ]

  # Create instance: myip_fifo_ctrl_0, and set properties
  set myip_fifo_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:myip_fifo_ctrl:1.0 myip_fifo_ctrl_0 ]

  # Create instance: newGpsIp_0, and set properties
  set newGpsIp_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:newGpsIp:1.0 newGpsIp_0 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ {10.158730} \
CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ {125.000000} \
CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ {100.000000} \
CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ {200.000000} \
CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ {200.000000} \
CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ {50.000000} \
CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ {10.000000} \
CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ {200.000000} \
CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ {50.000000} \
CONFIG.PCW_APU_CLK_RATIO_ENABLE {6:2:1} \
CONFIG.PCW_APU_PERIPHERAL_FREQMHZ {666.666667} \
CONFIG.PCW_ARMPLL_CTRL_FBDIV {40} \
CONFIG.PCW_CAN0_CAN0_IO {<Select>} \
CONFIG.PCW_CAN0_GRP_CLK_ENABLE {0} \
CONFIG.PCW_CAN0_GRP_CLK_IO {<Select>} \
CONFIG.PCW_CAN0_PERIPHERAL_CLKSRC {External} \
CONFIG.PCW_CAN0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_CAN1_CAN1_IO {<Select>} \
CONFIG.PCW_CAN1_GRP_CLK_ENABLE {0} \
CONFIG.PCW_CAN1_GRP_CLK_IO {<Select>} \
CONFIG.PCW_CAN1_PERIPHERAL_CLKSRC {External} \
CONFIG.PCW_CAN1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_CAN_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_CAN_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_CAN_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_CAN_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_CLK0_FREQ {100000000} \
CONFIG.PCW_CLK1_FREQ {10000000} \
CONFIG.PCW_CLK2_FREQ {10000000} \
CONFIG.PCW_CLK3_FREQ {10000000} \
CONFIG.PCW_CPU_CPU_6X4X_MAX_RANGE {667} \
CONFIG.PCW_CPU_CPU_PLL_FREQMHZ {1333.333} \
CONFIG.PCW_CPU_PERIPHERAL_CLKSRC {ARM PLL} \
CONFIG.PCW_CPU_PERIPHERAL_DIVISOR0 {2} \
CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ {33.333333} \
CONFIG.PCW_DCI_PERIPHERAL_CLKSRC {DDR PLL} \
CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0 {15} \
CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1 {7} \
CONFIG.PCW_DCI_PERIPHERAL_FREQMHZ {10.159} \
CONFIG.PCW_DDRPLL_CTRL_FBDIV {32} \
CONFIG.PCW_DDR_DDR_PLL_FREQMHZ {1066.667} \
CONFIG.PCW_DDR_HPRLPR_QUEUE_PARTITION {HPR(0)/LPR(32)} \
CONFIG.PCW_DDR_HPR_TO_CRITICAL_PRIORITY_LEVEL {15} \
CONFIG.PCW_DDR_LPR_TO_CRITICAL_PRIORITY_LEVEL {2} \
CONFIG.PCW_DDR_PERIPHERAL_CLKSRC {DDR PLL} \
CONFIG.PCW_DDR_PERIPHERAL_DIVISOR0 {2} \
CONFIG.PCW_DDR_PORT0_HPR_ENABLE {0} \
CONFIG.PCW_DDR_PORT1_HPR_ENABLE {0} \
CONFIG.PCW_DDR_PORT2_HPR_ENABLE {0} \
CONFIG.PCW_DDR_PORT3_HPR_ENABLE {0} \
CONFIG.PCW_DDR_PRIORITY_READPORT_0 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_READPORT_1 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_READPORT_2 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_READPORT_3 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_0 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_1 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_2 {<Select>} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_3 {<Select>} \
CONFIG.PCW_DDR_RAM_HIGHADDR {0x1FFFFFFF} \
CONFIG.PCW_DDR_WRITE_TO_CRITICAL_PRIORITY_LEVEL {2} \
CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} \
CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} \
CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53} \
CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0 {8} \
CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ {1000 Mbps} \
CONFIG.PCW_ENET0_RESET_ENABLE {0} \
CONFIG.PCW_ENET0_RESET_IO {<Select>} \
CONFIG.PCW_ENET1_ENET1_IO {<Select>} \
CONFIG.PCW_ENET1_GRP_MDIO_ENABLE {0} \
CONFIG.PCW_ENET1_GRP_MDIO_IO {<Select>} \
CONFIG.PCW_ENET1_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_ENET1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_ENET1_PERIPHERAL_FREQMHZ {1000 Mbps} \
CONFIG.PCW_ENET1_RESET_ENABLE {0} \
CONFIG.PCW_ENET1_RESET_IO {<Select>} \
CONFIG.PCW_ENET_RESET_ENABLE {1} \
CONFIG.PCW_ENET_RESET_POLARITY {Active Low} \
CONFIG.PCW_ENET_RESET_SELECT {Share reset pin} \
CONFIG.PCW_EN_4K_TIMER {0} \
CONFIG.PCW_EN_EMIO_TTC0 {1} \
CONFIG.PCW_EN_ENET0 {1} \
CONFIG.PCW_EN_QSPI {1} \
CONFIG.PCW_EN_SDIO0 {1} \
CONFIG.PCW_EN_TTC0 {1} \
CONFIG.PCW_EN_UART1 {1} \
CONFIG.PCW_EN_USB0 {1} \
CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR0 {5} \
CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR1 {2} \
CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_FCLK2_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_FCLK3_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR1 {1} \
CONFIG.PCW_FCLK_CLK0_BUF {true} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100.000000} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {150.000000} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_FPGA_FCLK0_ENABLE {1} \
CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE {0} \
CONFIG.PCW_GPIO_EMIO_GPIO_IO {<Select>} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE {1} \
CONFIG.PCW_GPIO_MIO_GPIO_IO {MIO} \
CONFIG.PCW_GPIO_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_I2C0_GRP_INT_ENABLE {0} \
CONFIG.PCW_I2C0_GRP_INT_IO {<Select>} \
CONFIG.PCW_I2C0_I2C0_IO {<Select>} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_I2C0_RESET_ENABLE {0} \
CONFIG.PCW_I2C0_RESET_IO {<Select>} \
CONFIG.PCW_I2C1_GRP_INT_ENABLE {0} \
CONFIG.PCW_I2C1_GRP_INT_IO {<Select>} \
CONFIG.PCW_I2C1_I2C1_IO {<Select>} \
CONFIG.PCW_I2C1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_I2C1_RESET_ENABLE {0} \
CONFIG.PCW_I2C1_RESET_IO {<Select>} \
CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ {25} \
CONFIG.PCW_I2C_RESET_ENABLE {1} \
CONFIG.PCW_I2C_RESET_POLARITY {Active Low} \
CONFIG.PCW_I2C_RESET_SELECT {<Select>} \
CONFIG.PCW_IOPLL_CTRL_FBDIV {30} \
CONFIG.PCW_IO_IO_PLL_FREQMHZ {1000.000} \
CONFIG.PCW_IRQ_F2P_INTR {1} \
CONFIG.PCW_MIO_0_DIRECTION {inout} \
CONFIG.PCW_MIO_0_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_0_PULLUP {disabled} \
CONFIG.PCW_MIO_0_SLEW {slow} \
CONFIG.PCW_MIO_10_DIRECTION {inout} \
CONFIG.PCW_MIO_10_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_10_PULLUP {disabled} \
CONFIG.PCW_MIO_10_SLEW {slow} \
CONFIG.PCW_MIO_11_DIRECTION {inout} \
CONFIG.PCW_MIO_11_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_11_PULLUP {disabled} \
CONFIG.PCW_MIO_11_SLEW {slow} \
CONFIG.PCW_MIO_12_DIRECTION {inout} \
CONFIG.PCW_MIO_12_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_12_PULLUP {disabled} \
CONFIG.PCW_MIO_12_SLEW {slow} \
CONFIG.PCW_MIO_13_DIRECTION {inout} \
CONFIG.PCW_MIO_13_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_13_PULLUP {disabled} \
CONFIG.PCW_MIO_13_SLEW {slow} \
CONFIG.PCW_MIO_14_DIRECTION {inout} \
CONFIG.PCW_MIO_14_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_14_PULLUP {disabled} \
CONFIG.PCW_MIO_14_SLEW {slow} \
CONFIG.PCW_MIO_15_DIRECTION {inout} \
CONFIG.PCW_MIO_15_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_15_PULLUP {disabled} \
CONFIG.PCW_MIO_15_SLEW {slow} \
CONFIG.PCW_MIO_16_DIRECTION {out} \
CONFIG.PCW_MIO_16_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_16_PULLUP {disabled} \
CONFIG.PCW_MIO_16_SLEW {fast} \
CONFIG.PCW_MIO_17_DIRECTION {out} \
CONFIG.PCW_MIO_17_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_17_PULLUP {disabled} \
CONFIG.PCW_MIO_17_SLEW {fast} \
CONFIG.PCW_MIO_18_DIRECTION {out} \
CONFIG.PCW_MIO_18_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_18_PULLUP {disabled} \
CONFIG.PCW_MIO_18_SLEW {fast} \
CONFIG.PCW_MIO_19_DIRECTION {out} \
CONFIG.PCW_MIO_19_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_19_PULLUP {disabled} \
CONFIG.PCW_MIO_19_SLEW {fast} \
CONFIG.PCW_MIO_1_DIRECTION {out} \
CONFIG.PCW_MIO_1_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_1_PULLUP {disabled} \
CONFIG.PCW_MIO_1_SLEW {fast} \
CONFIG.PCW_MIO_20_DIRECTION {out} \
CONFIG.PCW_MIO_20_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_20_PULLUP {disabled} \
CONFIG.PCW_MIO_20_SLEW {fast} \
CONFIG.PCW_MIO_21_DIRECTION {out} \
CONFIG.PCW_MIO_21_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_21_PULLUP {disabled} \
CONFIG.PCW_MIO_21_SLEW {fast} \
CONFIG.PCW_MIO_22_DIRECTION {in} \
CONFIG.PCW_MIO_22_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_22_PULLUP {disabled} \
CONFIG.PCW_MIO_22_SLEW {fast} \
CONFIG.PCW_MIO_23_DIRECTION {in} \
CONFIG.PCW_MIO_23_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_23_PULLUP {disabled} \
CONFIG.PCW_MIO_23_SLEW {fast} \
CONFIG.PCW_MIO_24_DIRECTION {in} \
CONFIG.PCW_MIO_24_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_24_PULLUP {disabled} \
CONFIG.PCW_MIO_24_SLEW {fast} \
CONFIG.PCW_MIO_25_DIRECTION {in} \
CONFIG.PCW_MIO_25_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_25_PULLUP {disabled} \
CONFIG.PCW_MIO_25_SLEW {fast} \
CONFIG.PCW_MIO_26_DIRECTION {in} \
CONFIG.PCW_MIO_26_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_26_PULLUP {disabled} \
CONFIG.PCW_MIO_26_SLEW {fast} \
CONFIG.PCW_MIO_27_DIRECTION {in} \
CONFIG.PCW_MIO_27_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_27_PULLUP {disabled} \
CONFIG.PCW_MIO_27_SLEW {fast} \
CONFIG.PCW_MIO_28_DIRECTION {inout} \
CONFIG.PCW_MIO_28_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_28_PULLUP {disabled} \
CONFIG.PCW_MIO_28_SLEW {fast} \
CONFIG.PCW_MIO_29_DIRECTION {in} \
CONFIG.PCW_MIO_29_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_29_PULLUP {disabled} \
CONFIG.PCW_MIO_29_SLEW {fast} \
CONFIG.PCW_MIO_2_DIRECTION {inout} \
CONFIG.PCW_MIO_2_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_2_PULLUP {disabled} \
CONFIG.PCW_MIO_2_SLEW {fast} \
CONFIG.PCW_MIO_30_DIRECTION {out} \
CONFIG.PCW_MIO_30_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_30_PULLUP {disabled} \
CONFIG.PCW_MIO_30_SLEW {fast} \
CONFIG.PCW_MIO_31_DIRECTION {in} \
CONFIG.PCW_MIO_31_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_31_PULLUP {disabled} \
CONFIG.PCW_MIO_31_SLEW {fast} \
CONFIG.PCW_MIO_32_DIRECTION {inout} \
CONFIG.PCW_MIO_32_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_32_PULLUP {disabled} \
CONFIG.PCW_MIO_32_SLEW {fast} \
CONFIG.PCW_MIO_33_DIRECTION {inout} \
CONFIG.PCW_MIO_33_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_33_PULLUP {disabled} \
CONFIG.PCW_MIO_33_SLEW {fast} \
CONFIG.PCW_MIO_34_DIRECTION {inout} \
CONFIG.PCW_MIO_34_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_34_PULLUP {disabled} \
CONFIG.PCW_MIO_34_SLEW {fast} \
CONFIG.PCW_MIO_35_DIRECTION {inout} \
CONFIG.PCW_MIO_35_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_35_PULLUP {disabled} \
CONFIG.PCW_MIO_35_SLEW {fast} \
CONFIG.PCW_MIO_36_DIRECTION {in} \
CONFIG.PCW_MIO_36_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_36_PULLUP {disabled} \
CONFIG.PCW_MIO_36_SLEW {fast} \
CONFIG.PCW_MIO_37_DIRECTION {inout} \
CONFIG.PCW_MIO_37_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_37_PULLUP {disabled} \
CONFIG.PCW_MIO_37_SLEW {fast} \
CONFIG.PCW_MIO_38_DIRECTION {inout} \
CONFIG.PCW_MIO_38_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_38_PULLUP {disabled} \
CONFIG.PCW_MIO_38_SLEW {fast} \
CONFIG.PCW_MIO_39_DIRECTION {inout} \
CONFIG.PCW_MIO_39_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_39_PULLUP {disabled} \
CONFIG.PCW_MIO_39_SLEW {fast} \
CONFIG.PCW_MIO_3_DIRECTION {inout} \
CONFIG.PCW_MIO_3_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_3_PULLUP {disabled} \
CONFIG.PCW_MIO_3_SLEW {fast} \
CONFIG.PCW_MIO_40_DIRECTION {inout} \
CONFIG.PCW_MIO_40_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_40_PULLUP {disabled} \
CONFIG.PCW_MIO_40_SLEW {fast} \
CONFIG.PCW_MIO_41_DIRECTION {inout} \
CONFIG.PCW_MIO_41_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_41_PULLUP {disabled} \
CONFIG.PCW_MIO_41_SLEW {fast} \
CONFIG.PCW_MIO_42_DIRECTION {inout} \
CONFIG.PCW_MIO_42_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_42_PULLUP {disabled} \
CONFIG.PCW_MIO_42_SLEW {fast} \
CONFIG.PCW_MIO_43_DIRECTION {inout} \
CONFIG.PCW_MIO_43_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_43_PULLUP {disabled} \
CONFIG.PCW_MIO_43_SLEW {fast} \
CONFIG.PCW_MIO_44_DIRECTION {inout} \
CONFIG.PCW_MIO_44_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_44_PULLUP {disabled} \
CONFIG.PCW_MIO_44_SLEW {fast} \
CONFIG.PCW_MIO_45_DIRECTION {inout} \
CONFIG.PCW_MIO_45_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_45_PULLUP {disabled} \
CONFIG.PCW_MIO_45_SLEW {fast} \
CONFIG.PCW_MIO_46_DIRECTION {in} \
CONFIG.PCW_MIO_46_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_46_PULLUP {disabled} \
CONFIG.PCW_MIO_46_SLEW {slow} \
CONFIG.PCW_MIO_47_DIRECTION {in} \
CONFIG.PCW_MIO_47_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_47_PULLUP {disabled} \
CONFIG.PCW_MIO_47_SLEW {slow} \
CONFIG.PCW_MIO_48_DIRECTION {out} \
CONFIG.PCW_MIO_48_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_48_PULLUP {disabled} \
CONFIG.PCW_MIO_48_SLEW {slow} \
CONFIG.PCW_MIO_49_DIRECTION {in} \
CONFIG.PCW_MIO_49_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_49_PULLUP {disabled} \
CONFIG.PCW_MIO_49_SLEW {slow} \
CONFIG.PCW_MIO_4_DIRECTION {inout} \
CONFIG.PCW_MIO_4_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_4_PULLUP {disabled} \
CONFIG.PCW_MIO_4_SLEW {fast} \
CONFIG.PCW_MIO_50_DIRECTION {inout} \
CONFIG.PCW_MIO_50_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_50_PULLUP {disabled} \
CONFIG.PCW_MIO_50_SLEW {slow} \
CONFIG.PCW_MIO_51_DIRECTION {inout} \
CONFIG.PCW_MIO_51_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_51_PULLUP {disabled} \
CONFIG.PCW_MIO_51_SLEW {slow} \
CONFIG.PCW_MIO_52_DIRECTION {out} \
CONFIG.PCW_MIO_52_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_52_PULLUP {disabled} \
CONFIG.PCW_MIO_52_SLEW {slow} \
CONFIG.PCW_MIO_53_DIRECTION {inout} \
CONFIG.PCW_MIO_53_IOTYPE {LVCMOS 1.8V} \
CONFIG.PCW_MIO_53_PULLUP {disabled} \
CONFIG.PCW_MIO_53_SLEW {slow} \
CONFIG.PCW_MIO_5_DIRECTION {inout} \
CONFIG.PCW_MIO_5_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_5_PULLUP {disabled} \
CONFIG.PCW_MIO_5_SLEW {fast} \
CONFIG.PCW_MIO_6_DIRECTION {out} \
CONFIG.PCW_MIO_6_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_6_PULLUP {disabled} \
CONFIG.PCW_MIO_6_SLEW {fast} \
CONFIG.PCW_MIO_7_DIRECTION {out} \
CONFIG.PCW_MIO_7_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_7_PULLUP {disabled} \
CONFIG.PCW_MIO_7_SLEW {slow} \
CONFIG.PCW_MIO_8_DIRECTION {out} \
CONFIG.PCW_MIO_8_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_8_PULLUP {disabled} \
CONFIG.PCW_MIO_8_SLEW {fast} \
CONFIG.PCW_MIO_9_DIRECTION {inout} \
CONFIG.PCW_MIO_9_IOTYPE {LVCMOS 3.3V} \
CONFIG.PCW_MIO_9_PULLUP {disabled} \
CONFIG.PCW_MIO_9_SLEW {slow} \
CONFIG.PCW_MIO_TREE_PERIPHERALS {GPIO#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#GPIO#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#Enet 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#SD 0#UART 1#UART 1#GPIO#GPIO#Enet 0#Enet 0} \
CONFIG.PCW_MIO_TREE_SIGNALS {gpio[0]#qspi0_ss_b#qspi0_io[0]#qspi0_io[1]#qspi0_io[2]#qspi0_io[3]#qspi0_sclk#gpio[7]#gpio[8]#gpio[9]#gpio[10]#gpio[11]#gpio[12]#gpio[13]#gpio[14]#gpio[15]#tx_clk#txd[0]#txd[1]#txd[2]#txd[3]#tx_ctl#rx_clk#rxd[0]#rxd[1]#rxd[2]#rxd[3]#rx_ctl#data[4]#dir#stp#nxt#data[0]#data[1]#data[2]#data[3]#clk#data[5]#data[6]#data[7]#clk#cmd#data[0]#data[1]#data[2]#data[3]#wp#cd#tx#rx#gpio[50]#gpio[51]#mdc#mdio} \
CONFIG.PCW_NAND_CYCLES_T_AR {1} \
CONFIG.PCW_NAND_CYCLES_T_CLR {1} \
CONFIG.PCW_NAND_CYCLES_T_RC {11} \
CONFIG.PCW_NAND_CYCLES_T_REA {1} \
CONFIG.PCW_NAND_CYCLES_T_RR {1} \
CONFIG.PCW_NAND_CYCLES_T_WC {11} \
CONFIG.PCW_NAND_CYCLES_T_WP {1} \
CONFIG.PCW_NAND_GRP_D8_ENABLE {0} \
CONFIG.PCW_NAND_GRP_D8_IO {<Select>} \
CONFIG.PCW_NAND_NAND_IO {<Select>} \
CONFIG.PCW_NAND_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_NOR_CS0_T_CEOE {1} \
CONFIG.PCW_NOR_CS0_T_PC {1} \
CONFIG.PCW_NOR_CS0_T_RC {11} \
CONFIG.PCW_NOR_CS0_T_TR {1} \
CONFIG.PCW_NOR_CS0_T_WC {11} \
CONFIG.PCW_NOR_CS0_T_WP {1} \
CONFIG.PCW_NOR_CS0_WE_TIME {0} \
CONFIG.PCW_NOR_CS1_T_CEOE {1} \
CONFIG.PCW_NOR_CS1_T_PC {1} \
CONFIG.PCW_NOR_CS1_T_RC {11} \
CONFIG.PCW_NOR_CS1_T_TR {1} \
CONFIG.PCW_NOR_CS1_T_WC {11} \
CONFIG.PCW_NOR_CS1_T_WP {1} \
CONFIG.PCW_NOR_CS1_WE_TIME {0} \
CONFIG.PCW_NOR_GRP_A25_ENABLE {0} \
CONFIG.PCW_NOR_GRP_A25_IO {<Select>} \
CONFIG.PCW_NOR_GRP_CS0_ENABLE {0} \
CONFIG.PCW_NOR_GRP_CS0_IO {<Select>} \
CONFIG.PCW_NOR_GRP_CS1_ENABLE {0} \
CONFIG.PCW_NOR_GRP_CS1_IO {<Select>} \
CONFIG.PCW_NOR_GRP_SRAM_CS0_ENABLE {0} \
CONFIG.PCW_NOR_GRP_SRAM_CS0_IO {<Select>} \
CONFIG.PCW_NOR_GRP_SRAM_CS1_ENABLE {0} \
CONFIG.PCW_NOR_GRP_SRAM_CS1_IO {<Select>} \
CONFIG.PCW_NOR_GRP_SRAM_INT_ENABLE {0} \
CONFIG.PCW_NOR_GRP_SRAM_INT_IO {<Select>} \
CONFIG.PCW_NOR_NOR_IO {<Select>} \
CONFIG.PCW_NOR_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_NOR_SRAM_CS0_T_CEOE {1} \
CONFIG.PCW_NOR_SRAM_CS0_T_PC {1} \
CONFIG.PCW_NOR_SRAM_CS0_T_RC {11} \
CONFIG.PCW_NOR_SRAM_CS0_T_TR {1} \
CONFIG.PCW_NOR_SRAM_CS0_T_WC {11} \
CONFIG.PCW_NOR_SRAM_CS0_T_WP {1} \
CONFIG.PCW_NOR_SRAM_CS0_WE_TIME {0} \
CONFIG.PCW_NOR_SRAM_CS1_T_CEOE {1} \
CONFIG.PCW_NOR_SRAM_CS1_T_PC {1} \
CONFIG.PCW_NOR_SRAM_CS1_T_RC {11} \
CONFIG.PCW_NOR_SRAM_CS1_T_TR {1} \
CONFIG.PCW_NOR_SRAM_CS1_T_WC {11} \
CONFIG.PCW_NOR_SRAM_CS1_T_WP {1} \
CONFIG.PCW_NOR_SRAM_CS1_WE_TIME {0} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY0 {0.063} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY1 {0.062} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY2 {0.065} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY3 {0.083} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_0 {-0.007} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_1 {-0.010} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_2 {-0.006} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_3 {-0.048} \
CONFIG.PCW_PCAP_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0 {5} \
CONFIG.PCW_PCAP_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_PERIPHERAL_BOARD_PRESET {part0} \
CONFIG.PCW_PJTAG_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_PJTAG_PJTAG_IO {<Select>} \
CONFIG.PCW_PLL_BYPASSMODE_ENABLE {0} \
CONFIG.PCW_PRESET_BANK0_VOLTAGE {LVCMOS 3.3V} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} \
CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE {0} \
CONFIG.PCW_QSPI_GRP_FBCLK_IO {<Select>} \
CONFIG.PCW_QSPI_GRP_IO1_ENABLE {0} \
CONFIG.PCW_QSPI_GRP_IO1_IO {<Select>} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO {MIO 1 .. 6} \
CONFIG.PCW_QSPI_GRP_SS1_ENABLE {0} \
CONFIG.PCW_QSPI_GRP_SS1_IO {<Select>} \
CONFIG.PCW_QSPI_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0 {5} \
CONFIG.PCW_QSPI_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_QSPI_QSPI_IO {MIO 1 .. 6} \
CONFIG.PCW_SD0_GRP_CD_ENABLE {1} \
CONFIG.PCW_SD0_GRP_CD_IO {MIO 47} \
CONFIG.PCW_SD0_GRP_POW_ENABLE {0} \
CONFIG.PCW_SD0_GRP_POW_IO {<Select>} \
CONFIG.PCW_SD0_GRP_WP_ENABLE {1} \
CONFIG.PCW_SD0_GRP_WP_IO {MIO 46} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} \
CONFIG.PCW_SD1_GRP_CD_ENABLE {0} \
CONFIG.PCW_SD1_GRP_CD_IO {<Select>} \
CONFIG.PCW_SD1_GRP_POW_ENABLE {0} \
CONFIG.PCW_SD1_GRP_POW_IO {<Select>} \
CONFIG.PCW_SD1_GRP_WP_ENABLE {0} \
CONFIG.PCW_SD1_GRP_WP_IO {<Select>} \
CONFIG.PCW_SD1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SD1_SD1_IO {<Select>} \
CONFIG.PCW_SDIO_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0 {20} \
CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_SDIO_PERIPHERAL_VALID {1} \
CONFIG.PCW_SMC_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_SMC_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_SMC_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_SPI0_GRP_SS0_ENABLE {0} \
CONFIG.PCW_SPI0_GRP_SS0_IO {<Select>} \
CONFIG.PCW_SPI0_GRP_SS1_ENABLE {0} \
CONFIG.PCW_SPI0_GRP_SS1_IO {<Select>} \
CONFIG.PCW_SPI0_GRP_SS2_ENABLE {0} \
CONFIG.PCW_SPI0_GRP_SS2_IO {<Select>} \
CONFIG.PCW_SPI0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SPI0_SPI0_IO {<Select>} \
CONFIG.PCW_SPI1_GRP_SS0_ENABLE {0} \
CONFIG.PCW_SPI1_GRP_SS0_IO {<Select>} \
CONFIG.PCW_SPI1_GRP_SS1_ENABLE {0} \
CONFIG.PCW_SPI1_GRP_SS1_IO {<Select>} \
CONFIG.PCW_SPI1_GRP_SS2_ENABLE {0} \
CONFIG.PCW_SPI1_GRP_SS2_IO {<Select>} \
CONFIG.PCW_SPI1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_SPI1_SPI1_IO {<Select>} \
CONFIG.PCW_SPI_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_SPI_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_SPI_PERIPHERAL_FREQMHZ {166.666666} \
CONFIG.PCW_S_AXI_HP0_DATA_WIDTH {64} \
CONFIG.PCW_S_AXI_HP1_DATA_WIDTH {64} \
CONFIG.PCW_S_AXI_HP2_DATA_WIDTH {64} \
CONFIG.PCW_S_AXI_HP3_DATA_WIDTH {64} \
CONFIG.PCW_TPIU_PERIPHERAL_CLKSRC {External} \
CONFIG.PCW_TPIU_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TPIU_PERIPHERAL_FREQMHZ {200} \
CONFIG.PCW_TRACE_GRP_16BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_16BIT_IO {<Select>} \
CONFIG.PCW_TRACE_GRP_2BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_2BIT_IO {<Select>} \
CONFIG.PCW_TRACE_GRP_32BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_32BIT_IO {<Select>} \
CONFIG.PCW_TRACE_GRP_4BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_4BIT_IO {<Select>} \
CONFIG.PCW_TRACE_GRP_8BIT_ENABLE {0} \
CONFIG.PCW_TRACE_GRP_8BIT_IO {<Select>} \
CONFIG.PCW_TRACE_INTERNAL_WIDTH {2} \
CONFIG.PCW_TRACE_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_TRACE_TRACE_IO {<Select>} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_TTC0_TTC0_IO {EMIO} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_TTC1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_TTC1_TTC1_IO {<Select>} \
CONFIG.PCW_TTC_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_UART0_BAUD_RATE {115200} \
CONFIG.PCW_UART0_GRP_FULL_ENABLE {0} \
CONFIG.PCW_UART0_GRP_FULL_IO {<Select>} \
CONFIG.PCW_UART0_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_UART0_UART0_IO {<Select>} \
CONFIG.PCW_UART1_BAUD_RATE {115200} \
CONFIG.PCW_UART1_GRP_FULL_ENABLE {0} \
CONFIG.PCW_UART1_GRP_FULL_IO {<Select>} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_UART1_UART1_IO {MIO 48 .. 49} \
CONFIG.PCW_UART_PERIPHERAL_CLKSRC {IO PLL} \
CONFIG.PCW_UART_PERIPHERAL_DIVISOR0 {20} \
CONFIG.PCW_UART_PERIPHERAL_FREQMHZ {50} \
CONFIG.PCW_UART_PERIPHERAL_VALID {1} \
CONFIG.PCW_UIPARAM_DDR_ADV_ENABLE {0} \
CONFIG.PCW_UIPARAM_DDR_AL {0} \
CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT {3} \
CONFIG.PCW_UIPARAM_DDR_BL {8} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0 {0.41} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1 {0.411} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2 {0.341} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3 {0.358} \
CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {32 Bit} \
CONFIG.PCW_UIPARAM_DDR_CL {7} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PACKAGE_LENGTH {61.0905} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PACKAGE_LENGTH {61.0905} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PACKAGE_LENGTH {61.0905} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PACKAGE_LENGTH {61.0905} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_STOP_EN {0} \
CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT {10} \
CONFIG.PCW_UIPARAM_DDR_CWL {6} \
CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY {2048 MBits} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_PACKAGE_LENGTH {68.4725} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_PACKAGE_LENGTH {71.086} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_PACKAGE_LENGTH {66.794} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_PACKAGE_LENGTH {108.7385} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0 {0.025} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1 {0.028} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2 {-0.009} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3 {-0.061} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_PACKAGE_LENGTH {64.1705} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_PACKAGE_LENGTH {63.686} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_PACKAGE_LENGTH {68.46} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_LENGTH_MM {0} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_PACKAGE_LENGTH {105.4895} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_PROPOGATION_DELAY {160} \
CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH {16 Bits} \
CONFIG.PCW_UIPARAM_DDR_ECC {Disabled} \
CONFIG.PCW_UIPARAM_DDR_ENABLE {1} \
CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {533.333313} \
CONFIG.PCW_UIPARAM_DDR_HIGH_TEMP {Normal (0-85)} \
CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE {DDR 3} \
CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41J128M16 HA-15E} \
CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT {14} \
CONFIG.PCW_UIPARAM_DDR_SPEED_BIN {DDR3_1066F} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE {1} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE {1} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL {1} \
CONFIG.PCW_UIPARAM_DDR_T_FAW {45.0} \
CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN {36.0} \
CONFIG.PCW_UIPARAM_DDR_T_RC {49.5} \
CONFIG.PCW_UIPARAM_DDR_T_RCD {7} \
CONFIG.PCW_UIPARAM_DDR_T_RP {7} \
CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF {1} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE {1} \
CONFIG.PCW_USB0_PERIPHERAL_FREQMHZ {60} \
CONFIG.PCW_USB0_RESET_ENABLE {0} \
CONFIG.PCW_USB0_RESET_IO {<Select>} \
CONFIG.PCW_USB0_USB0_IO {MIO 28 .. 39} \
CONFIG.PCW_USB1_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_USB1_PERIPHERAL_FREQMHZ {60} \
CONFIG.PCW_USB1_RESET_ENABLE {0} \
CONFIG.PCW_USB1_RESET_IO {<Select>} \
CONFIG.PCW_USB1_USB1_IO {<Select>} \
CONFIG.PCW_USB_RESET_ENABLE {1} \
CONFIG.PCW_USB_RESET_POLARITY {Active Low} \
CONFIG.PCW_USB_RESET_SELECT {Share reset pin} \
CONFIG.PCW_USE_CROSS_TRIGGER {0} \
CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
CONFIG.PCW_WDT_PERIPHERAL_CLKSRC {CPU_1X} \
CONFIG.PCW_WDT_PERIPHERAL_DIVISOR0 {1} \
CONFIG.PCW_WDT_PERIPHERAL_ENABLE {0} \
CONFIG.PCW_WDT_PERIPHERAL_FREQMHZ {133.333333} \
CONFIG.PCW_WDT_WDT_IO {<Select>} \
CONFIG.preset {ZedBoard} \
 ] $processing_system7_0

  # Need to retain value_src of defaults
  set_property -dict [ list \
CONFIG.PCW_ACT_CAN_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_DCI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_ENET0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_ENET1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_FPGA0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_FPGA1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_FPGA2_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_FPGA3_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_PCAP_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_QSPI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_SDIO_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_SMC_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_SPI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_TPIU_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ACT_UART_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_APU_CLK_RATIO_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_APU_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ARMPLL_CTRL_FBDIV.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN0_CAN0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN0_GRP_CLK_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN0_GRP_CLK_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN0_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN1_CAN1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN1_GRP_CLK_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN1_GRP_CLK_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN1_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CAN_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CLK0_FREQ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CLK1_FREQ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CLK2_FREQ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CLK3_FREQ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CPU_CPU_6X4X_MAX_RANGE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CPU_CPU_PLL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CPU_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CPU_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_CRYSTAL_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DCI_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DCI_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DCI_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DCI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDRPLL_CTRL_FBDIV.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_DDR_PLL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_HPRLPR_QUEUE_PARTITION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_HPR_TO_CRITICAL_PRIORITY_LEVEL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_LPR_TO_CRITICAL_PRIORITY_LEVEL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PORT0_HPR_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PORT1_HPR_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PORT2_HPR_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PORT3_HPR_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_READPORT_0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_READPORT_1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_READPORT_2.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_READPORT_3.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_2.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_PRIORITY_WRITEPORT_3.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_RAM_HIGHADDR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_DDR_WRITE_TO_CRITICAL_PRIORITY_LEVEL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_ENET0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_GRP_MDIO_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_GRP_MDIO_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET0_RESET_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_ENET1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_GRP_MDIO_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_GRP_MDIO_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET1_RESET_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET_RESET_POLARITY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_ENET_RESET_SELECT.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_4K_TIMER.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_EMIO_TTC0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_ENET0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_QSPI.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_SDIO0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_TTC0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_UART1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_EN_USB0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK0_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK0_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK1_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK1_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK2_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK2_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK3_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK3_PERIPHERAL_DIVISOR1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FCLK_CLK0_BUF.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FPGA2_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FPGA3_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_FPGA_FCLK0_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_GPIO_EMIO_GPIO_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_GPIO_EMIO_GPIO_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_GPIO_MIO_GPIO_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_GPIO_MIO_GPIO_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_GPIO_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C0_GRP_INT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C0_GRP_INT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C0_I2C0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C0_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C0_RESET_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C1_GRP_INT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C1_GRP_INT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C1_I2C1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C1_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C1_RESET_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C_RESET_POLARITY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_I2C_RESET_SELECT.VALUE_SRC {DEFAULT} \
CONFIG.PCW_IOPLL_CTRL_FBDIV.VALUE_SRC {DEFAULT} \
CONFIG.PCW_IO_IO_PLL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_0_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_0_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_0_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_0_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_10_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_10_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_10_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_10_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_11_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_11_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_11_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_11_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_12_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_12_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_12_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_12_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_13_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_13_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_13_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_13_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_14_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_14_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_14_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_14_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_15_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_15_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_15_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_15_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_16_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_16_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_16_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_16_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_17_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_17_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_17_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_17_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_18_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_18_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_18_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_18_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_19_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_19_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_19_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_19_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_1_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_1_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_1_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_1_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_20_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_20_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_20_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_20_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_21_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_21_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_21_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_21_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_22_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_22_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_22_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_22_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_23_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_23_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_23_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_23_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_24_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_24_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_24_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_24_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_25_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_25_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_25_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_25_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_26_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_26_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_26_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_26_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_27_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_27_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_27_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_27_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_28_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_28_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_28_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_28_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_29_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_29_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_29_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_29_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_2_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_2_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_2_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_2_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_30_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_30_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_30_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_30_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_31_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_31_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_31_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_31_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_32_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_32_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_32_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_32_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_33_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_33_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_33_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_33_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_34_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_34_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_34_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_34_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_35_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_35_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_35_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_35_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_36_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_36_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_36_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_36_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_37_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_37_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_37_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_37_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_38_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_38_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_38_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_38_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_39_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_39_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_39_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_39_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_3_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_3_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_3_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_3_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_40_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_40_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_40_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_40_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_41_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_41_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_41_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_41_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_42_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_42_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_42_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_42_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_43_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_43_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_43_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_43_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_44_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_44_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_44_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_44_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_45_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_45_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_45_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_45_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_46_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_46_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_46_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_46_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_47_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_47_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_47_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_47_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_48_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_48_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_48_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_48_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_49_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_49_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_49_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_49_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_4_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_4_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_4_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_4_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_50_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_50_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_50_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_50_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_51_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_51_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_51_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_51_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_52_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_52_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_52_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_52_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_53_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_53_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_53_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_53_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_5_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_5_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_5_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_5_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_6_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_6_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_6_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_6_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_7_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_7_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_7_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_7_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_8_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_8_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_8_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_8_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_9_DIRECTION.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_9_IOTYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_9_PULLUP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_9_SLEW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_TREE_PERIPHERALS.VALUE_SRC {DEFAULT} \
CONFIG.PCW_MIO_TREE_SIGNALS.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_AR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_CLR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_RC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_REA.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_RR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_WC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_CYCLES_T_WP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_GRP_D8_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_GRP_D8_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_NAND_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NAND_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_T_CEOE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_T_PC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_T_RC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_T_TR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_T_WC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_T_WP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS0_WE_TIME.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_T_CEOE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_T_PC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_T_RC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_T_TR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_T_WC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_T_WP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_CS1_WE_TIME.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_A25_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_A25_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_CS0_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_CS0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_CS1_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_CS1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_SRAM_CS0_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_SRAM_CS0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_SRAM_CS1_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_SRAM_CS1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_SRAM_INT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_GRP_SRAM_INT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_NOR_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_T_CEOE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_T_PC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_T_RC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_T_TR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_T_WC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_T_WP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS0_WE_TIME.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_T_CEOE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_T_PC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_T_RC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_T_TR.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_T_WC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_T_WP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_NOR_SRAM_CS1_WE_TIME.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY2.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_BOARD_DELAY3.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_2.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PACKAGE_DDR_DQS_TO_CLK_DELAY_3.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PCAP_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PCAP_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PCAP_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PERIPHERAL_BOARD_PRESET.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PJTAG_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PJTAG_PJTAG_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PLL_BYPASSMODE_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PRESET_BANK0_VOLTAGE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_PRESET_BANK1_VOLTAGE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_GRP_FBCLK_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_GRP_FBCLK_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_GRP_IO1_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_GRP_IO1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_GRP_SS1_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_GRP_SS1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_QSPI_QSPI_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD0_GRP_CD_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD0_GRP_CD_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD0_GRP_POW_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD0_GRP_POW_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD0_GRP_WP_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD0_GRP_WP_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD0_SD0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_GRP_CD_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_GRP_CD_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_GRP_POW_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_GRP_POW_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_GRP_WP_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_GRP_WP_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SD1_SD1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SDIO_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SDIO_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SDIO_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SDIO_PERIPHERAL_VALID.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SMC_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SMC_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SMC_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_GRP_SS0_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_GRP_SS0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_GRP_SS1_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_GRP_SS1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_GRP_SS2_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_GRP_SS2_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI0_SPI0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_GRP_SS0_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_GRP_SS0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_GRP_SS1_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_GRP_SS1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_GRP_SS2_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_GRP_SS2_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI1_SPI1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_SPI_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_S_AXI_HP0_DATA_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_S_AXI_HP1_DATA_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_S_AXI_HP2_DATA_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_S_AXI_HP3_DATA_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TPIU_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TPIU_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TPIU_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_16BIT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_16BIT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_2BIT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_2BIT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_32BIT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_32BIT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_4BIT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_4BIT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_8BIT_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_GRP_8BIT_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_INTERNAL_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TRACE_TRACE_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_CLK2_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC0_TTC0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_CLK2_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC1_TTC1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_TTC_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART0_BAUD_RATE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART0_GRP_FULL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART0_GRP_FULL_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART0_UART0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART1_BAUD_RATE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART1_GRP_FULL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART1_GRP_FULL_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART1_UART1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UART_PERIPHERAL_VALID.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_ADV_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_AL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_BANK_ADDR_COUNT.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_BL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY2.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_BOARD_DELAY3.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_0_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_1_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_2_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_3_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CLOCK_STOP_EN.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_COL_ADDR_COUNT.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_CWL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DEVICE_CAPACITY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_0_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_1_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_2_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_3_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_1.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_2.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQS_TO_CLK_DELAY_3.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_0_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_1_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_2_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_LENGTH_MM.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_PACKAGE_LENGTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DQ_3_PROPOGATION_DELAY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_DRAM_WIDTH.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_ECC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_HIGH_TEMP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_MEMORY_TYPE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_PARTNO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_ROW_ADDR_COUNT.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_SPEED_BIN.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_DATA_EYE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_READ_GATE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_TRAIN_WRITE_LEVEL.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_T_FAW.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_T_RAS_MIN.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_T_RC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_T_RCD.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_T_RP.VALUE_SRC {DEFAULT} \
CONFIG.PCW_UIPARAM_DDR_USE_INTERNAL_VREF.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB0_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB0_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB0_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB0_RESET_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB0_USB0_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB1_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB1_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB1_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB1_RESET_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB1_USB1_IO.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB_RESET_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB_RESET_POLARITY.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USB_RESET_SELECT.VALUE_SRC {DEFAULT} \
CONFIG.PCW_USE_CROSS_TRIGGER.VALUE_SRC {DEFAULT} \
CONFIG.PCW_WDT_PERIPHERAL_CLKSRC.VALUE_SRC {DEFAULT} \
CONFIG.PCW_WDT_PERIPHERAL_DIVISOR0.VALUE_SRC {DEFAULT} \
CONFIG.PCW_WDT_PERIPHERAL_ENABLE.VALUE_SRC {DEFAULT} \
CONFIG.PCW_WDT_PERIPHERAL_FREQMHZ.VALUE_SRC {DEFAULT} \
CONFIG.PCW_WDT_WDT_IO.VALUE_SRC {DEFAULT} \
 ] $processing_system7_0

  # Create instance: processing_system7_0_axi_periph, and set properties
  set processing_system7_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 processing_system7_0_axi_periph ]
  set_property -dict [ list \
CONFIG.NUM_MI {5} \
 ] $processing_system7_0_axi_periph

  # Create instance: rst_processing_system7_0_100M, and set properties
  set rst_processing_system7_0_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processing_system7_0_100M ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports UART] [get_bd_intf_pins axi_uartlite_0/UART]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins processing_system7_0/M_AXI_GP0] [get_bd_intf_pins processing_system7_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M00_AXI [get_bd_intf_pins newGpsIp_0/GPS_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M01_AXI [get_bd_intf_pins myImode_0/S00_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M02_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net processing_system7_0_axi_periph_M03_AXI [get_bd_intf_pins myip_fifo_ctrl_0/FIFO_AXI] [get_bd_intf_pins processing_system7_0_axi_periph/M03_AXI]

  # Create port connections
  connect_bd_net -net EF1_1 [get_bd_ports EF1] [get_bd_pins myImode_0/EF1]
  connect_bd_net -net EF2_1 [get_bd_ports EF2] [get_bd_pins myImode_0/EF2]
  connect_bd_net -net ErrFlag_1 [get_bd_ports ErrFlag] [get_bd_pins myImode_0/ErrFlag]
  connect_bd_net -net IrFlag_1 [get_bd_ports IrFlag] [get_bd_pins myImode_0/IrFlag]
  connect_bd_net -net Net [get_bd_ports data] [get_bd_pins myImode_0/data]
  connect_bd_net -net PPS_IN_1 [get_bd_ports PPS_IN] [get_bd_pins newGpsIp_0/PPS_IN]
  connect_bd_net -net StartTrigger_1 [get_bd_ports StartTrigger] [get_bd_pins myImode_0/StartTrigger]
  connect_bd_net -net StopTrigger1_1 [get_bd_ports StopTrigger1] [get_bd_pins myImode_0/StopTrigger1]
  connect_bd_net -net StopTrigger2_1 [get_bd_ports StopTrigger2] [get_bd_pins myImode_0/StopTrigger2]
  connect_bd_net -net StopTrigger3_1 [get_bd_ports StopTrigger3] [get_bd_pins myImode_0/StopTrigger3]
  connect_bd_net -net StopTrigger4_1 [get_bd_ports StopTrigger4] [get_bd_pins myImode_0/StopTrigger4]
  connect_bd_net -net StopTrigger5_1 [get_bd_ports StopTrigger5] [get_bd_pins myImode_0/StopTrigger5]
  connect_bd_net -net StopTrigger6_1 [get_bd_ports StopTrigger6] [get_bd_pins myImode_0/StopTrigger6]
  connect_bd_net -net StopTrigger7_1 [get_bd_ports StopTrigger7] [get_bd_pins myImode_0/StopTrigger7]
  connect_bd_net -net StopTrigger8_1 [get_bd_ports StopTrigger8] [get_bd_pins myImode_0/StopTrigger8]
  connect_bd_net -net fifo_generator_0_dout [get_bd_pins fifo_generator_0/dout] [get_bd_pins myip_fifo_ctrl_0/ch1_fifo1_rd_data]
  connect_bd_net -net fifo_generator_0_empty [get_bd_pins fifo_generator_0/empty] [get_bd_pins myip_fifo_ctrl_0/fifo1_empty]
  connect_bd_net -net fifo_generator_0_full [get_bd_pins fifo_generator_0/full] [get_bd_pins myip_fifo_ctrl_0/fifo1_full]
  connect_bd_net -net fifo_generator_10_dout [get_bd_pins fifo_generator_10/dout] [get_bd_pins myip_fifo_ctrl_0/ch6_fifo1_rd_data]
  connect_bd_net -net fifo_generator_11_dout [get_bd_pins fifo_generator_11/dout] [get_bd_pins myip_fifo_ctrl_0/ch6_fifo2_rd_data]
  connect_bd_net -net fifo_generator_12_dout [get_bd_pins fifo_generator_12/dout] [get_bd_pins myip_fifo_ctrl_0/ch7_fifo1_rd_data]
  connect_bd_net -net fifo_generator_13_dout [get_bd_pins fifo_generator_13/dout] [get_bd_pins myip_fifo_ctrl_0/ch7_fifo2_rd_data]
  connect_bd_net -net fifo_generator_14_dout [get_bd_pins fifo_generator_14/dout] [get_bd_pins myip_fifo_ctrl_0/ch8_fifo1_rd_data]
  connect_bd_net -net fifo_generator_15_dout [get_bd_pins fifo_generator_15/dout] [get_bd_pins myip_fifo_ctrl_0/ch8_fifo2_rd_data]
  connect_bd_net -net fifo_generator_16_dout [get_bd_pins fifo_generator_16/dout] [get_bd_pins myip_fifo_ctrl_0/gps1_fifo1_rd_data]
  connect_bd_net -net fifo_generator_17_dout [get_bd_pins fifo_generator_17/dout] [get_bd_pins myip_fifo_ctrl_0/gps1_fifo2_rd_data]
  connect_bd_net -net fifo_generator_18_dout [get_bd_pins fifo_generator_18/dout] [get_bd_pins myip_fifo_ctrl_0/gps2_fifo1_rd_data]
  connect_bd_net -net fifo_generator_19_dout [get_bd_pins fifo_generator_19/dout] [get_bd_pins myip_fifo_ctrl_0/gps2_fifo2_rd_data]
  connect_bd_net -net fifo_generator_1_dout [get_bd_pins fifo_generator_1/dout] [get_bd_pins myip_fifo_ctrl_0/ch1_fifo2_rd_data]
  connect_bd_net -net fifo_generator_1_empty [get_bd_pins fifo_generator_1/empty] [get_bd_pins myip_fifo_ctrl_0/fifo2_empty]
  connect_bd_net -net fifo_generator_1_full [get_bd_pins fifo_generator_1/full] [get_bd_pins myip_fifo_ctrl_0/fifo2_full]
  connect_bd_net -net fifo_generator_20_dout [get_bd_pins fifo_generator_20/dout] [get_bd_pins myip_fifo_ctrl_0/start_tri_fifo1_rd_data]
  connect_bd_net -net fifo_generator_21_dout [get_bd_pins fifo_generator_21/dout] [get_bd_pins myip_fifo_ctrl_0/start_tri_fifo2_rd_data]
  connect_bd_net -net fifo_generator_2_dout [get_bd_pins fifo_generator_2/dout] [get_bd_pins myip_fifo_ctrl_0/ch2_fifo1_rd_data]
  connect_bd_net -net fifo_generator_3_dout [get_bd_pins fifo_generator_3/dout] [get_bd_pins myip_fifo_ctrl_0/ch2_fifo2_rd_data]
  connect_bd_net -net fifo_generator_4_dout [get_bd_pins fifo_generator_4/dout] [get_bd_pins myip_fifo_ctrl_0/ch3_fifo1_rd_data]
  connect_bd_net -net fifo_generator_5_dout [get_bd_pins fifo_generator_5/dout] [get_bd_pins myip_fifo_ctrl_0/ch3_fifo2_rd_data]
  connect_bd_net -net fifo_generator_6_dout [get_bd_pins fifo_generator_6/dout] [get_bd_pins myip_fifo_ctrl_0/ch4_fifo1_rd_data]
  connect_bd_net -net fifo_generator_7_dout [get_bd_pins fifo_generator_7/dout] [get_bd_pins myip_fifo_ctrl_0/ch4_fifo2_rd_data]
  connect_bd_net -net fifo_generator_8_dout [get_bd_pins fifo_generator_8/dout] [get_bd_pins myip_fifo_ctrl_0/ch5_fifo1_rd_data]
  connect_bd_net -net fifo_generator_9_dout [get_bd_pins fifo_generator_9/dout] [get_bd_pins myip_fifo_ctrl_0/ch5_fifo2_rd_data]
  connect_bd_net -net myImode_0_AluTrigger [get_bd_ports AluTrigger] [get_bd_pins myImode_0/AluTrigger]
  connect_bd_net -net myImode_0_StartDis [get_bd_ports StartDis] [get_bd_pins myImode_0/StartDis]
  connect_bd_net -net myImode_0_StopDis1 [get_bd_ports StopDis1] [get_bd_pins myImode_0/StopDis1]
  connect_bd_net -net myImode_0_StopDis2 [get_bd_ports StopDis2] [get_bd_pins myImode_0/StopDis2]
  connect_bd_net -net myImode_0_StopDis3 [get_bd_ports StopDis3] [get_bd_pins myImode_0/StopDis3]
  connect_bd_net -net myImode_0_StopDis4 [get_bd_ports StopDis4] [get_bd_pins myImode_0/StopDis4]
  connect_bd_net -net myImode_0_Tstart [get_bd_ports Tstart] [get_bd_pins myImode_0/Tstart]
  connect_bd_net -net myImode_0_Tstart_counter [get_bd_pins myImode_0/Tstart_counter] [get_bd_pins myip_fifo_ctrl_0/start_tri_data_to_be_wr]
  connect_bd_net -net myImode_0_Tstop1 [get_bd_ports Tstop1] [get_bd_pins myImode_0/Tstop1]
  connect_bd_net -net myImode_0_Tstop2 [get_bd_ports Tstop2] [get_bd_pins myImode_0/Tstop2]
  connect_bd_net -net myImode_0_Tstop3 [get_bd_ports Tstop3] [get_bd_pins myImode_0/Tstop3]
  connect_bd_net -net myImode_0_Tstop4 [get_bd_ports Tstop4] [get_bd_pins myImode_0/Tstop4]
  connect_bd_net -net myImode_0_Tstop5 [get_bd_ports Tstop5] [get_bd_pins myImode_0/Tstop5]
  connect_bd_net -net myImode_0_Tstop6 [get_bd_ports Tstop6] [get_bd_pins myImode_0/Tstop6]
  connect_bd_net -net myImode_0_Tstop7 [get_bd_ports Tstop7] [get_bd_pins myImode_0/Tstop7]
  connect_bd_net -net myImode_0_Tstop8 [get_bd_ports Tstop8] [get_bd_pins myImode_0/Tstop8]
  connect_bd_net -net myImode_0_addr [get_bd_ports addr] [get_bd_pins myImode_0/addr]
  connect_bd_net -net myImode_0_ch1_data [get_bd_pins myImode_0/ch1_data] [get_bd_pins myip_fifo_ctrl_0/ch1_data_to_be_wr]
  connect_bd_net -net myImode_0_ch2_data [get_bd_pins myImode_0/ch2_data] [get_bd_pins myip_fifo_ctrl_0/ch2_data_to_be_wr]
  connect_bd_net -net myImode_0_ch3_data [get_bd_pins myImode_0/ch3_data] [get_bd_pins myip_fifo_ctrl_0/ch3_data_to_be_wr]
  connect_bd_net -net myImode_0_ch4_data [get_bd_pins myImode_0/ch4_data] [get_bd_pins myip_fifo_ctrl_0/ch4_data_to_be_wr]
  connect_bd_net -net myImode_0_ch5_data [get_bd_pins myImode_0/ch5_data] [get_bd_pins myip_fifo_ctrl_0/ch5_data_to_be_wr]
  connect_bd_net -net myImode_0_ch6_data [get_bd_pins myImode_0/ch6_data] [get_bd_pins myip_fifo_ctrl_0/ch6_data_to_be_wr]
  connect_bd_net -net myImode_0_ch7_data [get_bd_pins myImode_0/ch7_data] [get_bd_pins myip_fifo_ctrl_0/ch7_data_to_be_wr]
  connect_bd_net -net myImode_0_ch8_data [get_bd_pins myImode_0/ch8_data] [get_bd_pins myip_fifo_ctrl_0/ch8_data_to_be_wr]
  connect_bd_net -net myImode_0_csn [get_bd_ports csn] [get_bd_pins myImode_0/csn]
  connect_bd_net -net myImode_0_oen [get_bd_ports oen] [get_bd_pins myImode_0/oen]
  connect_bd_net -net myImode_0_rdn [get_bd_ports rdn] [get_bd_pins myImode_0/rdn]
  connect_bd_net -net myImode_0_set_zero [get_bd_pins myImode_0/set_zero] [get_bd_pins newGpsIp_0/tstartCome]
  connect_bd_net -net myImode_0_timeDataWrEn [get_bd_pins myImode_0/timeDataWrEn] [get_bd_pins myip_fifo_ctrl_0/data_in_flag]
  connect_bd_net -net myImode_0_wrn [get_bd_ports wrn] [get_bd_pins myImode_0/wrn]
  connect_bd_net -net myip_fifo_ctrl_0_ch1_fifo1_rd [get_bd_pins fifo_generator_0/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch1_fifo1_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch1_fifo1_wr [get_bd_pins fifo_generator_0/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch1_fifo1_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch1_fifo2_rd [get_bd_pins fifo_generator_1/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch1_fifo2_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch1_fifo2_wr [get_bd_pins fifo_generator_1/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch1_fifo2_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch1_fifo_wr_data [get_bd_pins fifo_generator_0/din] [get_bd_pins fifo_generator_1/din] [get_bd_pins myip_fifo_ctrl_0/ch1_fifo_wr_data]
  connect_bd_net -net myip_fifo_ctrl_0_ch2_fifo1_rd [get_bd_pins fifo_generator_2/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch2_fifo1_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch2_fifo1_wr [get_bd_pins fifo_generator_2/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch2_fifo1_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch2_fifo2_rd [get_bd_pins fifo_generator_3/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch2_fifo2_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch2_fifo2_wr [get_bd_pins fifo_generator_3/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch2_fifo2_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch2_fifo_wr_data [get_bd_pins fifo_generator_2/din] [get_bd_pins fifo_generator_3/din] [get_bd_pins myip_fifo_ctrl_0/ch2_fifo_wr_data]
  connect_bd_net -net myip_fifo_ctrl_0_ch3_fifo1_rd [get_bd_pins fifo_generator_4/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch3_fifo1_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch3_fifo1_wr [get_bd_pins fifo_generator_4/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch3_fifo1_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch3_fifo2_rd [get_bd_pins fifo_generator_5/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch3_fifo2_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch3_fifo2_wr [get_bd_pins fifo_generator_5/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch3_fifo2_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch3_fifo_wr_data [get_bd_pins fifo_generator_4/din] [get_bd_pins fifo_generator_5/din] [get_bd_pins myip_fifo_ctrl_0/ch3_fifo_wr_data]
  connect_bd_net -net myip_fifo_ctrl_0_ch4_fifo1_rd [get_bd_pins fifo_generator_6/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch4_fifo1_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch4_fifo1_wr [get_bd_pins fifo_generator_6/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch4_fifo1_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch4_fifo2_rd [get_bd_pins fifo_generator_7/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch4_fifo2_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch4_fifo2_wr [get_bd_pins fifo_generator_7/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch4_fifo2_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch4_fifo_wr_data [get_bd_pins fifo_generator_6/din] [get_bd_pins fifo_generator_7/din] [get_bd_pins myip_fifo_ctrl_0/ch4_fifo_wr_data]
  connect_bd_net -net myip_fifo_ctrl_0_ch5_fifo1_rd [get_bd_pins fifo_generator_8/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch5_fifo1_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch5_fifo1_wr [get_bd_pins fifo_generator_8/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch5_fifo1_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch5_fifo2_rd [get_bd_pins fifo_generator_9/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch5_fifo2_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch5_fifo2_wr [get_bd_pins fifo_generator_9/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch5_fifo2_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch5_fifo_wr_data [get_bd_pins fifo_generator_8/din] [get_bd_pins fifo_generator_9/din] [get_bd_pins myip_fifo_ctrl_0/ch5_fifo_wr_data]
  connect_bd_net -net myip_fifo_ctrl_0_ch6_fifo1_rd [get_bd_pins fifo_generator_10/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch6_fifo1_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch6_fifo1_wr [get_bd_pins fifo_generator_10/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch6_fifo1_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch6_fifo2_rd [get_bd_pins fifo_generator_11/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch6_fifo2_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch6_fifo2_wr [get_bd_pins fifo_generator_11/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch6_fifo2_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch6_fifo_wr_data [get_bd_pins fifo_generator_10/din] [get_bd_pins fifo_generator_11/din] [get_bd_pins myip_fifo_ctrl_0/ch6_fifo_wr_data]
  connect_bd_net -net myip_fifo_ctrl_0_ch7_fifo1_rd [get_bd_pins fifo_generator_12/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch7_fifo1_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch7_fifo1_wr [get_bd_pins fifo_generator_12/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch7_fifo1_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch7_fifo2_rd [get_bd_pins fifo_generator_13/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch7_fifo2_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch7_fifo2_wr [get_bd_pins fifo_generator_13/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch7_fifo2_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch7_fifo_wr_data [get_bd_pins fifo_generator_12/din] [get_bd_pins fifo_generator_13/din] [get_bd_pins myip_fifo_ctrl_0/ch7_fifo_wr_data]
  connect_bd_net -net myip_fifo_ctrl_0_ch8_fifo1_rd [get_bd_pins fifo_generator_14/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch8_fifo1_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch8_fifo1_wr [get_bd_pins fifo_generator_14/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch8_fifo1_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch8_fifo2_rd [get_bd_pins fifo_generator_15/rd_en] [get_bd_pins myip_fifo_ctrl_0/ch8_fifo2_rd]
  connect_bd_net -net myip_fifo_ctrl_0_ch8_fifo2_wr [get_bd_pins fifo_generator_15/wr_en] [get_bd_pins myip_fifo_ctrl_0/ch8_fifo2_wr]
  connect_bd_net -net myip_fifo_ctrl_0_ch8_fifo_wr_data [get_bd_pins fifo_generator_14/din] [get_bd_pins fifo_generator_15/din] [get_bd_pins myip_fifo_ctrl_0/ch8_fifo_wr_data]
  connect_bd_net -net myip_fifo_ctrl_0_fifo_rst [get_bd_pins fifo_generator_0/srst] [get_bd_pins fifo_generator_1/srst] [get_bd_pins fifo_generator_10/srst] [get_bd_pins fifo_generator_11/srst] [get_bd_pins fifo_generator_12/srst] [get_bd_pins fifo_generator_13/srst] [get_bd_pins fifo_generator_14/srst] [get_bd_pins fifo_generator_15/srst] [get_bd_pins fifo_generator_16/srst] [get_bd_pins fifo_generator_17/srst] [get_bd_pins fifo_generator_18/srst] [get_bd_pins fifo_generator_19/srst] [get_bd_pins fifo_generator_2/srst] [get_bd_pins fifo_generator_20/srst] [get_bd_pins fifo_generator_21/srst] [get_bd_pins fifo_generator_3/srst] [get_bd_pins fifo_generator_4/srst] [get_bd_pins fifo_generator_5/srst] [get_bd_pins fifo_generator_6/srst] [get_bd_pins fifo_generator_7/srst] [get_bd_pins fifo_generator_8/srst] [get_bd_pins fifo_generator_9/srst] [get_bd_pins myip_fifo_ctrl_0/fifo_rst]
  connect_bd_net -net myip_fifo_ctrl_0_gps1_fifo1_rd [get_bd_pins fifo_generator_16/rd_en] [get_bd_pins myip_fifo_ctrl_0/gps1_fifo1_rd]
  connect_bd_net -net myip_fifo_ctrl_0_gps1_fifo1_wr [get_bd_pins fifo_generator_16/wr_en] [get_bd_pins myip_fifo_ctrl_0/gps1_fifo1_wr]
  connect_bd_net -net myip_fifo_ctrl_0_gps1_fifo2_rd [get_bd_pins fifo_generator_17/rd_en] [get_bd_pins myip_fifo_ctrl_0/gps1_fifo2_rd]
  connect_bd_net -net myip_fifo_ctrl_0_gps1_fifo2_wr [get_bd_pins fifo_generator_17/wr_en] [get_bd_pins myip_fifo_ctrl_0/gps1_fifo2_wr]
  connect_bd_net -net myip_fifo_ctrl_0_gps1_fifo_wr_data [get_bd_pins fifo_generator_16/din] [get_bd_pins fifo_generator_17/din] [get_bd_pins myip_fifo_ctrl_0/gps1_fifo_wr_data]
  connect_bd_net -net myip_fifo_ctrl_0_gps2_fifo1_rd [get_bd_pins fifo_generator_18/rd_en] [get_bd_pins myip_fifo_ctrl_0/gps2_fifo1_rd]
  connect_bd_net -net myip_fifo_ctrl_0_gps2_fifo1_wr [get_bd_pins fifo_generator_18/wr_en] [get_bd_pins myip_fifo_ctrl_0/gps2_fifo1_wr]
  connect_bd_net -net myip_fifo_ctrl_0_gps2_fifo2_rd [get_bd_pins fifo_generator_19/rd_en] [get_bd_pins myip_fifo_ctrl_0/gps2_fifo2_rd]
  connect_bd_net -net myip_fifo_ctrl_0_gps2_fifo2_wr [get_bd_pins fifo_generator_19/wr_en] [get_bd_pins myip_fifo_ctrl_0/gps2_fifo2_wr]
  connect_bd_net -net myip_fifo_ctrl_0_gps2_fifo_wr_data [get_bd_pins fifo_generator_18/din] [get_bd_pins fifo_generator_19/din] [get_bd_pins myip_fifo_ctrl_0/gps2_fifo_wr_data]
  connect_bd_net -net myip_fifo_ctrl_0_start_tri_fifo1_rd [get_bd_pins fifo_generator_20/rd_en] [get_bd_pins myip_fifo_ctrl_0/start_tri_fifo1_rd]
  connect_bd_net -net myip_fifo_ctrl_0_start_tri_fifo1_wr [get_bd_pins fifo_generator_20/wr_en] [get_bd_pins myip_fifo_ctrl_0/start_tri_fifo1_wr]
  connect_bd_net -net myip_fifo_ctrl_0_start_tri_fifo2_rd [get_bd_pins fifo_generator_21/rd_en] [get_bd_pins myip_fifo_ctrl_0/start_tri_fifo2_rd]
  connect_bd_net -net myip_fifo_ctrl_0_start_tri_fifo2_wr [get_bd_pins fifo_generator_21/wr_en] [get_bd_pins myip_fifo_ctrl_0/start_tri_fifo2_wr]
  connect_bd_net -net myip_fifo_ctrl_0_start_tri_fifo_wr_data [get_bd_pins fifo_generator_20/din] [get_bd_pins fifo_generator_21/din] [get_bd_pins myip_fifo_ctrl_0/start_tri_fifo_wr_data]
  connect_bd_net -net newGpsIp_0_triggerTime_out1 [get_bd_pins myip_fifo_ctrl_0/gps1_data_to_be_wr] [get_bd_pins newGpsIp_0/triggerTime_out1]
  connect_bd_net -net newGpsIp_0_triggerTime_out2 [get_bd_pins myip_fifo_ctrl_0/gps2_data_to_be_wr] [get_bd_pins newGpsIp_0/triggerTime_out2]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins fifo_generator_0/clk] [get_bd_pins fifo_generator_1/clk] [get_bd_pins fifo_generator_10/clk] [get_bd_pins fifo_generator_11/clk] [get_bd_pins fifo_generator_12/clk] [get_bd_pins fifo_generator_13/clk] [get_bd_pins fifo_generator_14/clk] [get_bd_pins fifo_generator_15/clk] [get_bd_pins fifo_generator_16/clk] [get_bd_pins fifo_generator_17/clk] [get_bd_pins fifo_generator_18/clk] [get_bd_pins fifo_generator_19/clk] [get_bd_pins fifo_generator_2/clk] [get_bd_pins fifo_generator_20/clk] [get_bd_pins fifo_generator_21/clk] [get_bd_pins fifo_generator_3/clk] [get_bd_pins fifo_generator_4/clk] [get_bd_pins fifo_generator_5/clk] [get_bd_pins fifo_generator_6/clk] [get_bd_pins fifo_generator_7/clk] [get_bd_pins fifo_generator_8/clk] [get_bd_pins fifo_generator_9/clk] [get_bd_pins myImode_0/s00_axi_aclk] [get_bd_pins myip_fifo_ctrl_0/fifo_axi_aclk] [get_bd_pins newGpsIp_0/gps_axi_aclk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0_axi_periph/ACLK] [get_bd_pins processing_system7_0_axi_periph/M00_ACLK] [get_bd_pins processing_system7_0_axi_periph/M01_ACLK] [get_bd_pins processing_system7_0_axi_periph/M02_ACLK] [get_bd_pins processing_system7_0_axi_periph/M03_ACLK] [get_bd_pins processing_system7_0_axi_periph/M04_ACLK] [get_bd_pins processing_system7_0_axi_periph/S00_ACLK] [get_bd_pins rst_processing_system7_0_100M/slowest_sync_clk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins processing_system7_0/FCLK_RESET0_N] [get_bd_pins rst_processing_system7_0_100M/ext_reset_in]
  connect_bd_net -net rst_processing_system7_0_100M_interconnect_aresetn [get_bd_pins processing_system7_0_axi_periph/ARESETN] [get_bd_pins rst_processing_system7_0_100M/interconnect_aresetn]
  connect_bd_net -net rst_processing_system7_0_100M_peripheral_aresetn [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins myImode_0/s00_axi_aresetn] [get_bd_pins myip_fifo_ctrl_0/fifo_axi_aresetn] [get_bd_pins newGpsIp_0/gps_axi_aresetn] [get_bd_pins processing_system7_0_axi_periph/M00_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M01_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M02_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M03_ARESETN] [get_bd_pins processing_system7_0_axi_periph/M04_ARESETN] [get_bd_pins processing_system7_0_axi_periph/S00_ARESETN] [get_bd_pins rst_processing_system7_0_100M/peripheral_aresetn]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0x42C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x43C10000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs myImode_0/S00_AXI/S00_AXI_reg] SEG_myImode_0_S00_AXI_reg
  create_bd_addr_seg -range 0x00010000 -offset 0x43C20000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs myip_fifo_ctrl_0/FIFO_AXI/FIFO_AXI_reg] SEG_myip_fifo_ctrl_0_FIFO_AXI_reg
  create_bd_addr_seg -range 0x00010000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs newGpsIp_0/GPS_AXI/GPS_AXI_reg] SEG_newGpsIp_0_GPS_AXI_reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   comment_0: "ch1_fifo1",
   comment_1: "ch2_fifo1",
   comment_10: "start_tri_fifo1",
   comment_11: "ch1_fifo2",
   comment_12: "ch2_fifo2",
   comment_13: "ch3_fifo2",
   comment_14: "ch4_fifo2",
   comment_15: "ch5_fifo2",
   comment_16: "ch6_fifo2",
   comment_17: "ch7_fifo2",
   comment_18: "ch8_fifo2",
   comment_19: "gps1_fifo2",
   comment_2: "ch3_fifo1",
   comment_20: "gps2_fifo2",
   comment_21: "start_tri_fifo2",
   comment_3: "ch4_fifo1",
   comment_4: "ch5_fifo1",
   comment_5: "ch6_fifo1",
   comment_6: "ch7_fifo1",
   comment_7: "ch8_fifo1",
   comment_8: "gps1_fifo1",
   comment_9: "gps2_fifo1",
   commentid: "comment_0|comment_1|comment_2|comment_3|comment_4|comment_5|comment_6|comment_7|comment_8|comment_9|comment_10|comment_11|comment_12|comment_13|comment_14|comment_15|comment_16|comment_17|comment_18|comment_19|comment_20|comment_21|",
   fillcolor_comment_0: "",
   fillcolor_comment_1: "",
   fillcolor_comment_10: "",
   fillcolor_comment_11: "",
   fillcolor_comment_12: "",
   fillcolor_comment_13: "",
   fillcolor_comment_14: "",
   fillcolor_comment_15: "",
   fillcolor_comment_16: "",
   fillcolor_comment_17: "",
   fillcolor_comment_18: "",
   fillcolor_comment_19: "",
   fillcolor_comment_2: "",
   fillcolor_comment_20: "",
   fillcolor_comment_21: "",
   fillcolor_comment_3: "",
   fillcolor_comment_4: "",
   fillcolor_comment_5: "",
   fillcolor_comment_6: "",
   fillcolor_comment_7: "",
   fillcolor_comment_8: "",
   fillcolor_comment_9: "",
   font_comment_0: "9",
   font_comment_1: "15",
   font_comment_10: "14",
   font_comment_11: "14",
   font_comment_12: "9",
   font_comment_13: "9",
   font_comment_14: "14",
   font_comment_15: "9",
   font_comment_16: "10",
   font_comment_17: "9",
   font_comment_18: "9",
   font_comment_19: "9",
   font_comment_2: "15",
   font_comment_20: "6",
   font_comment_21: "9",
   font_comment_3: "15",
   font_comment_4: "14",
   font_comment_5: "14",
   font_comment_6: "14",
   font_comment_7: "14",
   font_comment_8: "14",
   font_comment_9: "14",
   guistr: "# # String gsaved with Nlview 6.5.12  2016-01-29 bk=1.3547 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port ErrFlag -pg 1 -y 4160 -defaultsOSRD
preplace port IrFlag -pg 1 -y 4100 -defaultsOSRD
preplace port StopTrigger5 -pg 1 -y 4020 -defaultsOSRD
preplace port PPS_IN -pg 1 -y 3560 -defaultsOSRD
preplace port DDR -pg 1 -y 3610 -defaultsOSRD
preplace port oen -pg 1 -y 3940 -defaultsOSRD
preplace port StopTrigger6 -pg 1 -y 4040 -defaultsOSRD
preplace port StopTrigger7 -pg 1 -y 4060 -defaultsOSRD
preplace port UART -pg 1 -y 3420 -defaultsOSRD
preplace port StopTrigger8 -pg 1 -y 4080 -defaultsOSRD
preplace port Tstop1 -pg 1 -y 4000 -defaultsOSRD
preplace port Tstart -pg 1 -y 3980 -defaultsOSRD
preplace port Tstop2 -pg 1 -y 4020 -defaultsOSRD
preplace port StartDis -pg 1 -y 3780 -defaultsOSRD
preplace port StartTrigger -pg 1 -y 3920 -defaultsOSRD
preplace port Tstop3 -pg 1 -y 4040 -defaultsOSRD
preplace port AluTrigger -pg 1 -y 3960 -defaultsOSRD
preplace port Tstop4 -pg 1 -y 4060 -defaultsOSRD
preplace port Tstop5 -pg 1 -y 4080 -defaultsOSRD
preplace port csn -pg 1 -y 3920 -defaultsOSRD
preplace port StopDis1 -pg 1 -y 3800 -defaultsOSRD
preplace port FIXED_IO -pg 1 -y 3630 -defaultsOSRD
preplace port Tstop6 -pg 1 -y 4100 -defaultsOSRD
preplace port StopDis2 -pg 1 -y 3760 -defaultsOSRD
preplace port StopTrigger1 -pg 1 -y 3940 -defaultsOSRD
preplace port Tstop7 -pg 1 -y 4120 -defaultsOSRD
preplace port rdn -pg 1 -y 3900 -defaultsOSRD
preplace port StopDis3 -pg 1 -y 3740 -defaultsOSRD
preplace port StopTrigger2 -pg 1 -y 3960 -defaultsOSRD
preplace port Tstop8 -pg 1 -y 4140 -defaultsOSRD
preplace port StopDis4 -pg 1 -y 3820 -defaultsOSRD
preplace port EF1 -pg 1 -y 4120 -defaultsOSRD
preplace port StopTrigger3 -pg 1 -y 3980 -defaultsOSRD
preplace port EF2 -pg 1 -y 4140 -defaultsOSRD
preplace port wrn -pg 1 -y 3880 -defaultsOSRD
preplace port StopTrigger4 -pg 1 -y 4000 -defaultsOSRD
preplace portBus data -pg 1 -y 3860 -defaultsOSRD
preplace portBus addr -pg 1 -y 3840 -defaultsOSRD
preplace inst fifo_generator_10 -pg 1 -lvl 4 -y 430 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_3 -pg 1 -lvl 4 -y 260 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_11 -pg 1 -lvl 4 -y 600 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_4 -pg 1 -lvl 4 -y 1110 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_12 -pg 1 -lvl 4 -y 770 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_5 -pg 1 -lvl 4 -y 1620 -defaultsOSRD -resize 162 146
preplace inst rst_processing_system7_0_100M -pg 1 -lvl 1 -y 3460 -defaultsOSRD
preplace inst newGpsIp_0 -pg 1 -lvl 3 -y 3270 -defaultsOSRD
preplace inst myip_fifo_ctrl_0 -pg 1 -lvl 3 -y 2360 -defaultsOSRD
preplace inst fifo_generator_13 -pg 1 -lvl 4 -y 940 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_6 -pg 1 -lvl 4 -y 1790 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_14 -pg 1 -lvl 4 -y 1450 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_7 -pg 1 -lvl 4 -y 1960 -defaultsOSRD -resize 162 146
preplace inst myImode_0 -pg 1 -lvl 3 -y 4050 -defaultsOSRD
preplace inst fifo_generator_15 -pg 1 -lvl 4 -y 2130 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_8 -pg 1 -lvl 4 -y 3510 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_16 -pg 1 -lvl 4 -y 2300 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_9 -pg 1 -lvl 4 -y 3720 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_17 -pg 1 -lvl 4 -y 2810 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_18 -pg 1 -lvl 4 -y 2470 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_19 -pg 1 -lvl 4 -y 2980 -defaultsOSRD -resize 162 146
preplace inst axi_uartlite_0 -pg 1 -lvl 3 -y 3430 -defaultsOSRD
preplace inst fifo_generator_0 -pg 1 -lvl 4 -y 1280 -defaultsOSRD -resize 159 144
preplace inst fifo_generator_20 -pg 1 -lvl 4 -y 2640 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_1 -pg 1 -lvl 4 -y 3320 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_21 -pg 1 -lvl 4 -y 3150 -defaultsOSRD -resize 162 146
preplace inst fifo_generator_2 -pg 1 -lvl 4 -y 90 -defaultsOSRD -resize 162 146
preplace inst processing_system7_0_axi_periph -pg 1 -lvl 2 -y 3390 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 1 -y 3690 -defaultsOSRD
preplace netloc EF2_1 1 0 3 NJ 4140 NJ 4140 NJ
preplace netloc myImode_0_csn 1 3 2 NJ 3920 NJ
preplace netloc fifo_generator_2_dout 1 2 2 750 90 NJ
preplace netloc myip_fifo_ctrl_0_ch7_fifo2_wr 1 3 1 1820
preplace netloc myImode_0_Tstart 1 3 2 NJ 3980 NJ
preplace netloc myip_fifo_ctrl_0_gps2_fifo1_wr 1 3 1 1990
preplace netloc processing_system7_0_FIXED_IO 1 1 4 NJ 3630 NJ 3630 NJ 3630 NJ
preplace netloc myip_fifo_ctrl_0_ch1_fifo2_rd 1 3 1 1730
preplace netloc fifo_generator_18_dout 1 2 2 970 2980 NJ
preplace netloc newGpsIp_0_triggerTime_out1 1 2 2 920 1670 1510
preplace netloc myip_fifo_ctrl_0_ch8_fifo1_rd 1 3 1 1730
preplace netloc newGpsIp_0_triggerTime_out2 1 2 2 840 3020 1490
preplace netloc myImode_0_ch7_data 1 2 2 900 1640 1590
preplace netloc myip_fifo_ctrl_0_ch2_fifo2_rd 1 3 1 1850
preplace netloc fifo_generator_3_dout 1 2 2 720 260 NJ
preplace netloc fifo_generator_14_dout 1 2 2 800 1450 NJ
preplace netloc fifo_generator_0_empty 1 2 2 940 1280 NJ
preplace netloc myImode_0_wrn 1 3 2 NJ 3890 NJ
preplace netloc fifo_generator_1_dout 1 2 2 870 3090 NJ
preplace netloc fifo_generator_6_dout 1 2 2 870 1690 NJ
preplace netloc StopTrigger8_1 1 0 3 NJ 4080 NJ 4080 NJ
preplace netloc myip_fifo_ctrl_0_start_tri_fifo1_rd 1 3 1 1820
preplace netloc myip_fifo_ctrl_0_ch3_fifo2_wr 1 3 1 1920
preplace netloc myip_fifo_ctrl_0_ch6_fifo2_wr 1 3 1 1750
preplace netloc myip_fifo_ctrl_0_ch2_fifo_wr_data 1 3 1 1610
preplace netloc myip_fifo_ctrl_0_ch1_fifo_wr_data 1 3 1 1770
preplace netloc PPS_IN_1 1 0 3 NJ 3160 NJ 3160 NJ
preplace netloc myip_fifo_ctrl_0_gps2_fifo1_rd 1 3 1 1750
preplace netloc fifo_generator_1_empty 1 2 2 820 3100 NJ
preplace netloc StopTrigger7_1 1 0 3 NJ 4060 NJ 4060 NJ
preplace netloc processing_system7_0_DDR 1 1 4 NJ 3610 NJ 3610 NJ 3610 NJ
preplace netloc myip_fifo_ctrl_0_ch4_fifo1_rd 1 3 1 1780
preplace netloc myip_fifo_ctrl_0_start_tri_fifo1_wr 1 3 1 1970
preplace netloc fifo_generator_13_dout 1 2 2 730 940 NJ
preplace netloc myip_fifo_ctrl_0_ch5_fifo2_rd 1 3 1 1670
preplace netloc fifo_generator_20_dout 1 2 2 960 3000 NJ
preplace netloc myip_fifo_ctrl_0_ch2_fifo1_rd 1 3 1 1700
preplace netloc fifo_generator_0_dout 1 2 2 850 1290 NJ
preplace netloc myImode_0_StopDis1 1 3 2 NJ 3830 NJ
preplace netloc myip_fifo_ctrl_0_gps2_fifo2_rd 1 3 1 1790
preplace netloc myip_fifo_ctrl_0_gps1_fifo2_wr 1 3 1 1950
preplace netloc myImode_0_set_zero 1 2 2 1000 3360 1490
preplace netloc myip_fifo_ctrl_0_ch1_fifo2_wr 1 3 1 1830
preplace netloc myip_fifo_ctrl_0_ch4_fifo_wr_data 1 3 1 2080
preplace netloc myImode_0_StopDis2 1 3 2 NJ 3840 NJ
preplace netloc processing_system7_0_FCLK_RESET0_N 1 0 2 10 3370 370
preplace netloc fifo_generator_9_dout 1 2 2 850 3650 NJ
preplace netloc myip_fifo_ctrl_0_ch7_fifo1_rd 1 3 1 1890
preplace netloc myip_fifo_ctrl_0_start_tri_fifo_wr_data 1 3 1 1960
preplace netloc myImode_0_StopDis3 1 3 2 NJ 3870 NJ
preplace netloc myip_fifo_ctrl_0_ch2_fifo2_wr 1 3 1 1650
preplace netloc processing_system7_0_axi_periph_M03_AXI 1 2 1 700
preplace netloc processing_system7_0_axi_periph_M02_AXI 1 2 1 710
preplace netloc myImode_0_ch8_data 1 2 2 910 1650 1580
preplace netloc myip_fifo_ctrl_0_ch5_fifo1_rd 1 3 1 1700
preplace netloc myImode_0_StopDis4 1 3 2 NJ 3850 NJ
preplace netloc axi_uartlite_0_UART 1 3 2 NJ 3420 NJ
preplace netloc myip_fifo_ctrl_0_ch7_fifo2_rd 1 3 1 1980
preplace netloc myip_fifo_ctrl_0_ch6_fifo2_rd 1 3 1 1940
preplace netloc myImode_0_rdn 1 3 2 NJ 3900 NJ
preplace netloc myImode_0_StartDis 1 3 2 NJ 3820 NJ
preplace netloc myip_fifo_ctrl_0_ch6_fifo1_rd 1 3 1 1810
preplace netloc myip_fifo_ctrl_0_start_tri_fifo2_wr 1 3 1 1860
preplace netloc fifo_generator_7_dout 1 2 2 880 1760 NJ
preplace netloc myip_fifo_ctrl_0_gps2_fifo_wr_data 1 3 1 2000
preplace netloc myip_fifo_ctrl_0_gps1_fifo2_rd 1 3 1 1950
preplace netloc myip_fifo_ctrl_0_ch3_fifo1_rd 1 3 1 1910
preplace netloc fifo_generator_16_dout 1 2 2 980 2960 1880
preplace netloc fifo_generator_10_dout 1 2 2 740 430 NJ
preplace netloc myip_fifo_ctrl_0_fifo_rst 1 3 1 2020
preplace netloc myip_fifo_ctrl_0_ch8_fifo_wr_data 1 3 1 2070
preplace netloc myip_fifo_ctrl_0_ch6_fifo_wr_data 1 3 1 1630
preplace netloc processing_system7_0_axi_periph_M01_AXI 1 2 1 720
preplace netloc myip_fifo_ctrl_0_gps1_fifo1_rd 1 3 1 2050
preplace netloc myip_fifo_ctrl_0_ch8_fifo2_wr 1 3 1 2030
preplace netloc myip_fifo_ctrl_0_ch4_fifo1_wr 1 3 1 1900
preplace netloc myImode_0_AluTrigger 1 3 2 NJ 3960 NJ
preplace netloc IrFlag_1 1 0 3 NJ 4100 NJ 4100 NJ
preplace netloc StartTrigger_1 1 0 3 NJ 3920 NJ 3920 NJ
preplace netloc ErrFlag_1 1 0 3 NJ 4160 NJ 4160 NJ
preplace netloc myip_fifo_ctrl_0_ch5_fifo2_wr 1 3 1 1740
preplace netloc Net 1 3 2 NJ 3860 NJ
preplace netloc myip_fifo_ctrl_0_gps1_fifo_wr_data 1 3 1 1790
preplace netloc myip_fifo_ctrl_0_ch2_fifo1_wr 1 3 1 1620
preplace netloc processing_system7_0_FCLK_CLK0 1 0 4 20 3550 390 3190 730 3030 2010
preplace netloc myImode_0_oen 1 3 2 NJ 3940 NJ
preplace netloc StopTrigger2_1 1 0 3 NJ 3960 NJ 3960 NJ
preplace netloc fifo_generator_8_dout 1 2 2 810 3510 NJ
preplace netloc myip_fifo_ctrl_0_ch1_fifo1_wr 1 3 1 1800
preplace netloc rst_processing_system7_0_100M_interconnect_aresetn 1 1 1 410
preplace netloc processing_system7_0_axi_periph_M00_AXI 1 2 1 710
preplace netloc myImode_0_timeDataWrEn 1 2 2 950 1660 1570
preplace netloc myImode_0_ch1_data 1 2 2 960 1710 1560
preplace netloc fifo_generator_12_dout 1 2 2 760 770 NJ
preplace netloc fifo_generator_0_full 1 2 2 930 1230 NJ
preplace netloc myip_fifo_ctrl_0_gps2_fifo2_wr 1 3 1 1900
preplace netloc EF1_1 1 0 3 NJ 4120 NJ 4120 NJ
preplace netloc myImode_0_ch5_data 1 2 2 1000 1750 1520
preplace netloc fifo_generator_15_dout 1 2 2 830 1700 NJ
preplace netloc fifo_generator_4_dout 1 2 2 790 1110 NJ
preplace netloc myImode_0_Tstop1 1 3 2 NJ 4000 NJ
preplace netloc fifo_generator_19_dout 1 2 2 990 2990 NJ
preplace netloc fifo_generator_1_full 1 2 2 780 3110 NJ
preplace netloc StopTrigger6_1 1 0 3 NJ 4040 NJ 4040 NJ
preplace netloc myip_fifo_ctrl_0_ch8_fifo1_wr 1 3 1 1880
preplace netloc myImode_0_Tstop2 1 3 2 NJ 4020 NJ
preplace netloc fifo_generator_17_dout 1 2 2 1000 2970 NJ
preplace netloc myip_fifo_ctrl_0_ch8_fifo2_rd 1 3 1 1800
preplace netloc fifo_generator_11_dout 1 2 2 710 600 NJ
preplace netloc myip_fifo_ctrl_0_ch4_fifo2_wr 1 3 1 1670
preplace netloc myip_fifo_ctrl_0_ch7_fifo_wr_data 1 3 1 1640
preplace netloc myImode_0_Tstop3 1 3 2 NJ 4040 NJ
preplace netloc StopTrigger5_1 1 0 3 NJ 4020 NJ 4020 NJ
preplace netloc myip_fifo_ctrl_0_ch5_fifo1_wr 1 3 1 1840
preplace netloc myip_fifo_ctrl_0_ch1_fifo1_rd 1 3 1 1930
preplace netloc myImode_0_Tstop4 1 3 2 NJ 4060 NJ
preplace netloc myImode_0_addr 1 3 2 NJ 3880 NJ
preplace netloc myip_fifo_ctrl_0_ch7_fifo1_wr 1 3 1 1740
preplace netloc myImode_0_Tstop5 1 3 2 NJ 4080 NJ
preplace netloc myip_fifo_ctrl_0_ch6_fifo1_wr 1 3 1 1660
preplace netloc myImode_0_Tstop6 1 3 2 NJ 4100 NJ
preplace netloc myip_fifo_ctrl_0_ch3_fifo1_wr 1 3 1 1760
preplace netloc myip_fifo_ctrl_0_ch3_fifo_wr_data 1 3 1 1670
preplace netloc processing_system7_0_M_AXI_GP0 1 1 1 400
preplace netloc myImode_0_ch2_data 1 2 2 970 1720 1550
preplace netloc myImode_0_Tstop7 1 3 2 NJ 4120 NJ
preplace netloc StopTrigger3_1 1 0 3 NJ 3980 NJ 3980 NJ
preplace netloc StopTrigger1_1 1 0 3 NJ 3940 NJ 3940 NJ
preplace netloc myImode_0_Tstart_counter 1 2 2 860 3010 1500
preplace netloc myip_fifo_ctrl_0_start_tri_fifo2_rd 1 3 1 1750
preplace netloc myip_fifo_ctrl_0_ch3_fifo2_rd 1 3 1 2040
preplace netloc myImode_0_Tstop8 1 3 2 NJ 4140 NJ
preplace netloc myImode_0_ch4_data 1 2 2 990 1740 1530
preplace netloc myip_fifo_ctrl_0_gps1_fifo1_wr 1 3 1 1660
preplace netloc myImode_0_ch6_data 1 2 2 890 1630 1600
preplace netloc myImode_0_ch3_data 1 2 2 980 1730 1540
preplace netloc myip_fifo_ctrl_0_ch4_fifo2_rd 1 3 1 2060
preplace netloc fifo_generator_5_dout 1 2 2 770 1620 NJ
preplace netloc StopTrigger4_1 1 0 3 NJ 4000 NJ 4000 NJ
preplace netloc rst_processing_system7_0_100M_peripheral_aresetn 1 1 2 380 3170 750
preplace netloc fifo_generator_21_dout 1 2 2 950 3150 NJ
preplace netloc myip_fifo_ctrl_0_ch5_fifo_wr_data 1 3 1 1870
preplace cgraphic comment_10 place abs 2223 2604 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_21 place abs 2228 3105 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_20 place abs 2238 2943 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_3 place abs 2205 1745 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_18 place abs 2241 2105 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_2 place abs 2227 1065 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_17 place abs 2236 890 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_1 place abs 2237 59 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_16 place abs 2226 559 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_0 place abs 2245 1231 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_15 place abs 2202 3680 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_7 place abs 2229 1394 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_14 place abs 2227 1909 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_6 place abs 2194 722 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_13 place abs 2248 1574 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_5 place abs 2198 394 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_12 place abs 2237 218 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_4 place abs 2238 3461 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_11 place abs 2245 3281 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_9 place abs 2212 2423 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_8 place abs 2196 2259 textcolor 4 linecolor 3 linewidth 2
preplace cgraphic comment_19 place abs 2228 2760 textcolor 4 linecolor 3 linewidth 2
levelinfo -pg 1 -20 200 560 1280 2240 2430 -top 0 -bot 4490
",
   linecolor_comment_0: "",
   linecolor_comment_1: "",
   linecolor_comment_10: "",
   linecolor_comment_11: "",
   linecolor_comment_12: "",
   linecolor_comment_13: "",
   linecolor_comment_14: "",
   linecolor_comment_15: "",
   linecolor_comment_16: "",
   linecolor_comment_17: "",
   linecolor_comment_18: "",
   linecolor_comment_19: "",
   linecolor_comment_2: "",
   linecolor_comment_20: "",
   linecolor_comment_21: "",
   linecolor_comment_3: "",
   linecolor_comment_4: "",
   linecolor_comment_5: "",
   linecolor_comment_6: "",
   linecolor_comment_7: "",
   linecolor_comment_8: "",
   linecolor_comment_9: "",
   linktoobj_comment_0: "/fifo_generator_0",
   linktoobj_comment_1: "/fifo_generator_2",
   linktoobj_comment_10: "/fifo_generator_20",
   linktoobj_comment_11: "/fifo_generator_1",
   linktoobj_comment_12: "/fifo_generator_3",
   linktoobj_comment_13: "/fifo_generator_5",
   linktoobj_comment_14: "/fifo_generator_7",
   linktoobj_comment_15: "/fifo_generator_9",
   linktoobj_comment_16: "/fifo_generator_11",
   linktoobj_comment_17: "/fifo_generator_13",
   linktoobj_comment_18: "/fifo_generator_15",
   linktoobj_comment_19: "/fifo_generator_17",
   linktoobj_comment_2: "/fifo_generator_4",
   linktoobj_comment_20: "/fifo_generator_19",
   linktoobj_comment_21: "/fifo_generator_21",
   linktoobj_comment_3: "/fifo_generator_6",
   linktoobj_comment_4: "/fifo_generator_8",
   linktoobj_comment_5: "/fifo_generator_10",
   linktoobj_comment_6: "/fifo_generator_12/din",
   linktoobj_comment_7: "/fifo_generator_14",
   linktoobj_comment_8: "/fifo_generator_16",
   linktoobj_comment_9: "/fifo_generator_18/FIFO_READ",
   linktotype_comment_0: "bd_cell",
   linktotype_comment_1: "bd_cell",
   linktotype_comment_10: "bd_cell",
   linktotype_comment_11: "bd_cell",
   linktotype_comment_12: "bd_cell",
   linktotype_comment_13: "bd_cell",
   linktotype_comment_14: "bd_cell",
   linktotype_comment_15: "bd_cell",
   linktotype_comment_16: "bd_cell",
   linktotype_comment_17: "bd_cell",
   linktotype_comment_18: "bd_cell",
   linktotype_comment_19: "bd_cell",
   linktotype_comment_2: "bd_cell",
   linktotype_comment_20: "bd_cell",
   linktotype_comment_21: "bd_cell",
   linktotype_comment_3: "bd_cell",
   linktotype_comment_4: "bd_cell",
   linktotype_comment_5: "bd_cell",
   linktotype_comment_6: "bd_pin",
   linktotype_comment_7: "bd_cell",
   linktotype_comment_8: "bd_cell",
   linktotype_comment_9: "bd_intf_pin",
   textcolor_comment_0: "",
   textcolor_comment_1: "",
   textcolor_comment_10: "",
   textcolor_comment_11: "",
   textcolor_comment_12: "",
   textcolor_comment_13: "",
   textcolor_comment_14: "",
   textcolor_comment_15: "",
   textcolor_comment_16: "",
   textcolor_comment_17: "",
   textcolor_comment_18: "",
   textcolor_comment_19: "",
   textcolor_comment_2: "",
   textcolor_comment_20: "",
   textcolor_comment_21: "",
   textcolor_comment_3: "",
   textcolor_comment_4: "",
   textcolor_comment_5: "",
   textcolor_comment_6: "",
   textcolor_comment_7: "",
   textcolor_comment_8: "",
   textcolor_comment_9: "",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""



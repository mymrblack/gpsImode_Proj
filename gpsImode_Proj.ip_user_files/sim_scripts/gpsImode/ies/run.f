-makelib ies/xil_defaultlib -sv \
  "D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_base.sv" \
  "D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dpdistram.sv" \
  "D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dprom.sv" \
  "D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sdpram.sv" \
  "D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_spram.sv" \
  "D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sprom.sv" \
  "D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_tdpram.sv" \
-endlib
-makelib ies/xpm \
  "D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/processing_system7_bfm_v2_0_5 \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_wr.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_rd.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_wr_4.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_rd_4.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_hp2_3.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_arb_hp0_1.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ssw_hp.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_sparse_mem.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_reg_map.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ocm_mem.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_intr_wr_mem.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_intr_rd_mem.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_fmsw_gp.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_regc.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ocmc.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_interconnect_model.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_gen_reset.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_gen_clock.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_ddrc.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_axi_slave.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_axi_master.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_afi_slave.v" \
  "../../../ipstatic/processing_system7_bfm_v2_0/hdl/processing_system7_bfm_v2_0_processing_system7_bfm.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../bd/gpsImode/ip/gpsImode_processing_system7_0_0/sim/gpsImode_processing_system7_0_0.v" \
  "../../../bd/gpsImode/ipshared/xilinx.com/newgpsip_v1_0/hdl/newGpsIp_v1_0_GPS_AXI.v" \
  "../../../bd/gpsImode/ipshared/xilinx.com/newgpsip_v1_0/hdl/newGpsIp_v1_0.v" \
  "../../../bd/gpsImode/ip/gpsImode_newGpsIp_0_0/sim/gpsImode_newGpsIp_0_0.v" \
-endlib
-makelib ies/axi_lite_ipif_v3_0_4 \
  "../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/ipif_pkg.vhd" \
  "../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/pselect_f.vhd" \
  "../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/address_decoder.vhd" \
  "../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/slave_attachment.vhd" \
  "../../../ipstatic/axi_lite_ipif_v3_0/hdl/src/vhdl/axi_lite_ipif.vhd" \
-endlib
-makelib ies/lib_pkg_v1_0_2 \
  "../../../ipstatic/lib_pkg_v1_0/hdl/src/vhdl/lib_pkg.vhd" \
-endlib
-makelib ies/lib_srl_fifo_v1_0_2 \
  "../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/cntr_incr_decr_addn_f.vhd" \
  "../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/dynshreg_f.vhd" \
  "../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/srl_fifo_rbu_f.vhd" \
  "../../../ipstatic/lib_srl_fifo_v1_0/hdl/src/vhdl/srl_fifo_f.vhd" \
-endlib
-makelib ies/lib_cdc_v1_0_2 \
  "../../../ipstatic/lib_cdc_v1_0/hdl/src/vhdl/cdc_sync.vhd" \
-endlib
-makelib ies/axi_uartlite_v2_0_13 \
  "../../../ipstatic/axi_uartlite_v2_0/hdl/src/vhdl/dynshreg_i_f.vhd" \
  "../../../ipstatic/axi_uartlite_v2_0/hdl/src/vhdl/uartlite_tx.vhd" \
  "../../../ipstatic/axi_uartlite_v2_0/hdl/src/vhdl/uartlite_rx.vhd" \
  "../../../ipstatic/axi_uartlite_v2_0/hdl/src/vhdl/baudrate.vhd" \
  "../../../ipstatic/axi_uartlite_v2_0/hdl/src/vhdl/uartlite_core.vhd" \
  "../../../ipstatic/axi_uartlite_v2_0/hdl/src/vhdl/axi_uartlite.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../bd/gpsImode/ip/gpsImode_axi_uartlite_0_0/sim/gpsImode_axi_uartlite_0_0.vhd" \
-endlib
-makelib ies/proc_sys_reset_v5_0_9 \
  "../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/upcnt_n.vhd" \
  "../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/sequence_psr.vhd" \
  "../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/lpf.vhd" \
  "../../../ipstatic/proc_sys_reset_v5_0/hdl/src/vhdl/proc_sys_reset.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../bd/gpsImode/ip/gpsImode_rst_processing_system7_0_100M_0/sim/gpsImode_rst_processing_system7_0_100M_0.vhd" \
-endlib
-makelib ies/generic_baseblocks_v2_1_0 \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_and.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_and.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_latch_or.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry_or.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_carry.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_command_fifo.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask_static.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_mask.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask_static.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_mask.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel_static.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_sel.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator_static.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_comparator.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux_enc.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_mux.v" \
  "../../../ipstatic/generic_baseblocks_v2_1/hdl/verilog/generic_baseblocks_v2_1_nto1_mux.v" \
-endlib
-makelib ies/axi_infrastructure_v1_1_0 \
  "../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axi2vector.v" \
  "../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_axic_srl_fifo.v" \
  "../../../ipstatic/axi_infrastructure_v1_1/hdl/verilog/axi_infrastructure_v1_1_vector2axi.v" \
-endlib
-makelib ies/axi_register_slice_v2_1_9 \
  "../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axic_register_slice.v" \
  "../../../ipstatic/axi_register_slice_v2_1/hdl/verilog/axi_register_slice_v2_1_axi_register_slice.v" \
-endlib
-makelib ies/fifo_generator_v13_1_1 \
  "../../../ipstatic/fifo_generator_v13_1/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib ies/fifo_generator_v13_1_1 \
  "../../../ipstatic/fifo_generator_v13_1/hdl/fifo_generator_v13_1_rfs.vhd" \
-endlib
-makelib ies/fifo_generator_v13_1_1 \
  "../../../ipstatic/fifo_generator_v13_1/hdl/fifo_generator_v13_1_rfs.v" \
-endlib
-makelib ies/axi_data_fifo_v2_1_8 \
  "../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_fifo.v" \
  "../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_fifo_gen.v" \
  "../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_srl_fifo.v" \
  "../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axic_reg_srl_fifo.v" \
  "../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_ndeep_srl.v" \
  "../../../ipstatic/axi_data_fifo_v2_1/hdl/verilog/axi_data_fifo_v2_1_axi_data_fifo.v" \
-endlib
-makelib ies/axi_crossbar_v2_1_10 \
  "../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter_sasd.v" \
  "../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_arbiter.v" \
  "../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_addr_decoder.v" \
  "../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_arbiter_resp.v" \
  "../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar_sasd.v" \
  "../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_crossbar.v" \
  "../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_decerr_slave.v" \
  "../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_si_transactor.v" \
  "../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_splitter.v" \
  "../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_mux.v" \
  "../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_wdata_router.v" \
  "../../../ipstatic/axi_crossbar_v2_1/hdl/verilog/axi_crossbar_v2_1_axi_crossbar.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../bd/gpsImode/ip/gpsImode_xbar_0/sim/gpsImode_xbar_0.v" \
  "../../../bd/gpsImode/hdl/gpsImode.v" \
  "../../../bd/gpsImode/ipshared/xilinx.com/myimode_v1_0/hdl/myImode_v1_0_S00_AXI.v" \
  "../../../bd/gpsImode/ipshared/xilinx.com/myimode_v1_0/hdl/myImode_v1_0.v" \
  "../../../bd/gpsImode/ip/gpsImode_myImode_0_1/sim/gpsImode_myImode_0_1.v" \
  "../../../bd/gpsImode/ipshared/xilinx.com/myip_fifo_ctrl_v1_0/hdl/myip_fifo_ctrl_v1_0_FIFO_AXI.v" \
  "../../../bd/gpsImode/ipshared/xilinx.com/myip_fifo_ctrl_v1_0/hdl/myip_fifo_ctrl_v1_0.v" \
  "../../../bd/gpsImode/ip/gpsImode_myip_fifo_ctrl_0_0/sim/gpsImode_myip_fifo_ctrl_0_0.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_0_4/sim/gpsImode_fifo_generator_0_4.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_0_5/sim/gpsImode_fifo_generator_0_5.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_1_1/sim/gpsImode_fifo_generator_1_1.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_1_2/sim/gpsImode_fifo_generator_1_2.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_2_2/sim/gpsImode_fifo_generator_2_2.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_3_1/sim/gpsImode_fifo_generator_3_1.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_4_1/sim/gpsImode_fifo_generator_4_1.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_5_1/sim/gpsImode_fifo_generator_5_1.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_6_1/sim/gpsImode_fifo_generator_6_1.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_7_1/sim/gpsImode_fifo_generator_7_1.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_8_2/sim/gpsImode_fifo_generator_8_2.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_10_2/sim/gpsImode_fifo_generator_10_2.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_10_3/sim/gpsImode_fifo_generator_10_3.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_12_0/sim/gpsImode_fifo_generator_12_0.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_12_1/sim/gpsImode_fifo_generator_12_1.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_14_1/sim/gpsImode_fifo_generator_14_1.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_14_2/sim/gpsImode_fifo_generator_14_2.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_16_0/sim/gpsImode_fifo_generator_16_0.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_16_1/sim/gpsImode_fifo_generator_16_1.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_18_0/sim/gpsImode_fifo_generator_18_0.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_18_1/sim/gpsImode_fifo_generator_18_1.v" \
  "../../../bd/gpsImode/ip/gpsImode_fifo_generator_19_0/sim/gpsImode_fifo_generator_19_0.v" \
-endlib
-makelib ies/axi_protocol_converter_v2_1_9 \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_a_axi3_conv.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi3_conv.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axilite_conv.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_r_axi3_conv.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_w_axi3_conv.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b_downsizer.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_decerr_slave.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_simple_fifo.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wrap_cmd.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_incr_cmd.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_wr_cmd_fsm.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_rd_cmd_fsm.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_cmd_translator.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_b_channel.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_r_channel.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_aw_channel.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s_ar_channel.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_b2s.v" \
  "../../../ipstatic/axi_protocol_converter_v2_1/hdl/verilog/axi_protocol_converter_v2_1_axi_protocol_converter.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../bd/gpsImode/ip/gpsImode_auto_pc_0/sim/gpsImode_auto_pc_0.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib


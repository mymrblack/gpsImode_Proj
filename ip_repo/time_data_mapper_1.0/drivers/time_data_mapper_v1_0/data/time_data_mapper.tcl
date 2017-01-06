

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "time_data_mapper" "NUM_INSTANCES" "DEVICE_ID"  "C_TIME_DATA_AXI_BASEADDR" "C_TIME_DATA_AXI_HIGHADDR"
}

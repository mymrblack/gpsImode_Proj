

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "myip_fifo_ctrl" "NUM_INSTANCES" "DEVICE_ID"  "C_FIFO_AXI_BASEADDR" "C_FIFO_AXI_HIGHADDR"
}

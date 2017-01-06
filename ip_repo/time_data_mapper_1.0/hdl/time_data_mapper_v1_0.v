
`timescale 1 ns / 1 ps

	module time_data_mapper_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface TIME_DATA_AXI
		parameter integer C_TIME_DATA_AXI_DATA_WIDTH	= 32,
		parameter integer C_TIME_DATA_AXI_ADDR_WIDTH	= 10
	)
	(
		// Users to add ports here
        input saveFlag_in, input [31:0] tdcTimeData_in, input setFlag, 
        output dataCanBeReadFlag,
        output [31:0] data1_group1_out, output [31:0] data2_group1_out,
        output [31:0] data3_group1_out, output [31:0] data4_group1_out,
        output [31:0] data5_group1_out, output [31:0] data6_group1_out,
        output [31:0] data7_group1_out, output [31:0] data8_group1_out,

        output [31:0] data1_group2_out, output [31:0] data2_group2_out,
        output [31:0] data3_group2_out, output [31:0] data4_group2_out,
        output [31:0] data5_group2_out, output [31:0] data6_group2_out,
        output [31:0] data7_group2_out, output [31:0] data8_group2_out,

        output [31:0] data1_group3_out, output [31:0] data2_group3_out,
        output [31:0] data3_group3_out, output [31:0] data4_group3_out,
        output [31:0] data5_group3_out, output [31:0] data6_group3_out,
        output [31:0] data7_group3_out, output [31:0] data8_group3_out,

        output [31:0] data1_group4_out, output [31:0] data2_group4_out,
        output [31:0] data3_group4_out, output [31:0] data4_group4_out,
        output [31:0] data5_group4_out, output [31:0] data6_group4_out,
        output [31:0] data7_group4_out, output [31:0] data8_group4_out,

        output [31:0] data1_group5_out, output [31:0] data2_group5_out,
        output [31:0] data3_group5_out, output [31:0] data4_group5_out,
        output [31:0] data5_group5_out, output [31:0] data6_group5_out,
        output [31:0] data7_group5_out, output [31:0] data8_group5_out,

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface TIME_DATA_AXI
		input wire  time_data_axi_aclk,
		input wire  time_data_axi_aresetn,
		input wire [C_TIME_DATA_AXI_ADDR_WIDTH-1 : 0] time_data_axi_awaddr,
		input wire [2 : 0] time_data_axi_awprot,
		input wire  time_data_axi_awvalid,
		output wire  time_data_axi_awready,
		input wire [C_TIME_DATA_AXI_DATA_WIDTH-1 : 0] time_data_axi_wdata,
		input wire [(C_TIME_DATA_AXI_DATA_WIDTH/8)-1 : 0] time_data_axi_wstrb,
		input wire  time_data_axi_wvalid,
		output wire  time_data_axi_wready,
		output wire [1 : 0] time_data_axi_bresp,
		output wire  time_data_axi_bvalid,
		input wire  time_data_axi_bready,
		input wire [C_TIME_DATA_AXI_ADDR_WIDTH-1 : 0] time_data_axi_araddr,
		input wire [2 : 0] time_data_axi_arprot,
		input wire  time_data_axi_arvalid,
		output wire  time_data_axi_arready,
		output wire [C_TIME_DATA_AXI_DATA_WIDTH-1 : 0] time_data_axi_rdata,
		output wire [1 : 0] time_data_axi_rresp,
		output wire  time_data_axi_rvalid,
		input wire  time_data_axi_rready
	);
// Instantiation of Axi Bus Interface TIME_DATA_AXI
	time_data_mapper_v1_0_TIME_DATA_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_TIME_DATA_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_TIME_DATA_AXI_ADDR_WIDTH)
    ) time_data_mapper_v1_0_TIME_DATA_AXI_inst (
        .saveFlag_in(saveFlag_in), 
        .tdcTimeData_in(tdcTimeData_in), 
        .setFlag(setFlag), 
        .dataCanBeReadFlag(dataCanBeReadFlag),
        .data1_group1_out(data1_group1_out), .data2_group1_out(data2_group1_out),
        .data3_group1_out(data3_group1_out), .data4_group1_out(data4_group1_out),
        .data5_group1_out(data5_group1_out), .data6_group1_out(data6_group1_out),
        .data7_group1_out(data7_group1_out), .data8_group1_out(data8_group1_out),

        .data1_group2_out(data1_group2_out), .data2_group2_out(data2_group2_out),
        .data3_group2_out(data3_group2_out), .data4_group2_out(data4_group2_out),
        .data5_group2_out(data5_group2_out), .data6_group2_out(data6_group2_out),
        .data7_group2_out(data7_group2_out), .data8_group2_out(data8_group2_out),

        .data1_group3_out(data1_group3_out), .data2_group3_out(data2_group3_out),
        .data3_group3_out(data3_group3_out), .data4_group3_out(data4_group3_out),
        .data5_group3_out(data5_group3_out), .data6_group3_out(data6_group3_out),
        .data7_group3_out(data7_group3_out), .data8_group3_out(data8_group3_out),

        .data1_group4_out(data1_group4_out), .data2_group4_out(data2_group4_out),
        .data3_group4_out(data3_group4_out), .data4_group4_out(data4_group4_out),
        .data5_group4_out(data5_group4_out), .data6_group4_out(data6_group4_out),
        .data7_group4_out(data7_group4_out), .data8_group4_out(data8_group4_out),

        .data1_group5_out(data1_group5_out), .data2_group5_out(data2_group5_out),
        .data3_group5_out(data3_group5_out), .data4_group5_out(data4_group5_out),
        .data5_group5_out(data5_group5_out), .data6_group5_out(data6_group5_out),
        .data7_group5_out(data7_group5_out), .data8_group5_out(data8_group5_out),
		.S_AXI_ACLK(time_data_axi_aclk),
		.S_AXI_ARESETN(time_data_axi_aresetn),
		.S_AXI_AWADDR(time_data_axi_awaddr),
		.S_AXI_AWPROT(time_data_axi_awprot),
		.S_AXI_AWVALID(time_data_axi_awvalid),
		.S_AXI_AWREADY(time_data_axi_awready),
		.S_AXI_WDATA(time_data_axi_wdata),
		.S_AXI_WSTRB(time_data_axi_wstrb),
		.S_AXI_WVALID(time_data_axi_wvalid),
		.S_AXI_WREADY(time_data_axi_wready),
		.S_AXI_BRESP(time_data_axi_bresp),
		.S_AXI_BVALID(time_data_axi_bvalid),
		.S_AXI_BREADY(time_data_axi_bready),
		.S_AXI_ARADDR(time_data_axi_araddr),
		.S_AXI_ARPROT(time_data_axi_arprot),
		.S_AXI_ARVALID(time_data_axi_arvalid),
		.S_AXI_ARREADY(time_data_axi_arready),
		.S_AXI_RDATA(time_data_axi_rdata),
		.S_AXI_RRESP(time_data_axi_rresp),
		.S_AXI_RVALID(time_data_axi_rvalid),
		.S_AXI_RREADY(time_data_axi_rready)
	);

	// Add user logic here

	// User logic ends

	endmodule

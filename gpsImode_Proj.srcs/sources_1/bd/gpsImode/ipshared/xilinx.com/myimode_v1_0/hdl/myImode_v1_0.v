
`timescale 1 ns / 1 ps

	module myImode_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 7
	)
	(
		// Users to add ports here
        input wire StartTrigger,
        input wire StopTrigger1,
        input wire StopTrigger2,
        input wire StopTrigger3,
        input wire StopTrigger4,
        input wire StopTrigger5,
        input wire StopTrigger6,
        input wire StopTrigger7,
        input wire StopTrigger8,

        output wire StopDis1,
        output wire StopDis2,
        output wire StopDis3,
        output wire StopDis4,
        output wire StartDis,
        output wire[3:0] addr,
        inout wire [27:0] data,
        output wire wrn,
        output wire rdn,
        output wire csn,
        output wire oen,
        output wire AluTrigger,
        input wire IrFlag,
        input wire EF1,
        input wire EF2,
        input wire ErrFlag,
        output wire Tstart,
        output  wire Tstop1,
        output wire Tstop2,
        output wire Tstop3,
        output wire Tstop4,
        output wire Tstop5,
        output wire Tstop6,
        output wire Tstop7,
        output wire Tstop8,
        output wire set_zero,
        
        output wire [31:0] Tstart_counter,
        output wire [16:0] ch1_data,
        output wire [16:0] ch2_data,
        output wire [16:0] ch3_data,
        output wire [16:0] ch4_data,
        output wire [16:0] ch5_data,
        output wire [16:0] ch6_data,
        output wire [16:0] ch7_data,
        output wire [16:0] ch8_data,
        output wire timeDataWrEn,
        // User ports ends
        // Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);
// Instantiation of Axi Bus Interface S00_AXI
	myImode_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) myImode_v1_0_S00_AXI_inst (
        .StartTrigger(StartTrigger),
        .StopTrigger1(StopTrigger1),
        .StopTrigger2(StopTrigger2),
        .StopTrigger3(StopTrigger3),
        .StopTrigger4(StopTrigger4),
        .StopTrigger5(StopTrigger5),
        .StopTrigger6(StopTrigger6),
        .StopTrigger7(StopTrigger7),
        .StopTrigger8(StopTrigger8),
        .StopDis1(StopDis1),
        .StopDis2(StopDis2),
        .StopDis3(StopDis3),
        .StopDis4(StopDis4),
        .StartDis(StartDis),
        .addr(addr),
        .data(data),
        .wrn(wrn),
        .rdn(rdn),
        .csn(csn),
        .oen(oen),
        .dataCanBeRd_out(timeDataWrEn),
        .ch1_data(ch1_data),
        .ch2_data(ch2_data),
        .ch3_data(ch3_data),
        .ch4_data(ch4_data),
        .ch5_data(ch5_data),
        .ch6_data(ch6_data),
        .ch7_data(ch7_data),
        .ch8_data(ch8_data),
        .Tstart_counter(Tstart_counter),
        .AluTrigger(AluTrigger),
        .IrFlag(IrFlag),
        .EF1(EF1),
        .EF2(EF2),
        .ErrFlag(ErrFlag),
        .Tstart(Tstart),
        .Tstop1(Tstop1),
        .Tstop2(Tstop2),
        .Tstop3(Tstop3),
        .Tstop4(Tstop4),
        .Tstop5(Tstop5),
        .Tstop6(Tstop6),
        .Tstop7(Tstop7),
        .Tstop8(Tstop8),
        .set_zero(set_zero),//as a tstart trigger
        .S_AXI_ACLK(s00_axi_aclk),
        .S_AXI_ARESETN(s00_axi_aresetn),
        .S_AXI_AWADDR(s00_axi_awaddr),
        .S_AXI_AWPROT(s00_axi_awprot),
        .S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);

	// Add user logic here

	// User logic ends

	endmodule

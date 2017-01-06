
`timescale 1 ns / 1 ps

module myip_fifo_ctrl_v1_0_FIFO_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 8
	)
    (
        // Users to add ports here
        input data_in_flag,
        input fifo1_full,
        input fifo2_full,
        input fifo1_empty,
        input fifo2_empty,

        input [16:0] ch1_data_to_be_wr,
        input [16:0] ch2_data_to_be_wr,
        input [16:0] ch3_data_to_be_wr,
        input [16:0] ch4_data_to_be_wr,
        input [16:0] ch5_data_to_be_wr,
        input [16:0] ch6_data_to_be_wr,
        input [16:0] ch7_data_to_be_wr,
        input [16:0] ch8_data_to_be_wr,
        input [31:0] gps1_data_to_be_wr,
        input [31:0] gps2_data_to_be_wr,
        input [31:0] start_tri_data_to_be_wr,

        input [16:0] ch1_fifo1_rd_data,
        input [16:0] ch2_fifo1_rd_data,
        input [16:0] ch3_fifo1_rd_data,
        input [16:0] ch4_fifo1_rd_data,
        input [16:0] ch5_fifo1_rd_data,
        input [16:0] ch6_fifo1_rd_data,
        input [16:0] ch7_fifo1_rd_data,
        input [16:0] ch8_fifo1_rd_data,
        input [31:0] gps1_fifo1_rd_data,
        input [31:0] gps2_fifo1_rd_data,
        input [31:0] start_tri_fifo1_rd_data,

        input [16:0] ch1_fifo2_rd_data,
        input [16:0] ch2_fifo2_rd_data,
        input [16:0] ch3_fifo2_rd_data,
        input [16:0] ch4_fifo2_rd_data,
        input [16:0] ch5_fifo2_rd_data,
        input [16:0] ch6_fifo2_rd_data,
        input [16:0] ch7_fifo2_rd_data,
        input [16:0] ch8_fifo2_rd_data,
        input [31:0] gps1_fifo2_rd_data,
        input [31:0] gps2_fifo2_rd_data,
        input [31:0] start_tri_fifo2_rd_data,

        output [16:0] ch1_fifo_wr_data,
        output [16:0] ch2_fifo_wr_data,
        output [16:0] ch3_fifo_wr_data,
        output [16:0] ch4_fifo_wr_data,
        output [16:0] ch5_fifo_wr_data,
        output [16:0] ch6_fifo_wr_data,
        output [16:0] ch7_fifo_wr_data,
        output [16:0] ch8_fifo_wr_data,
        output [31:0] gps1_fifo_wr_data,
        output [31:0] gps2_fifo_wr_data,
        output [31:0] start_tri_fifo_wr_data,

        output ch1_fifo1_wr,
        output ch2_fifo1_wr,
        output ch3_fifo1_wr,
        output ch4_fifo1_wr,
        output ch5_fifo1_wr,
        output ch6_fifo1_wr,
        output ch7_fifo1_wr,
        output ch8_fifo1_wr,
        output gps1_fifo1_wr,
        output gps2_fifo1_wr,
        output start_tri_fifo1_wr,

        output ch1_fifo2_wr,
        output ch2_fifo2_wr,
        output ch3_fifo2_wr,
        output ch4_fifo2_wr,
        output ch5_fifo2_wr,
        output ch6_fifo2_wr,
        output ch7_fifo2_wr,
        output ch8_fifo2_wr,
        output gps1_fifo2_wr,
        output gps2_fifo2_wr,
        output start_tri_fifo2_wr,

        output ch1_fifo1_rd,
        output ch2_fifo1_rd,
        output ch3_fifo1_rd,
        output ch4_fifo1_rd,
        output ch5_fifo1_rd,
        output ch6_fifo1_rd,
        output ch7_fifo1_rd,
        output ch8_fifo1_rd,
        output gps1_fifo1_rd,
        output gps2_fifo1_rd,
        output start_tri_fifo1_rd,

        output ch1_fifo2_rd,
        output ch2_fifo2_rd,
        output ch3_fifo2_rd,
        output ch4_fifo2_rd,
        output ch5_fifo2_rd,
        output ch6_fifo2_rd,
        output ch7_fifo2_rd,
        output ch8_fifo2_rd,
        output gps1_fifo2_rd,
        output gps2_fifo2_rd,
        output start_tri_fifo2_rd,

        output fifo_rst,
		// User ports ends
		// Do not modify the ports beyond this line

		// Global Clock Signal
		input wire  S_AXI_ACLK,
		// Global Reset Signal. This Signal is Active LOW
		input wire  S_AXI_ARESETN,
		// Write address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		// Write channel Protection type. This signal indicates the
    		// privilege and security level of the transaction, and whether
    		// the transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_AWPROT,
		// Write address valid. This signal indicates that the master signaling
    		// valid write address and control information.
		input wire  S_AXI_AWVALID,
		// Write address ready. This signal indicates that the slave is ready
    		// to accept an address and associated control signals.
		output wire  S_AXI_AWREADY,
		// Write data (issued by master, acceped by Slave) 
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		// Write strobes. This signal indicates which byte lanes hold
    		// valid data. There is one write strobe bit for each eight
    		// bits of the write data bus.    
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		// Write valid. This signal indicates that valid write
    		// data and strobes are available.
		input wire  S_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    		// can accept the write data.
		output wire  S_AXI_WREADY,
		// Write response. This signal indicates the status
    		// of the write transaction.
		output wire [1 : 0] S_AXI_BRESP,
		// Write response valid. This signal indicates that the channel
    		// is signaling a valid write response.
		output wire  S_AXI_BVALID,
		// Response ready. This signal indicates that the master
    		// can accept a write response.
		input wire  S_AXI_BREADY,
		// Read address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		// Protection type. This signal indicates the privilege
    		// and security level of the transaction, and whether the
    		// transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_ARPROT,
		// Read address valid. This signal indicates that the channel
    		// is signaling valid read address and control information.
		input wire  S_AXI_ARVALID,
		// Read address ready. This signal indicates that the slave is
    		// ready to accept an address and associated control signals.
		output wire  S_AXI_ARREADY,
		// Read data (issued by slave)
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		// Read response. This signal indicates the status of the
    		// read transfer.
		output wire [1 : 0] S_AXI_RRESP,
		// Read valid. This signal indicates that the channel is
    		// signaling the required read data.
		output wire  S_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    		// accept the read data and response information.
		input wire  S_AXI_RREADY
	);

	// AXI4LITE signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	// Example-specific design signals
	// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	// ADDR_LSB is used for addressing 32/64 bit registers/memories
	// ADDR_LSB = 2 for 32 bits (n downto 2)
	// ADDR_LSB = 3 for 64 bits (n downto 3)
	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
	localparam integer OPT_MEM_ADDR_BITS = 5;
	//----------------------------------------------
	//-- Signals for user logic register space example
    wire rd_command1;
    wire rd_command2;
    wire wr_fifo_num;

    wire [31:0] ch1_fifo1_data_to_sw;
    wire [31:0] ch2_fifo1_data_to_sw;
    wire [31:0] ch3_fifo1_data_to_sw;
    wire [31:0] ch4_fifo1_data_to_sw;
    wire [31:0] ch5_fifo1_data_to_sw;
    wire [31:0] ch6_fifo1_data_to_sw;
    wire [31:0] ch7_fifo1_data_to_sw;
    wire [31:0] ch8_fifo1_data_to_sw;
    wire [31:0] gps1_fifo1_data_to_sw;
    wire [31:0] gps2_fifo1_data_to_sw;
    wire [31:0] start_tri_fifo1_data_to_sw;

    wire [31:0] ch1_fifo2_data_to_sw;
    wire [31:0] ch2_fifo2_data_to_sw;
    wire [31:0] ch3_fifo2_data_to_sw;
    wire [31:0] ch4_fifo2_data_to_sw;
    wire [31:0] ch5_fifo2_data_to_sw;
    wire [31:0] ch6_fifo2_data_to_sw;
    wire [31:0] ch7_fifo2_data_to_sw;
    wire [31:0] ch8_fifo2_data_to_sw;
    wire [31:0] gps1_fifo2_data_to_sw;
    wire [31:0] gps2_fifo2_data_to_sw;
    wire [31:0] start_tri_fifo2_data_to_sw;
	//------------------------------------------------
	//-- Number of Slave Registers 43
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg4;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg5;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg6;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg7;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg8;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg9;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg10;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg11;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg12;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg13;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg14;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg15;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg16;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg17;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg18;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg19;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg20;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg21;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg22;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg23;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg24;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg25;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg26;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg27;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg28;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg29;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg30;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg31;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg32;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg33;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg34;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg35;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg36;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg37;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg38;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg39;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg40;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg41;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg42;
	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
	integer	 byte_index;

	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;
	// Implement axi_awready generation
	// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID)
	        begin
	          // slave is ready to accept write address when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_awready <= 1'b1;
	        end
	      else           
	        begin
	          axi_awready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_awaddr latching
	// This process is used to latch the address when both 
	// S_AXI_AWVALID and S_AXI_WVALID are valid. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID)
	        begin
	          // Write Address latching 
	          axi_awaddr <= S_AXI_AWADDR;
	        end
	    end 
	end       

	// Implement axi_wready generation
	// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	// de-asserted when reset is low. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID)
	        begin
	          // slave is ready to accept write data when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b0;
	        end
	    end 
	end       

	// Implement memory mapped register select and write logic generation
	// The write data is accepted and written to memory mapped registers when
	// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	// select byte enables of slave registers while writing.
	// These registers are cleared when reset (active low) is applied.
	// Slave register write enable is asserted when valid address and data are available
	// and the slave is ready to accept the write address and write data.
	assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      slv_reg0 <= 0;
	      slv_reg1 <= 0;
	      slv_reg2 <= 0;
	      slv_reg3 <= 0;
	      slv_reg4 <= 0;
	      slv_reg5 <= 0;
	      slv_reg6 <= 0;
	      slv_reg7 <= 0;
	      slv_reg8 <= 0;
	      slv_reg9 <= 0;
	      slv_reg10 <= 0;
	      slv_reg11 <= 0;
	      slv_reg12 <= 0;
	      slv_reg13 <= 0;
	      slv_reg14 <= 0;
	      slv_reg15 <= 0;
	      slv_reg16 <= 0;
	      slv_reg17 <= 0;
	      slv_reg18 <= 0;
	      slv_reg19 <= 0;
	      slv_reg20 <= 0;
	      slv_reg21 <= 0;
	      slv_reg22 <= 0;
	      slv_reg23 <= 0;
	      slv_reg24 <= 0;
	      slv_reg25 <= 0;
	      slv_reg26 <= 0;
	      slv_reg27 <= 0;
	      slv_reg28 <= 0;
	      slv_reg29 <= 0;
	      slv_reg30 <= 0;
	      slv_reg31 <= 0;
	      slv_reg32 <= 0;
	      slv_reg33 <= 0;
	      slv_reg34 <= 0;
	      slv_reg35 <= 0;
	      slv_reg36 <= 0;
	      slv_reg37 <= 0;
	      slv_reg38 <= 0;
	      slv_reg39 <= 0;
	      slv_reg40 <= 0;
	      slv_reg41 <= 0;
	      slv_reg42 <= 0;
	    end 
	  else begin
	    if (slv_reg_wren)
	      begin
	        case ( axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	          6'h00:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 0
	                slv_reg0[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h01:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 1
	                slv_reg1[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h02:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 2
	                slv_reg2[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h03:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 3
	                slv_reg3[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h04:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 4
	                slv_reg4[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h05:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 5
	                slv_reg5[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h06:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 6
	                slv_reg6[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h07:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 7
	                slv_reg7[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h08:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 8
	                slv_reg8[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h09:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 9
	                slv_reg9[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h0A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 10
	                slv_reg10[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h0B:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 11
	                slv_reg11[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h0C:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 12
	                slv_reg12[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h0D:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 13
	                slv_reg13[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h0E:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 14
	                slv_reg14[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h0F:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 15
	                slv_reg15[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h10:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 16
	                slv_reg16[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h11:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 17
	                slv_reg17[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h12:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 18
	                slv_reg18[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h13:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 19
	                slv_reg19[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h14:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 20
	                slv_reg20[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h15:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 21
	                slv_reg21[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h16:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 22
	                slv_reg22[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h17:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 23
	                slv_reg23[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h18:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 24
	                slv_reg24[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h19:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 25
	                slv_reg25[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h1A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 26
	                slv_reg26[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h1B:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 27
	                slv_reg27[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h1C:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 28
	                slv_reg28[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h1D:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 29
	                slv_reg29[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h1E:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 30
	                slv_reg30[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h1F:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 31
	                slv_reg31[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h20:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 32
	                slv_reg32[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h21:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 33
	                slv_reg33[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h22:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 34
	                slv_reg34[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h23:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 35
	                slv_reg35[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h24:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 36
	                slv_reg36[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h25:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 37
	                slv_reg37[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h26:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 38
	                slv_reg38[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h27:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 39
	                slv_reg39[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h28:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 40
	                slv_reg40[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h29:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 41
	                slv_reg41[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          6'h2A:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 42
	                slv_reg42[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          default : begin
	                      slv_reg0 <= slv_reg0;
	                      slv_reg1 <= slv_reg1;
	                      slv_reg2 <= slv_reg2;
	                      slv_reg3 <= slv_reg3;
	                      slv_reg4 <= slv_reg4;
	                      slv_reg5 <= slv_reg5;
	                      slv_reg6 <= slv_reg6;
	                      slv_reg7 <= slv_reg7;
	                      slv_reg8 <= slv_reg8;
	                      slv_reg9 <= slv_reg9;
	                      slv_reg10 <= slv_reg10;
	                      slv_reg11 <= slv_reg11;
	                      slv_reg12 <= slv_reg12;
	                      slv_reg13 <= slv_reg13;
	                      slv_reg14 <= slv_reg14;
	                      slv_reg15 <= slv_reg15;
	                      slv_reg16 <= slv_reg16;
	                      slv_reg17 <= slv_reg17;
	                      slv_reg18 <= slv_reg18;
	                      slv_reg19 <= slv_reg19;
	                      slv_reg20 <= slv_reg20;
	                      slv_reg21 <= slv_reg21;
	                      slv_reg22 <= slv_reg22;
	                      slv_reg23 <= slv_reg23;
	                      slv_reg24 <= slv_reg24;
	                      slv_reg25 <= slv_reg25;
	                      slv_reg26 <= slv_reg26;
	                      slv_reg27 <= slv_reg27;
	                      slv_reg28 <= slv_reg28;
	                      slv_reg29 <= slv_reg29;
	                      slv_reg30 <= slv_reg30;
	                      slv_reg31 <= slv_reg31;
	                      slv_reg32 <= slv_reg32;
	                      slv_reg33 <= slv_reg33;
	                      slv_reg34 <= slv_reg34;
	                      slv_reg35 <= slv_reg35;
	                      slv_reg36 <= slv_reg36;
	                      slv_reg37 <= slv_reg37;
	                      slv_reg38 <= slv_reg38;
	                      slv_reg39 <= slv_reg39;
	                      slv_reg40 <= slv_reg40;
	                      slv_reg41 <= slv_reg41;
	                      slv_reg42 <= slv_reg42;
	                    end
	        endcase
	      end
	  end
	end    

	// Implement write response logic generation
	// The write response and response valid signals are asserted by the slave 
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	// This marks the acceptance of address and indicates the status of 
	// write transaction.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'b0;
	    end 
	  else
	    begin    
	      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
	        begin
	          // indicates a valid write response is available
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; // 'OKAY' response 
	        end                   // work error responses in future
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid) 
	            //check if bready is asserted while bvalid is high) 
	            //(there is a possibility that bready is always asserted high)   
	            begin
	              axi_bvalid <= 1'b0; 
	            end  
	        end
	    end
	end   

	// Implement axi_arready generation
	// axi_arready is asserted for one S_AXI_ACLK clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is 
	// de-asserted when reset (active low) is asserted. 
	// The read address is also latched when S_AXI_ARVALID is 
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_araddr  <= 32'b0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID)
	        begin
	          // indicates that the slave has acceped the valid read address
	          axi_arready <= 1'b1;
	          // Read address latching
	          axi_araddr  <= S_AXI_ARADDR;
	        end
	      else
	        begin
	          axi_arready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_arvalid generation
	// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	// data are available on the axi_rdata bus at this instance. The 
	// assertion of axi_rvalid marks the validity of read data on the 
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	// is deasserted on reset (active low). axi_rresp and axi_rdata are 
	// cleared to zero on reset (active low).  
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end 
	  else
	    begin    
	      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
	        begin
	          // Valid read data is available at the read data bus
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; // 'OKAY' response
	        end   
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          // Read data is accepted by the master
	          axi_rvalid <= 1'b0;
	        end                
	    end
	end    

	// Implement memory mapped register select and read logic generation
	// Slave register read enable is asserted when valid address is available
	// and the slave is ready to accept the read address.
	assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
	always @(*)
	begin
	      // Address decoding for reading registers
	      case ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	        6'h00   : reg_data_out <= {fifo2_full, fifo2_empty, fifo1_full, fifo1_empty};
	        6'h01   : reg_data_out <= {15'b0, ch1_fifo1_data_to_sw[16:0]};
	        6'h02   : reg_data_out <= {15'b0, ch2_fifo1_data_to_sw[16:0]};
	        6'h03   : reg_data_out <= {15'b0, ch3_fifo1_data_to_sw[16:0]};
	        6'h04   : reg_data_out <= {15'b0, ch4_fifo1_data_to_sw[16:0]};
	        6'h05   : reg_data_out <= {15'b0, ch5_fifo1_data_to_sw[16:0]};
	        6'h06   : reg_data_out <= {15'b0, ch6_fifo1_data_to_sw[16:0]};
	        6'h07   : reg_data_out <= {15'b0, ch7_fifo1_data_to_sw[16:0]};
	        6'h08   : reg_data_out <= {15'b0, ch8_fifo1_data_to_sw[16:0]};
	        6'h09   : reg_data_out <= gps1_fifo1_data_to_sw;
	        6'h0A   : reg_data_out <= gps2_fifo1_data_to_sw;
	        6'h0B   : reg_data_out <= start_tri_fifo1_data_to_sw;
	        6'h0C   : reg_data_out <= slv_reg12;
	        6'h0D   : reg_data_out <= slv_reg13;
	        6'h0E   : reg_data_out <= slv_reg14;
	        6'h0F   : reg_data_out <= slv_reg15;
	        6'h10   : reg_data_out <= slv_reg16;
	        6'h11   : reg_data_out <= slv_reg17;
	        6'h12   : reg_data_out <= slv_reg18;
	        6'h13   : reg_data_out <= slv_reg19;
	        6'h14   : reg_data_out <= slv_reg20;
	        6'h15   : reg_data_out <= slv_reg21;
	        6'h16   : reg_data_out <= {15'b0, ch1_fifo2_data_to_sw[16:0]};
	        6'h17   : reg_data_out <= {15'b0, ch2_fifo2_data_to_sw[16:0]};
	        6'h18   : reg_data_out <= {15'b0, ch3_fifo2_data_to_sw[16:0]};
	        6'h19   : reg_data_out <= {15'b0, ch4_fifo2_data_to_sw[16:0]};
	        6'h1A   : reg_data_out <= {15'b0, ch5_fifo2_data_to_sw[16:0]};
	        6'h1B   : reg_data_out <= {15'b0, ch6_fifo2_data_to_sw[16:0]};
	        6'h1C   : reg_data_out <= {15'b0, ch7_fifo2_data_to_sw[16:0]};
	        6'h1D   : reg_data_out <= {15'b0, ch8_fifo2_data_to_sw[16:0]};
	        6'h1E   : reg_data_out <= gps1_fifo2_data_to_sw;
	        6'h1F   : reg_data_out <= gps2_fifo2_data_to_sw;
	        6'h20   : reg_data_out <= start_tri_fifo2_data_to_sw;
	        6'h21   : reg_data_out <= slv_reg33; 
	        6'h22   : reg_data_out <= slv_reg34;
	        6'h23   : reg_data_out <= slv_reg35;
	        6'h24   : reg_data_out <= slv_reg36;
	        6'h25   : reg_data_out <= slv_reg37;
	        6'h26   : reg_data_out <= slv_reg38;
	        6'h27   : reg_data_out <= slv_reg39;
	        6'h28   : reg_data_out <= slv_reg40;
	        6'h29   : reg_data_out <= slv_reg41;
	        6'h2A   : reg_data_out <= slv_reg42;
	        default : reg_data_out <= 0;
	      endcase
	end

	// Output register or memory read data
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end 
	  else
	    begin    
	      // When there is a valid read address (S_AXI_ARVALID) with 
	      // acceptance of read address by the slave (axi_arready), 
	      // output the read dada 
	      if (slv_reg_rden)
	        begin
	          axi_rdata <= reg_data_out;     // register read data
	        end   
	    end
	end    

	// Add user logic here
    assign fifo_rst = slv_reg0[0]; 
    assign rd_command1 = slv_reg0[1];
    assign rd_command2 = slv_reg0[2];

    fifo_block_ctrl ch1(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .rd_command1(rd_command1), .rd_command2(rd_command2), 
        .wr(data_in_flag), .full1(fifo1_full), .full2(fifo2_full), 
        .data_to_be_wr({15'b0, ch1_data_to_be_wr}), 
        .fifo1_rd_data({15'b0, ch1_fifo1_rd_data}), .fifo2_rd_data({15'b0, ch1_fifo2_rd_data}), 
        .wr1(ch1_fifo1_wr), .wr2(ch1_fifo2_wr), .rd1(ch1_fifo1_rd), .rd2(ch1_fifo2_rd),
        .wr_fifo_num(wr_fifo_num),
        .fifo1_data_to_sw(ch1_fifo1_data_to_sw), .fifo2_data_to_sw(ch1_fifo2_data_to_sw), 
        .fifo_wr_data(ch1_fifo_wr_data));
    
    fifo_block_ctrl ch2(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .rd_command1(rd_command1), .rd_command2(rd_command2), 
        .wr(data_in_flag), .full1(fifo1_full), .full2(fifo2_full), 
        .data_to_be_wr({15'b0, ch2_data_to_be_wr}), 
        .fifo1_rd_data({15'b0, ch2_fifo1_rd_data}), .fifo2_rd_data({15'b0, ch2_fifo2_rd_data}), 
        .wr1(ch2_fifo1_wr), .wr2(ch2_fifo2_wr), .rd1(ch2_fifo1_rd), .rd2(ch2_fifo2_rd),
        .wr_fifo_num(wr_fifo_num),
        .fifo1_data_to_sw(ch2_fifo1_data_to_sw), .fifo2_data_to_sw(ch2_fifo2_data_to_sw), 
        .fifo_wr_data(ch2_fifo_wr_data));
    
    fifo_block_ctrl ch3(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .rd_command1(rd_command1), .rd_command2(rd_command2), 
        .wr(data_in_flag), .full1(fifo1_full), .full2(fifo2_full), 
        .data_to_be_wr({15'b0, ch3_data_to_be_wr}), 
        .fifo1_rd_data({15'b0, ch3_fifo1_rd_data}), .fifo2_rd_data({15'b0, ch3_fifo2_rd_data}), 
        .wr1(ch3_fifo1_wr), .wr2(ch3_fifo2_wr), .rd1(ch3_fifo1_rd), .rd2(ch3_fifo2_rd),
        .wr_fifo_num(wr_fifo_num),
        .fifo1_data_to_sw(ch3_fifo1_data_to_sw), .fifo2_data_to_sw(ch3_fifo2_data_to_sw), 
        .fifo_wr_data(ch3_fifo_wr_data));
    
    fifo_block_ctrl ch4(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .rd_command1(rd_command1), .rd_command2(rd_command2), 
        .wr(data_in_flag), .full1(fifo1_full), .full2(fifo2_full), 
        .data_to_be_wr({15'b0, ch4_data_to_be_wr}), 
        .fifo1_rd_data({15'b0, ch4_fifo1_rd_data}), .fifo2_rd_data({15'b0, ch4_fifo2_rd_data}), 
        .wr1(ch4_fifo1_wr), .wr2(ch4_fifo2_wr), .rd1(ch4_fifo1_rd), .rd2(ch4_fifo2_rd),
        .wr_fifo_num(wr_fifo_num),
        .fifo1_data_to_sw(ch4_fifo1_data_to_sw), .fifo2_data_to_sw(ch4_fifo2_data_to_sw), 
        .fifo_wr_data(ch4_fifo_wr_data));
    
    fifo_block_ctrl ch5(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .rd_command1(rd_command1), .rd_command2(rd_command2), 
        .wr(data_in_flag), .full1(fifo1_full), .full2(fifo2_full), 
        .data_to_be_wr({15'b0, ch5_data_to_be_wr}), 
        .fifo1_rd_data({15'b0, ch5_fifo1_rd_data}), .fifo2_rd_data({15'b0, ch5_fifo2_rd_data}), 
        .wr1(ch5_fifo1_wr), .wr2(ch5_fifo2_wr), .rd1(ch5_fifo1_rd), .rd2(ch5_fifo2_rd),
        .wr_fifo_num(wr_fifo_num),
        .fifo1_data_to_sw(ch5_fifo1_data_to_sw), .fifo2_data_to_sw(ch5_fifo2_data_to_sw), 
        .fifo_wr_data(ch5_fifo_wr_data));
    
    fifo_block_ctrl ch6(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .rd_command1(rd_command1), .rd_command2(rd_command2), 
        .wr(data_in_flag), .full1(fifo1_full), .full2(fifo2_full), 
        .data_to_be_wr({15'b0, ch6_data_to_be_wr}), 
        .fifo1_rd_data({15'b0, ch6_fifo1_rd_data}), .fifo2_rd_data({15'b0, ch6_fifo2_rd_data}), 
        .wr1(ch6_fifo1_wr), .wr2(ch6_fifo2_wr), .rd1(ch6_fifo1_rd), .rd2(ch6_fifo2_rd),
        .wr_fifo_num(wr_fifo_num),
        .fifo1_data_to_sw(ch6_fifo1_data_to_sw), .fifo2_data_to_sw(ch6_fifo2_data_to_sw), 
        .fifo_wr_data(ch6_fifo_wr_data));
    
    fifo_block_ctrl ch7(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .rd_command1(rd_command1), .rd_command2(rd_command2), 
        .wr(data_in_flag), .full1(fifo1_full), .full2(fifo2_full), 
        .data_to_be_wr({15'b0, ch7_data_to_be_wr}), 
        .fifo1_rd_data({15'b0, ch7_fifo1_rd_data}), .fifo2_rd_data({15'b0, ch7_fifo2_rd_data}), 
        .wr1(ch7_fifo1_wr), .wr2(ch7_fifo2_wr), .rd1(ch7_fifo1_rd), .rd2(ch7_fifo2_rd),
        .wr_fifo_num(wr_fifo_num),
        .fifo1_data_to_sw(ch7_fifo1_data_to_sw), .fifo2_data_to_sw(ch7_fifo2_data_to_sw), 
        .fifo_wr_data(ch7_fifo_wr_data));
    
    fifo_block_ctrl ch8(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .rd_command1(rd_command1), .rd_command2(rd_command2), 
        .wr(data_in_flag), .full1(fifo1_full), .full2(fifo2_full), 
        .data_to_be_wr({15'b0, ch8_data_to_be_wr}), 
        .fifo1_rd_data({15'b0, ch8_fifo1_rd_data}), .fifo2_rd_data({15'b0, ch8_fifo2_rd_data}), 
        .wr1(ch8_fifo1_wr), .wr2(ch8_fifo2_wr), .rd1(ch8_fifo1_rd), .rd2(ch8_fifo2_rd),
        .wr_fifo_num(wr_fifo_num),
        .fifo1_data_to_sw(ch8_fifo1_data_to_sw), .fifo2_data_to_sw(ch8_fifo2_data_to_sw), 
        .fifo_wr_data(ch8_fifo_wr_data));

    fifo_block_ctrl gps1(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .rd_command1(rd_command1), .rd_command2(rd_command2), 
        .wr(data_in_flag), .full1(fifo1_full), .full2(fifo2_full), 
        .data_to_be_wr(gps1_data_to_be_wr), 
        .fifo1_rd_data(gps1_fifo1_rd_data), .fifo2_rd_data(gps1_fifo2_rd_data), 
        .wr1(gps1_fifo1_wr), .wr2(gps1_fifo2_wr), .rd1(gps1_fifo1_rd), .rd2(gps1_fifo2_rd),
        .wr_fifo_num(wr_fifo_num),
        .fifo1_data_to_sw(gps1_fifo1_data_to_sw), .fifo2_data_to_sw(gps1_fifo2_data_to_sw), 
        .fifo_wr_data(gps1_fifo_wr_data));

    fifo_block_ctrl gps2(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .rd_command1(rd_command1), .rd_command2(rd_command2), 
        .wr(data_in_flag), .full1(fifo1_full), .full2(fifo2_full), 
        .data_to_be_wr(gps2_data_to_be_wr), 
        .fifo1_rd_data(gps2_fifo1_rd_data), .fifo2_rd_data(gps2_fifo2_rd_data), 
        .wr1(gps2_fifo1_wr), .wr2(gps2_fifo2_wr), .rd1(gps2_fifo1_rd), .rd2(gps2_fifo2_rd),
        .wr_fifo_num(wr_fifo_num),
        .fifo1_data_to_sw(gps2_fifo1_data_to_sw), .fifo2_data_to_sw(gps2_fifo2_data_to_sw), 
        .fifo_wr_data(gps2_fifo_wr_data));

    fifo_block_ctrl start_tri(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .rd_command1(rd_command1), .rd_command2(rd_command2), 
        .wr(data_in_flag), .full1(fifo1_full), .full2(fifo2_full), 
        .data_to_be_wr(start_tri_data_to_be_wr), 
        .fifo1_rd_data(start_tri_fifo1_rd_data), .fifo2_rd_data(start_tri_fifo2_rd_data), 
        .wr1(start_tri_fifo1_wr), .wr2(start_tri_fifo2_wr), .rd1(start_tri_fifo1_rd), .rd2(start_tri_fifo2_rd),
        .wr_fifo_num(wr_fifo_num),
        .fifo1_data_to_sw(start_tri_fifo1_data_to_sw), .fifo2_data_to_sw(start_tri_fifo2_data_to_sw), 
        .fifo_wr_data(start_tri_fifo_wr_data));

	// User logic ends

endmodule

//--has been tested.
module get_signal_posedge_module(input clk, input resetn, input signal_in, output signal_out);
    reg signal_tem1;
    reg signal_tem2;
    always@(posedge clk) begin
        if(!resetn) begin
            signal_tem1 <= 1'b0;
            signal_tem2 <= 1'b0;
        end
        else begin
            signal_tem1 <= signal_in;
            signal_tem2 <= signal_tem1;
        end
    end
    assign signal_out = signal_tem1&(~signal_tem2);
endmodule

//--has been tested.
module get_signal_negedge_module(input clk, input resetn, input signal_in, output signal_out);
    reg signal_tem1;
    reg signal_tem2;
    always@(posedge clk) begin
        if(!resetn) begin
            signal_tem1 <= 1'b0;
            signal_tem2 <= 1'b0;
        end
        else begin
            signal_tem1 <= signal_in;
            signal_tem2 <= signal_tem1;
        end
    end
    assign signal_out = signal_tem2&(~signal_tem1);
endmodule



/************************* TDC ****************************/
//--has been tested.
module fifo_rd_module(input clk, input resetn,
    input rd_command, input [31:0] data_from_fifo, output reg [31:0] data_out, output rd_out);
    
    reg data_is_ready;

    always@(posedge clk) begin
        if (!resetn)
            data_out <= 32'b0;
        else if(data_is_ready)
            data_out <= data_from_fifo;
        else
            data_out <= data_out;
    end

    get_signal_posedge_module get_rd_for_fifo(.clk(clk), .resetn(resetn), 
        .signal_in(rd_command), .signal_out(rd_out));

    //- after one clk, the data will be ready to be get.
    always@(posedge clk) begin
        if(!resetn)
            data_is_ready <= 0;
        else
            data_is_ready <= rd_out;
    end
endmodule

//--has been tested.
module fifo_wr_module(input clk, input resetn,
    input [31:0] data_to_be_wr, input wr, input full1, input full2, 
    output [31:0]data_to_fifo, output wr1, output wr2, output wr_fifo_num);

    wr_fifo_num_module get_wr_fifo_number(.clk(clk), .resetn(resetn),
        .full1_in(full1), .full2_in(full2), .fifo_num_out(wr_fifo_num));
    assign data_to_fifo = data_to_be_wr; 
    assign wr1 = (wr_fifo_num == 0)? wr: 1'b0;
    assign wr2 = (wr_fifo_num == 1)? wr: 1'b0;
endmodule

//--has been tested.
module wr_fifo_num_module(input clk, input resetn,
    input full1_in, input full2_in,
    output reg fifo_num_out);

    wire full1_posedge, full2_posedge;

    always@(posedge clk) begin
        if(!resetn)
            fifo_num_out <= 1'b0;
        else if(full1_posedge)
            fifo_num_out <= 1'b1;
        else if(full2_posedge)
            fifo_num_out <= 1'b0;
        else
            fifo_num_out <= fifo_num_out;
    end

    get_signal_posedge_module get_full1_posedge(.clk(clk), .resetn(resetn), 
        .signal_in(full1_in), .signal_out(full1_posedge));
    get_signal_posedge_module get_full2_posedge(.clk(clk), .resetn(resetn), 
        .signal_in(full2_in), .signal_out(full2_posedge));
endmodule

module fifo_block_ctrl(input clk, input resetn, 
    input rd_command1, input rd_command2, input wr, input full1, input full2, 
    input [31:0]data_to_be_wr, input [31:0] fifo1_rd_data, input [31:0] fifo2_rd_data, 
    output wr1, output wr2, output rd1, output rd2, output wr_fifo_num,
    output [31:0] fifo1_data_to_sw, output [31:0] fifo2_data_to_sw, output [31:0] fifo_wr_data);

    fifo_wr_module fifo_wr(.clk(clk), .resetn(resetn),
        .data_to_be_wr(data_to_be_wr), .wr(wr), .full1(full1), .full2(full2), 
        .data_to_fifo(fifo_wr_data), .wr1(wr1), .wr2(wr2), .wr_fifo_num(wr_fifo_num));
    fifo_rd_module fifo1_rd(.clk(clk), .resetn(resetn),
        .rd_command(rd_command1), .data_from_fifo(fifo1_rd_data),
        .data_out(fifo1_data_to_sw), .rd_out(rd1));
    fifo_rd_module fifo2_rd(.clk(clk), .resetn(resetn),
        .rd_command(rd_command2), .data_from_fifo(fifo2_rd_data),
        .data_out(fifo2_data_to_sw), .rd_out(rd2));
endmodule



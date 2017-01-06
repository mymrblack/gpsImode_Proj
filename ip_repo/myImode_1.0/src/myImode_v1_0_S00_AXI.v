`define CALCULATE_TIME_END  (time_counter == 1000)
`define MASTER_RESET_BEGIN  (time_counter >= 150_00)
`define MASTER_RESET_END (time_counter < 150_30)
`define IS_SAVE_TIME (time_counter == 1200)
`define SHOULD_STOP_DIS ((time_counter >= 1000) && !AluTrigger)

`timescale 1 ns / 1 ps

	module myImode_v1_0_S00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 7
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
		output wire [31:0] timeData_out,
        output wire fifoWrFlag,
        output reg [C_S_AXI_DATA_WIDTH-1:0] Tstart_counter,

        output wire [31:0] ch1_data,
        output wire [31:0] ch2_data,
        output wire [31:0] ch3_data,
        output wire [31:0] ch4_data,
        output wire [31:0] ch5_data,
        output wire [31:0] ch6_data,
        output wire [31:0] ch7_data,
        output wire [31:0] ch8_data,
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
	localparam integer OPT_MEM_ADDR_BITS = 4;
	//----------------------------------------------
	//-- Signals for user logic register space example
    reg [C_S_AXI_DATA_WIDTH-1:0] time_counter;//bylk
       //bylk
   
   	reg  m_StopDis1;
    reg  m_StopDis2;
    reg m_StopDis3;
    reg  m_StopDis4;
    reg m_StartDis;
    reg  m_csn;
    reg  m_wrn;
    reg  m_rdn;
    reg m_oen;
    reg[27:0]  m_data;
    wire [27:0] data_in;
    reg[3:0]   m_addr;     
    reg  m_AluTrigger;
    reg  m_Tstart;
    reg m_Tstop1;
    reg m_Tstop2;
    reg m_Tstop3;
    reg m_Tstop4;
    reg m_Tstop5;
    reg m_Tstop6;
    reg m_Tstop7;
    reg m_Tstop8;
    reg [7:0] count;//bylk
    wire stop1_set_zero;
    wire stop2_set_zero;
    wire stop3_set_zero;
    wire stop4_set_zero;
    wire stop5_set_zero;
    wire stop6_set_zero;
    wire stop7_set_zero;
    wire stop8_set_zero;

	//------------------------------------------------
	//-- Number of Slave Registers 26
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

//	always @( posedge S_AXI_ACLK )
	
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
	always@(posedge S_AXI_ACLK)
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
            end 
          else begin
            if (slv_reg_wren)
              begin
                case ( axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
                  5'h00:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 0
                        slv_reg0[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h01:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 1
                        slv_reg1[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h02:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 2
                        slv_reg2[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h03:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 3
                        slv_reg3[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h04:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 4
                        slv_reg4[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h05:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 5
                        slv_reg5[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h06:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 6
                        slv_reg6[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h07:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 7
                        slv_reg7[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h08:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 8
                        slv_reg8[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h09:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 9
                        slv_reg9[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h0A:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 10
                        slv_reg10[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h0B:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 11
                        slv_reg11[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h0C:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 12
                        slv_reg12[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h0D:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 13
                        slv_reg13[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h0E:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 14
                        slv_reg14[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h0F:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 15
                        slv_reg15[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h10:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 16
                        slv_reg16[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h11:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 17
                        slv_reg17[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h12:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 18
                        slv_reg18[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h13:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 19
                        slv_reg19[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h14:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 20
                        slv_reg20[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h15:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 21
                        slv_reg21[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h16:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 22
                        slv_reg22[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h17:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 23
                        slv_reg23[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h18:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 24
                        slv_reg24[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
                      end  
                  5'h19:
                    for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
                      if ( S_AXI_WSTRB[byte_index] == 1 ) begin
                        // Respective byte enables are asserted as per write strobes 
                        // Slave register 25
                        slv_reg25[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
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
                            end
                endcase
              end
          end    
    end
    
	always @(*)
	begin
	      // Address decoding for reading registers
	      case ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	        5'h00   : reg_data_out <= slv_reg0;
            5'h01   : reg_data_out <= time_counter;
            5'h02   : reg_data_out <= Tstart_counter;
            5'h03   : reg_data_out <= slv_reg3;
            5'h04   : reg_data_out <= data_in; // modified by lynn;
            5'h05   : reg_data_out <= EF1;
            5'h06   : reg_data_out <= EF2;
            5'h07   : reg_data_out <= ErrFlag;
            5'h08   : reg_data_out <=  IrFlag;
            5'h09   : reg_data_out <= ch1_data;
            5'h0A   : reg_data_out <= ch2_data;
            5'h0B   : reg_data_out <= ch3_data;
            5'h0C   : reg_data_out <= ch4_data;
            5'h0D   : reg_data_out <= ch5_data;
            5'h0E   : reg_data_out <= ch6_data;
            5'h0F   : reg_data_out <= ch7_data;
            5'h10   : reg_data_out <= ch8_data;
            5'h11   : reg_data_out <= slv_reg17;
            5'h12   : reg_data_out <= slv_reg18;
            5'h13   : reg_data_out <= slv_reg19;
            5'h14   : reg_data_out <= count;
	        5'h15   : reg_data_out <= slv_reg21;
	        5'h16   : reg_data_out <= slv_reg22;
	        5'h17   : reg_data_out <= slv_reg23;
	        5'h18   : reg_data_out <= slv_reg24;
	        5'h19   : reg_data_out <= slv_reg25;
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
    wire saveDataFlag;

    always@(posedge S_AXI_ACLK )
    begin
      if (!S_AXI_ARESETN) 
        begin       
          m_oen<=1;
         {m_StartDis,m_StopDis1,m_StopDis2,m_StopDis3,m_StopDis4}<=5'b0;
          m_csn<=1;
          m_wrn<=1;
          m_rdn<=1;
          m_data<=0;
          m_addr<=0;     
          m_AluTrigger<=0;
          end
      else begin
         m_oen<=1;
        {m_StartDis,m_StopDis1,m_StopDis2,m_StopDis3,m_StopDis4}<=slv_reg7;
         {m_csn, m_wrn, m_rdn, m_addr}<=slv_reg0;
         m_data<=slv_reg4;
         m_AluTrigger<=slv_reg9;
         end
     end
     
     always@(posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin
         if(S_AXI_ARESETN == 1'b0) 
             count<=8'hFF;
         else begin
             if(set_zero == 1'b1) 
                 count<=8'hFF;
             else begin
                 if(time_counter<1000)  begin  
                     if(stop1_set_zero)   count[0]<=1'b0;
                     if(stop2_set_zero)   count[1]<=1'b0;
                     if(stop3_set_zero)   count[2]<=1'b0;
                     if(stop4_set_zero)   count[3]<=1'b0;
                     if(stop5_set_zero)   count[4]<=1'b0;
                     if(stop6_set_zero)   count[5]<=1'b0;
                     if(stop7_set_zero)   count[6]<=1'b0;
                     if(stop8_set_zero)   count[7]<=1'b0;
                 end
                 else 
                     count <= count;
             end
         end
     end

     always@(posedge S_AXI_ACLK) begin
         if(S_AXI_ARESETN == 0) 
             Tstart_counter <= 32'b0;
         else begin 
             if(set_zero) begin
                 if(Tstart_counter<32'hFFFFFFFF)
                     Tstart_counter<=Tstart_counter+1;
                 else
                     Tstart_counter = Tstart_counter;
             end
             else
                 Tstart_counter = Tstart_counter;
         end
     end

     always@(posedge S_AXI_ACLK) begin
         if((S_AXI_ARESETN == 0) | set_zero | (time_counter == 2000))
             time_counter <= 32'b0;
         else
             time_counter <= time_counter + 1;
     end


    assign StopDis1= `SHOULD_STOP_DIS ? 1'b1: 1'b0;
    assign StopDis2= `SHOULD_STOP_DIS ? 1'b1: 1'b0;
    assign StopDis3= `SHOULD_STOP_DIS ? 1'b1: 1'b0;
    assign StopDis4= `SHOULD_STOP_DIS ? 1'b1: 1'b0;
    assign StartDis= `SHOULD_STOP_DIS ? 1'b1: 1'b0;

    //-- use alutrigger to reset tdc,
    //-- this function should be companied with reg5[23] == 1.
    //-- and it is better to set reg[21] == 1 to set stopDisStart.
    assign AluTrigger = (`MASTER_RESET_BEGIN && `MASTER_RESET_END)? 1'b1: 1'b0;

    assign Tstart=StartTrigger;
    assign Tstop1=StopTrigger1;
    assign Tstop2=StopTrigger2;
    assign Tstop3=StopTrigger3;
    assign Tstop4=StopTrigger4;
    assign Tstop5=StopTrigger5;
    assign Tstop6=StopTrigger6;
    assign Tstop7=StopTrigger7;
    assign Tstop8=StopTrigger8;
    //bylk
    AllocateDataToEachChannel  allocateDataToEachChannel(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .data_in(timeData_out), .setFlag(rdOverFlag_out), .saveFlag(saveDataFlag),
        .data1_out(ch1_data), .data2_out(ch2_data), .data3_out(ch3_data), .data4_out(ch4_data),
        .data5_out(ch5_data), .data6_out(ch6_data), .data7_out(ch7_data), .data8_out(ch8_data));

    TdcRegReadAndWrite tdcRegReadAndWrite(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .sfWrFlag_in(m_wrn), .sfRdFlag_in(m_rdn), .addr_in(m_addr), .sfData_in(m_data), .tdcDataReg_inout(data),
        .EF1_in(EF1), .EF2_in(EF2), 
        .sfData_out(data_in), .csn_out(csn), .wrn_out(wrn), .rdn_out(rdn), .addr_out(addr),
        .timeData_out(timeData_out), .rdOverFlag_out(rdOverFlag_out)); 

    PosEdgeGet_Sync getSaveDataFlag(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .signal_in(AluTrigger), .signal_out(saveDataFlag));

    PosEdgeGet_Sync getFifoWrFlag(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
        .signal_in(saveDataFlag), .signal_out(fifoWrFlag));

    GetSyncSignal_Async  getTstartTrigger(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), .signal_in(StartTrigger), .signal_out(set_zero)); 
    GetSyncSignal_Async  getTstopTrigger1(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), .signal_in(StopTrigger1), .signal_out(stop1_set_zero)); 
    GetSyncSignal_Async  getTstopTrigger2(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), .signal_in(StopTrigger2), .signal_out(stop2_set_zero)); 
    GetSyncSignal_Async  getTstopTrigger3(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), .signal_in(StopTrigger3), .signal_out(stop3_set_zero)); 
    GetSyncSignal_Async  getTstopTrigger4(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), .signal_in(StopTrigger4), .signal_out(stop4_set_zero)); 
    GetSyncSignal_Async  getTstopTrigger5(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), .signal_in(StopTrigger5), .signal_out(stop5_set_zero)); 
    GetSyncSignal_Async  getTstopTrigger6(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), .signal_in(StopTrigger6), .signal_out(stop6_set_zero)); 
    GetSyncSignal_Async  getTstopTrigger7(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), .signal_in(StopTrigger7), .signal_out(stop7_set_zero)); 
    GetSyncSignal_Async  getTstopTrigger8(.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), .signal_in(StopTrigger8), .signal_out(stop8_set_zero)); 

    // User logic ends

    endmodule
	

    /************************************************************************
    * call type:
    TdcRegReadAndWrite tdcRegReadAndWrite(.clk(), .resetn(), 
        .sfWrFlag_in(), .sfRdFlag_in(), .addr_in(), .sfData_in(), .tdcDataReg_inout(),
        .EF1_in(), .EF2_in(), 
        .sfData_out(), .csn_out(), .wrn_out(), .rdn_out(), .addr_out(),
        .timeData_out(), .rdOverFlag_out()); 
    *************************************************************************/
    module TdcRegReadAndWrite(input clk, input resetn, 
        input sfWrFlag_in, input sfRdFlag_in, input [3:0] addr_in, 
        input EF1_in, input EF2_in,
        input [27:0] sfData_in, inout [27:0] tdcDataReg_inout,
        output csn_out, output wrn_out, output rdn_out, output [3:0] addr_out,
        output [31:0]timeData_out, output [31:0] sfData_out, output rdOverFlag_out);
    
        wire [27:0] dataWriteOut;
        wire csn_rd, csn_wr;
        wire [3:0] rd_addr;
        wire [3:0] wr_addr;
        wire EF1_toRead, rdLockFlag, efRdFlag;
        wire [1:0] rdStep;
    
        assign tdcDataReg_inout = dataWriteOut;
        assign csn_out =  sfWrFlag_in? csn_wr: csn_rd;
        assign addr_out =  sfWrFlag_in? wr_addr: rd_addr;
    
        RdAndWrSequenceCtrl rdAndWrCtrl(.clk(clk), .resetn(resetn),
            .sfRdFlag_in(sfRdFlag_in), .sfWrFlag_in(sfWrFlag_in),
            .EF1_in(EF1_in), .EF2_in(EF2_in), 
            .rdStep_in(rdStep), .rdLockFlag_in(rdLockFlag), 
            .EF1_out(EF1_toRead), .efRdFlag_out(efRdFlag));
    
        TdcRegRead tdcRegRead(.clk(clk), .resetn(resetn), 
            .EF1_in(EF1_toRead), .efFlag_in(efRdFlag), .sfRdFlag_in(sfRdFlag_in),
            .addr_in(addr_in), .data_in(tdcDataReg_inout),//addr_in[3:0], data_in[27:0] 
            .sfRdData_out(sfData_out), .timeData_out(timeData_out),//sfRdData_out[31:0], timeData_out[27:0] 
            .lockFlag_out(rdLockFlag), .step_out(rdStep),//step_out[1:0]
            .csn_out(csn_rd), .rdn_out(rdn_out), .addr_out(rd_addr),//addr_out[3:0] 
            .rdOverFlag_out(rdOverFlag_out));
    
        TdcRegWrite    tdcRegWrite(.clk(clk), .resetn(resetn),
            .sfWrFlag_in(sfWrFlag_in), .addr_in(addr_in), .data_in(sfData_in),
            .wrData_out(dataWriteOut), .csn_out(csn_wr), 
            .wrn_out(wrn_out), .addr_out(wr_addr));
    
    endmodule
    
    
    `define IS_TIME_DATA   (addr_out == 8) | (addr_out == 9)
    `define RESET      4'b1xxx
    `define READ_STEP1 4'b0100
    `define READ_STEP2 4'b0101
    `define READ_STEP3 4'b0110
    `define READ_STEP4 4'b0111
    /************************************************************************
    * call type
    TdcRegRead tdcRegRead(.clk(), .resetn(), 
        .EF1_in(), .sfRdFlag_in(), .efFlag_in(),
        .addr_in(), .data_in(),//addr_in[3:0], data_in[27:0] 
        .sfRdData_out(), .timeData_out(),//sfRdData_out[31:0], timeData_out[27:0] 
        .csn_out(), .lockFlag_out(), .step_out(),//step_out[1:0]
        .rdn_out(), .addr_out(), .rdOverFlag_out());//addr_out[3:0]
    * Note
    * It is no need to get EF2 because EF2 can be recognized through EF1_in 
    * and efFlag_in.
    *************************************************************************/
    module TdcRegRead (input clk, input resetn, 
        input EF1_in, input efFlag_in, input sfRdFlag_in, 
        input [3:0] addr_in, input [27:0]data_in,
        output reg[31:0] sfRdData_out, output reg [31:0]timeData_out, 
        output reg csn_out, output lockFlag_out, output [1:0]step_out,
        output reg rdn_out, output reg [3:0] addr_out, output reg rdOverFlag_out);
    
        wire sfRdTrig, efTrig, lockFlag, rdTrig;
        wire [1:0] step;
    
        assign lockFlag_out = lockFlag;
        assign step_out = step;
        assign rdTrig = (sfRdTrig | efTrig)? 1'b1: 1'b0; 
     
        always@(posedge clk) begin
            casex({!resetn, lockFlag, step}) 
                `RESET: begin
                    csn_out <= 1'b1;
                    rdn_out <= 1'b1;
                    addr_out <= 4'b1111;
                    sfRdData_out <= 32'b0;
                    timeData_out <= 32'b0;
                    rdOverFlag_out <= 1'b0;
                    end
                `READ_STEP1: begin
                    if(sfRdFlag_in)
                      addr_out <= addr_in;
                    else begin
                      if(EF1_in)
                        addr_out <= 4'h8;
                      else
                        addr_out <= 4'h9;
                    end
                  end
                `READ_STEP2: begin
                    csn_out <= 1'b0;
                    rdn_out <= 1'b0;
                    end
                `READ_STEP3: begin
                    csn_out <= 1'b0;
                    rdn_out <= 1'b0;
                    end
                `READ_STEP4: begin
                    csn_out <= 1'b1;
                    rdn_out <= 1'b1;
                    if(sfRdFlag_in) 
                        sfRdData_out <= {addr_out, data_in};
                    if(`IS_TIME_DATA) begin
                        timeData_out <= {addr_out, data_in};
                        rdOverFlag_out <= 1'b1;
                    end                   
                    else begin
                        timeData_out <= timeData_out;
                    end
                    addr_out <= 4'hf;
                   end
                default : begin
                    csn_out <= csn_out;
                    rdn_out <= rdn_out;
                    addr_out <= addr_out;
                    timeData_out <= timeData_out;
                    rdOverFlag_out <= 1'b0;
                    if(sfRdFlag_in)
                        sfRdData_out <= sfRdData_out;
                    else
                        sfRdData_out <= 32'b0;
                end
            endcase
        end
    
        GetSyncSignal_Sync  getEfTrigger(.clk(clk), .resetn(resetn), 
            .signal_in(efFlag_in), .signal_out(efTrig));
    
        GetSyncSignal_Sync  getsfRdTrigger(.clk(clk), .resetn(resetn), 
            .signal_in(sfRdFlag_in), .signal_out(sfRdTrig));
    
        TimingStepGenerator    getTimingStep(.clk(clk), .resetn(resetn), 
            .trigger(rdTrig), .step_out(step));
    
        TimingFlagGenerator getTimingFlag(.clk(clk), .resetn(resetn), 
            .trigger(rdTrig), .step(step), .flag_out(lockFlag));
    
    endmodule
    
    
    
    module TimingStepGenerator(input clk, input resetn, input trigger, output reg [1:0] step_out);
        always@(posedge clk)
            if(!resetn| trigger| (step_out == 2'b11)) 
                step_out <= 2'b00;
            else
                step_out <= step_out + 1;
    endmodule
        
    module TimingFlagGenerator(input clk, input resetn, input trigger, input [1:0] step, output reg flag_out);
    
        always@(posedge clk) begin
            if(!resetn)
                flag_out <= 1'b0;
            else if(trigger == 1'b1)
                    flag_out <= 1'b1;
                else if (step == 2'b11)
                        flag_out <= 1'b0;
                     else
                        flag_out <= flag_out;
        end
    
    endmodule
    
    
    module GetSyncSignal_Sync(input clk, input resetn, input signal_in, output signal_out);
    
        reg signal_temp1;
        always@(posedge clk) begin
            if(!resetn) 
                signal_temp1 <= 1'b0;
            else 
                signal_temp1 <= signal_in;
        end
    
        assign signal_out = signal_in &(~signal_temp1);
    
    endmodule
    
    module GetSyncSignal_Async(input clk, input resetn, input signal_in, output signal_out);
    
        reg signal_temp1;
        reg signal_temp2;
        reg signal_temp3;
    
        always@(posedge clk) begin
            if(!resetn) begin
                signal_temp1 <=0;
                signal_temp2 <=0;
                signal_temp3 <=0;
            end
            else begin
                signal_temp1 <= signal_in;
                signal_temp2 <= signal_temp1;
                signal_temp3 <= signal_temp2;
            end
        end
    
        assign signal_out = signal_temp2 &(~signal_temp3);
    endmodule
    
    `define WRITE_STEP1 4'b0100
    `define WRITE_STEP2 4'b0101
    `define WRITE_STEP3 4'b0110
    `define WRITE_STEP4 4'b0111
    `define HIGH_Z        28'hzzzz
    
    module TdcRegWrite (input clk, input resetn, input sfWrFlag_in, input [3:0] addr_in, input [27:0]data_in,
                    output [27:0] wrData_out, output reg csn_out, output reg wrn_out, output reg [3:0] addr_out);
    
        reg [27:0] data_out;
        wire [1:0] step;
           wire wrFlag;
        wire wrTrig;
    
        always@(posedge clk) begin
            casex({!resetn, wrFlag, step}) 
                      `RESET: begin
                    csn_out <= 1'b1;
                    wrn_out <= 1'b1;
                    addr_out <= 4'b1111;
                    data_out <= 28'b0;
                    end
                `WRITE_STEP1: begin
                    addr_out <= addr_in;
                    data_out <= data_in;
                    end
                `WRITE_STEP2: begin
                    csn_out <= 1'b0;
                    wrn_out <= 1'b0;
                    end
                `WRITE_STEP3: begin
                    csn_out <= 1'b1;
                    wrn_out <= 1'b1;
                    end
                `WRITE_STEP4: data_out <= 28'b0;
                default : begin
                    csn_out <= csn_out;
                    wrn_out <= wrn_out;
                    addr_out <= addr_out;
                    data_out <= data_in;
                    end
            endcase
        end
    
        assign wrData_out = wrFlag? data_out:`HIGH_Z;//TDC data reg is a inout pin, so if write is no use, keep it in high_z
    
        GetSyncSignal_Sync  getWrTrigger(.clk(clk), .resetn(resetn), .signal_in(sfWrFlag_in), .signal_out(wrTrig));
         TimingStepGenerator    getTimingStep(.clk(clk), .resetn(resetn), .trigger(wrTrig), .step_out(step));
        TimingFlagGenerator getTimingFlag(.clk(clk), .resetn(resetn), .trigger(wrTrig), .step(step), .flag_out(wrFlag));
       
      
    endmodule
    
    
    /************************************************************************
    * call type
    RdAndWrSequenceCtrl ctrlModule(.clk(), .resetn(),
        .sfRdFlag_in(), .sfWrFlag_in(),
        .EF1_in(), .EF1_in(), .rdStep_in(), .rdLockFlag(), 
        .EF1_out(), .efRdFlag_out());
    * Note
    * It is no need to output EF2 because EF2 can be recognized through EF1_in 
    * and efFlag_in.
    *************************************************************************/
    `define IS_IN_READ_STEP4  rdLockFlag_in& (rdStep_in == 2'b11) 
    module RdAndWrSequenceCtrl(input clk, input resetn,
        input sfRdFlag_in, input sfWrFlag_in,
        input EF1_in, input EF2_in,  input [1:0] rdStep_in, input rdLockFlag_in, 
        output reg EF1_out, output reg efRdFlag_out);
    
        reg EF2;
        
        /*********************************************************
        * Handle with the EF1_out and EF2 signal.
        * It get these two signal in one time, after read the FIFO1(FIFO2)data,
        * the EF1_out(EF2) should be reset. 
        * The sfRdFlag has the highest priority, so when it come, 
        * EF1_out and EF2 will be ignored. 
        * The handle in (`IS_IN_READ_STEP4) is because
        * the EF1_out and EF2 should be read sequencely(when EF1_out and EF2 were both set) ,
        * so the data in both two fifo can't be lost.This is 
        * very important so it should be handled like this.
        * *********************************************************/   
        always@(posedge clk) begin
            if(!resetn | sfRdFlag_in | sfWrFlag_in) begin
                EF1_out <= 1'b0;
                EF2 <= 1'b0;
            end
            else begin
                if(!rdLockFlag_in & !EF1_out & !EF2) begin
                    EF1_out <= EF1_in;
                    EF2 <= EF2_in;
                end
                else begin
                    if(`IS_IN_READ_STEP4) begin
                        if(EF1_out) 
                            EF1_out <= 1'b0;
                        else 
                            EF2 <= 1'b0;
                    end
                    else begin
                        EF1_out <= EF1_out;
                        EF2 <= EF2;     
                    end           
                end
            end
        end 
        /************************ END ***************************/
    
        /*********************************************************
        * Get the efRdFlag_out to trigger the Read timing sequence.
        * The handle in (`IS_IN_READ_STEP4& EF1_out& EF2) is because
        * the EF1_out and EF2 should be read sequencely(when EF1_out and EF2 were both set) ,
        * so the data in both two fifo can't be lost.
        * *********************************************************/
        always@(posedge clk)begin
           if(!resetn)
               efRdFlag_out <= 1'b0;
           else begin
               if(!rdLockFlag_in)begin
                   efRdFlag_out <= (EF1_out|EF2);
               end
               else begin
                   if(`IS_IN_READ_STEP4& EF1_out& EF2)
                       efRdFlag_out <= 1'b1;
                   else
                       efRdFlag_out <= 0;
               end
           end
       end
        /************************ END ***************************/
    
       assign rdFlag_out = sfRdFlag_in;
       assign wrFlag_out = sfWrFlag_in;
    
    endmodule

/********************************************************************************
* call type:
AllocateDataToEachChannel  allocateDataToEachChannel(.clk(), .resetn(), 
        .data_in(), .setFlag(), .saveFlag(),
        .data1_out(), .data2_out(), .data3_out(), .data4_out(),
        .data5_out(), .data6_out(), .data7_out(), .data8_out());
*********************************************************************************/
`define TDC_CHANNEL_BIT    27:26
`define TDC_DATA_WIDTH    32
module AllocateDataToEachChannelAndSaveIt(input clk, input resetn,  
    input [31:0] data_in, input setFlag, input saveFlag,
    output reg [`TDC_DATA_WIDTH-1:0]data1_out, output reg [`TDC_DATA_WIDTH-1:0]data2_out, 
    output reg [`TDC_DATA_WIDTH-1:0]data3_out, output reg [`TDC_DATA_WIDTH-1:0] data4_out,
    output reg [`TDC_DATA_WIDTH-1:0]data5_out, output reg [`TDC_DATA_WIDTH-1:0]data6_out, 
    output reg [`TDC_DATA_WIDTH-1:0]data7_out, output reg [`TDC_DATA_WIDTH-1:0] data8_out);

    wire [2:0]offset;
    wire clearFlag;
    reg [`TDC_DATA_WIDTH-1:0] data1_temp;
    reg [`TDC_DATA_WIDTH-1:0] data2_temp;
    reg [`TDC_DATA_WIDTH-1:0] data3_temp;
    reg [`TDC_DATA_WIDTH-1:0] data4_temp;
    reg [`TDC_DATA_WIDTH-1:0] data5_temp;
    reg [`TDC_DATA_WIDTH-1:0] data6_temp;
    reg [`TDC_DATA_WIDTH-1:0] data7_temp;
    reg [`TDC_DATA_WIDTH-1:0] data8_temp;

    assign offset = (data_in[31:28] == 8)? data_in[`TDC_CHANNEL_BIT]: data_in[`TDC_CHANNEL_BIT]+4;

    always@(posedge clk) begin
        if(!resetn | clearFlag) begin
            data1_temp <= `TDC_DATA_WIDTH'b0;
            data2_temp <= `TDC_DATA_WIDTH'b0;
            data3_temp <= `TDC_DATA_WIDTH'b0;
            data4_temp <= `TDC_DATA_WIDTH'b0;
            data5_temp <= `TDC_DATA_WIDTH'b0;
            data6_temp <= `TDC_DATA_WIDTH'b0;
            data7_temp <= `TDC_DATA_WIDTH'b0;
            data8_temp <= `TDC_DATA_WIDTH'b0;
        end
        else begin
            if(setFlag) begin
                case(offset)
                    0: data1_temp <= data_in[`TDC_DATA_WIDTH-1:0];
                    1: data2_temp <= data_in[`TDC_DATA_WIDTH-1:0];
                    2: data3_temp <= data_in[`TDC_DATA_WIDTH-1:0];
                    3: data4_temp <= data_in[`TDC_DATA_WIDTH-1:0];
                    4: data5_temp <= data_in[`TDC_DATA_WIDTH-1:0];
                    5: data6_temp <= data_in[`TDC_DATA_WIDTH-1:0];
                    6: data7_temp <= data_in[`TDC_DATA_WIDTH-1:0];
                    7: data8_temp <= data_in[`TDC_DATA_WIDTH-1:0];
                endcase
            end
            else begin
                data1_temp <= data1_temp;
                data2_temp <= data2_temp;
                data3_temp <= data3_temp;
                data4_temp <= data4_temp;
                data5_temp <= data5_temp;
                data6_temp <= data6_temp;
                data7_temp <= data7_temp;
                data8_temp <= data8_temp;
            end
        end
    end

    always@(posedge clk) begin
        if(!resetn) begin
            data1_out <= `TDC_DATA_WIDTH'b0;
            data2_out <= `TDC_DATA_WIDTH'b0;
            data3_out <= `TDC_DATA_WIDTH'b0;
            data4_out <= `TDC_DATA_WIDTH'b0;
            data5_out <= `TDC_DATA_WIDTH'b0;
            data6_out <= `TDC_DATA_WIDTH'b0;
            data7_out <= `TDC_DATA_WIDTH'b0;
            data8_out <= `TDC_DATA_WIDTH'b0;
        end
        else begin
            if(saveFlag) begin
                data1_out <= data1_temp;
                data2_out <= data2_temp;
                data3_out <= data3_temp;
                data4_out <= data4_temp;
                data5_out <= data5_temp;
                data6_out <= data6_temp;
                data7_out <= data7_temp;
                data8_out <= data8_temp;
            end
            else begin
                data1_out <= data1_out;
                data2_out <= data2_out;
                data3_out <= data3_out;
                data4_out <= data4_out;
                data5_out <= data5_out;
                data6_out <= data6_out;
                data7_out <= data7_out;
                data8_out <= data8_out;
            end
        end
    end

    NegEdgeGet_Sync negGet(.clk(clk), .resetn(resetn), 
        .signal_in(saveFlag), .signal_out(clearFlag));
endmodule


/********************************************************************************
* call type:
PosEdgeGet_Sync posGet(.clk(), .resetn(), .signal_in(), .signal_out());
*********************************************************************************/
module PosEdgeGet_Sync(input clk, input resetn, input signal_in, output signal_out);

    reg signal_tem1;

    always@(posedge clk) begin
        if(!resetn)
            signal_tem1 <= 1'b0;
        else
            signal_tem1 <= signal_in;
    end
    assign signal_out = signal_in&(~signal_tem1);

endmodule

/********************************************************************************
* call type:
NegEdgeGet_Sync negGet(.clk(), .resetn(), .signal_in(), .signal_out());
*********************************************************************************/
module NegEdgeGet_Sync(input clk, input resetn, input signal_in, output signal_out);

    reg signal_tem1;

    always@(posedge clk) begin
        if(!resetn)
            signal_tem1 <= 1'b0;
        else
            signal_tem1 <= signal_in;
    end
    assign signal_out = (~signal_in)&signal_tem1;

endmodule

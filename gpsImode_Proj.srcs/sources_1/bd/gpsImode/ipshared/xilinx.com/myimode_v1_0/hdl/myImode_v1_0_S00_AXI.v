
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
//	reg [C_S_AXI_DATA_WIDTH-1:0] flag_Tstart;
    reg [C_S_AXI_DATA_WIDTH-1:0] time_counter;//bylk
    reg [C_S_AXI_DATA_WIDTH-1:0] Tstart_counter;
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
            5'h04   : reg_data_out <=data_in; // modified by lynn;
            5'h05   : reg_data_out <= EF1;
            5'h06   : reg_data_out <= EF2;
            5'h07   : reg_data_out <= slv_reg7;
            5'h08   : reg_data_out <=  IrFlag;
            5'h09   : reg_data_out <= slv_reg9;
            5'h0A   : reg_data_out <= slv_reg10;
            5'h0B   : reg_data_out <= slv_reg11;
            5'h0C   : reg_data_out <= ErrFlag;
            5'h0D   : reg_data_out <= slv_reg13;
            5'h0E   : reg_data_out <= slv_reg14;
            5'h0F   : reg_data_out <= slv_reg15;
            5'h10   : reg_data_out <= slv_reg16;
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
    always@(posedge S_AXI_ACLK or negedge S_AXI_ARESETN )
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
      if(S_AXI_ARESETN == 1'b0) begin
        time_counter<=0;
        count<=8'hFF;
        Tstart_counter<=0;
      end
      else begin
       if(set_zero == 1'b1) begin
          time_counter<=0;
          count<=8'hFF;
       if(Tstart_counter<32'hFFFFFFFF)
          Tstart_counter<=Tstart_counter+1;
       end
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
           time_counter<=time_counter+1;
          end
        end
      end
    end 
    
 
          assign StopDis1=m_StopDis1;
          assign StopDis2=m_StopDis2;
          assign StopDis3=m_StopDis3;
          assign StopDis4=m_StopDis4;
          assign StartDis=m_StartDis;
          
          assign AluTrigger=m_AluTrigger;
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
                     
   TdcRegReadAndWrite shouldCompleteTdcTimingSequenceforRegReadAndWrite (.clk(S_AXI_ACLK), .resetn(S_AXI_ARESETN), 
	   .wr_in(m_wrn), .rd_in(m_rdn), .addr_in(m_addr), .dataFromSoftware(m_data), .tdcDataReg(data),
	   .dataForSoftware(data_in), .csn_out(csn), .rdn_out(rdn), 
	   .wrn_out(wrn), .addr_out(addr));
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
	


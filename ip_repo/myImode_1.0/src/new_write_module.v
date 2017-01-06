/*`define RESET      4'b0xxx
`define READ_STEP1 4'b1100
`define READ_STEP2 4'b1101
`define READ_STEP3 4'b1110
`define READ_STEP4 4'b1111

`define WRITE_STEP1 4'b1100
`define WRITE_STEP2 4'b1101
`define WRITE_STEP3 4'b1110
`define WRITE_STEP4 4'b1111
`define HIGH_Z		28'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz
module TdcRegReadAndWrite(clk, resetn, 
                wr_in, rd_in, addr_in, dataFromSoftware, tdcDataReg,
                dataForSoftware, csn_out, wrn_out, rdn_out, addr_out);
	input clk, resetn, wr_in, rd_in;
	input [3:0] addr_in;
	input [27:0] dataFromSoftware;

	output [27:0] dataForSoftware;
	output csn_out, wrn_out, rdn_out;
	output [3:0] addr_out;

	inout [27:0] tdcDataReg;

	wire [27:0] dataReadOut;
	wire [27:0] dataWriteOut;

	wire [27:0] dataInChoose;
	wire [1:0]highIsWrLowIsRd;
	wire csn_rd, csn_wr;
	wire [3:0] rd_addr;
	wire [3:0] wr_addr;

	assign dataForSoftware = dataReadOut;
	assign tdcDataReg = dataWriteOut;
	assign csn_out =  wr_in? csn_wr: csn_rd;
	assign addr_out =  wr_in? wr_addr: rd_addr;



	TdcRegWrite	tdcRegWrite(.clk(clk), .resetn(resetn),
                .wr_in(wr_in), .addr_in(addr_in), .data_in(dataFromSoftware),
                .write_data_out(dataWriteOut), .csn_out(csn_wr), .wrn_out(wrn_out), .addr_out(wr_addr));
	TdcRegRead tdcRegRead(.clk(clk), .resetn(resetn),
                .rd_in(rd_in), .addr_in(addr_in), .data_in(tdcDataReg),
                .data_out(dataReadOut), .csn_out(csn_rd), .rdn_out(rdn_out), .addr_out(rd_addr));

endmodule

module TdcRegWrite (input clk, input resetn, input wr_in, input [3:0] addr_in, input [27:0]data_in,
                output [27:0] write_data_out, output reg csn_out, output reg wrn_out, output reg [3:0] addr_out);

    reg [27:0] data_out;
    wire [1:0] step;
   	wire wr_flag;
    wire wr_trigger;

    always@(posedge clk) begin
        casex({resetn, wr_flag, step}) 
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

	assign write_data_out = wr_flag? data_out:`HIGH_Z;//TDC data reg is a inout pin, so if write is no use, keep it in high_z

	GetSyncSignal_Sync  getWrTrigger(.clk(clk), .resetn(resetn), .signal_in(wr_in), .signal_out(wr_trigger));
 	TimingStepGenerator	getTimingStep(.clk(clk), .resetn(resetn), .trigger(wr_trigger), .step_out(step));
	TimingFlagGenerator getTimingFlag(.clk(clk), .resetn(resetn), .trigger(wr_trigger), .step(step), .flag_out(wr_flag));
   
  
endmodule

module TdcRegRead (input clk, input resetn, input rd_in, input [3:0] addr_in, input [27:0]data_in,
                output reg [27:0] data_out, output reg csn_out, output reg rdn_out, output reg [3:0] addr_out);

    wire [1:0] step;
	wire rd_trigger;
    wire rd_flag;
	
    always@(posedge clk) begin
        casex({resetn, rd_flag, step}) 
            `RESET: begin
                csn_out <= 1'b1;
                rdn_out <= 1'b1;
                addr_out <= 4'b1111;
                data_out <= 28'b0;
                end
            `READ_STEP1: addr_out <= addr_in;
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
                data_out <= data_in;
                end
            default : begin
                csn_out <= csn_out;
                rdn_out <= rdn_out;
                addr_out <= addr_out;
				if(rd_in)
					data_out <= data_out;
				else
					data_out <= 28'b0;
                end
        endcase
    end

	GetSyncSignal_Sync  getRdTrigger(.clk(clk), .resetn(resetn), .signal_in(rd_in), .signal_out(rd_trigger));

	TimingStepGenerator	getTimingStep(.clk(clk), .resetn(resetn), .trigger(rd_trigger), .step_out(step));

	TimingFlagGenerator getTimingFlag(.clk(clk), .resetn(resetn), .trigger(rd_trigger), .step(step), .flag_out(rd_flag));

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
*/
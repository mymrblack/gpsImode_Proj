
`define YEAR_WIDTH	12
`define MONTH_WIDTH	4
`define DAY_WIDTH	5
`define HOUR_WIDTH	5
`define MINUTE_WIDTH	6
`define SECOND_WIDTH	6
`define MILLISEC_WIDTH	10
`define MICROSEC_WIDTH	10


module GpsConnectToImode(clk, resetn, trigger,
						yearData, monthData, dayData, hourData, minuteData, secondData, microsecData, millisecData,
						year_out, month_out, day_out, hour_out, minute_out, second_out, microsec_out, millisec_out);
						

	input clk;
	input resetn;
	input trigger;
	input [`YEAR_WIDTH-1:0]	yearData;
	input [`MONTH_WIDTH-1:0]  monthData;
	input [`DAY_WIDTH-1:0]	dayData;
	input [`HOUR_WIDTH-1:0]  hourData;
	input [`MINUTE_WIDTH-1:0]  minuteData;
	input [`SECOND_WIDTH-1:0]  secondData;
	input [`MILLISEC_WIDTH-1:0]  microsecData;
	input [`MICROSEC_WIDTH-1:0]  millisecData;

	output reg [`YEAR_WIDTH-1:0]  year_out;
	output reg [`MONTH_WIDTH-1:0]  month_out;
	output reg [`DAY_WIDTH-1:0]  day_out;
	output reg [`HOUR_WIDTH-1:0]  hour_out;
	output reg [`MINUTE_WIDTH-1:0]  minute_out;
	output reg [`SECOND_WIDTH-1:0]  second_out;
	output reg [`MILLISEC_WIDTH-1:0]  microsec_out;
	output reg [`MICROSEC_WIDTH-1:0]  millisec_out;

	always@(posedge clk) begin
		if(!resetn) begin
			year_out <= `YEAR_WIDTH'b0;
            month_out <= `MONTH_WIDTH'b0;
            day_out <= `DAY_WIDTH'b0;
            hour_out <= `HOUR_WIDTH'b0;
            minute_out <= `MINUTE_WIDTH'b0;
            second_out <= `SECOND_WIDTH'b0;
            microsec_out <= `MILLISEC_WIDTH'b0;
            millisec_out <= `MICROSEC_WIDTH'b0;
		end
		else begin
		if(trigger == 1'b1)begin
				year_out <= yearData;
				month_out <= monthData;
				day_out <= dayData;
				hour_out <= hourData;
				minute_out <= minuteData;
				second_out <= secondData;
				microsec_out <= microsecData;
				millisec_out <= millisecData;
			end 
			else begin
				year_out <= year_out;
				month_out <= month_out;
				day_out <= day_out;
 				hour_out <= hour_out;
 				minute_out <= minute_out;
	 			second_out <= second_out;
	 			microsec_out <= microsec_out;
	 			millisec_out <= millisec_out;
 			end
		end
	end

endmodule



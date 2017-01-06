
`define TDC_REG_WIDTH  28
`define TDC_DATA_WIDTH  28
/********************************************************************************
* call type:
TdcDataSetter tdcDataSetter(.clk(), .resetn(), 
    .saveFlag_in(), .tdcTimeData_in(), .setFlag(), 
    .dataCanBeReadFlag(),
    .data1_group1_out(), .data2_group1_out(),
    .data3_group1_out(), .data4_group1_out(),
    .data5_group1_out(), .data6_group1_out(),
    .data7_group1_out(), .data8_group1_out(),

    .data1_group2_out(), .data2_group2_out(),
    .data3_group2_out(), .data4_group2_out(),
    .data5_group2_out(), .data6_group2_out(),
    .data7_group2_out(), .data8_group2_out(),
    
    .data1_group3_out(), .data2_group3_out(),
    .data3_group3_out(), .data4_group3_out(),
    .data5_group3_out(), .data6_group3_out(),
    .data7_group3_out(), .data8_group3_out(),

    .data1_group4_out(), .data2_group4_out(),
    .data3_group4_out(), .data4_group4_out(),
    .data5_group4_out(), .data6_group4_out(),
    .data7_group4_out(), .data8_group4_out(),

    .data1_group5_out(), .data2_group5_out(),
    .data3_group5_out(), .data4_group5_out(),
    .data5_group5_out(), .data6_group5_out(),
    .data7_group5_out(), .data8_group5_out());
*********************************************************************************/
`define TDC_DATA_SETTER_STEP    3
`define TDC_DATA_SETTER_STEP_WIDTH 3
module TdcDataSetter(input clk, input resetn, 
    input saveFlag_in, input [31:0] tdcTimeData_in, input setFlag, 
    output reg dataCanBeReadFlag,
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
    output [31:0] data7_group5_out, output [31:0] data8_group5_out);

    wire [`TDC_DATA_SETTER_STEP_WIDTH:0] step;
    wire saveFlag;

    wire setFlag1;
    wire setFlag2;
    wire setFlag3;
    wire setFlag4;
    wire setFlag5;

   assign setFlag1 = ((step == 0) & setFlag)? 1'b1: 1'b0;
   assign setFlag2 = ((step == 1) & setFlag)? 1'b1: 1'b0;
   assign setFlag3 = ((step == 2) & setFlag)? 1'b1: 1'b0;
   assign setFlag4 = ((step == 3) & setFlag)? 1'b1: 1'b0;
   assign setFlag5 = ((step == 4) & setFlag)? 1'b1: 1'b0;

   AllocateDataToEachChannelAndSaveIt allocate1 (.clk(clk), .resetn(resetn), 
       .saveFlag(saveFlag), .data_in(tdcTimeData_in), 
       .setFlag(setFlag1),
       .data1_out(data1_group1_out), .data2_out(data2_group1_out), 
       .data3_out(data3_group1_out), .data4_out(data4_group1_out),
       .data5_out(data5_group1_out), .data6_out(data6_group1_out), 
       .data7_out(data7_group1_out), .data8_out(data8_group1_out));

   AllocateDataToEachChannelAndSaveIt allocate2 (.clk(clk), .resetn(resetn), 
       .saveFlag(saveFlag), .data_in(tdcTimeData_in), 
       .setFlag(setFlag2),
       .data1_out(data1_group2_out), .data2_out(data2_group2_out), 
       .data3_out(data3_group2_out), .data4_out(data4_group2_out),
       .data5_out(data5_group2_out), .data6_out(data6_group2_out), 
       .data7_out(data7_group2_out), .data8_out(data8_group2_out));

   AllocateDataToEachChannelAndSaveIt allocate3 (.clk(clk), .resetn(resetn), 
       .saveFlag(saveFlag), .data_in(tdcTimeData_in), 
       .setFlag(setFlag3),
       .data1_out(data1_group3_out), .data2_out(data2_group3_out), 
       .data3_out(data3_group3_out), .data4_out(data4_group3_out),
       .data5_out(data5_group3_out), .data6_out(data6_group3_out), 
       .data7_out(data7_group3_out), .data8_out(data8_group3_out));

   AllocateDataToEachChannelAndSaveIt allocate4 (.clk(clk), .resetn(resetn), 
       .saveFlag(saveFlag), .data_in(tdcTimeData_in), 
       .setFlag(setFlag4),
       .data1_out(data1_group4_out), .data2_out(data2_group4_out), 
       .data3_out(data3_group4_out), .data4_out(data4_group4_out),
       .data5_out(data5_group4_out), .data6_out(data6_group4_out), 
       .data7_out(data7_group4_out), .data8_out(data8_group4_out));

   AllocateDataToEachChannelAndSaveIt allocate5 (.clk(clk), .resetn(resetn), 
       .saveFlag(saveFlag), .data_in(tdcTimeData_in), 
       .setFlag(setFlag5),
       .data1_out(data1_group5_out), .data2_out(data2_group5_out), 
       .data3_out(data3_group5_out), .data4_out(data4_group5_out),
       .data5_out(data5_group5_out), .data6_out(data6_group5_out), 
       .data7_out(data7_group5_out), .data8_out(data8_group5_out));
    /************************************************************
    * After saveFlag be set, it means all 5 parts data have been saved.
    * Then dataCanBeReadFlag be set to tell the program all datas can be read. 
    *************************************************************/
    always@(posedge clk) begin
        if(!resetn)
            dataCanBeReadFlag <= 1'b0;
        else
            dataCanBeReadFlag <= saveFlag;
    end

   StepGenerator tdcStepGet(.clk(clk), .resetn(resetn), .trigger(saveFlag_in),
       .step_num(`TDC_DATA_SETTER_STEP-1), .step_out(step), .stepOver_out(saveFlag)); 

endmodule

/********************************************************************************
* call type:
AllocateDataToEachChannel  allocateDataToEachChannel(.clk(), .resetn(), 
        .data_in(), .setFlag(),
        .data1_out(), .data2_out(), .data3_out(), .data4_out(),
        .data5_out(), .data6_out(), .data7_out(), .data8_out());
*********************************************************************************/
`define TDC_CHANNEL_BIT    27:26
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
StepGenerator tdcStepGet(.clk(), .resetn(), .trigger(),
       .step_num(), .step_out(), .stepOver_out()); 
*********************************************************************************/
module StepGenerator(input clk, input resetn, input trigger, 
    input [`TDC_DATA_SETTER_STEP_WIDTH-1:0]step_num, 
    output reg [`TDC_DATA_SETTER_STEP_WIDTH-1:0] step_out, output stepOver_out);

    wire lastStep;

    always@(posedge clk) begin
        if(!resetn)
            step_out <= `TDC_DATA_SETTER_STEP_WIDTH'b0;
        else begin
            if(trigger) begin
                if(step_out == step_num)
                    step_out <= `TDC_DATA_SETTER_STEP_WIDTH'b0;
                else
                    step_out <= step_out + 1;
            end
            else 
                step_out <= step_out;
        end
    end
    
    assign lastStep = (step_out == step_num)?1'b1:1'b0;
    
    NegEdgeGet_Sync negGet(.clk(clk), .resetn(resetn), 
        .signal_in(lastStep), .signal_out(stepOver_out));

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

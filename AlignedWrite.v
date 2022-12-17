`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Module Name: AlignedWrite
// Project Name: Single Cycle Processor 
//////////////////////////////////////////////////////////////////////////////////


module AlignedWrite(
    input [31:0] datain,
    input sb,shw,sw,
    output [31:0] dataout 
    );
    wire V,U;
    wire [1:0] T;
    assign V = (shw | sw)?1'b1:1'b0;
    assign U = sw?1'b1:1'b0;
    assign T = sw?2'b10:(shw?2'b01:2'b00);
    
    assign dataout[7:0] = datain[7:0];
    assign dataout[15:8] = V?datain[15:8]:datain[7:0];
    assign dataout[23:16] = U?datain[23:16]:datain[7:0];
    assign dataout[31:24] = (T==2'b10)?datain[31:24]:((T==2'b01)?datain[15:8]:datain[7:0]);
endmodule

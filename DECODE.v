`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: DECODE
// Project Name: Single Cycle RISC Processor
//////////////////////////////////////////////////////////////////////////////////


module DECODE(
    input clk,
    input wen,
    input [4:0] rd,rs1,rs2,
    input [31:0] din,
    output [31:0] sdout1,sdout2
    );
    
    reg [31:0] regfile [0:31];
    always @(posedge clk)
    begin
        regfile[5'd0] <= 32'd0;
        if(wen)
            regfile[rd] <= rd?din:32'd0;
    end
    assign sdout1 = regfile[rs1];
    assign sdout2 = regfile[rs2];
endmodule

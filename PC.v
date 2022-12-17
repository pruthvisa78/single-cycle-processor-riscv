`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: PC
// Project Name: Single Cycle Processor
//////////////////////////////////////////////////////////////////////////////////

module PC(
    input clk,
    input [31:0] Immediate,
    input rst,
    input PCsrc,
    output reg [31:0] PCcurrent
    );
    wire [31:0] PCtemp;
    always @(posedge clk)
    begin
        if(rst)
            PCcurrent <= 32'd0;
        else
            PCcurrent <= PCtemp;
    end
    
    assign PCtemp = PCsrc?(PCcurrent+(Immediate<<1)):(PCcurrent + 32'd4);
endmodule

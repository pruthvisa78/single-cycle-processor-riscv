`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: ImGen
// Project Name: Single Cycle Processor
//////////////////////////////////////////////////////////////////////////////////

module ImmGen(
    input [16:0] ImmIN,
    input [1:0] immsel,
    output reg [31:0] Immediate
    );
    
    always @(*)
        case(immsel)
/*Imm & load*/2'b00: Immediate = {{20{ImmIN[16]}},ImmIN[16:5]};
/*Store*/     2'b01: Immediate = {{20{ImmIN[16]}},ImmIN[16:10],ImmIN[4:0]};
/* Branch*/   2'b10: Immediate = {{20{ImmIN[16]}},ImmIN[16],ImmIN[0],ImmIN[15:10],ImmIN[4:1]};
              default: Immediate = 32'd0;
        endcase
endmodule
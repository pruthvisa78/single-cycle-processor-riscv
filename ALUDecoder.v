`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: ALUDecoder
// Project Name: Single Cycle Processor
//////////////////////////////////////////////////////////////////////////////////


module ALUDecoder(
    input [1:0] ALUop,
    input [2:0] func3,
    input [6:0] func7,
    output reg [3:0] ALUctrl
    );
    
    always @(*)
        case(ALUop)
            2'b00: ALUctrl = 4'b0010;
            2'b01: ALUctrl = 4'b0110;
            2'b10: case(func3)
                    3'b000: ALUctrl = func7[5]?4'b0110:4'b0010;
                    3'b111: ALUctrl = 4'b0000;
                    3'b110: ALUctrl = 4'b0001;
                    3'b100: ALUctrl = 4'b0011;
                    default: ALUctrl = 4'b0010;
                   endcase
           2'b11: case(func3)
                    3'b000: ALUctrl = 4'b0010;
                    3'b110: ALUctrl = 4'b0001;
                    3'b111: ALUctrl = 4'b0000;
                    3'b100: ALUctrl = 4'b0011;
                    default: ALUctrl = 4'b0010;
                  endcase
        endcase
endmodule

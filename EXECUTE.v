`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Module Name: EXECUTE
// Project Name: Single Cycle Processor
//////////////////////////////////////////////////////////////////////////////////

module EXECUTE(
    input [31:0] A,B,Immediate,PCpresent,
    input [19:0] UPI,
    input [2:0] func3,
    output reg [31:0] ALUResult,
    input [1:0] ALUSrcB,
    input ALUsrcA,
    input [3:0] ALUCtrl,
    output reg zero
    );
    reg [31:0] Bmux;
    wire beq,bne,bl,bge;
    wire [31:0] Amux;
    
    always @(*)
        case(ALUSrcB)
            2'b00: Bmux = B;
            2'b01: Bmux = Immediate;
            2'b10: Bmux = {UPI,12'd0};
            default: Bmux = B;
        endcase
     
     assign Amux = ALUsrcA?PCpresent:A;   
        
    always @(*)
    case(ALUCtrl)
        4'b0010: ALUResult = Amux + Bmux;
        4'b0110: ALUResult = Amux - Bmux;
        4'b0000: ALUResult = Amux & Bmux;
        4'b0001: ALUResult = Amux | Bmux;
        4'b0011: ALUResult = Amux^Bmux;
        default: ALUResult = Amux + Bmux;
    endcase
    assign beq = ~(|ALUResult);
    assign bne = |ALUResult;
    assign bl = ALUResult[31];
    assign bge = ~ALUResult[31];
    
    always @(*)
        case(func3)
            3'b000: zero = beq;
            3'b001: zero = bne;
            3'b100: zero = bl;
            3'b101: zero = bge;
            default: zero = 1'b0;
        endcase
endmodule

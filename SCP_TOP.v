`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: SCP_TOP
// Project Name: Single Cycle Processor
//////////////////////////////////////////////////////////////////////////////////

module SCP_TOP(
    input clk,memsel,rst,
    input [11:0] addrcheck,
    output [11:0] datacheck
    );
    wire [31:0] Instr,A,B;
    wire [31:0] PCcurrent;
    wire rwen,sb,sh,sw,lb,lh,lw,ALUsrcA;
    wire [1:0] ALUsrcB,memreg;
    wire [1:0] immsel,ALUop;
    wire [31:0] ALUResult;
    wire [6:0] opcode;
    wire [2:0] func3;
    wire [16:0] ImmIN;
    wire [31:0] Immediate;
    wire [4:0] rd,rs2,rs1;
    wire [31:0] sdout1,sdout2;
    reg [31:0] din;
    wire [3:0] ALUctrl;
    wire zero;
    wire [31:0] dataoutdm,dataindm,dataoutar;
    wire PCsrc;
    wire [6:0] func7;
    wire clk_div;
    
    clk_wiz_0 CLD0 (.clk_out1(clk_div),.clk_in1(clk));    
   
    assign opcode = Instr[6:0];
    assign func3 =  Instr[14:12];
    assign func7 = Instr[31:25];
    ControlDecoder CD0(opcode,func3,rwen,sb,sh,sw,branch,memreg,lb,lh,lw,ALUsrcA,ALUop,immsel,ALUsrcB);
    
    assign ImmIN = {Instr[31:20],Instr[11:7]};
    ImmGen IG0(ImmIN,immsel,Immediate);
    
    assign rd = Instr[11:7];
    assign rs2 = Instr[24:20];
    assign rs1 = Instr[19:15]; 
    
    always @(*)
    case(memreg)
        2'b00: din = ALUResult;
        2'b01: din = dataoutar;
        2'b10: din = {Instr[31:12],12'd0};
        default: din = ALUResult;
    endcase
    
    DECODE D0(clk_div,rwen,rd,rs1,rs2,din,sdout1,sdout2);
    
    ALUDecoder AD0(ALUop,func3,func7,ALUctrl);
    assign A = sdout1;
    assign B = sdout2;
    EXECUTE E0(A,B,Immediate,PCcurrent,Instr[31:12],func3,ALUResult,ALUsrcB,ALUsrcA,ALUctrl,zero);
    
    DataMemory DM0(clk_div,sb,sh,sw,memsel,ALUResult[11:0],addrcheck,dataoutdm,dataindm);
    AlignedWrite AW0(sdout2,sb,sh,sw,dataindm);
    AlignedRead AR0(dataoutdm,lb,lh,lw,ALUResult[1:0],dataoutar);

    assign PCsrc = branch&zero;
    PC P0(clk_div,Immediate,rst,PCsrc,PCcurrent);
    InstructionMemory IM0(PCcurrent[11:0],Instr);
    
    assign datacheck = dataoutdm[11:0];
endmodule

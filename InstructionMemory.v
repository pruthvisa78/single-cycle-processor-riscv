`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: InstructionMemory
// Project Name: Single Cycle Processor
//////////////////////////////////////////////////////////////////////////////////

module InstructionMemory(
    input [11:0] addr,
    output [31:0] instr
    );
    Instr_mem_bank3 i3 (.a(addr[11:2]),.spo(instr[31:24]));
    Instr_mem_bank2 i2 (.a(addr[11:2]),.spo(instr[23:16]));
    Instr_mem_bank1 i1 (.a(addr[11:2]),.spo(instr[15:8]));
    Instr_mem_bank0 i0 (.a(addr[11:2]),.spo(instr[7:0]));
endmodule

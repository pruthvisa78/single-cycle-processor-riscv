`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: DataMemory
// Project Name: Single Cycle Processor
//////////////////////////////////////////////////////////////////////////////////


module DataMemory(
    input clk,
    input sb,sh,sw,memsel,
    input [11:0] addr,addrcheck,
    output [31:0] dataout,
    input [31:0] datain
    );
    wire [31:0] dataouttemp;
    reg [3:0] we;
    wire [11:0] addrmux;
    always @(*)
    begin
        case(addr[1:0])
            2'b11:we = sb?4'b0111:4'b1111;                  
            2'b01:we = sb?4'b1101:4'b1111;
            2'b10:case({sh,sb})
                  2'b01: we = 4'b1011;
                  2'b10: we = 4'b0011;
                  default: we = 4'b1111;
                  endcase                
            2'b00:case({sw,sh,sb})
                  3'b001: we = 4'b1110;
                  3'b010: we = 4'b1100;
                  3'b100: we = 4'b0000;
                  default:we = 4'b1111;
                  endcase
        endcase
    end
    
    assign addrmux = memsel?addrcheck:addr;
    data_mem_bank3 b3 (.a(addrmux[11:2]),.dpra(addrmux[11:2]),.d(datain[31:24]),.clk(clk),.we(~we[3]),.dpo(dataouttemp[31:24]));
    data_mem_bank2 b2 (.a(addrmux[11:2]),.dpra(addrmux[11:2]),.d(datain[23:16]),.clk(clk),.we(~we[2]),.dpo(dataouttemp[23:16]));
    data_mem_bank1 b1 (.a(addrmux[11:2]),.dpra(addrmux[11:2]),.d(datain[15:8]),.clk(clk),.we(~we[1]),.dpo(dataouttemp[15:8]));
    data_mem_bank0 b0 (.a(addrmux[11:2]),.dpra(addrmux[11:2]),.d(datain[7:0]),.clk(clk),.we(~we[0]),.dpo(dataouttemp[7:0]));

    assign dataout = dataouttemp;
endmodule

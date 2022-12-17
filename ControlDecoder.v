`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Module Name: ControlDecoder
// Project Name: Single Cycle Processor
//////////////////////////////////////////////////////////////////////////////////


module ControlDecoder(
    input [6:0] opcode,
    input [2:0] func3,
    output reg rwen,sb,sh,sw,branch,
    output reg[1:0] memreg,
    output reg lb,lh,lw,ALUsrcA,
    output reg [1:0] ALUop,immsel,ALUsrc
);

always @(*)
    case(opcode)
        7'b0110011: begin // R to R
                    rwen = 1'b1; sb = 1'b0; sh = 1'b0; sw = 1'b0; branch = 1'b0; memreg = 2'b00; ALUsrc = 2'b00; ALUop = 2'b10;
                    lb = 1'b0; lh = 1'b0; lw = 1'b0; immsel = 2'b00; ALUsrcA = 1'b0;
                    end
        7'b0000011: begin // Load
                    rwen = 1'b1; sb = 1'b0; sh = 1'b0; sw = 1'b0; branch = 1'b0; ALUsrc = 2'b01; ALUop = 2'b00;
                    immsel = 2'b00;memreg = 2'b01; ALUsrcA = 1'b0;
                    case(func3)
                        3'b000: begin lb = 1'b1; lh = 1'b0; lw = 1'b0; end
                        3'b001: begin lb = 1'b0; lh = 1'b1; lw = 1'b0; end
                        3'b010: begin lb = 1'b0; lh = 1'b0; lw = 1'b1; end
                        default:begin lb = 1'b0; lh = 1'b0; lw = 1'b0; end
                    endcase
                    end
        7'b0010011: begin // Immediate
                    rwen = 1'b1; sb = 1'b0; sh = 1'b0; sw = 1'b0; branch = 1'b0; ALUsrc = 2'b01; ALUop = 2'b11;
                    immsel = 2'b00;lb = 1'b0; lh = 1'b0; lw = 1'b0; memreg = 2'b00;ALUsrcA = 1'b0;
                    end            
        7'b0100011: begin // Store
                    rwen = 1'b0;  branch = 1'b0; memreg = 2'b00; ALUsrc = 2'b01; ALUop = 2'b00;lb = 1'b0; lh = 1'b0; lw = 1'b0;
                    immsel = 2'b01;ALUsrcA = 1'b0;
                    case(func3)
                        3'b000: begin sb = 1'b1; sh = 1'b0; sw = 1'b0; end
                        3'b001: begin sb = 1'b0; sh = 1'b1; sw = 1'b0; end
                        3'b010: begin sb = 1'b0; sh = 1'b0; sw = 1'b1; end
                        default: begin sb = 1'b0; sh = 1'b0; sw = 1'b0; end
                    endcase
                    end
        7'b1100011: begin // Branch
                    rwen = 1'b0; sb = 1'b0; sh = 1'b0; sw = 1'b0; branch = 1'b1; memreg = 2'b00; ALUsrc = 2'b00; ALUop = 2'b01;
                    lb = 1'b0; lh = 1'b0; lw = 1'b0;
                    immsel = 2'b10;ALUsrcA = 1'b0;
                    end
        7'b0010111: begin //auipc
                    rwen = 1'b1; sb = 1'b0; sh = 1'b0; sw = 1'b0; branch = 1'b0; memreg = 2'b00; ALUsrc = 2'b10; ALUop = 2'b01;
                    lb = 1'b0; lh = 1'b0; lw = 1'b0;
                    immsel = 2'b00;ALUsrcA = 1'b1;
                    end
        7'b0110111: begin  // lui 
                    rwen = 1'b1; sb = 1'b0; sh = 1'b0; sw = 1'b0; branch = 1'b0; memreg = 2'b10; ALUsrc = 2'b00; ALUop = 2'b01;
                    lb = 1'b0; lh = 1'b0; lw = 1'b0;
                    immsel = 2'b10;ALUsrcA = 1'b0;         
                    end
        default: begin 
                    rwen = 1'b0; sb = 1'b0; sh = 1'b0; sw = 1'b0; branch = 1'b0; memreg = 1'b0; ALUsrc = 2'b00; ALUop = 2'b00;
                    lb = 1'b0; lh = 1'b0; lw = 1'b0;immsel = 2'b00;ALUsrcA = 1'b0;
                    end                                                
    endcase
endmodule

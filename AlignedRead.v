`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: AlignedRead
// Project Name: Single Cycle Processor
//////////////////////////////////////////////////////////////////////////////////


module AlignedRead( 
       input [31:0] datain,
       input lb,lh,lw,
       input [1:0] A1A0,
       output reg [31:0] dataout);
       
       always @(*)
       case({lb,lh,lw})
        3'b100: case(A1A0)
                2'b00: dataout = {{24{datain[7]}},datain[7:0]};
                2'b01: dataout = {{24{datain[15]}},datain[15:8]};
                2'b10: dataout = {{24{datain[23]}},datain[23:16]};
                2'b11: dataout = {{24{datain[31]}},datain[31:24]};
                endcase
        3'b010: case(A1A0)
                2'b00: dataout = {{16{datain[15]}},datain[15:0]};
                2'b10: dataout = {{16{datain[31]}},datain[31:16]};
                default: dataout = datain;
                endcase
         3'b001: dataout = datain;
         default: dataout = datain;
                               
       endcase
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/27 12:31:10
// Design Name: 
// Module Name: alu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [2:0] alucontrol,
    output logic [31:0] aluout,
    output logic zero
    );
    always_comb
    begin
        case(alucontrol)
        3'b000:
            begin
                aluout=a&b;
                zero=(aluout==0)?1:0;
            end
        3'b001:
            begin
                aluout=a|b;
                zero=(aluout==0)?1:0;
            end
         3'b010:
            begin
                aluout=a+b;
                zero=(aluout==0)?1:0;
            end
         3'b100:
            begin
                aluout=a&(~b);
                zero=(aluout==0)?1:0;
            end
         3'b101:
            begin
                aluout=a|(~b);
                zero=(aluout==0)?1:0;
            end
         3'b110:
            begin
                aluout=a-b;
                zero=(aluout==0)?1:0;
            end
         3'b111:
            begin
                aluout=(a<b)?1:0;
                zero=(aluout==0)?1:0;
            end
         default:
            begin 
                aluout=0;
                zero=1;
            end
         endcase
     end
            
endmodule

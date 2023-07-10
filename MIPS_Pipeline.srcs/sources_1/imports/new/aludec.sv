`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/27 10:20:49
// Design Name: 
// Module Name: aludec
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


module aludec(
    input logic [5:0] funct,
    input logic [2:0] aluop,
    output logic [2:0] alucontrol
    );

     always_comb begin
        case (aluop)
            3'b000: alucontrol <= 3'b010; // ADD
            3'b001: alucontrol <= 3'b110; // SUB
            3'b011: alucontrol <= 3'b001; // ORi
            3'b100: alucontrol <= 3'b000; // ANDi
            3'b101: alucontrol <= 3'b111; // SLTi
            // 3'b010;   RTYPE
            default: case (funct)
                6'b100000: alucontrol <= 3'b010;
                6'b100010: alucontrol <= 3'b110;
                6'b100100: alucontrol <= 3'b000;
                6'b100101: alucontrol <= 3'b001;
                6'b101010: alucontrol <= 3'b111;
                default:   alucontrol <= 3'bxxx;
            endcase
        endcase
    end
endmodule

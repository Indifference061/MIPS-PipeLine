`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/27 10:19:01
// Design Name: 
// Module Name: maindec
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



module maindec(
    input  logic[5:0] op,
    input logic [5:0] funct,
    output logic      memtoreg,memwrite,
    output logic [1:0] branch,
    output logic      alusrc,
    output logic      regdst,regwrite,
    output logic      jump,
    output logic[2:0] aluop,
    output logic      immsel
    );
//    opD, functD, memtoregD, memwriteD, branchD, alusrcD, regdstD, regwriteD, jumpD, aluopD, immextD
    logic[11:0] controls;
    assign{regwrite,regdst,alusrc,branch,memwrite,
           memtoreg,jump,aluop,immsel} = controls;
    always_comb
      case(op)
        6'b000000:controls<=12'b11_0_00_000_010_0; // R
        6'b100011:controls<=12'b10_1_00_010_000_0; // lw
        6'b101011:controls<=12'b00_1_00_100_000_0; // sw
        6'b000100:controls<=12'b00_0_10_000_001_0; // beq
        6'b001000:controls<=12'b10_1_00_000_000_1; // addi
        6'b000010:controls<=12'b00_0_00_001_000_0; // j
        6'b000101:controls<=12'b00_0_01_000_001_0;//bne
        6'b001100:controls<=12'b10_1_00_000_100_1;//andi
        6'b001101:controls<=12'b10_1_00_000_011_1;//ori
        default:  controls<=12'bxxxxxxxxxxxx; // illegal op
      endcase
endmodule


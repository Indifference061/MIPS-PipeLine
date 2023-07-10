`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/27 10:14:01
// Design Name: 
// Module Name: controller
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


module controller(
    input logic clk,reset,
    input logic [5:0] opD,functD,
    input logic  flushE, equalD,
    output logic memtoregE,memtoregM,memtoregW,memwriteM,
    output logic        pcsrcD, 
    output logic [1:0]  branchD,
    output logic        alusrcE,
    output logic        regdstE, regwriteE, regwriteM, regwriteW,
    output logic jumpD,
    output logic [2:0]  alucontrolE,
    output logic        immextD
    );
    logic [2:0] aluopD;
    logic       memtoregD, memwriteD, alusrcD, regdstD, regwriteD;
    logic [2:0] alucontrolD;
    logic       memwriteE;

    maindec md(opD, functD, memtoregD, memwriteD, branchD, alusrcD, regdstD, regwriteD, jumpD, aluopD, immextD);
    aludec  ad(functD, aluopD, alucontrolD);

    assign pcsrcD = (branchD[1] & equalD) | (branchD[0] & ~equalD);

    floprc #(8) regE(
        clk, reset, flushE,
        {memtoregD, memwriteD, alusrcD, regdstD, regwriteD, alucontrolD},
        {memtoregE, memwriteE, alusrcE, regdstE, regwriteE, alucontrolE}
    );

    flopr #(3) regM(
        clk, reset, 
        {memtoregE, memwriteE, regwriteE},
        {memtoregM, memwriteM, regwriteM}
    );

    flopr #(2) regW(
        clk, reset,
        {memtoregM, regwriteM},
        {memtoregW, regwriteW}
    );
endmodule

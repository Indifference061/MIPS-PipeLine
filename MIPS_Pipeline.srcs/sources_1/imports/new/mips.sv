`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/27 10:12:59
// Design Name: 
// Module Name: mips
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


module mips(
    input  logic       clk,reset,
    output logic[31:0] pcF,
    input  logic[31:0] instrF,
    output logic       memwriteM,
    output logic[31:0] aluoutM,writedataM,
    input  logic[31:0] readdataM
    );
//    CLK100MHZ,BTNC,pc,instr,Write,dataadr,
//             writedata,readdata
    logic alusrcE,regdstE;
    logic memtoregE,regwriteE;
    logic memtoregM,regwriteM;
    logic memtoregW,regwriteW;
    logic[2:0] alucontrolE;
    logic [5:0] opD,functD;
    logic pcsrcD,jumpD;
    logic [1:0] branchD;
    logic immextD;
    logic flushE,equalD;

    controller c(clk,reset,opD,functD,flushE,equalD,
        memtoregE,memtoregM,memtoregW,memwriteM,pcsrcD,
        branchD,alusrcE,regdstE,regwriteE,regwriteM,
        regwriteW,jumpD,alucontrolE,immextD);
    datapath dp(clk,reset,memtoregE,memtoregM,memtoregW,
        pcsrcD,branchD,alusrcE,regdstE,regwriteE,regwriteM,
        regwriteW,jumpD,alucontrolE,immextD,equalD,pcF,instrF,aluoutM,
        writedataM,readdataM,opD,functD,flushE);
endmodule

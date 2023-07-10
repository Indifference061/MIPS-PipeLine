`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/02 16:18:35
// Design Name: 
// Module Name: dMemoryDecoder
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


//module dMemoryDecoder(input logic clk,
//                      input logic writeEN,
//                      input logic [7:0]addr,
//                      input logic [31:0] writeData,
//                      output logic [31:0] readData,
//                      input logic IOclock,
//                      input logic reset,
//                      input logic btnL,
//                      input logic btnR,
//                      input logic [15:0]switch,
//                      output logic [7:0]an,
//                      output logic [6:0]a2g
//            );
//    logic [11:0]led;
//    logic pRead,pWrite,mWrite;
//    logic [31:0]ReadData1,ReadData2;
//    assign pRead=addr[7];
//    assign pWrite=(addr[7]==1)?1:0;
//    assign mWrite=writeEN&(addr[7]==0);
    
//    IO io(.clk(IOclock),
//          .reset(reset),
//          .pRead(pRead),
//          .pWrite(pWrite),
//          .addr(addr[3:2]),
//          .pWriteData(writeData[11:0]),
//          .pReadData(ReadData2),
//          .buttonL(btnL),
//          .buttonR(btnR),
//          .switch(switch),
//          .led(led));
//    dmem dmem(.clk(clk),.we(WE),.a(addr),.wd(writeData),.rd(ReadData1));
//    assign readData=(addr[7]==1)?ReadData2:ReadData1;   
//    mux7Seg seg(.clk(IOclock),
//                .reset(reset),
//                .data({switch,4'b0000,led}),
//                .an(an),
//                .a2g(a2g));
    
              
//endmodule
module dMemoryDecoder(
    input  logic        clk, writeEN,
    input  logic [31:0] addr, writeData,
    output logic [31:0] readData,

    input  logic        IOclock,
    input  logic        reset,
    input  logic        btnL, btnR,
    input  logic [15:0] switch,
    output logic [7:0]  an,
    output logic [6:0]  a2g
    );
    
    logic pRead, pWrite, mWrite;
    logic [11:0] led,led1;
    logic [31:0] preadData, mreadData;

    assign pRead = (addr[7] == 1'b1) ? 1 : 0;
    assign pWrite = (addr[7] == 1'b1) ? writeEN : 0;
    assign mWrite = writeEN & (addr[7] == 1'b0);

    IO io(IOclock, reset, pRead, pWrite, addr[3:2], writeData, preadData,
          btnL, btnR, switch, led);
    dmem dmem(clk, mWrite, addr, writeData, mreadData);
    assign readData = (addr[7] == 1'b1) ? preadData : mreadData;    
    mux7Seg sg(IOclock, reset, {switch, 4'b0000, led}, an, a2g);
endmodule

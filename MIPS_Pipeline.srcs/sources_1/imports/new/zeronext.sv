`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/06 08:43:55
// Design Name: 
// Module Name: zeronext
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


module zeroext(
    input logic [15:0] instr,
    output logic [31:0] zeroimm
    );
    assign zeroimm={16'b0,instr};
endmodule

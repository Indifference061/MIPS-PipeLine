`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/27 10:36:54
// Design Name: 
// Module Name: mux2
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


module mux2#(parameter WIDTH=8)
            (input logic [WIDTH-1:0] d0,d1,
             input logic s,
             output logic [WIDTH-1:0] y);
      assign y=s?d1:d0;
endmodule

module mux3 #(parameter WIDTH=8)

			(input logic [WIDTH-1:0] d0,d1,d2,
			 input logic [1:0] select,
			 output logic [WIDTH-1:0] result);
assign #1 result = select[1] ? d2 : (select[0] ? d1 : d0 );
endmodule

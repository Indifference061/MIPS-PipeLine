`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/27 10:34:18
// Design Name: 
// Module Name: flopr
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


module flopr #(parameter WIDTH=8)
              (input logic clk,reset,
               input logic [WIDTH-1:0] d,
               output logic [WIDTH-1:0] q);
      always_ff @(posedge clk,posedge reset)
          if(reset) q<=0;
          else q<=d;
endmodule

module floprc #(parameter WIDTH=8)
            (input logic clk,
             input logic reset,
             input logic clear,
             input logic [WIDTH-1:0]d,
             output logic [WIDTH-1:0]q);
      always_ff @(posedge clk,posedge reset)
           if(reset) q<=0;
           else if(clear) q<=0;
           else q<=d;
endmodule

module flopenr #(parameter WIDTH=8)
              (input logic clk,reset,en,
               input logic [WIDTH-1:0] d,
               output logic [WIDTH-1:0] q);
      always_ff @(posedge clk,posedge reset)
          if(reset) q<=0;
          else if(en) q<=d;
endmodule

module flopenrc #(parameter WIDTH=8)
            (input logic clk,
             input logic reset,en,
             input logic clear,
             input logic [WIDTH-1:0]d,
             output logic [WIDTH-1:0]q);
      always_ff @(posedge clk,posedge reset)
           if(reset) q<=0;
           else if(en&clear) q<=0;
           else if(en) q<=d;
endmodule

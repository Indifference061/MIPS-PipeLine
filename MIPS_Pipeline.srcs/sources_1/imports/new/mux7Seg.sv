`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/02 19:24:58
// Design Name: 
// Module Name: mux7Seg
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


module mux7Seg(
            input logic clk,
            input logic reset,
            input logic [31:0]data,
            output logic [7:0]an,
            output logic [6:0]a2g
    );
    logic [2:0]s;
    logic [3:0]digit;
    logic [19:0]clkdiv;
    
    assign s=clkdiv[19:17];
    
    always_comb
        case(s)
            0:  digit = data[31:28];
            1:  digit = data[27:24];
            2:  digit = data[23:20];
            3:  digit = data[19:16];
            4:  digit = data[15:12];
            5:digit=data[11:8];
            6:digit=data[7:4];
            7:digit=data[3:0];
            default: digit = 4'b0000;
        endcase
    
    //8个数码管的使能
    always_comb
        case(s)
            0:  an = 8'b0111_1111;
            1:  an = 8'b1011_1111;
            2:  an = 8'b1101_1111;
            3:  an = 8'b1110_1111;
            4: an=8'b1111_0111;
            5: an=8'b1111_1011;
            6: an=8'b1111_1101;
            7: an=8'b1111_1110;
            default: an = 8'b1111_1111;
        endcase
    
    // 时钟分频器（20位二进制计数器）
    always @(posedge clk)
      if(reset == 1) clkdiv<=0;
      else       clkdiv<=clkdiv+1;
    
    //实例化 7段数码管
    Hex7Seg s7(.x(digit),.s(s), .a2g(a2g));
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/20 23:27:57
// Design Name: 
// Module Name: lab4_2
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


module lab4_4(clock,rest,d,SSD);
input clock;
input rest;
output [3:0]d;
output SSD;

reg clk;
reg rst;
reg [1:0]c;

wire [3:0]b;
wire [7:0] SSD;
wire [3:0] d;


BCD_down U1(.b(b),.clk(clock),.rst(rest));
show_SSD_1 U2(.cin(c[0]),.cout(c[1]),.q(b),.d(d),.SSD(SSD));


endmodule

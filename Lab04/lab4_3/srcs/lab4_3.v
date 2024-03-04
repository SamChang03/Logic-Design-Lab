`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/20 02:56:43
// Design Name: 
// Module Name: lab4_3
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


module lab4_3(clock,rest,d,SSD);
input clock;
input rest;
output [3:0]d;
output SSD;

reg clk;
reg rst;

wire [3:0]b;
wire [7:0] SSD;
wire [3:0] d;


bcd_counter U1(.b(b),.clk(clock),.rst(rest));
BCD_To_SSD U2(.q(b),.d(d),.SSD(SSD));


endmodule

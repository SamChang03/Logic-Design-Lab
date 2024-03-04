`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/20 02:17:56
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


module lab4_2(clock,rest,d,SSD);
input clock;
input rest;
output [3:0]d;
output SSD;

reg clk;
reg rst;

wire [3:0]b;
wire [7:0] SSD;
wire [3:0] d;


down_counter U1(.b(b),.clk(clock),.rst(rest));
show_SSD U2(.i(b),.d(d),.SSD(SSD));


endmodule

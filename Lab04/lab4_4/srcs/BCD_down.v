`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/10 22:22:36
// Design Name: 
// Module Name: prelab3_1
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


module BCD_down(
b, // output
clk, // global clock
rst // active high reset
);
output reg [3:0]b;
input clk;
input rst;
wire clk_new;
reg [3:0]b_tmp;

clk_2HZ(.clk_out(clk_new),.clk(clk),.rst_n(rst));

// Combinational logics
always @*
   if(b!=4'b0000)
    b_tmp <= b - 1'b1;
   else 
    b_tmp<=4'b1001;

// Sequential logics: Flip flops
always @(posedge clk_new or negedge rst)
    if (~rst)
     b<=4'b1001;
    else 
     b<=b_tmp;

endmodule
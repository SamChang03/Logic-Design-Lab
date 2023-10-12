`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/11 00:29:46
// Design Name: 
// Module Name: lab3_1
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

module lab3_1(
clk_out, // divided clock output
clk, // global clock input
rst // active high reset
);

output clk_out; // divided output
input clk; // global clock input
input rst; // active high reset
reg [26:0] cnt; // remainder of the counter
reg [26:0] cnt_tmp; // input to dff (in always block)
wire clk_out;

// Dividied frequency
assign clk_out = cnt[26];

// Combinational logics: increment, neglecting overflow 
always @(cnt)
cnt_tmp = cnt + 1'b1;

// Sequential logics: Flip flops
always @(posedge clk or negedge rst)
if (~rst) 
cnt<=27'd0;
else 
cnt<=cnt_tmp;
endmodule


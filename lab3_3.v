`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/11 02:18:08
// Design Name: 
// Module Name: lab3_3
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


module lab3_3(
q, // output
clk, // global clock
rst // active high reset
);
output reg [3:0]q;
input clk;
input rst;
wire clk_new;
reg [3:0]q_tmp;

lab3_2 U0(.clk_out(clk_new),.clk(clk),.rst_n(rst));

// Combinational logics
always @*
    q_tmp = q + 1'b1;

// Sequential logics: Flip flops
always @(posedge clk_new or negedge rst)
    if (~rst)
     q<=4'd0;
    
    else q<=q_tmp;

endmodule
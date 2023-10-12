`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/11 03:57:53
// Design Name: 
// Module Name: lab3_4
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


module lab3_4(q,clk,rst_n);

output [7:0] q; // output
input clk; // global clock
input rst_n; // active low reset
reg [7:0] q; // output
integer i;
wire clk_new;

lab3_2 U0(.clk_out(clk_new),.clk(clk),.rst_n(rst_n));

// Sequential logics: Flip flops
always @(posedge clk_new or negedge rst_n)
    if (~rst_n) 
    q<=8'b01010101;
    
    else
        begin
        q[0]<=q[7];
        for(i=1;i<8;i=i+1)
        q[i]<=q[i-1];
        end
endmodule

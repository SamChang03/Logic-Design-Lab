`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/10 23:59:09
// Design Name: 
// Module Name: sr
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


module shift_reg(q,clk,rst_n);
output [7:0] q; // output
input clk; // global clock
input rst_n; // active low reset
reg [7:0] q; // output
integer i;

// Sequential logics: Flip flops
always @(posedge clk or negedge rst_n)
    if (~rst_n) 
    begin
    q<=8'b01010101;
    end 
    else
        begin
        q[0]<=q[7];
        for(i=1;i<8;i=i+1)
        q[i]<=q[i-1];
end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/28 03:37:36
// Design Name: 
// Module Name: clock_generator
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


module clock_generator(clk_master,clk_lr,clk_sampling,clk,rst_n);

output clk_master;
output clk_lr;
output clk_sampling;
input clk;
input rst_n;

reg [8:0] cnt;
reg [8:0] cnt_next;

//conbination
always@(cnt)
cnt_next= cnt + 4'd1;

assign clk_master = cnt[2];
assign clk_lr = cnt[8];
assign vclk_sampling = cnt[4];

//sequencial
always@(posedge clk or negedge rst_n)begin
if (~rst_n) 
cnt<=9'd0;
else 
cnt<=cnt_next;

end

endmodule

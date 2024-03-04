`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/11 01:33:06
// Design Name: 
// Module Name: lab3_2
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


module clk_10HZ(
clk_out,
clk,
rst_n
    );
    
output clk_out;
input clk;
input rst_n;

reg [23:0]cnt_temp;
reg [23:0]cnt;
reg clk_t;
wire rst_d;
wire trigger;
wire clk_out;

// Dividied frequency
assign clk_out =clk_t;
assign trigger = (cnt== 24'd4000000);
assign rst_d =(trigger||rst_n);

// T-FF
always@(posedge trigger or negedge rst_n)begin
if (~rst_n) 
clk_t<=0;
else
clk_t =~clk_t;
end

// Combinational logics: increment, neglecting overflow 
always @(cnt)begin
cnt_temp = cnt + 1'b1;
end

// Sequential logics: Flip flops
always @(posedge clk or negedge rst_d)begin
if (~rst_d) 
cnt<=24'd0;
else 
cnt<=cnt_temp;
end

endmodule

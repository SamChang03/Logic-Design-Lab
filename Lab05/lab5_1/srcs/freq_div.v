`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/25 03:07:27
// Design Name: 
// Module Name: freq_div
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


module freq_div(clk_out,clk,rst_n);
    
output reg  clk_out;
input clk;
input rst_n;

    reg [25:0] cnt;
    reg [25:0] cnt_tmp1;
    reg [25:0] cnt_tmp2;
    reg cmp;
    reg clk_tmp;

//1Hz    
    always@*
    begin
    clk_tmp = clk_out ^ cmp;
    cnt_tmp1 = cnt + 1'b1;
    end
    
    always@*
    if(cnt==26'd50000000) cmp = 1;
    else cmp = 0;
    
    always@*
    if(cmp) cnt_tmp2 = 26'd0;
    else cnt_tmp2 = cnt_tmp1;
    
    always@(posedge clk or posedge rst_n)
    if(rst_n)
    begin
        cnt <= 26'd0;
        clk_out <= 1'b0;
    end
    else
    begin
        cnt <= cnt_tmp2;
        clk_out <= clk_tmp;
    end   
        
endmodule

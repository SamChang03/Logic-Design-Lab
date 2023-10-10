`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 19:41:35
// Design Name: 
// Module Name: randomizer
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


module random(
input rst_n,
input fallen,
output reg [2:0] random_num
);
reg temp;

always@*
    temp = random_num[1]^random_num[2];

always@(posedge fallen or negedge rst_n)
    if(~rst_n) random_num <= 3'b111;
    else random_num[2:0] <= {random_num[1:0],temp};
    
endmodule

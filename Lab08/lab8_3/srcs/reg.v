`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 07:05:43
// Design Name: 
// Module Name: register
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


module register_2(reg_out,reg_in,load_en,rst);
output reg [7:0]reg_out;
input [7:0]reg_in;
input load_en,rst;

always@*begin
if(~rst)
reg_out = 8'd0;
else if(load_en)
reg_out = reg_in;
else
reg_out = reg_out;
end
endmodule

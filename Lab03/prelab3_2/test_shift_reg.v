`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/11 00:09:15
// Design Name: 
// Module Name: test_shift_reg
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


module test_shift_reg();
reg clk,rst_n;
wire [7:0]q;
shift_reg U0(.q(q),.clk(clk),.rst_n(rst_n));
initial begin
clk=1;
rst_n<=0;
#5 rst_n<=1;
end

always
begin
#10 clk<=~clk;
end
endmodule

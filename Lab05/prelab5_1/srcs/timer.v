`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/25 01:51:35
// Design Name: 
// Module Name: timer
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


module timer(LED,buttone, clk,rst);
output reg LED;
input buttone;
input clk;
input rst;

wire rst;
wire signal;
wire state;
wire clk_1HZ;

one_pluse U0(.signal(signal),.rst(rst),.buttone(buttone),.clk(clk));
fsm U1(.state(state),.signal(signal),.clk(clk),.rst(rst));

always  @(state) begin
   if(state==1'd0)
    LED=0;
   else
    LED=1;
end 
endmodule
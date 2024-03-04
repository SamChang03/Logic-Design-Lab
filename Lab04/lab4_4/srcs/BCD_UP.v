`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/10 22:22:36
// Design Name: 
// Module Name: prelab3_1
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


module BCD_UP(
b1, // output
b2, // output
clk, // global clock
rst // active high reset
);
output reg [3:0]b1;
output reg [3:0]b2;
input clk;
input rst;
wire clk_new;
reg [3:0]b1_tmp;
reg [3:0]b2_tmp;

clk_10HZ U0(.clk_out(clk_new),.clk(clk),.rst_n(rst));

// Combinational logics
always @*
   if((b2==4'd9)&&(b1==4'd9))begin
   b1_tmp=4'd0;
   b2_tmp=4'd0;
   end
   
   else if(b1!=4'd9)begin
    b1_tmp = b1 + 1'b1;
    b2_tmp = b2;
    end
   else
   begin 
    b1_tmp=4'd0;
    b2_tmp = b2 + 1'b1;
   end

// Sequential logics: Flip flops
always @(posedge clk_new or negedge rst)
    if (~rst)begin
     b1<=4'd0;
     b2<=4'd0;
     end
    else 
     begin
     b1<=b1_tmp;
     b2<=b2_tmp;
     end
endmodule
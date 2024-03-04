`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/19 21:29:32
// Design Name: 
// Module Name: top
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


module lab8_1(
    inout PS2_DATA,
    inout PS2_CLK,
    input rst,
    input clk,
    output [3:0]ssd,
    output [7:0]seg
    );
    wire [511:0]key_down;
    wire [8:0]last_change;
    wire key_valid;
    
   
KeyboardDecoder U0(
    .key_down(key_down),
    .last_change(last_change),
    .key_valid(key_valid),
    .PS2_DATA(PS2_DATA),
    .PS2_CLK(PS2_CLK),
    .rst(~rst),
    .clk(clk)
    );

display_control U1(
    .key_down(key_down),
    .last_change(last_change),
    .key_valid(key_valid),
    .ssd(ssd),
    .seg(seg)
);
endmodule
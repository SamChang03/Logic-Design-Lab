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


module lab8_4(
    output [6:0]LED,
    output cap,
    input clk,
    input rst,
    inout PS2_CLK,
    inout PS2_DATA
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

assign cap_en = last_change == 9'h58 && key_valid;

FSM U1(
    .cap(cap),
    .cap_en(cap_en),
    .clk(clk),
    .rst_n(rst)
    );

display_control U2(
    .cap(cap),
    .shift(key_down[89] | key_down[18]),
    .last_change(last_change),
    .led(LED)
    );
endmodule
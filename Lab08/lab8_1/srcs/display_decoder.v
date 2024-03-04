`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/19 21:08:36
// Design Name: 
// Module Name: display_decoder
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
`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001
`define SS_a 8'b00000101
`define SS_s 8'b11111101
`define SS_d 8'b10010001
`define SS_F 8'b01110001

module display_control(
    input [8:0]last_change,
    input key_valid,
    input [511:0]key_down,
    output reg [3:0]ssd,
    output reg [7:0]seg
    );
    reg [8:0]letter;

always@*
begin
  if (key_valid)
    letter = last_change;
  else
    letter = letter;
end

always@*
begin
  if (last_change == 9'h5A)
    ssd = 4'b1111;
  else
    ssd = 4'b1110;
end

always@*
begin
  case(letter)
    9'h45: seg = `SS_0;
    9'h16: seg = `SS_1;
    9'h1E: seg = `SS_2;
    9'h26: seg = `SS_3;
    9'h25: seg = `SS_4;
    9'h2E: seg = `SS_5;
    9'h36: seg = `SS_6;
    9'h3D: seg = `SS_7;
    9'h3E: seg = `SS_8;
    9'h46: seg = `SS_9;
    9'h1C: seg = `SS_a;
    9'h1B: seg = `SS_s;
    9'h23: seg = `SS_d;
    default: seg = `SS_F;
  endcase
end

endmodule

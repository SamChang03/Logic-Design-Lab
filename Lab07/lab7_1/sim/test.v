`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/28 04:28:18
// Design Name: 
// Module Name: test
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


module test();
reg clk;
reg rst_n;
wire audio_mclk, audio_lrck, audio_sck, audio_sdin;

speaker u0(audio_mclk, audio_lrck, audio_sck, audio_sdin, clk, rst_n );

initial
begin
clk=1;
rst_n=0;
#10 rst_n=1;
end

always
begin
#10 clk=~clk;
end

endmodule

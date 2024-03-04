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
reg clk,button_Do, button_Re, button_Me, button_Fa, button_So,switch;
reg rst_n;
wire audio_mclk, audio_lrck, audio_sck, audio_sdin;


Speaker u0(audio_mclk, audio_lrck, audio_sck, audio_sdin
,clk, rst_n, button_Do, button_Re, button_Me, button_Fa, button_So, switch);

initial
begin
button_Do=0;
button_Re=1; 
button_Me=0; 
button_Fa=0; 
button_So=0;
clk=1;
rst_n=0;
#10 rst_n=1;
#100 switch=1;
end

always
begin
#10 clk=~clk;
end

endmodule

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
reg clk,button_Do, button_Re, button_Me, button_up, button_down;
reg rst_n;
wire audio_mclk, audio_lrck, audio_sck, audio_sdin;
wire [7:0]segs;
wire [3:0]ssd_ctl;

Speaker u0(segs,ssd_ctl,audio_mclk, audio_lrck, audio_sck, audio_sdin
,clk, rst_n, button_Do, button_Re, button_Me, button_up, button_down);

initial
begin
button_Do=0;
button_Re=0; 
button_Me=0; 
button_up=0; 
button_down=0;
clk=1;
rst_n=0;
#10 rst_n=1;
#100 button_up=1;
end

always
begin
#10 clk=~clk;
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/28 03:36:05
// Design Name: 
// Module Name: lab7_1
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


module speaker(audio_mclk, audio_lrck, audio_sck, audio_sdin, clk, rst_n );
output audio_mclk, audio_lrck, audio_sck, audio_sdin;
input clk, rst_n;

// Declare internal nodes
wire [15:0] audio_in_left, audio_in_right; // Note generation

note_gen Ung (.clk(clk), // clock from crystal 
.rst_n(rst_n), // active low reset 
.note_div(22'd191571), // div for note generation 
.audio_left(audio_in_left), // left sound audio 
.audio_right(audio_in_right) // right sound audio
);

// Speaker controllor
speaker_control Usc (.clk(clk), // clock from the crystal 
.rst_n(rst_n), // active low reset 
.audio_in_left(audio_in_left), // left channel audio data input 
.audio_in_right(audio_in_right), // right channel audio data input
.audio_mclk(audio_mclk), // master clock 
.audio_lrck(audio_lrck), // left-right clock 
.audio_sck(audio_sck), // serial clock 
.audio_sdin(audio_sdin) // serial audio data input
);


endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/28 06:14:32
// Design Name: 
// Module Name: lab7_2
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


module Speaker (segs,ssd_ctl,audio_mclk, audio_lrck, audio_sck, audio_sdin
,clk, rst_n, button_Do, button_Re, button_Me, button_up, button_down);

output [7:0] segs;
output [3:0] ssd_ctl;
output audio_mclk, audio_lrck, audio_sck, audio_sdin;
input clk, rst_n, button_Do, button_Re, button_Me, button_up, button_down;

wire up_pulse, down_pulse;
wire Do_debounced, Re_debounced,Me_debounced;
wire clk_1,clk_100,clk_2k;
wire [3:0] level0,level1;
wire [15:0]amplitude_def;
wire [3:0]ssd_in;
wire [15:0] audio_in_left, audio_in_right;

reg [21:0] freq;

clock_generator Uclkgen(
  .clk_1(clk_1), // generated 1 Hz clock
  .clk_100(clk_100), // generated 100 Hz clock
  .clk_2k(clk_2k), // generated 100 Hz clock
  .clk(clk), // clock from crystal
  .rst_n(rst_n) // active low reset
);

one_pulse Uup(.out(up_pulse),.in(button_up),.rst(rst_n),.clk(clk_100));
one_pulse Udown(.out(down_pulse),.in(button_down),.rst(rst_n),.clk(clk_100));

debounce Uleft(.rst(rst_n), .clk(clk_100), .push(button_Do), .push_debounced(Do_debounced));
debounce Ucenter(.rst(rst_n), .clk(clk_100), .push(button_Re), .push_debounced( Re_debounced));
debounce Uright(.rst(rst_n), .clk(clk_100), .push(button_Me), .push_debounced(Me_debounced));

volume Uvol(.amplitude_def(amplitude_def),.level0(level0),.level1(level1)
            ,.rst_n(rst_n),.up(up_pulse),.down(down_pulse),.clk(clk_100));

always@(button_Do , button_Re ,button_Me)begin
 if (button_Do & ~button_Re & ~button_Me )
   freq= 22'd191571;
 else if (~button_Do & button_Re & ~button_Me)
   freq= 22'd170648;
 else if (~button_Do & ~button_Re & button_Me)
   freq= 22'd151515;
 else
   freq= 22'd0;
end

note_gen Ung (.clk(clk), // clock from crystal 
.rst_n(rst_n), // active low reset 
.note_div(freq), // div for note generation 
.amplitude_def(amplitude_def),
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

// Scan control
scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal
  .ssd_in(ssd_in), // output to ssd display
  .in0(level0), // 1st input
  .in1(level1), // 2nd input
  .in2(4'd0), // 3rd input
  .in3(4'd0),  // 4th input
  .ssd_ctl_en(clk_2k), // divided clock for scan control
  .rst_n(rst_n)
);

// binary to 7-segment display decoder
display U_display(
  .segs(segs), // 7-segment display output
  .bin(ssd_in)  // BCD number input
);

endmodule

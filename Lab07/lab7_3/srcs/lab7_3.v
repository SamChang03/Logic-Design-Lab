`include "global.v"
module Speaker (segs,ssd_ctl,audio_mclk, audio_lrck, audio_sck, audio_sdin
        ,clk, rst_n, DIP_c, DIP_d, DIP_e, DIP_f, DIP_g,DIP_a, DIP_b,
         DIP_C, DIP_D, DIP_E, DIP_F, DIP_G,DIP_A, DIP_B);

output [7:0] segs;
output [3:0] ssd_ctl;
output audio_mclk, audio_lrck, audio_sck, audio_sdin;
input clk, rst_n;
input   DIP_c, DIP_d, DIP_e, DIP_f, DIP_g,DIP_a, DIP_b,
         DIP_C, DIP_D, DIP_E, DIP_F, DIP_G,DIP_A, DIP_B;


wire clk_1,clk_100,clk_2k;
reg [3:0] in0,in1;
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


always@(DIP_c, DIP_d, DIP_e, DIP_f, DIP_g,DIP_a, DIP_b,
         DIP_C, DIP_D, DIP_E, DIP_F, DIP_G,DIP_A, DIP_B)begin
 if (DIP_c & ~DIP_d & ~DIP_e & ~DIP_f & ~DIP_g & ~DIP_a & ~DIP_b &
         ~DIP_C &~DIP_D &~DIP_E & ~DIP_F  &~DIP_G & ~DIP_A & ~DIP_B)
   begin
   freq= `freq_mid_Do;
   in0 = 4'd12;
   in1 = 4'd4;
   end
 else if (~DIP_c & DIP_d & ~DIP_e & ~DIP_f & ~DIP_g & ~DIP_a & ~DIP_b &
         ~DIP_C &~DIP_D &~DIP_E & ~DIP_F  &~DIP_G & ~DIP_A & ~DIP_B)
   begin
   freq= `freq_mid_Re;
   in0 = 4'd13;
   in1 = 4'd4;
   end
 else if (~DIP_c & ~DIP_d & DIP_e & ~DIP_f & ~DIP_g & ~DIP_a & ~DIP_b &
         ~DIP_C &~DIP_D &~DIP_E & ~DIP_F  &~DIP_G & ~DIP_A & ~DIP_B)
   begin
   freq= `freq_mid_Me;
   in0 = 4'd14;
   in1 = 4'd4;
   end
   
 else if (~DIP_c & ~DIP_d & ~DIP_e & DIP_f & ~DIP_g & ~DIP_a & ~DIP_b &
         ~DIP_C &~DIP_D &~DIP_E & ~DIP_F  &~DIP_G & ~DIP_A & ~DIP_B)
   begin
   freq= `freq_mid_Fa;
   in0 = 4'd15;
   in1 = 4'd4;
   end
 else if (~DIP_c & ~DIP_d & ~DIP_e & ~DIP_f & DIP_g & ~DIP_a & ~DIP_b &
         ~DIP_C &~DIP_D &~DIP_E & ~DIP_F  &~DIP_G & ~DIP_A & ~DIP_B)
   begin
   freq= `freq_mid_So;
   in0 = 4'd1;
   in1 = 4'd4;
   end
 else if (~DIP_c & ~DIP_d & ~DIP_e & ~DIP_f & ~DIP_g & DIP_a & ~DIP_b &
         ~DIP_C &~DIP_D &~DIP_E & ~DIP_F  &~DIP_G & ~DIP_A & ~DIP_B)
   begin
   freq= `freq_mid_La;
   in0 = 4'd10;
   in1 = 4'd4;
   end
 else if (~DIP_c & ~DIP_d & ~DIP_e & ~DIP_f & ~DIP_g & ~DIP_a & DIP_b &
         ~DIP_C &~DIP_D &~DIP_E & ~DIP_F  &~DIP_G & ~DIP_A & ~DIP_B)
   begin
   freq = `freq_mid_Si;
   in0 = 4'd11;
   in1 = 4'd4;
   end
 else if (~DIP_c & ~DIP_d & ~DIP_e & ~DIP_f & ~DIP_g & ~DIP_a & ~DIP_b &
         DIP_C &~DIP_D &~DIP_E & ~DIP_F  &~DIP_G & ~DIP_A & ~DIP_B)
   begin
   freq= `freq_high_Do;
   in0 = 4'd12;
   in1 = 4'd5;
   end
 else if (~DIP_c & ~DIP_d & ~DIP_e & ~DIP_f & ~DIP_g & ~DIP_a & ~DIP_b &
         ~DIP_C &DIP_D &~DIP_E & ~DIP_F  &~DIP_G & ~DIP_A & ~DIP_B)
   begin
   freq= `freq_high_Re;
   in0 = 4'd13;
   in1 = 4'd5;
   end
 else if (~DIP_c & ~DIP_d & ~DIP_e & ~DIP_f & ~DIP_g & ~DIP_a & ~DIP_b &
         ~DIP_C & ~DIP_D & DIP_E & ~DIP_F  &~DIP_G & ~DIP_A & ~DIP_B)
   begin
   freq= `freq_high_Me;
   in0 = 4'd14;
   in1 = 4'd5;
   end
 else if (~DIP_c & ~DIP_d & ~DIP_e & ~DIP_f & ~DIP_g & ~DIP_a & ~DIP_b &
         ~DIP_C &~DIP_D &~DIP_E & DIP_F  &~DIP_G & ~DIP_A & ~DIP_B)
   begin 
   freq= `freq_high_Fa;
   in0 = 4'd15;
   in1 = 4'd5;
   end
 else if (~DIP_c & ~DIP_d & ~DIP_e & ~DIP_f & ~DIP_g & ~DIP_a & ~DIP_b &
         ~DIP_C &~DIP_D &~DIP_E & ~DIP_F  &DIP_G & ~DIP_A & ~DIP_B)
   begin 
   freq= `freq_high_So;
   in0 = 4'd1;
   in1 = 4'd5;
   end
 else if (~DIP_c & ~DIP_d & ~DIP_e & ~DIP_f & ~DIP_g & ~DIP_a & ~DIP_b &
         ~DIP_C &~DIP_D &~DIP_E & ~DIP_F  &~DIP_G & DIP_A & ~DIP_B)
   begin 
   freq= `freq_high_La;
   in0 = 4'd10;
   in1 = 4'd5;
   end
 else if (~DIP_c & ~DIP_d & ~DIP_e & ~DIP_f & ~DIP_g & ~DIP_a & ~DIP_b &
         ~DIP_C &~DIP_D &~DIP_E & ~DIP_F  &~DIP_G & ~DIP_A & DIP_B)
   begin
   freq = `freq_high_Si;
   in0 = 4'd11;
   in1 = 4'd5;
   end
 else
   begin
   freq= 4'd0;
   in0 = 4'd0;
   in1 = 4'd0;
   end
end

note_gen Ung (.clk(clk), // clock from crystal 
.rst_n(rst_n), // active low reset 
.note_div(freq), // div for note generation 
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
  .in0(4'd0), // 1st input
  .in1(4'd0), // 2nd input
  .in2(in0), // 3rd input
  .in3(in1),  // 4th input
  .ssd_ctl_en(clk_2k), // divided clock for scan control
  .rst_n(rst_n)
);

// binary to 7-segment display decoder
display U_display(
  .segs(segs), // 7-segment display output
  .bin(ssd_in)  // BCD number input
);

endmodule

module Speaker (audio_mclk, audio_lrck, audio_sck, audio_sdin
,clk, rst_n, button_Do, button_Re, button_Me, button_Fa, button_So, switch);

output audio_mclk, audio_lrck, audio_sck, audio_sdin;
input clk, rst_n, button_Do, button_Re, button_Me,  button_Fa, button_So,switch;

wire Do_pulse, Re_pulse, Me_pulse, Fa_pulse, So_pulse;
wire clk_1,clk_100,clk_2k;
wire [15:0] audio_in_left, audio_in_right;

reg [21:0] freq_left,freq_right ;

clock_generator Uclkgen(
  .clk_1(clk_1), // generated 1 Hz clock
  .clk_100(clk_100), // generated 100 Hz clock
  .clk_2k(clk_2k), // generated 100 Hz clock
  .clk(clk), // clock from crystal
  .rst_n(rst_n) // active low reset
);

debounce Udo(.rst(rst_n), .clk(clk), .push(button_Do), .push_debounced(button_Do_debounced));
debounce Ure(.rst(rst_n), .clk(clk), .push(button_Re), .push_debounced(button_Re_debounced));
debounce Ume(.rst(rst_n), .clk(clk), .push(button_Me), .push_debounced(button_Me_debounced));
debounce Ufa(.rst(rst_n), .clk(clk), .push(button_Fa), .push_debounced(button_Fa_debounced));
debounce Uso(.rst(rst_n), .clk(clk), .push(button_So), .push_debounced(button_So_debounced));


always@(button_Do , button_Re ,button_Me,button_Fa,button_So,switch)begin
  if(~switch) begin
    if (button_Do & ~button_Re & ~button_Me & ~button_Fa & ~button_So) begin
     freq_left= `freq_mid_Do;
     freq_right= `freq_mid_Do;
    end
    else if (~button_Do & button_Re & ~button_Me & ~button_Fa & ~button_So)begin
     freq_left= `freq_mid_Re;
     freq_right= `freq_mid_Re;
    end
    else if (~button_Do & ~button_Re & button_Me & ~button_Fa & ~button_So)begin
    freq_left= `freq_mid_Me;
    freq_right= `freq_mid_Me;
    end
    else if (~button_Do & ~button_Re & ~button_Me & button_Fa & ~button_So)begin
    freq_left= `freq_mid_Fa;
    freq_right= `freq_mid_Fa;
    end
    else if (~button_Do & ~button_Re & ~button_Me & ~button_Fa & button_So)begin
    freq_left= `freq_mid_So;
    freq_right= `freq_mid_So;
    end
    else begin
    freq_left= 22'd0;
    freq_right= 22'd0;
    end
  end
  else begin
     if (button_Do & ~button_Re & ~button_Me & ~button_Fa & ~button_So) begin
     freq_left= `freq_mid_Do;
     freq_right= `freq_mid_Me;
    end
    else if (~button_Do & button_Re & ~button_Me & ~button_Fa & ~button_So)begin
     freq_left= `freq_mid_Re;
     freq_right= `freq_mid_Fa;
    end
    else if (~button_Do & ~button_Re & button_Me & ~button_Fa & ~button_So)begin
    freq_left= `freq_mid_Me;
    freq_right= `freq_mid_So;
    end
    else if (~button_Do & ~button_Re & ~button_Me & button_Fa & ~button_So)begin
    freq_left= `freq_mid_Fa;
    freq_right= `freq_mid_La;
    end
    else if (~button_Do & ~button_Re & ~button_Me & ~button_Fa & button_So)begin
    freq_left= `freq_mid_So;
    freq_right= `freq_mid_Si;
    end
    else begin
    freq_left= 22'd0;
    freq_right= 22'd0;
    end
  end
end

//left
note_gen Uleft (.clk(clk), // clock from crystal 
.rst_n(rst_n), // active low reset 
.note_div(freq_left), // div for note generation 
.audio_left(audio_in_left), // left sound audio 
.audio_right() // right sound audio
);

//right
note_gen Uright (.clk(clk), // clock from crystal 
.rst_n(rst_n), // active low reset 
.note_div(freq_right), // div for note generation 
.audio_left(), // left sound audio 
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

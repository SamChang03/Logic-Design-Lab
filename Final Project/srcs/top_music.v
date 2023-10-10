`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/14 15:28:20
// Design Name: 
// Module Name: top_music
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


module top_music(
    input f_crystal,
    input reset,   
    input BGM_on_off,  // switch on => BGM on vice versa
    input vol_up_btn,
    input vol_down_btn,
    input [2:0] game_state,
    output [3:0] ssd_ctl,
    output [7:0] display,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin
    );
    wire [15:0] audio1, audio2;   
    wire [21:0] note_div1, note_div2;
    wire vol_up_pulse, vol_down_pulse;
    reg rst_state;
  
  // needs to add these three declaration to input declaration above  
  // needs a FSM to determine which music to play depending on the state of game
   assign game_start =  (game_state == 3'b000);            // the opening music
   assign pause = (game_state == 3'b010);
   assign gaming = (game_state == 3'b001);               // game playing 
   assign game_over = (game_state == 3'b011);    // game over music
   
    speaker_control d2(       // paralell to serial
        .f_crystal(f_crystal),
        .reset(reset),
        .audio1(audio1),
        .audio2(audio2),
        .audio_mclk(audio_mclk),
        .audio_lrck(audio_lrck),
        .audio_sck(audio_sck),   
        .audio_sdin(audio_sdin)
    );
    
    tone_ctl g0(              
        .reset(reset),  
        .f_crystal(f_crystal),
        .game_start(game_start),
        .gaming(gaming),
        .game_over(game_over),
        .pause(pause),
        .note_div1(note_div1),
        .note_div2(note_div2)
    );
    
    buzz_control d3(
        .f_crystal(f_crystal),
        .reset(reset),
        .BGM_on_off(BGM_on_off),
        .note_div1(note_div1),
        .note_div2(note_div2),
        .vol_up_pulse(vol_up_pulse),
        .vol_down_pulse(vol_down_pulse),
        .audio1(audio1),
        .audio2(audio2)  
    );
    
    one_pulse d4(
        .reset(reset),
        .f_crystal(f_crystal),
        .pb_in(vol_up_btn),
        .pb_pulse(vol_up_pulse)
    );
    one_pulse d5(
        .reset(reset),
        .f_crystal(f_crystal),
        .pb_in(vol_down_btn),
        .pb_pulse(vol_down_pulse)
    );
    
    ssd_control d6(
        .reset(reset|pause),
        .f_crystal(f_crystal),
        .game_start(game_start),
        .gaming(gaming),
        .game_over(game_over),
        .ssd_ctl(ssd_ctl),
        .display(display)
    );
    
endmodule

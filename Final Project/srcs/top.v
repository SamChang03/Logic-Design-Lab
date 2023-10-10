`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/08 22:56:28
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


module top(
    input clk,
    input rst,
    inout PS2_CLK,
    inout PS2_DATA,
    input volume_up,
    input volume_down,
    input BGM_sitch,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output hsync,
    output vsync,
    output [3:0]ssd_ctl,
    output [7:0]display,
    output audio_mclk,
    output audio_lrck,
    output audio_sck,
    output audio_sdin
    );

wire [511:0] key_down;
wire [8:0]last_change;
wire clk_25MHz;
wire clk_21;
wire [11:0] pixel_bg,pixel_bird,pixel_start,pixel_gameover,
            pixel_pause,pixel_score,pixel_pipebody,
            pixel_pipemouth,pixel_pipebase,
            pixel_num;
wire valid;
wire [9:0] h_cnt; //640
wire [9:0] v_cnt;  //480
wire crash,reset;
wire [2:0] state;
wire [6:0]score;

top_music(
    .f_crystal(clk),
    .reset(rst),   
    .BGM_on_off(BGM_sitch), 
    .vol_up_btn(volume_up),
    .vol_down_btn(volume_down),
    .game_state(state),
    .ssd_ctl(ssd_ctl),
    .display(display),
    .audio_mclk(audio_mclk),
    .audio_lrck(audio_lrck),
    .audio_sck(audio_sck),
    .audio_sdin(audio_sdin)
    );

gamestate gamestate_inst(
.clk(clk),
.rst(rst),
.key1(key_down[9'h29]),
.key2(key_down[9'h5A]),
.crash(crash),
.state(state)
);

clock_divisor clk_wiz_0_inst(
 .clk(clk),
 .clk1(clk_25MHz),
 .clk21(clk_21)
);

pipe pipe_inst(
.clk_21(clk_21),
.clk(clk),
.rst(rst),
.state(state),
.h_cnt(h_cnt),
.v_cnt(v_cnt),
.pixel_pipebody(pixel_pipebody),
.pipebody_valid(pipebody_valid),
.pixel_pipemouth(pixel_pipemouth),
.pipemouth_valid(pipemouth_valid),
.pixel_pipebase(pixel_pipebase),
.pipebase_valid(pipebase_valid),
.score(score)
);

vga_controller   vga_inst(
  .pclk(clk_25MHz),
  .reset(rst),
  .hsync(hsync),
  .vsync(vsync),
  .valid(valid),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt)
);

mem_addr_gen U1(
.clk_21(clk_21),
.clk(clk),
.rst(rst),
.state(state),
.pixel_pipemouth(pixel_pipemouth),
.pipemouth_valid(pipemouth_valid),
.pixel_pipebase(pixel_pipebase),
.pipebase_valid(pipebase_valid),
.pipebody_valid(pipebody_valid),
.pixel_pipebody(pixel_pipebody),
.h_cnt(h_cnt),
.v_cnt(v_cnt),
.key(key_down[9'h29]),
.crash(crash),
.pixel_bg(pixel_bg),
.pixel_bird(pixel_bird),
.bird_valid(bird_valid)
);

pixel_gen pixel_inst(
.valid(valid),
.bird_valid(bird_valid),
.start_valid(start_valid),
.gameover_valid(gameover_valid),
.pause_valid(pause_valid),
.score_valid(score_valid),
.b0_valid(b0_valid),
.b1_valid(b1_valid),
.s0_valid(s0_valid),
.s1_valid(s1_valid),
.pipebody_valid(pipebody_valid),
.pixel_pipemouth(pixel_pipemouth),
.pipemouth_valid(pipemouth_valid),
.pixel_pipebase(pixel_pipebase),
.pipebase_valid(pipebase_valid),
.pixel_bg(pixel_bg),
.pixel_bird(pixel_bird),
.pixel_start(pixel_start),
.pixel_gameover(pixel_gameover),
.pixel_pause(pixel_pause),
.pixel_score(pixel_score),
.pixel_num(pixel_num),
.pixel_pipebody(pixel_pipebody),
.vgaRed(vgaRed),
.vgaGreen(vgaGreen),
.vgaBlue(vgaBlue)
);

Maingame maingame_inst(
.clk(clk),
.rst(rst),
.state(state),
.v_cnt(v_cnt),
.h_cnt(h_cnt), 
.score(score),
.start_valid(start_valid),
.gameover_valid(gameover_valid),
.pause_valid(pause_valid),
.score_valid(score_valid),
.s1_valid(s1_valid),
.s0_valid(s0_valid),
.b1_valid(b1_valid),
.b0_valid(b0_valid),
.pixel_start(pixel_start),
.pixel_gameover(pixel_gameover),
.pixel_pause(pixel_pause),
.pixel_score(pixel_score),
.pixel_num(pixel_num)
    );

KeyboardDecoder U0(
  .key_down(key_down),
  .last_change(last_change),
  .key_valid(key_valid),
  .PS2_DATA(PS2_DATA),
  .PS2_CLK(PS2_CLK),
  .rst(rst),
  .clk(clk)
);

endmodule

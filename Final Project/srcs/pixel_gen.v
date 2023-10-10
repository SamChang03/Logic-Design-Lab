`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/09 02:36:42
// Design Name: 
// Module Name: pixel_gen
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


module pixel_gen(
input valid,
input bird_valid,
input start_valid,
input pause_valid,
input gameover_valid,
input score_valid,
input b0_valid,
input b1_valid,
input s0_valid,
input s1_valid,
input pipebody_valid,
input pipemouth_valid,
input pipebase_valid,
input [11:0] pixel_bg,
input [11:0] pixel_bird,
input [11:0] pixel_start,
input [11:0] pixel_gameover,
input [11:0] pixel_pause,
input [11:0] pixel_score,
input [11:0] pixel_num,
input [11:0] pixel_pipebody,
input [11:0] pixel_pipemouth,
input [11:0] pixel_pipebase,
output reg [3:0] vgaRed,
output reg [3:0] vgaGreen,
output reg [3:0] vgaBlue
);
    
always @*
if (valid)
    if(score_valid & pixel_score !=12'h0FF)
        {vgaRed, vgaGreen, vgaBlue} = pixel_score;
    else if(b0_valid & pixel_num !=12'h0FF)
        {vgaRed, vgaGreen, vgaBlue} = pixel_num;
    else if(b1_valid & pixel_num !=12'h0FF)
        {vgaRed, vgaGreen, vgaBlue} = pixel_num;
    else if(s0_valid & pixel_num !=12'h0FF)
        {vgaRed, vgaGreen, vgaBlue} = pixel_num;
    else if(s1_valid & pixel_num !=12'h0FF)
        {vgaRed, vgaGreen, vgaBlue} = pixel_num;    
    else if(start_valid & pixel_start !=12'h0FF)
        {vgaRed, vgaGreen, vgaBlue} = pixel_start;
    else if(gameover_valid & pixel_gameover !=12'h0FF)
        {vgaRed, vgaGreen, vgaBlue} = pixel_gameover;
    else if(pause_valid & pixel_pause !=12'h0FF)
        {vgaRed, vgaGreen, vgaBlue} = pixel_pause;
    else if (bird_valid & pixel_bird != 12'h0FF)
        {vgaRed, vgaGreen, vgaBlue} = pixel_bird;
    else if(pipemouth_valid & pixel_pipemouth != 12'h0FF)
        {vgaRed, vgaGreen, vgaBlue} = pixel_pipemouth;
    else if(pipebase_valid & pixel_pipebase != 12'h0FF)
        {vgaRed, vgaGreen, vgaBlue} = pixel_pipebase;
    else if(pipebody_valid & pixel_pipebody != 12'h0FF)
        {vgaRed, vgaGreen, vgaBlue} = pixel_pipebody;
    else 
        {vgaRed, vgaGreen, vgaBlue} = pixel_bg;
else
        {vgaRed, vgaGreen, vgaBlue} = 12'h0;

endmodule

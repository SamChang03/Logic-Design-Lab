`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/09 03:31:01
// Design Name: 
// Module Name: mem_addr_gen
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
`define BIRD_H 200 
`define BIRD_SIDE 36 

module mem_addr_gen(
input clk_21,
input clk,
input rst,
input [9:0] h_cnt,
input [9:0] v_cnt,
input key,
input [2:0]state,
input [11:0] pixel_pipemouth,
input pipemouth_valid,
input [11:0]pixel_pipebase,
input pipebase_valid,
input [11:0]pixel_pipebody,
input pipebody_valid,
output crash,
output [11:0] pixel_bg,
output reg [11:0] pixel_bird,
output bird_valid
);
reg key_delay;
reg [10:0] bird_v,bird_v_next;
reg [3:0]bird_state,bird_state_next;
wire [16:0]pixel_addr_bg; 
wire [10:0]pixel_addr_bird;
wire [11:0]pixel_birdfly,pixel_birdfly2,pixel_birdideal,pixel_birdup,pixel_birddown;
reg [3:0]ini_cnt,ini_cnt_next;
reg [9:0]cnt, cnt_next;
wire reset;
reg [2:0] state_delay;

assign reset = (state_delay != 3'd0 & state == 3'd0);
assign crash = (bird_v >= 380 | bird_v <= 0 ) | (bird_valid & (pipebody_valid | pipebase_valid | pipemouth_valid)
                & pixel_bird != 12'h0FF & pixel_pipebody != 12'h0FF & pixel_pipemouth != 12'h0FF & pixel_pipebase != 12'h0FF);
assign pixel_addr_bg = (((h_cnt>>1) + cnt)%320 + 320 * (v_cnt>>1)) % 76800;  // 640*480 -> 320*240
assign bird_valid = h_cnt >= `BIRD_H & h_cnt < (`BIRD_H + `BIRD_SIDE ) &
                    v_cnt >= bird_v & v_cnt < (bird_v  + `BIRD_SIDE );
assign pixel_addr_bird = ((h_cnt - `BIRD_H + 1 + (v_cnt - bird_v) * `BIRD_SIDE));

always@(*)begin
if(state != 3'd0)
    case(bird_state[3:1])
    3'd0: pixel_bird = pixel_birddown;
    3'd1: pixel_bird = pixel_birdfly;
    3'd2: pixel_bird = pixel_birdfly;
    3'd3: pixel_bird = pixel_birdideal;
    3'd4: pixel_bird = pixel_birdfly2;
    3'd5: pixel_bird = pixel_birdup;
    3'd6: pixel_bird = pixel_birdup;
    3'd7: pixel_bird = pixel_birdfly2;
    endcase
else
    pixel_bird = pixel_birdideal;
end

always@(*)begin
if(state == 3'd1) begin
    case(bird_state[3:1])
    3'd0: bird_v_next = (bird_v + 5) < 380 ? (bird_v + 5) : 380;
    3'd1: bird_v_next = (bird_v + 3) < 380 ? (bird_v + 3) : 380;
    3'd2: bird_v_next = (bird_v + 1) < 380? (bird_v + 1) : 380;
    3'd3: bird_v_next = bird_v > 0 ? bird_v : 0;
    3'd4: bird_v_next = (bird_v - 1) > 0 ? (bird_v - 1) : 0;
    3'd5: bird_v_next = (bird_v - 3) > 0 ? (bird_v - 3) : 0;
    3'd6: bird_v_next = (bird_v - 5) > 0 ? (bird_v - 5) : 0;
    3'd7: bird_v_next = (bird_v - 7) > 0 ? (bird_v - 7) : 0;
    endcase
    ini_cnt_next = ini_cnt;
    
    if(cnt < 320)
        cnt_next = cnt + 1;
    else
        cnt_next = 0;
end
else if(state == 3'd0) begin
    case(ini_cnt[3:2])
        2'd0: bird_v_next = (bird_v + 2);
        2'd1: bird_v_next = (bird_v + 1);
        2'd2: bird_v_next = (bird_v - 1);
        2'd3: bird_v_next = (bird_v - 2);
    endcase
    ini_cnt_next = ini_cnt + 1;
    
    if(cnt < 320)
        cnt_next = cnt + 1;
    else
        cnt_next = 0;
end
else begin
    cnt_next = cnt;
    bird_v_next = bird_v;
    ini_cnt_next = ini_cnt;
end
    
end    

always@(*)begin
if(state == 3'd1)
    if(key & ~key_delay)
        bird_state_next = 4'b1111;
    else if(bird_state == 4'd0)
        bird_state_next = 4'd0;
    else
        bird_state_next = bird_state - 1;
else
    bird_state_next = bird_state;
end

always @(posedge clk_21 or posedge rst) begin
        if(rst)
        state_delay <= 0;
        else
        state_delay <= state;
    end

always@(posedge clk_21 or posedge rst) begin
    if(rst|reset) begin
        bird_v <= 200;
        bird_state <= 5'b01111;
        key_delay <= 0;
        ini_cnt <= 0;
        cnt <= 0;
    end
    else if(state == 3'd0) begin
        bird_v <= bird_v_next;
        bird_state <= 5'b011111;
        key_delay <= 0;
        ini_cnt <= ini_cnt_next;
        cnt <= cnt_next;
    end
    else begin
        bird_v <= bird_v_next;
        bird_state <= bird_state_next;
        key_delay <= key; 
        ini_cnt <= 2'd0;
        cnt <= cnt_next;
    end
end 

blk_mem_gen_0 mem_bg_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr_bg),
  .douta(pixel_bg)
);

blk_mem_gen_1 mem_bird1_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr_bird),
  .douta(pixel_birdideal)
);

blk_mem_gen_2 mem_bird2_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr_bird),
  .douta(pixel_birdfly)
);

blk_mem_gen_3 mem_bird3_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr_bird),
  .douta(pixel_birdfly2)
);

blk_mem_gen_4 mem_bird4_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr_bird),
  .douta(pixel_birdup)
);

blk_mem_gen_5 mem_bird5_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr_bird),
  .douta(pixel_birddown)
);
endmodule

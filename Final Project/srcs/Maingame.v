`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/09 00:54:02
// Design Name: 
// Module Name: Maingame
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


module Maingame(
input clk,
input rst,
input [2:0]state,
input [9:0]v_cnt,
input [9:0]h_cnt, 
input [6:0]score,
output start_valid,
output gameover_valid,
output pause_valid,
output score_valid,
output b0_valid,
output b1_valid,
output s0_valid,
output s1_valid,
output [11:0]pixel_start,
output [11:0]pixel_gameover,
output [11:0]pixel_pause,
output [11:0]pixel_score,
output [11:0]pixel_num
    );

wire [11:0]pixel_addr_start; 
wire [11:0]pixel_addr_gameover;
wire [11:0]pixel_addr_pause;
wire [11:0]pixel_addr_score;
wire [11:0]pixel_addr_b0;
wire [11:0]pixel_addr_b1;
wire [11:0]pixel_addr_s0;
wire [11:0]pixel_addr_s1;
reg [11:0]pixel_addr_num;

wire [3:0] num_s0,num_s1,num_b1,num_b0;
reg [3:0] num;

assign start_valid = (state == 3'd0) & (h_cnt >= 230 & h_cnt < 410) 
                    &  (v_cnt >= 200 & v_cnt < 260);
assign gameover_valid = (state == 3'd3) & (h_cnt >= 200 & h_cnt < 430) 
                    &  (v_cnt >= 200 & v_cnt < 260);
assign pause_valid = (state == 3'd2) & (h_cnt >= 260 & h_cnt < 380) 
                    &  (v_cnt >= 150 & v_cnt < 270); 
assign score_valid = (h_cnt >= 10 & h_cnt < 190) & (v_cnt >= 10 & v_cnt < 70);

assign s1_valid = (h_cnt >= 200 & h_cnt < 230) & (v_cnt >= 10 & v_cnt < 40);
assign s0_valid = (h_cnt >= 230 & h_cnt < 260) & (v_cnt >= 10 & v_cnt < 40);
assign b1_valid = (h_cnt >= 200 & h_cnt < 230) & (v_cnt >= 40 & v_cnt < 70);
assign b0_valid = (h_cnt >= 230 & h_cnt < 260) & (v_cnt >= 40 & v_cnt < 70);
                   
/*(((h_cnt>>1) + cnt)%320 + 320 * (v_cnt>>1)) % 76800;  // 640*480 -> 320*240*/  
                 
assign pixel_addr_start = (((h_cnt - 230 + 2)>> 1) + ((v_cnt - 200)>> 1) * 90);
assign pixel_addr_gameover =  (((h_cnt - 200 + 2)>> 1) + ((v_cnt - 200) >> 1) * 115);
assign pixel_addr_pause =  (((h_cnt - 260+2 )>> 1) + ((v_cnt - 150) >> 1) * 60);
assign pixel_addr_score =  (((h_cnt - 10 + 2)>> 1) + ((v_cnt - 10)>> 1) * 90);

assign pixel_addr_s1 =  ((h_cnt - 200 + 2) + ((v_cnt - 10)) * 30);
assign pixel_addr_s0 =  ((h_cnt - 230 + 2) + ((v_cnt - 10)) * 30);
assign pixel_addr_b1 =  (h_cnt - 200 + 2) + ((v_cnt - 40) * 30);
assign pixel_addr_b0 =  (h_cnt - 230 + 2) + ((v_cnt - 40) * 30);

register r0(.reg_out(num_b0),.reg_in(num_s0),.load_en(load_en),.rst(rst),.clk(clk));
register r1(.reg_out(num_b1),.reg_in(num_s1),.load_en(load_en),.rst(rst),.clk(clk));

assign load_en= (score>=(10*num_b1+num_b0)) & (score!=0);
assign num_s0=score%10;
assign num_s1=score/10;


always@*begin
    if(s1_valid)begin
        pixel_addr_num= pixel_addr_s1;
        num=num_s1;
    end
    else if(s0_valid)begin
        pixel_addr_num= pixel_addr_s0;
        num=num_s0;
    end
    else if(b0_valid)begin
        pixel_addr_num= pixel_addr_b0;
        num=num_b0;
    end
    else if (b1_valid)begin
        pixel_addr_num= pixel_addr_b1;
        num=num_b1;
    end
    else begin
        pixel_addr_num= 0;
        num=0;
    end
end

score_address S(
.pixel(pixel_num),
.clk(clk),
.pixel_addr(pixel_addr_num),
.num(num) 
);
    

blk_mem_gen_12 mem_bird12_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr_score),
  .douta(pixel_score)
);

blk_mem_gen_11 mem_bird11_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr_pause),
  .douta(pixel_pause)
);

blk_mem_gen_6 mem_bird6_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr_gameover),
  .douta(pixel_gameover)
);

blk_mem_gen_7 mem_bird7_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr_start),
  .douta(pixel_start)
);


endmodule

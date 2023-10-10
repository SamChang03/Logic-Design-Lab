`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/16 06:56:21
// Design Name: 
// Module Name: score_address
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


module score_address(
output reg [11:0] pixel,
input clk,
input [11:0] pixel_addr,
input [3:0]num 
    );
 wire [11:0]pixel0,pixel1,pixel2,pixel3,
      pixel4,pixel5,pixel6,pixel7,pixel8,pixel9;   
    
always@* begin
case(num)
 4'd01: pixel= pixel1;
 4'd02: pixel= pixel2;
 4'd03: pixel= pixel3;
 4'd04: pixel= pixel4;
 4'd05: pixel= pixel5;
 4'd06: pixel= pixel6;
 4'd07: pixel= pixel7;
 4'd08: pixel= pixel8;
 4'd09: pixel= pixel9;
 4'd0: pixel= pixel0;
 default: pixel= pixel0;
 endcase
end

blk_mem_gen_num0 mem_bird0_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr),
  .douta(pixel0)
);

blk_mem_gen_num1 mem_bird1_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr),
  .douta(pixel1)
);

blk_mem_gen_num2 mem_bird2_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr),
  .douta(pixel2)
);

blk_mem_gen_num3 mem_bird3_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr),
  .douta(pixel3)
);

blk_mem_gen_num4 mem_bird4_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr),
  .douta(pixel4)
);

blk_mem_gen_num5 mem_bird5_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr),
  .douta(pixel5)
);

blk_mem_gen_num6 mem_bird6_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr),
  .douta(pixel6)
);

blk_mem_gen_num7 mem_bird7_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr),
  .douta(pixel7)
);

blk_mem_gen_num8 mem_bird8_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr),
  .douta(pixel8)
);

blk_mem_gen_num9 mem_bird9_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr),
  .douta(pixel9)
);



endmodule

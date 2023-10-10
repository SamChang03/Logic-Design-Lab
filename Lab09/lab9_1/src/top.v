`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/22 22:30:47
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


module lab9_1(
  input clk,
  input rst,
  input rst_n,
  input button,
  output [3:0] vgaRed,
  output [3:0] vgaGreen,
  output [3:0] vgaBlue,
  output hsync,
  output vsync
);

wire clk_25MHz;
wire clk_22;
wire [16:0] pixel_addr;
wire [11:0] pixel;
wire valid;
wire button_pulse;
wire [9:0] h_cnt; //640
wire [9:0] v_cnt;  //480

assign {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel:12'h0;

// Frequency Divider
clk_div clk0(
  .clk(clk),
  .clk1(clk_25MHz),
  .clk22(clk_22)
);

wire enable;

// Reduce frame address from 640x480 to 320x240
mem_addr_gen mem_addr_gen(
  .clk(clk_22),
  .rst(rst),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt),
  .enable(enable),
  .pixel_addr(pixel_addr)
);
     
// Use reduced 320x240 address to output the saved picture from RAM 
blk_mem_gen_0 blk_mem_gen_0(
  .clka(clk_25MHz),
  .wea(0),
  .addra(pixel_addr),
  .dina(),
  .douta(pixel)
); 

// Render the picture by VGA controller
vga_controller   vga(
  .pclk(clk_25MHz),
  .reset(rst),
  .hsync(hsync),
  .vsync(vsync),
  .valid(valid),
  .h_cnt(h_cnt),
  .v_cnt(v_cnt)
);
      
wire clk_10,clk_100;
      
clk_gen U0(
.clk(clk),
.rst_n(rst_n),
.clk_10(clk_10),
.clk_100(clk_100)
);

one_pulse u0(.out(button_pulse),.in(button),.rst(rst_n),.clk(clk));

FSM U3(
.clk_10(clk_10),
.rst(rst_n),
.pulse_en(button_pulse),
.enable(enable)
);

endmodule

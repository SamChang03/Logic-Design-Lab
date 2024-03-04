`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 06:04:20
// Design Name: 
// Module Name: display_control
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
`define SS_0 8'b00000011
`define SS_1 8'b10011111
`define SS_2 8'b00100101
`define SS_3 8'b00001101
`define SS_4 8'b10011001
`define SS_5 8'b01001001
`define SS_6 8'b01000001
`define SS_7 8'b00011111
`define SS_8 8'b00000001
`define SS_9 8'b00001001
`define SS_a 8'b00000101
`define SS_s 8'b11111101
`define SS_d 8'b10010001
`define SS_F 8'b01110001

`define S0 2'b00
`define S1 2'b01
`define S2 2'b10
`define S3 2'b11

module display_control(display,ssd_ctl,state,last_change,key_valid,key_down,clk,rst);

output [7:0]display;
output [3:0]ssd_ctl;
input [1:0]state;
input rst,clk;
input [8:0]last_change;
input key_valid;
input [511:0]key_down;

reg [8:0]letter;
reg [7:0] seg;
wire [7:0]seg0,seg1,seg2,seg3;
wire [3:0] num0,num1;
wire [4:0] num2,num3;
wire [1:0] ssd_ctl_en;
reg [3:0] num,num1_in;
reg [4:0]num0_in;
freq_div U_FD2(.clk_out(ssd_ctl_en),.clk(clk),.rst(rst));

always@*
begin
  if (key_valid)
    letter = last_change;
  else
    letter = letter;
end

always@*
begin
  case(letter)
    9'h70: begin seg = `SS_0; num=4'd0; end
    9'h69: begin seg = `SS_1; num=4'd1; end
    9'h72: begin seg = `SS_2; num=4'd2; end
    9'h7A: begin seg = `SS_3; num=4'd3; end
    9'h6B: begin seg = `SS_4; num=4'd4; end
    9'h73: begin seg = `SS_5; num=4'd5; end
    9'h36: begin seg = `SS_6; num=4'd6; end
    9'h6C: begin seg = `SS_7; num=4'd7; end
    9'h75: begin seg = `SS_8; num=4'd8; end
    9'h7D: begin seg = `SS_9; num=4'd9; end
    9'h1C: seg = `SS_a;
    9'h1B: seg = `SS_s;
    9'h23: seg = `SS_d;
    default: seg = `SS_F;
  endcase
end

wire rst_reg,load_en0,load_en1,load_en2,load_en3;
assign rst_reg = rst | state==`S0;
assign load_en3 = (state==`S1);
assign load_en2 = (state==`S2);
assign load_en1 = (state==`S3);
assign load_en0 = (state==`S3);

always@*begin
    if((num2+num3)>5'd9)begin
    num1_in= 4'd1;
    num0_in= num2+num3-5'd10;
    end
    else begin
    num1_in= 4'd0;
    num0_in= num2+num3;
    end
end

register r0(.reg_out(num0),.reg_in(num0_in[3:0]),.load_en(load_en0),.rst(rst_reg));
register r1(.reg_out(num1),.reg_in(num1_in),.load_en(load_en1),.rst(rst_reg));
register r2(.reg_out(num2),.reg_in(num),.load_en(load_en2),.rst(rst_reg));
register r3(.reg_out(num3),.reg_in(num),.load_en(load_en3),.rst(rst_reg));

ssd U_SSD3( .display(seg3),.bcd(num3));
ssd U_SSD2( .display(seg2),.bcd(num2));
ssd U_SSD1( .display(seg1), .bcd(num1));
ssd U_SSD0( .display(seg0),.bcd(num0));


// SSD display scan control
ssd_ctl U_CTL(
.display_c(ssd_ctl), // ssd display control signal 
.display(display), // output to ssd display 
.ssd_ctl_en(ssd_ctl_en), // divided clock for scan control
.display0(seg0), // 1st input
.display1(seg1), // 2st input
.display2(seg2), // 3st input
.display3(seg3), // 4st input,
.state(state),
.rst(rst)
);

endmodule

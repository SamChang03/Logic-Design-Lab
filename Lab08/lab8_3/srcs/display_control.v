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

`define S0 4'b0000
`define S1 4'b0001
`define S2 4'b0010
`define S3 4'b0011
`define S4 4'b0100
`define S5 4'b0101
`define S6 4'b0110
`define S7 4'b0111
`define S8 4'b1000
`define S9 4'b1001

module display_control(display,ssd_ctl,state,last_change,key_valid,key_down,clk,rst);

output [7:0]display;
output [3:0]ssd_ctl;
input [3:0]state;
input rst,clk;
input [8:0]last_change;
input key_valid;
input [511:0]key_down;

reg [8:0]letter;
reg [7:0] seg;
wire [7:0]operator;
wire [7:0]seg0,seg1,seg2,seg3,seg4,seg5,seg6,seg7;
reg  [7:0]in0,in1,in2,in3;
wire [3:0] num0,num1,num2,num3;
reg  [3:0] result_0,result_1,result_2,result_3;
wire [1:0] ssd_ctl_en;
wire rst_reg,load_en_1st,load_en_2nd,load_en_dec,load_en_uni,load_en_op;
reg [3:0] num;
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
    9'h79: seg = `SS_a;
    9'h7B: seg = `SS_s;
    9'h7C: seg = `SS_d;
    default: seg = `SS_F;
  endcase
end


assign rst_reg = rst | state==`S0;


always@*begin
 if(operator==`SS_a) begin
 
        result_0= (((10*num1)+num0)+((10*num3)+num2))-(100*result_2)-(10*result_1);
        result_1= (((10*num1)+num0)+((10*num3)+num2)-(100*result_2))/10;
        result_2= (((10*num1)+num0)+((10*num3)+num2))/100;
        result_3= 4'd0;

  end
  else if(operator==`SS_s) begin
     if(((10*num1)+num0)<((10*num3)+num2))begin
        result_0= ((10*num3)+num2)-((10*num1)+num0)-(10*result_1);
        result_1= (((10*num3)+num2)-((10*num1)+num0))/10;
        result_2= 4'd0;
        result_3= 4'd11;
     end
     else begin
        
        result_0= ((10*num1)+num0)-((10*num3)+num2)-(10*result_1);
        result_1= (((10*num1)+num0)-((10*num3)+num2))/10;
        result_2= 4'd0;
        result_3= 4'd0;
     end
  end
  else if(operator==`SS_d) begin
  
        result_0= (((10*num1)+num0)*((10*num3)+num2))-(1000*result_3)-(100*result_2)-(10*result_1);
        result_1= ((((10*num1)+num0)*((10*num3)+num2))-(1000*result_3)-(100*result_2))/10;
        result_2= ((((10*num1)+num0)*((10*num3)+num2))-(1000*result_3))/100;
        result_3= (((10*num1)+num0)*((10*num3)+num2))/1000;
     
  end
  
    else  begin
        result_0= 4'd11;
        result_1= 4'd11;
        result_2= 4'd11;
        result_3= 4'd11; 
     end
end

register r3(.reg_out(num3),.reg_in(num),.load_en((state==`S5)),.rst(rst_reg));
register r2(.reg_out(num2),.reg_in(num),.load_en((state==`S6)),.rst(rst_reg));
register r1(.reg_out(num1),.reg_in(num),.load_en((state==`S1)),.rst(rst_reg));
register r0(.reg_out(num0),.reg_in(num),.load_en((state==`S2)),.rst(rst_reg));

register_2 rop(.reg_out(operator),.reg_in(seg),.load_en((state==`S3)),.rst(rst_reg));

ssd U_SSD7( .display(seg7),.bcd(result_3));
ssd U_SSD6( .display(seg6),.bcd(result_2));
ssd U_SSD5( .display(seg5),.bcd(result_1));
ssd U_SSD4( .display(seg4),.bcd(result_0));

ssd U_SSD3( .display(seg3),.bcd(num3));
ssd U_SSD2( .display(seg2),.bcd(num2));
ssd U_SSD1( .display(seg1),.bcd(num1));
ssd U_SSD0( .display(seg0),.bcd(num0));

always@*begin

    if(state == `S0)begin
        in0=0;
        in1=0;
        in2=0;
        in3=0;
    end
    else if(state == `S1)begin
        in0=0;
        in1=0;
        in2=0;
        in3=0;
    end
    else if(state == `S2)begin
        in0=seg0;
        in1=seg1;
        in2=0;
        in3=0;
    end
    else if(state == `S3)begin
        in0=seg0;
        in1=seg1;
        in2=0;
        in3=0;
    end
    else if(state == `S4)begin
        in0=operator;
        in1=0;
        in2=0;
        in3=0;
    end
    else if(state == `S5)begin
        in0=0;
        in1=0;
        in2=0;
        in3=0;
    end
    else if(state == `S6)begin
        in0=0;
        in1=seg3;
        in2=0;
        in3=0;
    end
    else if(state == `S7)begin
        in0=seg2;
        in1=seg3;
        in2=0;
        in3=0;
    end
    else if(state == `S8)begin
        in0=seg4;
        in1=seg5;
        in2=seg6;
        in3=seg7;
    end
    else if(state == `S9)begin
        in0=seg4;
        in1=seg5;
        in2=seg6;
        in3=seg7;
    end
    else begin
        in0=`SS_F;
        in1=`SS_F;
        in2=`SS_F;
        in3=`SS_F;
    end
end

// SSD display scan control
ssd_ctl U_CTL(
.display_c(ssd_ctl), // ssd display control signal 
.display(display), // output to ssd display 
.ssd_ctl_en(ssd_ctl_en), // divided clock for scan control
.display0(in0), // 1st input
.display1(in1), // 2st input
.display2(in2), // 3st input
.display3(in3), // 4st input,
.state(state),
.rst(rst)
);

endmodule

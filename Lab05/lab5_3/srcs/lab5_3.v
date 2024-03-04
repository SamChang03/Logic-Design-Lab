`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/05 03:24:29
// Design Name: 
// Module Name: lab5_3
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


module lab5_3(LED,display,ssd_ctl,clk,set,rst,
              b1,b2,b3,b4);
output  reg [15:0] LED;
output [7:0] display; // seven segment display control
output [3:0] ssd_ctl; // scan control for ssd
input clk; // clock
input rst; // high active reset
input set;
input b1,b2,b3,b4;

wire rst_fsm;
wire [1:0] ssd_ctl_en; // divided output for ssd ctl
wire [7:0] disp0,disp1,disp2,disp3; // ssd control
wire clk_d; // divided clock
wire count_enable; // if count is enabled
wire [3:0] dig0,dig1,dig2,dig3; // fouro counter outputs
wire b1_pulse;
wire b2_pulse;
wire b3_pulse;
wire b4_pulse;
wire [2:0]state;

wire [3:0] digit3_initial,digit2_initial,digit1_initial,digit0_initial;
reg [3:0] dig0_out,dig1_out,dig2_out,dig3_out; // fouro counter outputs


timer UT(.digit3(dig3),.digit2(dig2),.digit1(dig1),.digit0(dig0),
            .digit3_initial(digit3_initial),.digit2_initial(digit2_initial),
            .digit1_initial(digit1_initial),.digit0_initial(digit0_initial),
            .clk(clk_d),.rst(rst),.rst_fsm(rst_fsm),.en(count_enable),.set(set));
    
setting US( .digit1_initial(digit1_initial),.digit0_initial(digit0_initial),
            .signal(b3_pulse),.rst(rst),.en(set));

setting US2(.digit1_initial(digit3_initial),.digit0_initial(digit2_initial),
            .signal(b4_pulse),.rst(rst),.en(set));

FSM U_fsm(.state(state),.reset_fsm(rst_fsm),.count_enable(count_enable),
          .b1(b1_pulse),.b2(b2_pulse),.clk(clk),.rst(rst));

//generate one pluse
one_pulse U0(.out(b1_pulse),.in(b1),.rst(rst),.clk(clk));
one_pulse U1(.out(b2_pulse),.in(b2),.rst(rst),.clk(clk));
one_pulse U3(.out(b3_pulse),.in(b3),.rst(rst),.clk(clk));
one_pulse U4(.out(b4_pulse),.in(b4),.rst(rst),.clk(clk));

freq_div U_FD(.clk_out(clk_d),.clk(clk),.rst_n(rst));
freq_div2 U_FD2(.clk_out(ssd_ctl_en),.clk(clk),.rst(rst));

always @(rst_fsm,~rst,set,state)
begin
    if (rst_fsm || ~rst) // setting state 
    begin
    dig0_out=4'd0;
    dig1_out=4'd0;
    dig2_out=4'd0;
    dig3_out=4'd0;
    end
    
    else if (set || state==3'd4)
    begin
    dig0_out= digit0_initial;
    dig1_out= digit1_initial;
    dig2_out= digit2_initial;
    dig3_out= digit3_initial;
    end
    
    else
    begin
    dig0_out=dig0;
    dig1_out=dig1;
    dig2_out=dig2;
    dig3_out=dig3;
    end
end


ssd U_SSD3( .display(disp3),.bcd(dig3_out));
ssd U_SSD2( .display(disp2),.bcd(dig2_out));
ssd U_SSD1( .display(disp1),.bcd(dig1_out));
ssd U_SSD0( .display(disp0),.bcd(dig0_out));

// SSD display scan control
ssd_ctl U_CTL(
.display_c(ssd_ctl), // ssd display control signal 
.display(display), // output to ssd display 
.ssd_ctl_en(ssd_ctl_en), // divided clock for scan control
.display0(disp0), // 1st input
.display1(disp1), // 2st input
.display2(disp2), // 3st input
.display3(disp3), // 4st input,
.rst(rst)
);

always @*
begin
if(~rst_fsm && dig0_out==0 && dig1_out==0 && dig2_out==0 && dig3_out==0 && set==0 )
 LED = 16'b1111111111111111;
else
 LED = 16'b0000000000000000;
end

endmodule

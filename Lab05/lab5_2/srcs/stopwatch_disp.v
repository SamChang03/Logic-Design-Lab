`include "global.v"
module stopwatch_disp(display, // seven segment display control 
ssd_ctl, // scan control for seven-segment display 
clk, // clock 
rst, // high active reset 
b1, // input control for FSM
b2 // input control for FSM
);

output [7:0] display; // seven segment display control
output [3:0] ssd_ctl; // scan control for ssd
input clk; // clock
input rst; // high active reset
input b1; // input control for FSM
input b2; // input control for FSM
wire rst_fsm;
wire [1:0] ssd_ctl_en; // divided output for ssd ctl
wire [7:0] disp0,disp1,disp2,disp3; // ssd control
wire clk_d; // divided clock
wire count_enable; // if count is enabled
wire freeze_enable; // if ssd is enabled
wire [3:0] dig0,dig1,dig2,dig3; // fouro counter outputs
wire b1_pulse;
wire b2_pulse;
reg [3:0] dig0_latch,dig1_latch,dig2_latch,dig3_latch; // four counter latches
reg [3:0] dig0_out,dig1_out,dig2_out,dig3_out; // output to ssd

//**************************************************************
// Functional block
//**************************************************************

//generate one pluse
one_pulse U0(.out(b1_pulse),.in(b1),.rst(rst),.clk(clk));
one_pulse U1(.out(b2_pulse),.in(b2),.rst(rst),.clk(clk));

//frequency divider 1HZ
freq_div U_FD(.clk_out(clk_d),.clk(clk),.rst(rst));
freq_div2 U_FD2(.clk_out(ssd_ctl_en),.clk(clk),.rst(rst));

FSM U_fsm(.reset_fsm(rst_fsm),.count_enable(count_enable),.freeze_enable(freeze_enable),.b1(b1_pulse),.b2(b2_pulse),.clk(clk),.rst(rst));

// stopwatch module
stopwatch U_sw( 
.digit3(dig3), // 4th digit of the down counter 
.digit2(dig2), // 3th digit of the down counter 
.digit1(dig1), // 2nd digit of the down counter 
.digit0(dig0), // 1st digit of the down counter 
.clk(clk_d), // global clock 
.rst(rst), // high active reset 
.rst_fsm(rst_fsm),
.en(count_enable) // enable/disable for the stopwatch
);

// Display latch
always @(posedge clk or posedge rst or posedge rst_fsm) 
if (rst || rst_fsm) begin 
dig0_out <= 4'd0; 
dig1_out <= 4'd0; 
dig2_out <= 4'd0; 
dig3_out <= 4'd0; 
end

else begin 
dig0_out <= dig0_latch; 
dig1_out <= dig1_latch; 
dig2_out <= dig2_latch; 
dig3_out <= dig3_latch; 
end

// Whether the display is freezed
always @* begin
if (freeze_enable) begin 
dig0_latch = dig0_out; 
dig1_latch = dig1_out;
dig2_latch = dig2_out; 
dig3_latch = dig3_out; 
end 

else 
begin 
dig0_latch = dig0; 
dig1_latch = dig1; 
dig2_latch = dig2; 
dig3_latch = dig3; 
end
end
//**************************************************************
// Display block
//**************************************************************
// BCD to seven segment display decoding
// seven-segment display decoder for DISP3

ssd U_SSD3( .display(disp3),.bcd(dig3_out));
ssd U_SSD2( .display(disp2),.bcd(dig2_out));
ssd U_SSD1( .display(disp1), .bcd(dig1_out));
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
endmodule
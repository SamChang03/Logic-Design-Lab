`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/05 05:56:20
// Design Name: 
// Module Name: setting
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


module setting
(
digit1_initial, // 2nd digit of the down counter
digit0_initial, // 1st digit of the down counter
signal, // global clock
rst, // active high reset
en // enable/disable for stopwatch
);

output [3:0] digit1_initial; 
output [3:0] digit0_initial; 
input signal; // global clock
input rst; // active high reset
input en; // enable/disable for stopwatch


wire carry0, carry1; // carry indicator
wire increase_enable; 


assign increase_enable = en && (~((digit0_initial==4'd9) 
                            && (digit1_initial==4'd5)));

// down counter
upcounter  Udc0( 
.value(digit0_initial), // counter value 
.carry(carry0), // carry indicator for counter to next stage 
.signal(signal), // global clock signal 
.rst(rst), // high active reset 
.increase(increase_enable), // increase input from previous stage of counter 
.init_value(0), // initial value for the counter 
.limit(4'd9), // limit for the counter 
.en(1) // enable/disable of the counter
);

upcounter Udc1(
.value(digit1_initial), // counter value 
.carry(carry1), // carry indicator for counter to next stage 
.signal(signal), // global clock signal 
.rst(rst), // high active reset 
.increase(carry0), // increase input from previous stage of counter 
.init_value(0), // initial value for the counter 
.limit(4'd5), // limit for the counter 
.en(1) // enable/disable of the counter
);
endmodule

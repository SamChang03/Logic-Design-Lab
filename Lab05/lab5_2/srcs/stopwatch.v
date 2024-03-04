`include "global.v"
module stopwatch(
digit3, // 4nd digit of the down counter
digit2, // 3nd digit of the down counter
digit1, // 2nd digit of the down counter
digit0, // 1st digit of the down counter
clk, // global clock
rst, // active high reset
rst_fsm,
en // enable/disable for stopwatch
);
output [`BCD_BIT_WIDTH-1:0] digit3; 
output [`BCD_BIT_WIDTH-1:0] digit2; 
output [`BCD_BIT_WIDTH-1:0] digit1; 
output [`BCD_BIT_WIDTH-1:0] digit0; 
input clk; // global clock
input rst; // active high reset
input rst_fsm;
input en; // enable/disable for stopwatch
wire carrry0, carrry1,carrry2, carrry3; // borrow indicator
wire increase_enable; 


assign increase_enable = en && (~((digit0==4'd9) && (digit1==4'd5) 
                         && (digit2==4'd9) &&(digit3==4'd5)));

// down counter
upcounter  Udc0( 
.value(digit0), // counter value 
.carry(carrry0), // carry indicator for counter to next stage 
.clk(clk), // global clock signal 
.rst(rst), // high active reset 
.rst_fsm(rst_fsm),
.increase(increase_enable), // increase input from previous stage of counter 
.init_value(0), // initial value for the counter 
.limit(`BCD_NINE), // limit for the counter 
.en(1) // enable/disable of the counter
);

upcounter Udc1(.value(digit1), // counter value 
.carry(carrry1), // carry indicator for counter to next stage 
.clk(clk), // global clock signal 
.rst(rst), // high active reset 
.rst_fsm(rst_fsm),
.increase(carrry0), // increase input from previous stage of counter 
.init_value(0), // initial value for the counter 
.limit(`BCD_FIVE), // limit for the counter 
.en(1) // enable/disable of the counter
);

upcounter Udc2(.value(digit2), // counter value 
.carry(carrry2), // carry indicator for counter to next stage 
.clk(clk), // global clock signal 
.rst(rst), // high active reset 
.rst_fsm(rst_fsm),
.increase(carrry1), // increase input from previous stage of counter 
.init_value(0), // initial value for the counter 
.limit(`BCD_NINE), // limit for the counter 
.en(1) // enable/disable of the counter
);

upcounter Udc3(.value(digit3), // counter value 
.carry(carrry3), // carry indicator for counter to next stage 
.clk(clk), // global clock signal 
.rst(rst), // high active reset 
.rst_fsm(rst_fsm),
.increase(carrry2), // increase input from previous stage of counter 
.init_value(0), // initial value for the counter 
.limit(`BCD_FIVE), // limit for the counter 
.en(1) // enable/disable of the counter
);
endmodule

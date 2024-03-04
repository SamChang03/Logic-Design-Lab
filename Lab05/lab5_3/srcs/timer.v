module timer(
digit3, // 4nd digit of the down counter
digit2, // 3nd digit of the down counter
digit1, // 2nd digit of the down counter
digit0, // 1st digit of the down counter
digit3_initial, // 4nd digit of the down counter
digit2_initial, // 3nd digit of the down counter
digit1_initial, // 2nd digit of the down counter
digit0_initial, // 1st digit of the down counter
clk, // global clock
rst, // active high reset
rst_fsm,
en, // enable/disable for stopwatch
set
);

output [3:0] digit3; 
output [3:0] digit2; 
output [3:0] digit1; 
output [3:0] digit0; 
input clk; // global clock
input rst; // active high reset
input rst_fsm;
input en; // enable/disable for stopwatch
input set;
input [3:0] digit3_initial,digit2_initial,digit1_initial,digit0_initial;

wire borrow0, borrow1,borrow2, borrow3; // borrow indicator
wire decrease_enable; 


assign decrease_enable = en && (~((digit0==4'd0) && (digit1==4'd0) 
                         && (digit2==4'd0) &&(digit3==4'd0)));

// down counter
downcounter  Udc0( 
.value(digit0), // counter value 
.borrow(borrow0), // borrow indicator for counter to next stage 
.clk(clk), // global clock signal 
.rst(rst), // high active reset 
.rst_fsm(rst_fsm),
.decrease(decrease_enable), // decrease input from previous stage of counter 
.init_value(digit0_initial), // initial value for the counter 
.limit(4'd9), // limit for the counter 
.en(1) // enable/disable of the counter
,.set(set)
);

downcounter Udc1(.value(digit1), // counter value 
.borrow(borrow1), // borrow indicator for counter to next stage 
.clk(clk), // global clock signal 
.rst(rst), // high active reset 
.rst_fsm(rst_fsm),
.decrease(borrow0), // decrease input from previous stage of counter 
.init_value(digit1_initial), // initial value for the counter 
.limit(4'd5), // limit for the counter 
.en(1) // enable/disable of the counter
,.set(set)
);

downcounter Udc2(.value(digit2), // counter value 
.borrow(borrow2), // borrow indicator for counter to next stage 
.clk(clk), // global clock signal 
.rst(rst), // high active reset 
.rst_fsm(rst_fsm),
.decrease(borrow1), // decrease input from previous stage of counter 
.init_value(digit2_initial), // initial value for the counter 
.limit(4'd9), // limit for the counter 
.en(1), // enable/disable of the counter
.set(set)
);

downcounter Udc3(.value(digit3), // counter value 
.borrow(borrow3), // borrow indicator for counter to next stage 
.clk(clk), // global clock signal 
.rst(rst), // high active reset 
.rst_fsm(rst_fsm),
.decrease(borrow2), // decrease input from previous stage of counter 
.init_value(digit3_initial), // initial value for the counter 
.limit(4'd5), // limit for the counter 
.en(1) // enable/disable of the counter
,.set(set)
);
endmodule
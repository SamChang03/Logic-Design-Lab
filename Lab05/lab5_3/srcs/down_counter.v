module downcounter(value,borrow,clk,rst,rst_fsm,decrease,init_value,limit,en,set);
output [3:0] value; // counter value
output borrow; // borrow indicator for counter to next stage
input clk; // global clock
input rst; // active high reset
input rst_fsm;
input decrease; // decrease input from previous stage of counter
input [3:0] init_value; // initial value for the counter
input [3:0] limit; // limit for the counter
input en; // enable/disable of the counter
input set;
reg [3:0] value; // output (in always block)
reg [3:0] value_tmp; // input to dff (in always block)
reg borrow; // borrow indicator for counter to next stage

// Combinational logics
always @(value or decrease or en or limit)begin
if (value==0 && decrease && en)
begin
value_tmp = limit;
borrow = 1;
end

else if (decrease && en) 
begin
value_tmp = value -1;
borrow = 0;
end

else if (en)
begin
value_tmp = value;
borrow = 0;
end

else
begin
value_tmp = 4'd0;
borrow = 0;
end

end
// register part for BCD counter
always @(posedge clk or negedge rst or posedge rst_fsm) 
if (~rst || rst_fsm || set) 
value <= init_value; 
else 
value <= value_tmp;
endmodule
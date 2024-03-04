`include "global.v"
module upcounter(value,carry,clk,rst,rst_fsm,increase,init_value,limit,en);
output [`BCD_BIT_WIDTH-1:0] value; // counter value
output carry; // borrow indicator for counter to next stage
input clk; // global clock
input rst; // active high reset
input rst_fsm;
input increase; // decrease input from previous stage of counter
input [`BCD_BIT_WIDTH-1:0] init_value; // initial value for the counter
input [`BCD_BIT_WIDTH-1:0] limit; // limit for the counter
input en; // enable/disable of the counter
reg [`BCD_BIT_WIDTH-1:0] value; // output (in always block)
reg [`BCD_BIT_WIDTH-1:0] value_tmp; // input to dff (in always block)
reg carry; // borrow indicator for counter to next stage

// Combinational logics
always @(value or increase or en or limit)begin
if (value==limit && increase && en)
begin
value_tmp = `BCD_ZERO;
carry = `ENABLED;
end

else if (increase && en) 
begin
value_tmp = value + `INCREMENT;
carry = `DISABLED;
end

else if (en)
begin
value_tmp = value;
carry = `DISABLED;
end

else
begin
value_tmp = limit;
carry = `DISABLED;
end

end
// register part for BCD counter
always @(posedge clk or posedge rst or posedge rst_fsm) 
if (rst || rst_fsm) 
value <= init_value; 
else 
value <= value_tmp;
endmodule
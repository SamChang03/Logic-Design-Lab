module upcounter(value,carry,signal,rst,increase,init_value,limit,en);
output [3:0] value; // counter value
output carry; // borrow indicator for counter to next stage
input signal; // global clock
input rst; // active high reset
input increase; // decrease input from previous stage of counter
input [3:0] init_value; // initial value for the counter
input [3:0] limit; // limit for the counter
input en; // enable/disable of the counter
reg [3:0] value; // output (in always block)
reg [3:0] value_tmp; // input to dff (in always block)
reg carry; // borrow indicator for counter to next stage

// Combinational logics
always @(value or increase or en or limit)begin
if (value==limit && increase && en)
begin
value_tmp = 4'd0;
carry = 1;
end

else if (increase && en) 
begin
value_tmp = value + 1;
carry = 0;
end

else if (en)
begin
value_tmp = value;
carry = 0;
end

else
begin
value_tmp = limit;
carry = 0;
end

end
// register part for BCD counter
always @(posedge signal or negedge rst) 
if (~rst) 
value <= init_value; 
else 
value <= value_tmp;
endmodule
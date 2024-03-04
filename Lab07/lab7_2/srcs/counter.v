module counter(value,carry,borrow,signal_up,signal_down,rst,increase,decrease,init_value,limit,en_up,en_down);
output [3:0] value; // counter value
output reg carry,borrow;
input signal_up; // global clock
input signal_down; // global clock
input increase,decrease;
input rst; // active high reset
input [3:0] init_value; // initial value for the counter
input [3:0] limit; // limit for the counter
input en_up; // enable/disable of the counter
input en_down; // enable/disable of the counter

reg [3:0] value; // output (in always block)
reg [3:0] value_tmp_up,value_tmp_down; // input to dff (in always block)


// Combinational logics
always @(value or increase or decrease) begin
    if (value==limit && increase && en_up)
    begin
    value_tmp_up = 4'd0;
    value_tmp_down = value - 1;
    carry = 1;
    borrow = 0;
    end

    else if (value==4'd0 && decrease && en_down)
    begin
    value_tmp_up = value + 1;
    value_tmp_down = limit;
    carry = 0;
    borrow = 1;
    end

    else if ((increase && en_up) && (decrease && en_down)) 
    begin
    value_tmp_up = value + 1;
    value_tmp_down = value - 1;
    carry = 0;
    borrow = 0;
    end

    else if (en_up || en_down)
    begin
    value_tmp_up = value;
    value_tmp_down = value;
    carry = 0;
    borrow = 0;
    end

    else
    begin
    value_tmp_up = value;
    value_tmp_down = value;
    carry = 0;
    borrow = 0;
    end
end

// register part for BCD counter
always @(posedge signal_up or negedge rst) 
if (~rst) 
value<= init_value; 
else
value <= value_tmp_up;

/*always @(posedge signal_down or negedge rst) 
if (~rst) 
value <= init_value; 
else
value <= value_tmp_down;
*/
endmodule
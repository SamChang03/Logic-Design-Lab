`include "global.v"
module upcounter(
  output reg [`BCD_BIT_WIDTH-1:0] q, // counter value
  output reg time_carry, // counter carry indicator
  input count_enable, // counting enabled control signal
  input load_value_enable, // load setting value control
  input [`BCD_BIT_WIDTH-1:0] load_value, // value to be loaded
  input [`BCD_BIT_WIDTH-1:0] count_limit, // top boundary of the counter
  input clk, // clock
  input rst_n // low active reset
);

reg [`BCD_BIT_WIDTH-1:0] q_next;

// Counter registers
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    q <= `BCD_BIT_WIDTH'b0;
  else
    q <= q_next;

// next state of counter 
always @*
begin
  q_next = q;
  time_carry = `DISABLED;
  if (load_value_enable)
    q_next = load_value;
  else if (count_enable && q == count_limit)
  begin
    q_next = `ZERO;
    time_carry = `ENABLED;
  end
  else if (count_enable)
    q_next = q + `ONE;
end

endmodule

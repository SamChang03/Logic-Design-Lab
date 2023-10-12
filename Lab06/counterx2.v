module counterx2(
  output reg [3:0] q, // counter value
  output reg time_carry, // counter carry
  input count_enable, // counting enabled control signal
  input load_value_enable, // load setting value control
  input [3:0] load_value, // value to be loaded
  input [3:0] count_limit, // limit of the up counter
  input clk, // clock
  input rst_n, // low active reset
  input [3:0] cond
);

reg [3:0] q_next;
reg initialvalue;
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    q <= 4'b1;
  else
    q <= q_next;

always @*
begin
  if(cond ==4'd3||(count_limit==8 && cond ==4'd2)||(count_limit==2 &&cond ==4'd1))
    initialvalue = 1;
  else
    initialvalue = 0;
  
  q_next = q;
  time_carry = 0;
  if (load_value_enable)
    q_next = load_value;
  else if (count_enable && q == count_limit)
  begin
    q_next = initialvalue;
    time_carry = 1;
  end
  else if (count_enable)
    q_next = q + 1;
end
endmodule

`include "global.v"
module unitset(
  output [`BCD_BIT_WIDTH-1:0] q0,
  output [`BCD_BIT_WIDTH-1:0] q1,
  output [`BCD_BIT_WIDTH-1:0] q2,
  output [`BCD_BIT_WIDTH-1:0] q3,
  output [`BCD_BIT_WIDTH-1:0] q4,
  output [`BCD_BIT_WIDTH-1:0] q5,
  output [`BCD_BIT_WIDTH-1:0] q6,
  output [`BCD_BIT_WIDTH-1:0] q7,
  output [`BCD_BIT_WIDTH-1:0] q8,
  output [`BCD_BIT_WIDTH-1:0] q9,
  output [`BCD_BIT_WIDTH-1:0] q10,
  output [`BCD_BIT_WIDTH-1:0] q11,
  input [5:0] count_enable,
  input load_value_enable,
  input [`BCD_BIT_WIDTH-1:0] load_value_q0,
  input [`BCD_BIT_WIDTH-1:0] load_value_q1,
  input [`BCD_BIT_WIDTH-1:0] load_value_q2,
  input [`BCD_BIT_WIDTH-1:0] load_value_q3,
  input [`BCD_BIT_WIDTH-1:0] load_value_q4,
  input [`BCD_BIT_WIDTH-1:0] load_value_q5,
  input [`BCD_BIT_WIDTH-1:0] load_value_q6,
  input [`BCD_BIT_WIDTH-1:0] load_value_q7,
  input [`BCD_BIT_WIDTH-1:0] load_value_q8,
  input [`BCD_BIT_WIDTH-1:0] load_value_q9,
  input [`BCD_BIT_WIDTH-1:0] load_value_q10,
  input [`BCD_BIT_WIDTH-1:0] load_value_q11,
  input clk,
  input rst_n,
  input [4:0]state_in
);

reg [`BCD_BIT_WIDTH-1:0] limit0,limit1,limit2,limit3,limit4,limit5;
reg [`BCD_BIT_WIDTH-1:0] limit6,limit7,limit8,limit9,limit10,limit11;

wire carry_q0;
wire carry_q2;
wire carry_q4;
wire carry_q6;
wire carry_q8;
wire carry_q10;

always@*begin
      if(q5< 2)
        limit4=`NINE;
      else
        limit4=`THREE;
    
        limit0=`NINE;
        limit1=`FIVE;
        limit2=`NINE;
        limit3=`FIVE;
        limit5=`TWO;    
 
    case(q8+q9)
    4'd2 : begin
           limit7=4'd2;
           if(q7< 4'd2)
            limit6=4'd9;
           else
            limit6=4'd8;
           end
    4'd4 : begin
           limit7=4'd3;
           if(q7< 4'd3)
            limit6=4'd9;
           else
            limit6=0;
           end
    4'd6 : begin
           limit7=4'd3;
           if(q7< 4'd3)
            limit6=4'd9;
           else
            limit6=0;
           end
    4'd9 : begin
           limit7=4'd3;
           if(q7< 4'd3)
            limit6=4'd9;
           else
            limit6=0;
           end  
    4'd11 : begin
           limit7=4'd3;
           if(q7< 4'd3)
            limit6=4'd9;
           else
            limit6=0;
           end   
    default :begin
           limit7=4'd3;
           if(q7< 4'd3)
            limit6=4'd9;
           else
            limit6=4'd1;
           end   
    endcase
    
    if(q9==0)
        limit8=4'd9;
    else begin
        limit8=4'd2;
        limit9=`ONE;
        limit10=`NINE;
        limit11=`NINE;  
    end
end


counterx Uq0(
  .q(q0), // counter value
  .time_carry(carry_q0), // counter carry
  .count_enable(count_enable[0]), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q0), // value to be loaded
  .count_limit(limit0), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uq1(
  .q(q1), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_q0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q1), // value to be loaded
  .count_limit(limit1), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uq2(
  .q(q2), // counter value
  .time_carry(carry_q2), // counter carry
  .count_enable(count_enable[1]), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q2), // value to be loaded
  .count_limit(limit2), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uq3(
  .q(q3), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_q2), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q3), // value to be loaded
  .count_limit(limit3), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uq4(
  .q(q4), // counter value
  .time_carry(carry_q4), // counter carry
  .count_enable(count_enable[2]), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q4), // value to be loaded
  .count_limit(limit4), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uq5(
  .q(q5), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_q4), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q5), // value to be loaded
  .count_limit(limit5), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uq6(
  .q(q6), // counter value
  .time_carry(carry_q6), // counter carry
  .count_enable(count_enable[3]), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q6), // value to be loaded
  .count_limit(limit6), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uq7(
  .q(q7), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_q6), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q7), // value to be loaded
  .count_limit(limit7), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uq8(
  .q(q8), // counter value
  .time_carry(carry_q8), // counter carry
  .count_enable(count_enable[4]), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q8), // value to be loaded
  .count_limit(limit8), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uq9(
  .q(q9), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_q8), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q9), // value to be loaded
  .count_limit(limit9), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uq10(
  .q(q10), // counter value
  .time_carry(carry_q10), // counter carry
  .count_enable(count_enable[5]), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q10), // value to be loaded
  .count_limit(limit10), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uq11(
  .q(q11), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_q10), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_q11), // value to be loaded
  .count_limit(limit11), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);
endmodule

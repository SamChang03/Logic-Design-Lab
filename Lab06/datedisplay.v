module datedisplay(
  output [3:0] day0,
  output [3:0] day1,
  output [3:0] mounth0,
  output [3:0] mounth1,
  output [3:0] year0,
  output [3:0] year1,

  input count_enable,
  input load_value_enable,
  input [3:0] load_value_day0,
  input [3:0] load_value_day1,
  input [3:0] load_value_mounth0,
  input [3:0] load_value_mounth1,
  input [3:0] load_value_year0,
  input [3:0] load_value_year1,
  input clk,
  input rst_n
);

wire carry_day0, carry_day1, carry_mounth0, carry_mounth1,carry_year0;
reg [3:0] day0_limit,day1_limit,mounth_limit;

always@*begin
    case(mounth0+mounth1)
    4'd2 : begin
           day1_limit=4'd2;
           if(day1< 4'd2)
            day0_limit=4'd9;
           else
            day0_limit=4'd8;
           end
    4'd4 : begin
           day1_limit=4'd3;
           if(day1< 4'd3)
            day0_limit=4'd9;
           else
            day0_limit=0;
           end
    4'd6 : begin
           day1_limit=4'd3;
           if(day1< 4'd3)
            day0_limit=4'd9;
           else
            day0_limit=0;
           end
    4'd9 : begin
           day1_limit=4'd3;
           if(day1< 4'd3)
            day0_limit=4'd9;
           else
            day0_limit=0;
           end  
    4'd11 : begin
           day1_limit=4'd3;
           if(day1< 4'd3)
            day0_limit=4'd9;
           else
            day0_limit=0;
           end   
    default :begin
           day1_limit=4'd3;
           if(day1< 4'd3)
            day0_limit=4'd9;
           else
            day0_limit=4'd1;
           end   
    endcase
end

//dayond0 counter
counterx2 Uday0(
  .q(day0), // counter value
  .time_carry(carry_day0), // counter carry
  .count_enable(count_enable), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_day0), // value to be loaded
  .count_limit(day0_limit), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n), // low active reset
  .cond(day1)
);

//dayond1 counter
counterx Uday1(
  .q(day1), // counter value
  .time_carry(carry_day1), // counter carry
  .count_enable(carry_day0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_day1), // value to be loaded
  .count_limit(day1_limit), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

always@*begin
    if(mounth1==0)
    mounth_limit=4'd9;
    else
    mounth_limit=4'd2;
end

//mounthute0 counter
counterx2 Umounth0(
  .q(mounth0), // counter value
  .time_carry(carry_mounth0), // counter carry
  .count_enable(carry_day0 && carry_day1), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_mounth0), // value to be loaded
  .count_limit(mounth_limit), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n), // low active reset
  .cond(mounth1)
);

//mounthute1 counter
counterx Umounth1(
  .q(mounth1), // counter value
  .time_carry(carry_mounth1), // counter carry
  .count_enable(carry_day0 && carry_day1 && carry_mounth0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_mounth1), // value to be loaded
  .count_limit(4'd1), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uyear0(
  .q(year0), // counter value
  .time_carry(carry_year0), // counter carry
  .count_enable(carry_day0 && carry_day1 && carry_mounth0 && carry_mounth1), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_year0), // value to be loaded
  .count_limit(4'd9), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uyear1(
  .q(year1), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_day0 && carry_day1 && carry_mounth0 && carry_mounth1 && carry_year0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_year1), // value to be loaded
  .count_limit(4'd9), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

endmodule

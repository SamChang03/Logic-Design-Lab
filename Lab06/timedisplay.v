`include "global.v"
module timedisplay(
  output [`BCD_BIT_WIDTH-1:0] sec0,
  output [`BCD_BIT_WIDTH-1:0] sec1,
  output [`BCD_BIT_WIDTH-1:0] min0,
  output [`BCD_BIT_WIDTH-1:0] min1,
  output [`BCD_BIT_WIDTH-1:0] hour0,
  output [`BCD_BIT_WIDTH-1:0] hour1,
  output [`BCD_BIT_WIDTH-1:0] day0,
  output [`BCD_BIT_WIDTH-1:0] day1,
  output [`BCD_BIT_WIDTH-1:0] mounth0,
  output [`BCD_BIT_WIDTH-1:0] mounth1,
  output [`BCD_BIT_WIDTH-1:0] year0,
  output [`BCD_BIT_WIDTH-1:0] year1,

  input count_enable,
  input load_value_enable,
  input [`BCD_BIT_WIDTH-1:0] load_value_sec0,
  input [`BCD_BIT_WIDTH-1:0] load_value_sec1,
  input [`BCD_BIT_WIDTH-1:0] load_value_min0,
  input [`BCD_BIT_WIDTH-1:0] load_value_min1,
  input [`BCD_BIT_WIDTH-1:0] load_value_hour0,
  input [`BCD_BIT_WIDTH-1:0] load_value_hour1,
  input [`BCD_BIT_WIDTH-1:0] load_value_day0,
  input [`BCD_BIT_WIDTH-1:0] load_value_day1,
  input [`BCD_BIT_WIDTH-1:0] load_value_mounth0,
  input [`BCD_BIT_WIDTH-1:0] load_value_mounth1,
  input [`BCD_BIT_WIDTH-1:0] load_value_year0,
  input [`BCD_BIT_WIDTH-1:0] load_value_year1,
  input clk,
  input rst_n
);

wire carry_sec0, carry_sec1, carry_min0, carry_min1,carry_hour0,carry_hour1;
wire carry_day0, carry_day1,carry_mounth0, carry_mounth1,carry_year0,carry_year1;
reg [3:0]limit;
reg [3:0] day0_limit,day1_limit,mounth_limit;

//second0 counter
counterx Usec0(
  .q(sec0), // counter value
  .time_carry(carry_sec0), // counter carry
  .count_enable(count_enable), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_sec0), // value to be loaded
  .count_limit(`NINE), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//second1 counter
counterx Usec1(
  .q(sec1), // counter value
  .time_carry(carry_sec1), // counter carry
  .count_enable(carry_sec0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_sec1), // value to be loaded
  .count_limit(`FIVE), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//minute0 counter
counterx Umin0(
  .q(min0), // counter value
  .time_carry(carry_min0), // counter carry
  .count_enable(carry_sec0 && carry_sec1), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_min0), // value to be loaded
  .count_limit(`NINE), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

//minute1 counter
counterx Umin1(
  .q(min1), // counter value
  .time_carry(carry_min1), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_min1), // value to be loaded
  .count_limit(`FIVE), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);
always@*begin
    if(hour1< 2)
    limit=`NINE;
    else
    limit=`THREE;
end

counterx Uhour0(
  .q(hour0), // counter value
  .time_carry(carry_hour0), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0 && carry_min1), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_hour0), // value to be loaded
  .count_limit(limit), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uhour1(
  .q(hour1), // counter value
  .time_carry(carry_hour1), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0 && carry_min1 && carry_hour0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_hour1), // value to be loaded
  .count_limit(`TWO), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

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
  .count_enable(carry_sec0 && carry_sec1 && carry_min0 
                && carry_min1 && carry_hour0 && carry_hour1), // counting enabled control signal
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
  .count_enable(carry_sec0 && carry_sec1 && carry_min0   
              && carry_min1 && carry_hour0 && carry_hour1 && carry_day0), // counting enabled control signal
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
  .count_enable(carry_sec0 && carry_sec1 && carry_min0 && carry_min1 
                && carry_hour0 && carry_hour1 && carry_day0 && carry_day1), // counting enabled control signal
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
  .count_enable(carry_sec0 && carry_sec1 && carry_min0 && carry_min1 
                && carry_hour0 && carry_hour1 && carry_day0 && carry_day1 && carry_mounth0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_mounth1), // value to be loaded
  .count_limit(4'd1), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uyear0(
  .q(year0), // counter value
  .time_carry(carry_year0), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0 && carry_min1 
                && carry_hour0 && carry_hour1 && carry_day0 && carry_day1 
                && carry_mounth0 && carry_mounth1), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_year0), // value to be loaded
  .count_limit(4'd9), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

counterx Uyear1(
  .q(year1), // counter value
  .time_carry(), // counter carry
  .count_enable(carry_sec0 && carry_sec1 && carry_min0 && carry_min1
                && carry_hour0 && carry_hour1 && carry_day0 && carry_day1 
                && carry_mounth0 && carry_mounth1 && carry_year0), // counting enabled control signal
  .load_value_enable(load_value_enable), // load setting value control
  .load_value(load_value_year1), // value to be loaded
  .count_limit(4'd9), // limit of the up counter
  .clk(clk), // clock
  .rst_n(rst_n) // low active reset
);

endmodule

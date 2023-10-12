`include "global.v"
module alarm(
  output reg [9:0] led,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_sec0,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_sec1,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_min0,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_min1,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_hour0,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_hour1,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_day0,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_day1,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_mounth0,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_mounth1,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_year0,
  output reg [`BCD_BIT_WIDTH-1:0] alarm_year1,
  input [`BCD_BIT_WIDTH-1:0] time_sec0,
  input [`BCD_BIT_WIDTH-1:0] time_sec1,
  input [`BCD_BIT_WIDTH-1:0] time_min0,
  input [`BCD_BIT_WIDTH-1:0] time_min1,
  input  [`BCD_BIT_WIDTH-1:0] time_hour0,
  input  [`BCD_BIT_WIDTH-1:0] time_hour1,
  input  [`BCD_BIT_WIDTH-1:0] time_day0,
  input  [`BCD_BIT_WIDTH-1:0] time_day1,
  input  [`BCD_BIT_WIDTH-1:0] time_mounth0,
  input  [`BCD_BIT_WIDTH-1:0] time_mounth1,
  input  [`BCD_BIT_WIDTH-1:0] time_year0,
  input  [`BCD_BIT_WIDTH-1:0] time_year1,
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
  input alarm_enable,
  input clk,
  input rst_n
);

reg [`BCD_BIT_WIDTH-1:0] alarm_sec0_next, alarm_sec1_next, alarm_min0_next, alarm_min1_next
                        ,alarm_hour0_next,alarm_hour1_next,alarm_day0_next,alarm_day1_next,
                        alarm_mounth0_next,alarm_mounth1_next,alarm_year0_next,alarm_year1_next;

always @(posedge clk or negedge rst_n)
  if (~rst_n)
  begin
    alarm_sec0 <= 4'd0;
    alarm_sec1 <= 4'd0;
    alarm_min0 <= 4'd0;
    alarm_min1 <= 4'd0;
    alarm_hour0<= 4'd0;
    alarm_hour1<= 4'd0;
    alarm_day0<= 4'd0;
    alarm_day1<= 4'd0;
    alarm_mounth0<= 4'd0;
    alarm_mounth1<= 4'd0;
    alarm_year0<= 4'd0;
    alarm_year1<= 4'd0;
  end
  else
  begin
    alarm_sec0 <= alarm_sec0_next;
    alarm_sec1 <= alarm_sec1_next;
    alarm_min0 <= alarm_min0_next;
    alarm_min1 <= alarm_min1_next;
    alarm_hour0<= alarm_hour0_next;
    alarm_hour1<= alarm_hour1_next;
    alarm_day0<= alarm_day0_next;
    alarm_day1<= alarm_day1_next;
    alarm_mounth0<= alarm_mounth0_next;
    alarm_mounth1<= alarm_mounth1_next;
    alarm_year0<= alarm_year0_next;
    alarm_year1<= alarm_year1_next;
  end

always @*
  if (load_value_enable)
  begin
    alarm_sec0_next = load_value_sec0;
    alarm_sec1_next = load_value_sec1;
    alarm_min0_next = load_value_min0;
    alarm_min1_next = load_value_min1;
    alarm_hour0_next= load_value_hour0;
    alarm_hour1_next= load_value_hour1;
    alarm_day0_next= load_value_day0;
    alarm_day1_next= load_value_day1;
    alarm_mounth0_next= load_value_mounth0;
    alarm_mounth1_next= load_value_mounth1;
    alarm_year0_next= load_value_year0;
    alarm_year1_next= load_value_year1;
  end
  else 
  begin
    alarm_sec0_next = alarm_sec0;
    alarm_sec1_next = alarm_sec1;
    alarm_min0_next = alarm_min0;
    alarm_min1_next = alarm_min1;
    alarm_hour0_next= alarm_hour0;
    alarm_hour1_next= alarm_hour1;
    alarm_day0_next= alarm_day0;
    alarm_day1_next= alarm_day1;
    alarm_mounth0_next= alarm_mounth0;
    alarm_mounth1_next= alarm_mounth1;
    alarm_year0_next= alarm_year0;
    alarm_year1_next= alarm_year1;
  end

always @*
  if (alarm_enable && (alarm_sec0 == time_sec0) 
      && (alarm_sec1 == time_sec1)&& (alarm_min0 == time_min0)
      && (alarm_min1 == time_min1) && (alarm_hour0 == time_hour0) 
      && (alarm_hour1 == time_hour1)&& (alarm_mounth0 == time_mounth0)
      && (alarm_mounth1 == time_mounth1) && (alarm_day0 == time_day0) 
      && (alarm_day1 == time_day1)&& (alarm_year0 == time_year0)
      && (alarm_year1 == time_year1))
    led = 10'b11_1111_1111; 
  else
    led = 10'd0;

endmodule

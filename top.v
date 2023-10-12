`include "global.v"
module t2(
  output [15:0] led,
  output  [`SSD_BIT_WIDTH-1:0] segs,  // 7-segment display
  output  [`SSD_NUM-1:0] ssd_ctl, // scan control for 7-segment display
  input mode,
  input mode_long,
  input switch,
  input display_ctl,
  input freeze_ctl,
  input  clk,  // clock from oscillator
  input  rst_n  // active low reset
);

wire clk_1, clk_2k,clk_100; //divided clock
wire data_load_enable, reg_load_enable;
wire alarm_enable;
wire rst_stw;
wire [5:0] set_min_sec;
reg [`BCD_BIT_WIDTH-1:0] sec0, sec1,min0, min1,hour0,hour1; // Binary counter output
reg [`BCD_BIT_WIDTH-1:0] day0, day1,mounth0, mounth1,year0,year1;
wire [`BCD_BIT_WIDTH-1:0] ssd_in;
wire [`BCD_BIT_WIDTH-1:0] time_sec0, time_sec1,time_min0, time_min1,time_hour0,time_hour1; // Binary counter output
wire [`BCD_BIT_WIDTH-1:0] time_day0, time_day1,time_mounth0, time_mounth1,time_year0,time_year1;
wire [`BCD_BIT_WIDTH-1:0] stopwatch_sec0, stopwatch_sec1, stopwatch_min0, stopwatch_min1; // Binary counter output
reg [`BCD_BIT_WIDTH-1:0] stopwatch_sec0_out, stopwatch_sec1_out, stopwatch_min0_out, stopwatch_min1_out;
wire [`BCD_BIT_WIDTH-1:0] alarm_sec0, alarm_sec1,alarm_min0, alarm_min1,alarm_hour0,alarm_hour1; // Binary counter output
wire [`BCD_BIT_WIDTH-1:0] alarm_day0, alarm_day1,alarm_mounth0, alarm_mounth1,alarm_year0,alarm_year1; // Binary counter output
wire [`BCD_BIT_WIDTH-1:0] reg_q0, reg_q1, reg_q2, reg_q3,reg_q4, reg_q5; // Binary counter 
wire [`BCD_BIT_WIDTH-1:0] reg_q6, reg_q7, reg_q8, reg_q9,reg_q10, reg_q11; // Binary counter 
reg [`BCD_BIT_WIDTH-1:0] reg_load_q0, reg_load_q1, reg_load_q2, reg_load_q3,reg_load_q4, reg_load_q5; // Binary counter 
reg [`BCD_BIT_WIDTH-1:0] reg_load_q6, reg_load_q7, reg_load_q8, reg_load_q9,reg_load_q10, reg_load_q11; // Binary counter 
reg [`BCD_BIT_WIDTH-1:0] sec0_latch,sec1_latch, min0_latch, min1_latch,hour0_latch,hour1_latch;
reg [`BCD_BIT_WIDTH-1:0] day0_latch, day1_latch,mounth0_latch, mounth1_latch,year0_latch,year1_latch;
reg [5:0]count_enable;
wire display_pulse;
wire [4:0] state;
wire [4:0] state_led;
wire [9:0] alarm_led;
wire [3:0] in0,in1,in2,in3;
wire freeze_enable;
wire mode_pulse, mode_long_pulse,switch_pulse, 
     display_ctl_pulse,freeze_ctl_pulse;


assign led = {state_led,alarm_led,alarm_enable};

one_pulse U0(.out(mode_pulse),.in(mode),.rst(rst_n),.clk(clk_100));
one_pulse U1(.out(mode_long_pulse),.in(mode_long),.rst(rst_n),.clk(clk_100));
one_pulse U2(.out(switch_pulse),.in(switch),.rst(rst_n),.clk(clk_100));
one_pulse U3(.out(display_ctl_pulse),.in(display_ctl),.rst(rst_n),.clk(clk_100));
one_pulse U4(.out(freeze_ctl_pulse),.in(freeze_ctl),.rst(rst_n),.clk(clk_100));

// clock generator
clock_generator Uclkgen(
  .clk_1(clk_1), // generated 1 Hz clock
  .clk_100(clk_100), // generated 100 Hz clock
  .clk_2k(clk_2k), // generated 100 Hz clock
  .clk(clk), // clock from crystal
  .rst_n(rst_n) // active low reset
);

// Time Display Counter
timedisplay Utd(
  .sec0(time_sec0),
  .sec1(time_sec1),
  .min0(time_min0),
  .min1(time_min1),
  .hour0(time_hour0),
  .hour1(time_hour1),
  .day0(time_day0),
  .day1(time_day1),
  .mounth0(time_mounth0),
  .mounth1(time_mounth1),
  .year0(time_year0),
  .year1(time_year1),
  .count_enable(`ENABLED),
  .load_value_enable(data_load_enable & (state[4:3] == `TIME)),
  .load_value_sec0(reg_q0),
  .load_value_sec1(reg_q1),
  .load_value_min0(reg_q2),
  .load_value_min1(reg_q3),
  .load_value_hour0(reg_q4),
  .load_value_hour1(reg_q5),
  .load_value_day0(reg_q6),
  .load_value_day1(reg_q7),
  .load_value_mounth0(reg_q8),
  .load_value_mounth1(reg_q9),
  .load_value_year0(reg_q10),
  .load_value_year1(reg_q11),
  .clk(clk_1),
  .rst_n(rst_n)
);


// Stopwatch
stopwatch Ustw(
  .sec0(stopwatch_sec0), // counter value
  .sec1(stopwatch_sec1), // counter value
  .min0(stopwatch_min0), // counter value
  .min1(stopwatch_min1), // counter value
  .count_enable(stopwatch_count_enable), // counting enabled control signal
  .load_value_enable(data_load_enable & (state[4:3] == `STW)), // load setting value control
  .load_value_sec0(reg_q0), // value to be loaded
  .load_value_sec1(reg_q1), // value to be loaded
  .load_value_min0(reg_q2), // value to be loaded
  .load_value_min1(reg_q3), // value to be loaded
  .clk(clk_1), // clock
  .rst_n(rst_n) // low active reset
);

always @(posedge clk or negedge rst_n or negedge rst_stw) 
if (~rst_n || ~rst_stw) begin 
stopwatch_sec0_out <= 4'd0; 
stopwatch_sec1_out <= 4'd0; 
stopwatch_min0_out <= 4'd0; 
stopwatch_min1_out <= 4'd0; 
end

else begin 
stopwatch_sec0_out <= sec0_latch; 
stopwatch_sec1_out <= sec1_latch; 
stopwatch_min0_out<= min0_latch; 
stopwatch_min1_out <= min1_latch; 
end

// Whether the display is freezed
always @* begin
if (freeze_enable) begin 
sec0_latch = stopwatch_sec0_out; 
sec1_latch = stopwatch_sec1_out;
min0_latch = stopwatch_min0_out; 
min1_latch = stopwatch_min1_out;
end 

else 
begin 
sec0_latch = stopwatch_sec0;
sec1_latch = stopwatch_sec1; 
min0_latch = stopwatch_min0; 
min1_latch = stopwatch_min1; 
end
end

// Alarm
alarm(
  .led(alarm_led),
  .alarm_sec0(alarm_sec0),
  .alarm_sec1(alarm_sec1),
  .alarm_min0(alarm_min0),
  .alarm_min1(alarm_min1),
  .alarm_hour0(alarm_hour0),
  .alarm_hour1(alarm_hour1),
  .alarm_day0(alarm_day0),
  .alarm_day1(alarm_day1),
  .alarm_mounth0(alarm_mounth0),
  .alarm_mounth1(alarm_mounth1),
  .alarm_year0(alarm_year0),
  .alarm_year1(alarm_year1),
  .time_sec0(time_sec0),
  .time_sec1(time_sec1),
  .time_min0(time_min0),
  .time_min1(time_min1),
  .time_hour0(time_hour0),
  .time_hour1(time_hour1),
  .time_day0(time_day0),
  .time_day1(time_day1),
  .time_mounth0(time_mounth0),
  .time_mounth1(time_mounth1),
  .time_year0(time_year0),
  .time_year1(time_year1),
  .load_value_enable(data_load_enable & (state[4:3] == `ALM)),
  .load_value_sec0(reg_q0),
  .load_value_sec1(reg_q1),
  .load_value_min0(reg_q2),
  .load_value_min1(reg_q3),
  .load_value_hour0(reg_q4),
  .load_value_hour1(reg_q5),
  .load_value_day0(reg_q6),
  .load_value_day1(reg_q7),
  .load_value_mounth0(reg_q8),
  .load_value_mounth1(reg_q9),
  .load_value_year0(reg_q10),
  .load_value_year1(reg_q11),
  .alarm_enable(alarm_enable),
  .clk(clk_1),
  .rst_n(rst_n)
);

// FSM
fsm Ufsm(
  .state_led(state_led),
  .set_enable(set_enable),
  .stopwatch_count_enable(stopwatch_count_enable),
  .freeze_enable(freeze_enable),
  .data_load_enable(data_load_enable),
  .reg_load_enable(reg_load_enable),
  .alarm_enable(alarm_enable),
  .set_min_sec(set_min_sec),
  .state(state),
  .rst_stw(rst_stw),
  .mode(mode_pulse),
  .mode_long(mode_long_pulse),
  .switch(switch_pulse),
  .freeze_ctl(freeze_ctl_pulse),
  .clk(clk_100),
  .rst_n(rst_n)
);

// Selection which data to load to setting register
always @*
  case (state[4:3])
  `TIME:
    begin
      reg_load_q0 = time_sec0;
      reg_load_q1 = time_sec1;
      reg_load_q2 = time_min0;
      reg_load_q3 = time_min1;
      reg_load_q4 = time_hour0;
      reg_load_q5 = time_hour1;
      reg_load_q6 = time_day0;
      reg_load_q7 = time_day1;
      reg_load_q8 = time_mounth0;
      reg_load_q9 = time_mounth1;
      reg_load_q10 = time_year0;
      reg_load_q11 = time_year1;
    end
  `STW:
    begin
      reg_load_q0 = stopwatch_sec0_out;
      reg_load_q1 = stopwatch_sec1_out;
      reg_load_q2 = stopwatch_min0_out;
      reg_load_q3 = stopwatch_min1_out;
      reg_load_q4 = 0;
      reg_load_q5 = 0;
      reg_load_q6 = 0;
      reg_load_q7 = 0;
      reg_load_q8 = 0;
      reg_load_q9 = 0;
      reg_load_q10 = 0;
      reg_load_q11 = 0;
    end
  `ALM:
    begin
      reg_load_q0 = alarm_sec0;
      reg_load_q1 = alarm_sec1;
      reg_load_q2 = alarm_min0;
      reg_load_q3 = alarm_min1;
      reg_load_q4 = alarm_hour0;
      reg_load_q5 = alarm_hour1;
      reg_load_q6 = alarm_day0;
      reg_load_q7 = alarm_day1;
      reg_load_q8 = alarm_mounth0;
      reg_load_q9 = alarm_mounth1;
      reg_load_q10 = alarm_year0;
      reg_load_q11 = alarm_year1;
      
    end
  default:
    begin
      reg_load_q0 = 4'd0;
      reg_load_q1 = 4'd0;
      reg_load_q2 = 4'd0;
      reg_load_q3 = 4'd0;
      reg_load_q4 = 4'd0;
      reg_load_q5 = 4'd0;
      reg_load_q6 = 4'd0;
      reg_load_q7 = 4'd0;
      reg_load_q8 = 4'd0;
      reg_load_q9 = 4'd0;
      reg_load_q10 = 4'd0;
      reg_load_q11 = 4'd0;
    end
  endcase

always@*begin
 count_enable= {set_enable & set_min_sec[5],set_enable & set_min_sec[4],set_enable & set_min_sec[3],
                set_enable & set_min_sec[2],set_enable & set_min_sec[1],set_enable & set_min_sec[0]};
end

// Setting Registers
unitset Usreg(
  .q0(reg_q0),
  .q1(reg_q1),
  .q2(reg_q2),
  .q3(reg_q3),
  .q4(reg_q4),
  .q5(reg_q5),
  .q6(reg_q6),
  .q7(reg_q7),
  .q8(reg_q8),
  .q9(reg_q9),
  .q10(reg_q10),
  .q11(reg_q11),
  .count_enable(count_enable),
  .load_value_enable(reg_load_enable),
  .load_value_q0(reg_load_q0),
  .load_value_q1(reg_load_q1),
  .load_value_q2(reg_load_q2),
  .load_value_q3(reg_load_q3),
  .load_value_q4(reg_load_q4),
  .load_value_q5(reg_load_q5),
  .load_value_q6(reg_load_q6),
  .load_value_q7(reg_load_q7),
  .load_value_q8(reg_load_q8),
  .load_value_q9(reg_load_q9),
  .load_value_q10(reg_load_q10),
  .load_value_q11(reg_load_q11),
  .clk(clk_100),
  .rst_n(rst_n),
  .state_in(state)
);


always @*
  case (state)
  `TIME_DISP:
    begin
      sec0 = time_sec0;
      sec1 = time_sec1;
      min0 = time_min0;
      min1 = time_min1;
      hour0 = time_hour0;
      hour1 = time_hour1;
      day0 = time_day0;
      day1 = time_day1;
      mounth0 = time_mounth0;
      mounth1 = time_mounth1;
      year0 = time_year0;
      year1 = time_year1;      
    end
  `STW_DISP: 
    begin
      sec0 = stopwatch_sec0_out;
      sec1 = stopwatch_sec1_out;
      min0 = stopwatch_min0_out;
      min1 = stopwatch_min1_out;
      hour0 = 0;
      hour1 = 0;
      day0 = 0;
      day1 = 0;
      mounth0 = 0;
      mounth1 = 0;
      year0 = 0;
      year1 = 0;      
    end
   `STW_STOP: 
    begin
      sec0 = stopwatch_sec0_out;
      sec1 = stopwatch_sec1_out;
      min0 = stopwatch_min0_out;
      min1 = stopwatch_min1_out;
      hour0 = 0;
      hour1 = 0;
      day0 = 0;
      day1 = 0;
      mounth0 = 0;
      mounth1 = 0;
      year0 = 0;
      year1 = 0;      
    end   
  `STW_START:
    begin
      sec0 = stopwatch_sec0_out;
      sec1 = stopwatch_sec1_out;
      min0 = stopwatch_min0_out;
      min1 = stopwatch_min1_out;
      hour0 = 0;
      hour1 = 0;
      day0 = 0;
      day1 = 0;
      mounth0 = 0;
      mounth1 = 0;
      year0 = 0;
      year1 = 0; 
    end
  `STW_PAUSE:
    begin
      sec0 = stopwatch_sec0_out;
      sec1 = stopwatch_sec1_out;
      min0 = stopwatch_min0_out;
      min1 = stopwatch_min1_out;
      hour0 = 0;
      hour1 = 0;
      day0 = 0;
      day1 = 0;
      mounth0 = 0;
      mounth1 = 0;
      year0 = 0;
      year1 = 0; 
    end
  `STW_FREEZE:
    begin
      sec0 = stopwatch_sec0_out;
      sec1 = stopwatch_sec1_out;
      min0 = stopwatch_min0_out;
      min1 = stopwatch_min1_out;
      hour0 = 0;
      hour1 = 0;
      day0 = 0;
      day1 = 0;
      mounth0 = 0;
      mounth1 = 0;
      year0 = 0;
      year1 = 0; 
    end
  `ALM_DISP:
    begin
      sec0 = alarm_sec0;
      sec1 = alarm_sec1;
      min0 = alarm_min0;
      min1 = alarm_min1;
      hour0 = alarm_hour0;
      hour1 = alarm_hour1;
      day0 = alarm_day0;
      day1 = alarm_day1;
      mounth0 = alarm_mounth0;
      mounth1 = alarm_mounth1;
      year0 = alarm_year0;
      year1 = alarm_year1; 
    end
  `TIME_SETYEAR:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = reg_q4;
      hour1 = reg_q5;
      day0 = reg_q6;
      day1 = reg_q7;
      mounth0 = reg_q8;
      mounth1 = reg_q9;
      year0 = reg_q10;
      year1 = reg_q11;       
    end  
  `TIME_SETMOUN:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = reg_q4;
      hour1 = reg_q5;
      day0 = reg_q6;
      day1 = reg_q7;
      mounth0 = reg_q8;
      mounth1 = reg_q9;
      year0 = reg_q10;
      year1 = reg_q11;
    end
  `TIME_SETDAY:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = reg_q4;
      hour1 = reg_q5;
      day0 = reg_q6;
      day1 = reg_q7;
      mounth0 = reg_q8;
      mounth1 = reg_q9;
      year0 = reg_q10;
      year1 = reg_q11;
    end
  `TIME_SETHOUR:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = reg_q4;
      hour1 = reg_q5;
      day0 = reg_q6;
      day1 = reg_q7;
      mounth0 = reg_q8;
      mounth1 = reg_q9;
      year0 = reg_q10;
      year1 = reg_q11;
    end
  `TIME_SETMIN:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = reg_q4;
      hour1 = reg_q5;
      day0 = reg_q6;
      day1 = reg_q7;
      mounth0 = reg_q8;
      mounth1 = reg_q9;
      year0 = reg_q10;
      year1 = reg_q11;
    end
  `TIME_SETSEC:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = reg_q4;
      hour1 = reg_q5;
      day0 = reg_q6;
      day1 = reg_q7;
      mounth0 = reg_q8;
      mounth1 = reg_q9;
      year0 = reg_q10;
      year1 = reg_q11;
    end
  `STW_SETMIN:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = 0;
      hour1 = 0;
      day0 = 0;
      day1 = 0;
      mounth0 = 0;
      mounth1 = 0;
      year0 = 0;
      year1 = 0;
    end
  `STW_SETSEC:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = 0;
      hour1 = 0;
      day0 = 0;
      day1 = 0;
      mounth0 = 0;
      mounth1 = 0;
      year0 = 0;
      year1 = 0;
    end
  `ALM_SETMIN:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = reg_q4;
      hour1 = reg_q5;
      day0 = reg_q6;
      day1 = reg_q7;
      mounth0 = reg_q8;
      mounth1 = reg_q9;
      year0 = reg_q10;
      year1 = reg_q11;
    end
  `ALM_SETSEC:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = reg_q4;
      hour1 = reg_q5;
      day0 = reg_q6;
      day1 = reg_q7;
      mounth0 = reg_q8;
      mounth1 = reg_q9;
      year0 = reg_q10;
      year1 = reg_q11;
    end
 `ALM_SETHOUR:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = reg_q4;
      hour1 = reg_q5;
      day0 = reg_q6;
      day1 = reg_q7;
      mounth0 = reg_q8;
      mounth1 = reg_q9;
      year0 = reg_q10;
      year1 = reg_q11;
    end
`ALM_SETDAY:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = reg_q4;
      hour1 = reg_q5;
      day0 = reg_q6;
      day1 = reg_q7;
      mounth0 = reg_q8;
      mounth1 = reg_q9;
      year0 = reg_q10;
      year1 = reg_q11;
    end
`ALM_SETMOUN:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = reg_q4;
      hour1 = reg_q5;
      day0 = reg_q6;
      day1 = reg_q7;
      mounth0 = reg_q8;
      mounth1 = reg_q9;
      year0 = reg_q10;
      year1 = reg_q11;
    end
`ALM_SETYEAR:
    begin
      sec0 = reg_q0;
      sec1 = reg_q1;
      min0 = reg_q2;
      min1 = reg_q3;
      hour0 = reg_q4;
      hour1 = reg_q5;
      day0 = reg_q6;
      day1 = reg_q7;
      mounth0 = reg_q8;
      mounth1 = reg_q9;
      year0 = reg_q10;
      year1 = reg_q11;
    end 
  default:
    begin
      sec0 = time_sec0;
      sec1 = time_sec1;
      min0 = time_min0;
      min1 = time_min1;
      hour0 = 0;
      hour1 = 0;
      day0 = 0;
      day1 = 0;
      mounth0 = 0;
      mounth1 = 0;
      year0 = 0;
      year1 = 0; 
    end
  endcase

fsm2(.out0(in0),.out1(in1),.out2(in2),.out3(in3),
     .sec0(sec0),.sec1(sec1),.min0(min0),.min1(min1)
     ,.hour0(hour0),.hour1(hour1),
     .day0(day0),.day1(day1),.mounth0(mounth0),.mounth1(mounth1)
     ,.year0(year0),.year1(year1),
     .switch(display_ctl_pulse),.clk(clk_100),.rst_n(rst_n),.state_in(state));

// Scan control
scan_ctl U_SC(
  .ssd_ctl(ssd_ctl), // ssd display control signal
  .ssd_in(ssd_in), // output to ssd display
  .in0(in0), // 1st input
  .in1(in1), // 2nd input
  .in2(in2), // 3rd input
  .in3(in3),  // 4th input
  .ssd_ctl_en(clk_2k), // divided clock for scan control
  .rst_n(rst_n)
);

// binary to 7-segment display decoder
display U_display(
  .segs(segs), // 7-segment display output
  .bin(ssd_in)  // BCD number input
);

endmodule

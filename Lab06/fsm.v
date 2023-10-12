module fsm(
  output reg [4:0] state_led,
  output reg set_enable,
  output reg stopwatch_count_enable,
  output reg freeze_enable,
  output reg data_load_enable,
  output reg reg_load_enable,
  output reg alarm_enable,
  output reg [5:0] set_min_sec,
  output reg [4:0] state,
  output reg rst_stw,
  input mode,
  input mode_long,
  input switch,
  input freeze_ctl,
  input clk,
  input rst_n
);

reg [4:0] state_next;
wire long_press, short_press;
reg alarm_enable_next;

assign long_press = mode_long;
assign short_press = mode;

// Alarm enable register
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    alarm_enable = 1'b0;
  else
    alarm_enable = alarm_enable_next;

// state transition
always @*
begin
  set_enable = `DISABLED;
  stopwatch_count_enable = `DISABLED;
  freeze_enable= `DISABLED;
  set_min_sec = {3{`DISABLED}};
  reg_load_enable = `DISABLED;
  state_next = `TIME_DISP;
  alarm_enable_next = alarm_enable;
  state_led = state;
  rst_stw=1;
  
  case (state)
  `TIME_DISP:
    begin
      state_led = `TIME_DISP;
      data_load_enable = `DISABLED;
      if (long_press)
      begin
        state_next = `TIME_SETSEC;
        reg_load_enable = `ENABLED;
      end
      else if (short_press)
        state_next = `ALM_DISP;
      else 
        state_next = `TIME_DISP;
    end
    
  `TIME_SETSEC:
    begin
      state_led = `TIME_SETSEC;
      set_enable = switch;
      set_min_sec = `SETSEC;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `TIME_SETMIN;
      else if (long_press)
      begin
        state_next =  `TIME_DISP;
      end
      else
        state_next = `TIME_SETSEC;
    end
  
  `TIME_SETMIN:
    begin
      state_led = `TIME_SETMIN;
      set_enable = switch;
      set_min_sec = `SETMIN;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `TIME_SETHOUR;
      else if (long_press)
      begin
        state_next =  `TIME_DISP;
      end
      else
        state_next = `TIME_SETMIN;
    end
  
  `TIME_SETHOUR:
    begin
      state_led = `TIME_SETHOUR;
      set_enable = switch;
      set_min_sec = `SETHOUR;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `TIME_SETDAY;
      else if (long_press)
      begin
        state_next =  `TIME_DISP;
      end
      else
        state_next = `TIME_SETHOUR;
    end 
   `TIME_SETDAY:
    begin
      state_led = `TIME_SETDAY;
      set_enable = switch;
      set_min_sec = `SETDAY;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `TIME_SETMOUN;
      else if (long_press)
      begin
        state_next =  `TIME_DISP;
      end
      else
        state_next = `TIME_SETDAY;
    end
  `TIME_SETMOUN:
    begin
      state_led = `TIME_SETMOUN;
      set_enable = switch;
      set_min_sec = `SETMOUN;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `TIME_SETYEAR;
      else if (long_press)
      begin
        state_next =  `TIME_DISP;
      end
      else
        state_next = `TIME_SETMOUN;
    end
  `TIME_SETYEAR:
    begin
      state_led = `TIME_SETYEAR;
      set_enable = switch;
      set_min_sec = `SETYEAR;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `TIME_SETSEC;
      else if (long_press)
      begin
        state_next =  `TIME_DISP;
      end
      else
        state_next = `TIME_SETYEAR;
    end    
  `STW_DISP:
    begin
      state_led = `STW_DISP;
      freeze_enable= `DISABLED;
      data_load_enable = `DISABLED;
      
      if (long_press)
      begin
        state_next = `STW_SETSEC;
        reg_load_enable = `ENABLED;
      end
      else if (short_press)
        state_next = `TIME_DISP;
      else if (switch)
      begin
        state_next = `STW_START;
        stopwatch_count_enable = `ENABLED;
      end
      else
        state_next = `STW_DISP;
    end
  `STW_STOP:
    begin
      state_led = `STW_STOP;
      freeze_enable= `DISABLED;
      data_load_enable = `DISABLED;
      rst_stw=0;
      if (long_press)
      begin
        state_next = `STW_DISP;
      end
      else if (short_press)
        state_next = `STW_DISP;
      else
        state_next = `STW_STOP;
    end
  `STW_SETMIN:
    begin
      state_led = `STW_SETMIN;
      set_enable = switch;
      set_min_sec = `SETMIN;
      freeze_enable= `DISABLED;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `STW_SETSEC;
      else if (long_press)
      begin
        state_next =  `STW_DISP;
      end
      else
        state_next = `STW_SETMIN;
    end
  `STW_SETSEC:
    begin
      state_led = `STW_SETSEC;
      set_enable = switch;
      set_min_sec = `SETSEC;
      freeze_enable= `DISABLED;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `STW_SETMIN;
      else if (long_press)
      begin
        state_next =  `STW_DISP;
      end
      else
        state_next = `STW_SETSEC;
    end
  `STW_START:
    begin
      state_led = `STW_START;
      stopwatch_count_enable = `ENABLED;
      freeze_enable= `DISABLED;
      data_load_enable = `DISABLED;
      if (switch)
        state_next = `STW_PAUSE;
      else if(freeze_ctl)
        state_next = `STW_FREEZE;
      else
        state_next = `STW_START;
    end
  `STW_PAUSE:
    begin
      state_led = `STW_PAUSE;
      stopwatch_count_enable = `DISABLED;
      freeze_enable= `DISABLED;
      data_load_enable = `DISABLED;
      if (switch)
        state_next = `STW_START;
      else if (long_press)
        state_next = `STW_DISP;
      else if(freeze_ctl) begin
        state_next = `STW_STOP;
      end
      else
        state_next = `STW_PAUSE;
    end
  `STW_FREEZE:
    begin
      state_led = `STW_FREEZE;
      stopwatch_count_enable = `ENABLED;
      freeze_enable= `ENABLED;
      data_load_enable = `DISABLED;
      if (freeze_ctl)
        state_next = `STW_START;
      else if (long_press)
        state_next = `STW_DISP;
      else
        state_next = `STW_FREEZE;
    end
  `ALM_DISP:
    begin
      state_led = `ALM_DISP;
      data_load_enable = `DISABLED;
      if (long_press)
      begin
        state_next = `ALM_SETSEC;
        reg_load_enable = `ENABLED;
      end
      else if (short_press)
        state_next = `STW_DISP;
      else if (switch)
      begin
        state_next = `ALM_DISP;
        alarm_enable_next = ~ alarm_enable;
      end
      else
        state_next = `ALM_DISP;
    end
    `ALM_SETYEAR:
    begin
      state_led = `ALM_SETYEAR;
      set_enable = switch;
      set_min_sec = `SETYEAR;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `ALM_SETSEC;
      else if (long_press)
      begin
        state_next =  `ALM_DISP;
      end
      else
        state_next = `ALM_SETYEAR;
    end
    `ALM_SETMOUN:
    begin
      state_led = `ALM_SETMOUN;
      set_enable = switch;
      set_min_sec = `SETMOUN;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `ALM_SETYEAR;
      else if (long_press)
      begin
        state_next =  `ALM_DISP;
      end
      else
        state_next = `ALM_SETMOUN;
    end
    `ALM_SETDAY:
    begin
      state_led = `ALM_SETDAY;
      set_enable = switch;
      set_min_sec = `SETDAY;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `ALM_SETMOUN;
      else if (long_press)
      begin
        state_next =  `ALM_DISP;
      end
      else
        state_next = `ALM_SETDAY;
    end
  `ALM_SETHOUR:
    begin
      state_led = `ALM_SETHOUR;
      set_enable = switch;
      set_min_sec = `SETHOUR;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `ALM_SETDAY;
      else if (long_press)
      begin
        state_next =  `ALM_DISP;
      end
      else
        state_next = `ALM_SETHOUR;
    end    

  `ALM_SETMIN:
    begin
      state_led = `ALM_SETMIN;
      set_enable = switch;
      set_min_sec = `SETMIN;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `ALM_SETHOUR;
      else if (long_press)
      begin
        state_next =  `ALM_DISP;
      end
      else
        state_next = `ALM_SETMIN;
    end
  `ALM_SETSEC:
    begin
      state_led = `ALM_SETSEC;
      set_enable = switch;
      set_min_sec = `SETSEC;
      data_load_enable = `ENABLED;
      if (short_press)
        state_next = `ALM_SETMIN;
      else if (long_press)
      begin
        state_next =  `ALM_DISP;
      end
      else
        state_next = `ALM_SETSEC;
    end
  endcase
end

// state register
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    state <=5'b0;
  else
    state <= state_next;    

endmodule

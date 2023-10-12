module fsm2(
  output reg [3:0] out0,
  output reg [3:0] out1,
  output reg [3:0] out2,
  output reg [3:0] out3,
  
  input [3:0] sec0,
  input [3:0] sec1,
  input [3:0] min0,
  input [3:0] min1,
  input [3:0] hour0,
  input [3:0] hour1,
  input [3:0] day0,
  input [3:0] day1,
  input [3:0] mounth0,
  input [3:0] mounth1,
  input [3:0] year0,
  input [3:0] year1, 
  input switch,
  input clk,
  input rst_n,
  input [4:0]state_in
);

reg [4:0] state_next;
reg [1:0] press_count; 
wire [1:0] press_count_next;
reg switch_delay;
wire short_press;
reg alarm_enable_next;
reg [1:0]state;

//  Counter for press time
assign short_press= switch;

// state transition
always @*
begin
if(state_in[4:3]== `TIME || state_in[4:3]== `ALM)begin  
  case (state)
  2'b00 : begin
            out0=sec0 ;
            out1=sec1 ;
            out2=min0 ;
            out3=min1 ;
            if(short_press)
            state_next = 2'b01;
            else
            state_next = 2'b00;
            end
  2'b01 : begin
            out0=hour0 ;
            out1=hour1 ;
            out2=day0 ;
            out3=day1 ;
            if(short_press)
            state_next = 2'b10;
            else
            state_next = 2'b01;
            end
  2'b10 : begin
            out0=mounth0 ;
            out1=mounth1 ;
            out2=year0 ;
            out3=year1 ;
            if(short_press)
            state_next = 2'b00;
            else
            state_next = 2'b10;
            end
  default :
           begin
            out0=sec0 ;
            out1=sec1 ;
            out2=min0 ;
            out3=min1 ;
            if(short_press)
            state_next = 3'b01;
            else
            state_next = 3'b00;
            end
  endcase
end

else begin
            out0=sec0 ;
            out1=sec1 ;
            out2=min0 ;
            out3=min1 ;
end
end

// state register
always @(posedge clk or negedge rst_n)
  if (~rst_n)
    state <=2'b00;
  else
    state <= state_next;    

endmodule

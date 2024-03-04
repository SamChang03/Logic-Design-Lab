`include "global.v"
// State Definition
`define STAT_STOP 2'b00
`define STAT_COUNT 2'b01
`define STAT_FREEZE 2'b10
`define STAT_DEF 2'b11
module FSM(reset_fsm,count_enable,freeze_enable,b1,b2,clk,rst);

// outputs
output reg count_enable; 
output reg freeze_enable;
output reg reset_fsm;
// inputs
input clk; // global clock signal
input rst; // high active reset
input b1; //input control
input b2; //input control
reg [1:0] state; // state of FSM
reg [1:0] next_state; // next state of FSM



// FSM state transition
always @(posedge clk or posedge rst)
begin
if (rst) state <= `STAT_DEF; //state <= `STAT_DEF;
else state <= next_state;
end
// ************************
// Press counting
// ************************


// FSM state decision
always @(state or  b1 or b2)
case (state) 
`STAT_STOP: 
   begin
   count_enable = 0; 
   freeze_enable = 0; 
   reset_fsm=0;
   
    if (b2==0 && b1==0)
    next_state = `STAT_STOP;
    else if (b2==0 && b1==1)  
    next_state = `STAT_COUNT;
    else
    next_state = `STAT_DEF;
end
`STAT_COUNT:  begin
    count_enable = 1; 
    freeze_enable = 0; 
    reset_fsm=0;
    
    if (b2==0 && b1==1) 
    next_state = `STAT_STOP;
    else if (b2==1 && b1==0)
    next_state = `STAT_FREEZE;   
    else  
    next_state = `STAT_COUNT;
     
end
`STAT_FREEZE:  begin
    count_enable = 1; 
    freeze_enable = 1; 
    reset_fsm=0;
    
    if (b2==1)  
    next_state = `STAT_COUNT;
    else
    next_state = `STAT_FREEZE; 
end

default: begin 
    count_enable = 0; 
    freeze_enable = 0; 
    reset_fsm=1;
    if (b1==1)
    next_state = `STAT_COUNT;
    else
    next_state = `STAT_DEF;
end 
endcase
endmodule

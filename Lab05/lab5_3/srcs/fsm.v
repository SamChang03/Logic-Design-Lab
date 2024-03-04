// State Definition
`define STAT_STOP 3'b000
`define STAT_COUNT 3'b001
`define STAT_PAUSE 3'b010
`define STAT_DONE 3'b011
`define STAT_DEF 3'b100

module FSM(state,reset_fsm,count_enable,b1,b2,clk,rst);

// outputs
output reg count_enable; 
output reg reset_fsm;
output reg [2:0]state;
// inputs
input clk; // global clock signal
input rst; // high active reset
input b1; //input control
input b2; //input control

reg [2:0] next_state; // next state of FSM



// FSM state transition
always @(posedge clk or negedge rst)
begin
if (~rst) state <= `STAT_DEF; //state <= `STAT_DEF;
else state <= next_state;
end
// ************************
// Press counting
// ************************


// FSM state decision
always @(state or b1 or b2)
case (state) 
`STAT_STOP: 
   begin
   count_enable = 0; 
   reset_fsm=0;
   
    if ( b1==1)
    next_state = `STAT_DONE;
    else
    next_state = `STAT_STOP;
end
`STAT_COUNT:  begin
    count_enable = 1; 
    reset_fsm=0;
    
    if (b2==0 && b1==1) 
    next_state = `STAT_STOP;
    else if (b2==1 && b1==0)
    next_state = `STAT_PAUSE;   
    else  
    next_state = `STAT_COUNT;
     
end
`STAT_PAUSE:  begin
    count_enable = 0; 
    reset_fsm=0;
    
    if (b2==1 || b1==1)  
    next_state = `STAT_COUNT;
    else
    next_state = `STAT_PAUSE; 
end

`STAT_DONE:  begin 
    count_enable = 0; 
    reset_fsm=1;
    if (b1==1)
    next_state = `STAT_COUNT;
    else
    next_state = `STAT_DONE; 
end

default: begin 
    count_enable = 0; 
    reset_fsm=0;
    if (b1==1)
    next_state = `STAT_COUNT;
    else
    next_state = `STAT_DEF;   
end 


endcase
endmodule
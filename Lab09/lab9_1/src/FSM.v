`define run 1
`define stop 0

module FSM(
input clk_10,
input rst,
input pulse_en,
output reg enable
);

reg enable_next;
reg state,state_next;

always@(posedge pulse_en)
    case(state)
    `run: begin 
         state_next = `stop; 
         enable_next = 0;
        end
    `stop: begin 
          state_next = `run; 
          enable_next = 1; 
         end
    default: begin 
             state_next = state; 
             enable_next = enable; 
            end
    endcase
    
always@(posedge clk_10 or posedge rst)
    if(rst) begin 
            state = `stop; 
            enable <= 0; 
            end
    else begin 
        state <= state_next; 
        enable <= enable_next; 
        end
    
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/25 01:54:16
// Design Name: 
// Module Name: fsm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fsm(state,signal,clk,rst);
output reg state;
input signal;
input clk;
input rst;

reg next_state;

always@(posedge clk or posedge rst )
begin
   
  if (rst) state <= 0; 
  else state <= next_state;

end

always@(state or signal)
begin
case(state)
    1'b0 : begin if(signal==1'b1) next_state=1'b1; else next_state=1'b0; end
    1'b1 : begin if(signal==1'b1) next_state=1'b0; else next_state=1'b1; end
    default: state=0;
    endcase
end

endmodule
  /*case(state)
    1'b0 : begin if(signal==1'b1) state=1'b1; else state=1'b0; end
    1'b1 : begin if(signal==1'b1) state=1'b0; else state=1'b1; end
    default: state=0;
    endcase*/
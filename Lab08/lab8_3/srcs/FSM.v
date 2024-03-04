`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 06:06:22
// Design Name: 
// Module Name: FSM
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

`define S0 4'b0000
`define S1 4'b0001
`define S2 4'b0010
`define S3 4'b0011
`define S4 4'b0100
`define S5 4'b0101
`define S6 4'b0110
`define S7 4'b0111
`define S8 4'b1000
`define S9 4'b1001

module FSM(state,num_en,enter_en,operator_en,del_en,clk,rst);

output reg [3:0]state;
input num_en,enter_en,operator_en,del_en,clk,rst;

reg [3:0]next_state;

always@(enter_en,num_en) begin
    case(state)
    `S1: begin
         if(enter_en)
          next_state = `S0;
         else if (num_en)
          next_state = `S2;
         else
          next_state = `S1;
         end
    `S2: begin
         if(enter_en)
          next_state = `S0;
         else if (num_en)
          next_state = `S3;
         else
          next_state = `S2;
         end
    `S3: begin
         if(enter_en)
          next_state = `S0;
         else if (operator_en)
          next_state = `S4;
         else
          next_state = `S3;
         end
     `S4: begin
         if(enter_en)
          next_state = `S0;
         else if (num_en)
          next_state = `S5;
         else
          next_state = `S4;
         end
      `S5: begin
         if(enter_en)
          next_state = `S0;
         else if (num_en)
          next_state = `S6;
         else
          next_state = `S5;
         end   
     `S6: begin
         if(enter_en)
          next_state = `S0;
         else if (num_en)
          next_state = `S7;
         else
          next_state = `S6;
         end            
     `S7: begin
         if(enter_en)
          next_state = `S8;
         else
          next_state = `S7;
         end
      `S8: begin
         if(del_en)
          next_state = `S9;
         else
          next_state = `S8;
         end
      `S9: begin
         if(del_en)
          next_state = `S0;
         else
          next_state = `S9;
         end     
    default : begin
         if(enter_en)
          next_state = `S0;
         else if (num_en)
          next_state = `S1;
         else
          next_state = `S0;
         end
    endcase
end

always@(posedge clk or negedge rst)
    if(~rst)
        state = `S0;
    else 
        state = next_state;
endmodule

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

`define S0 2'b00
`define S1 2'b01
`define S2 2'b10
`define S3 2'b11

module FSM(state,num_en,enter_en,clk,rst);

output reg [1:0]state;
input num_en,enter_en,clk,rst;

reg [1:0]next_state;

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
         else if (num_en)
          next_state = `S3;
         else
          next_state = `S3;
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

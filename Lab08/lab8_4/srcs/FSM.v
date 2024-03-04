`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/23 15:04:21
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


module FSM(
    output reg cap,
    input cap_en,
    input clk,
    input rst_n
    );
    reg [1:0]state, next_state;

always@*
  case (state)
    2'b00:
      if (cap_en)
      begin
        next_state = 2'b01;
        cap = 1;
      end
      else
      begin
        next_state = 2'b00;
        cap = 0;
      end
    2'b01:
      if (cap_en)
      begin
        next_state = 2'b10;
        cap = 1;
      end
      else
      begin
        next_state = 2'b01;
        cap = 1;
      end
    2'b10:
        if (cap_en)
        begin
          next_state = 2'b11;
          cap = 0;
        end
        else
        begin
          next_state = 2'b10;
          cap = 1;
        end
    2'b11:
        if (cap_en)
          begin
            next_state = 2'b00;
            cap = 0;
          end
          else
          begin
            next_state = 2'b11;
            cap = 0;
          end
    default:
    begin
      next_state = 2'b00;
      cap = 0;
    end
  endcase

always@(posedge clk or negedge rst_n)
  if (~rst_n)
    state <= 2'b00;
  else
    state <= next_state;

endmodule

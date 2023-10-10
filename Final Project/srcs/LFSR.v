`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 08:29:01
// Design Name: 
// Module Name: LFSR
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


module LFSR(
  input clk21,
  input rst,
  output reg [7:0] random
    );
 
    
reg [7:0]random_temp;
  
always@(*)begin
    random_temp = {random[7] ^ random[6] ^ random[5] ^ random[0] ,random[7:1] };  
end
  
  always@(posedge clk21 or posedge rst)begin
      if(rst) begin
          random <= 8'b11111111;
      end
      else begin
          random <= random_temp;
      end
  end
endmodule

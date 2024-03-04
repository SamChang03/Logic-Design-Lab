`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/20 03:08:14
// Design Name: 
// Module Name: BCD_To_SSD Decoder
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

module BCD_To_SSD(q,d,SSD);
output [7:0] SSD;
output d;
input [3:0] q;
reg [3:0] d;
integer  idx ;
reg [7:0] SSD;
always@(q)
begin
for(idx=0; idx < 4; idx = idx +1) //assign 4-bit binary
    d[idx] <= q[idx];
case (q)
4'd0 : SSD<=8'b00000011;
4'd1 : SSD<=8'b10011111;
4'd2 : SSD<=8'b00100101;
4'd3 : SSD<=8'b00001101;
4'd4 : SSD<=8'b10011001;
4'd5 : SSD<=8'b01001001;
4'd6 : SSD<=8'b01000001;
4'd7 : SSD<=8'b00011111;
4'd8 : SSD<=8'b00000001;
4'd9 : SSD<=8'b00001001;
default SSD<=8'b00000000;
endcase
end
endmodule

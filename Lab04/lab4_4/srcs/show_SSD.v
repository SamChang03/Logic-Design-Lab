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

module show_SSD(SSD1,SSD2,b1,b2);

output [7:0] SSD1;
output [7:0] SSD2;
input [3:0] b1;
input [3:0] b2;

reg [7:0] SSD1;
reg [7:0] SSD2;

always@(b1)
begin
case (b1)
4'd0 : SSD1=8'b00000011;
4'd1 : SSD1=8'b10011111;
4'd2 : SSD1=8'b00100101;
4'd3 : SSD1=8'b00001101;
4'd4 : SSD1=8'b10011001;
4'd5 : SSD1=8'b01001001;
4'd6 : SSD1=8'b01000001;
4'd7 : SSD1=8'b00011111;
4'd8 : SSD1=8'b00000001;
4'd9 : SSD1=8'b00001001;
default SSD1=8'b00000000;
endcase
end

always@(b2)
begin
case (b2)
4'd0 : SSD2=8'b00000011;
4'd1 : SSD2=8'b10011111;
4'd2 : SSD2=8'b00100101;
4'd3 : SSD2=8'b00001101;
4'd4 : SSD2=8'b10011001;
4'd5 : SSD2=8'b01001001;
4'd6 : SSD2=8'b01000001;
4'd7 : SSD2=8'b00011111;
4'd8 : SSD2=8'b00000001;
4'd9 : SSD2=8'b00001001;
default SSD2=8'b00000000;
endcase
end

endmodule

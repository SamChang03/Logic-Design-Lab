`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/20 23:27:57
// Design Name: 
// Module Name: lab4_2
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


module lab4_4(clock,rst,LED,SSD);
input clock;
input rst;
output LED;
output SSD;

reg [3:0]LED;
reg [7:0] SSD;

wire clk_5kHZ;
wire [3:0]b1;
wire [3:0]b2;
wire [7:0] SSD1;
wire [7:0] SSD2;
integer i;

BCD_UP U1(.b1(b1),.b2(b2),.clk(clock),.rst(rst));
show_SSD(.SSD1(SSD1),.SSD2(SSD2),.b1(b1),.b2(b2));
clk_2(
.clk_out(clk_5kHZ),
.clk(clock),.
rst_n(rst)
);

always@(posedge clk_5kHZ or negedge rst) //Persistence of vision
begin

    if (~rst) begin
    LED<=4'b1110;
    SSD <= 8'b11111111;
    end
    else
        begin
        LED[0]<=LED[1];
        LED[1]<=LED[0];
        
        case(~LED)
        4'b0010 : SSD <= SSD1;
        4'b0001 : SSD <= SSD2;
        default : SSD <= 8'b00000000;
        endcase
        
        end
end

endmodule

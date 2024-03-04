`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/25 01:51:35
// Design Name: 
// Module Name: timer
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


module timer(show,SSD,LED,buttone, clk,rst);
output reg [15:0]LED;
output reg [7:0]SSD;
output show;
input buttone;
input clk;
input rst;

wire [7:0]SSD1;
wire [7:0]SSD0;
reg [3:0]show;

wire rst;
wire signal;
wire state;
wire clk_1HZ;
wire [3:0]b0;
wire [3:0]b1;
wire clk_5kHZ;

one_pluse U0(.signal(signal),.rst(rst),.buttone(buttone),.clk(clk));
fsm U2(.state(state),.signal(signal),.clk(clk),.rst(rst));
down_counter U3(.b1(b1),.b0(b0),.state(state),.clk(clk_1HZ),.rst_n(rst));
freq_div U5(.clk_out(clk_1HZ),.clk(clk),.rst_n(rst));
ssd U6(.display(SSD0),.bcd(b0));
ssd U7(.display(SSD1),.bcd(b1));
freq_div2 U8(.clk_out(clk_5kHZ),.clk(clk),.rst_n(rst));

always @(b0,b1) begin
   if(b0==4'd0 && b1==4'd0)
    LED=16'b1111111111111111;
   else
    LED=16'b0;
end

always @(posedge clk_5kHZ or posedge rst) begin
   if (rst) begin
    show<=4'b1110;
    SSD <= 8'b11111111;
    end
    else
        begin
        show[0]<=show[1];
        show[1]<=show[0];
        
        case(show)
        4'b1101 : SSD <= SSD0;
        4'b1110 : SSD <= SSD1;
        default : SSD <= 8'b00000000;
        endcase
end
end
endmodule
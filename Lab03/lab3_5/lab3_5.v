`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/11 04:22:30
// Design Name: 
// Module Name: lab3_5
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

`define SS_N  8'b11010101;
`define SS_T  8'b11100001;
`define SS_H  8'b10010001;
`define SS_U  8'b10000011;
`define SS_E  8'b01100001;
`define SS_2  8'b00100101;
`define SS_0  8'b00000011;
`define SS_3  8'b00001101;

module lab3_5(pattern,LED,clk,rst);
output pattern;
output LED;
input clk;
input rst;
integer i;

reg [7:0]pattern;
reg [7:0]show_1;
reg [7:0]show_2;
reg [7:0]show_3;
reg [7:0]show_4;
reg [9:0]scrolling_pattern;
reg [3:0]LED;
wire clk_1HZ;
wire clk_5kHZ;

lab3_2 U0(.clk_out(clk_1HZ),.clk(clk),.rst_n(rst));
clk_2 U1(.clk_out(clk_5kHZ),.clk(clk),.rst_n(rst));


always@(posedge clk_1HZ or negedge rst) //change pattern
begin
   if (~rst)
    scrolling_pattern<= 10'b0000000001;
    else
        begin
        scrolling_pattern[0]<=scrolling_pattern[9];
        for(i=1;i<10;i=i+1)
        scrolling_pattern[i]<=scrolling_pattern[i-1];
        end
        
        case(scrolling_pattern)
        10'b0000000001 : begin show_1<=`SS_N show_2<=`SS_T show_3<=`SS_H show_4<=`SS_U  end
        10'b0000000010 : begin show_1<=`SS_T show_2<=`SS_H show_3<=`SS_U show_4<=`SS_E  end
        10'b0000000100 : begin show_1<=`SS_H show_2<=`SS_U show_3<=`SS_E show_4<=`SS_E  end
        10'b0000001000 : begin show_1<=`SS_U show_2<=`SS_E show_3<=`SS_E show_4<=`SS_2  end
        10'b0000010000 : begin show_1<=`SS_E show_2<=`SS_E show_3<=`SS_2 show_4<=`SS_0  end
        10'b0000100000 : begin show_1<=`SS_E show_2<=`SS_2 show_3<=`SS_0 show_4<=`SS_2  end
        10'b0001000000 : begin show_1<=`SS_2 show_2<=`SS_0 show_3<=`SS_2 show_4<=`SS_3  end
        10'b0010000000 : begin show_1<=`SS_0 show_2<=`SS_2 show_3<=`SS_3 show_4<=`SS_N  end
        10'b0100000000 : begin show_1<=`SS_2 show_2<=`SS_3 show_3<=`SS_N show_4<=`SS_T  end
        10'b1000000000 : begin show_1<=`SS_3 show_2<=`SS_N show_3<=`SS_T show_4<=`SS_H  end
        default  : begin show_1<=0; show_2<=0; show_3<=0; show_4<=0;  end
        endcase
end

always@(posedge clk_5kHZ or negedge rst) //Persistence of vision
begin
    if (~rst) begin
    LED<=4'b1110;
    pattern <= 8'b11111111;
    end
    else
        begin
        LED[0]<=LED[3];
        for(i=1;i<4;i=i+1)
        LED[i]<=LED[i-1];
        
        case(~LED)
        4'b0001 : pattern <= show_3;
        4'b0010 : pattern <= show_2;
        4'b0100 : pattern <= show_1;
        4'b1000 : pattern <= show_4;
        default : pattern <= 8'b11111111;
        endcase
        
        end
end
endmodule

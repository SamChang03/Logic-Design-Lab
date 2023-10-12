`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/10 22:36:50
// Design Name: 
// Module Name: test
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


module test();
reg CLK,RST;
wire [3:0]Q;
bcdcounter U0(.q(Q), .clk(CLK),.rst(RST));

initial 
begin 
    RST=0;
    CLK=1;
    #10RST=1;
end

always
begin
 #10 CLK = ~CLK;
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/25 13:16:51
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
wire LED;
reg buttone;
reg clk;
reg rst;

timer U0(LED,buttone, clk,rst);

initial 
begin 
    rst=0;
    clk=1;
    buttone=0;
    #100 buttone=1;
    #100 buttone=0;
     #100 buttone=1;
    #100 buttone=0;
    #100 buttone=1;
    #100 buttone=0;
    #100 rst=1;
     #100 buttone=1;
    #100 buttone=0;
    
end

always
begin
 #10 clk = ~clk;
end

endmodule

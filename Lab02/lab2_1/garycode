`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/02 23:55:43
// Design Name: 
// Module Name: garycode
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


module garycode(
input a,
    input b,
    input c,
    input d,
    output w,
    output x,
    output y,
    output z
    );
    assign w= a | b&d | b&c;
    assign x= (~b)&c&d | b&(~c);
    assign y= b | c;
    assign z= c&d | (~a)&(~b)&d | (~a)&(~b)&c | a&(~c)&(~d);
endmodule

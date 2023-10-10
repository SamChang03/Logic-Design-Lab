timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/19 18:13:23
// Design Name: 
// Module Name: lab_1-1
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


module graycode(
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

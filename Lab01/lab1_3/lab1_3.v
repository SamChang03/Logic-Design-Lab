`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/21 00:54:15
// Design Name: 
// Module Name: lab1_3
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


module lab1_3(
    input [2:0] a,
    input [2:0] b,
    output [2:0] o,
    wire m
    );
    
    assign m =( ~a[2]& b[2]) | ((a[2]==b[2])&a[1]& ~b[1]) | ((a[2]==b[2]) & (a[1]==b[1]) & a[0]& ~b[0]);
    
    assign o[0]=(a[0]& m) | (b[0]& ~m);
    assign o[1]=(a[1]& m) | (b[1]& ~m);
    assign o[2]=(a[2]& m) | (b[2]& ~m);
    
    
endmodule

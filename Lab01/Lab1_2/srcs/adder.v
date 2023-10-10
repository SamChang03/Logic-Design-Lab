`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/02/20 23:58:00
// Design Name: 
// Module Name: adder
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


module lab1_2(
    input [3:0]a,
    input [3:0]b,
    output [3:0]s,
    input m,
    output v,
    wire [4:0]c
    );
   assign s[0]=(b[0]^m)^a[0]^c[0];
   assign s[1]=(b[1]^m)^a[1]^c[1];
   assign s[2]=(b[2]^m)^a[2]^c[2];
   assign s[3]=(b[3]^m)^a[3]^c[3];

   
   assign c[0]=m;
   assign c[1]=(a[0]& (b[0]^m)) | (a[0]& c[0]) | ((b[0]^m) & c[0]);
   assign c[2]=(a[1]& (b[1]^m)) | (a[1]& c[1]) | ((b[1]^m) & c[1]);
   assign c[3]=(a[2]& (b[2]^m)) | (a[2]& c[2]) | ((b[2]^m) & c[2]);
   assign c[4]=(a[3]& (b[3]^m)) | (a[3]& c[3]) | ((b[3]^m) & c[3]);
   
   assign v= c[3]^c[4];
   
   
endmodule

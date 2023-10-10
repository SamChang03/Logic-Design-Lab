`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: National Tsing Hua University
// Engineer: Sam Chang
// 
// Create Date: 2023/02/20 22:34:56
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
wire W,X,Y,Z;
reg A,B,C,D;
graycode U0(.a(A),.b(B),.c(C),.d(D),.w(W),.x(X),.y(Y),.z(Z));

initial
begin

A=0;B=0;C=0;D=0;
#10 A=0;B=0;C=0;D=1;
#10 A=0;B=0;C=1;D=0;
#10 A=0;B=0;C=1;D=1;
#10 A=0;B=1;C=0;D=0;
#10 A=0;B=1;C=0;D=1;
#10 A=0;B=1;C=1;D=0;
#10 A=0;B=1;C=1;D=1;
#10 A=1;B=0;C=0;D=0;
#10 A=1;B=0;C=0;D=1;

end
endmodule

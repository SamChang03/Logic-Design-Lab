`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/30 16:16:49
// Design Name: 
// Module Name: test_signed_4b_adder
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


module test_lab1_2;

    reg [3:0] a;
    reg [3:0] b;
    reg m;
    wire [3:0] s;
    wire v;
    
    lab1_2 U0(
        .s(s),
        .v(v),
        .a(a),
        .b(b),
        .m(m)
    );
    
    initial begin
               m = 1'b0; a = 4'sd3;  b = 4'sd4;     // s = 7, v = 0    
        #10    m = 1'b1; a = 4'sd3;  b = 4'sd4;     // s = -1, v = 0
        #10    m = 1'b0; a = -4'sd4; b = 4'sd4;     // s = 0, v = 0
        #10    m = 1'b1; a = -4'sd4; b = 4'sd5;     // s = 7, v = 1
        #10    m = 1'b1; a = 4'sd4;  b = -4'sd4;    // s = -8, v = 1
        #10    m = 1'b1; a = -4'sd4; b = 4'sd4;     // s = -8, v = 0
    end
    
endmodule

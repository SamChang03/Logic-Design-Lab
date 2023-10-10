`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/30 18:58:33
// Design Name: 
// Module Name: test_signed_3b_compatator
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


module test_lab1_3;

    reg [2:0] a;
    reg [2:0] b;
    wire [2:0] o;
    
    lab1_3 U0(
        .o(o),
        .a(a),
        .b(b)
    );

    initial begin
             a = 3'sd3;   b = 3'sd2;   // o = 3
        #10  a = 3'sd1;   b = 3'sd3;   // o = 3
        #10  a = -3'sd1;  b = 3'sd1;   // o = 1
        #10  a = 3'sd2;   b = -3'sd3;  // o = 2
        #10  a = -3'sd2;  b = -3'sd1;  // o = -1
        #10  a = -3'sd3;  b = -3'sd4;  // o = -3
    end

endmodule

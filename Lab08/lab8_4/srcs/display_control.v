`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/09 04:02:01
// Design Name: 
// Module Name: display_control
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
`define a 7'd97
`define b 7'd98
`define c 7'd99
`define d 7'd100
`define e 7'd101
`define f 7'd102
`define g 7'd103
`define h 7'd104
`define i 7'd105
`define j 7'd106
`define k 7'd107
`define l 7'd108
`define m 7'd109
`define n 7'd110
`define o 7'd111
`define p 7'd112
`define q 7'd113
`define r 7'd114
`define s 7'd115
`define t 7'd116
`define u 7'd117
`define v 7'd118
`define w 7'd119
`define x 7'd120
`define y 7'd121
`define z 7'd122

module display_control(led,cap,last_change,shift);

output reg [6:0]led;
input cap;
input [8:0]last_change;
input shift ;

reg [6:0]letter;
reg letter_en;
    
always@*
  case (last_change)
    9'h1c: begin letter = `a; letter_en = 1; end
    9'h32: begin letter = `b; letter_en = 1; end
    9'h21: begin letter = `c; letter_en = 1; end
    9'h23: begin letter = `d; letter_en = 1; end
    9'h24: begin letter = `e; letter_en = 1; end
    9'h2b: begin letter = `f; letter_en = 1; end
    9'h34: begin letter = `g; letter_en = 1; end
    9'h33: begin letter = `h; letter_en = 1; end
    9'h43: begin letter = `i; letter_en = 1; end
    9'h3b: begin letter = `j; letter_en = 1; end
    9'h42: begin letter = `k; letter_en = 1; end
    9'h4b: begin letter = `l; letter_en = 1; end
    9'h3a: begin letter = `m; letter_en = 1; end
    9'h31: begin letter = `n; letter_en = 1; end
    9'h44: begin letter = `o; letter_en = 1; end
    9'h4d: begin letter = `p; letter_en = 1; end
    9'h15: begin letter = `q; letter_en = 1; end
    9'h2d: begin letter = `r; letter_en = 1; end
    9'h1b: begin letter = `s; letter_en = 1; end
    9'h2c: begin letter = `t; letter_en = 1; end
    9'h3c: begin letter = `u; letter_en = 1; end
    9'h2a: begin letter = `v; letter_en = 1; end
    9'h1d: begin letter = `w; letter_en = 1; end
    9'h22: begin letter = `x; letter_en = 1; end
    9'h35: begin letter = `y; letter_en = 1; end
    9'h1a: begin letter = `z; letter_en = 1; end
    default: begin letter = 0; letter_en = 0; end
  endcase

always@*
  case ({letter_en,shift,cap})
    3'b100: led = letter;
    3'b101: led = letter - 7'd32;
    3'b110: led = letter - 7'd32;
    3'b111: led = letter;
    default: led = 0;
  endcase

endmodule

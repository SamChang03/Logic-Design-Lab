`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/10 22:22:36
// Design Name: 
// Module Name: prelab3_1
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


module bcdcounter(
q, // output
clk, // global clock
rst // active high reset
);

output [3:0] q; // output
input clk; // global clock
input rst; // active high reset
reg [3:0] q; // output (in always block)
reg [3:0] q_tmp; // input to dff (in always block)

// Combinational logics
always @(q)
    q_tmp = q + 4'b0001;

// Sequential logics: Flip flops
always @(posedge clk or negedge rst)
    if (~rst)begin 
    q<=4'd0;
    q_tmp<=4'd0;
    end
    else q<=q_tmp;

endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/19 21:29:32
// Design Name: 
// Module Name: top
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


module lab8_2(
    inout PS2_DATA,
    inout PS2_CLK,
    input rst,
    input clk,
    output [3:0]ssd,
    output [7:0]seg,
    output [1:0]state
    );
    wire [511:0]key_down;
    wire [8:0]last_change;
    wire key_valid;
    wire num_en,enter_en;

assign num_en= key_valid & ((last_change==9'h70)|(last_change==9'h69)|(last_change==9'h72)|(last_change==9'h7A)|(last_change==9'h6B)
| (last_change==9'h73)|(last_change==9'h36)|(last_change==9'h6c)|(last_change==9'h75)|(last_change==9'h7D));

assign enter_en= key_valid & (last_change==9'h5A);
  
  
FSM u0(.state(state),.num_en(num_en),.enter_en(enter_en),.clk(clk),.rst(rst)); 
  
KeyboardDecoder U0(
    .key_down(key_down),
    .last_change(last_change),
    .key_valid(key_valid),
    .PS2_DATA(PS2_DATA),
    .PS2_CLK(PS2_CLK),
    .rst(~rst),
    .clk(clk)
    );
    
display_control(
    .display(seg),
    .ssd_ctl(ssd),
    .state(state),
    .last_change(last_change),
    .key_valid(key_valid),
    .key_down(key_down),
    .clk(clk),
    .rst(rst));
endmodule
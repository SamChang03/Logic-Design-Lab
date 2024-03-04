`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/25 17:13:18
// Design Name: 
// Module Name: ssd
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


`define BCD_BIT_WIDTH 4 // BCD bit width
`define SSD_BIT_WIDTH 8 // SSD display control bit width
`define SSD_ZERO `SSD_BIT_WIDTH'b0000001_1 // 0
`define SSD_ONE `SSD_BIT_WIDTH'b1001111_1 // 1
`define SSD_TWO `SSD_BIT_WIDTH'b0010010_1 // 2
`define SSD_THREE `SSD_BIT_WIDTH'b000110_1 // 3
`define SSD_FOUR `SSD_BIT_WIDTH'b1001100_1 // 4
`define SSD_FIVE `SSD_BIT_WIDTH'b0100100_1 // 5
`define SSD_SIX `SSD_BIT_WIDTH'b0100000_1 // 6
`define SSD_SEVEN `SSD_BIT_WIDTH'b0001111_1 // 7
`define SSD_EIGHT `SSD_BIT_WIDTH'b0000000_1 // 8
`define SSD_NINE `SSD_BIT_WIDTH'b0001100_1 // 9
`define SSD_DEF `SSD_BIT_WIDTH'b0000000_0 // default

module ssd(
display, // SSD display output
bcd // BCD input
);
output [0:`SSD_BIT_WIDTH-1] display; // SSD display output
input [`BCD_BIT_WIDTH-1:0] bcd; // BCD input
reg [0:`SSD_BIT_WIDTH-1] display; // SSD display output (in always)
// Combinational logics: 
always @(bcd)
case (bcd)
`BCD_BIT_WIDTH'd0: display = `SSD_ZERO;
`BCD_BIT_WIDTH'd1: display = `SSD_ONE;
`BCD_BIT_WIDTH'd2: display = `SSD_TWO;
`BCD_BIT_WIDTH'd3: display = `SSD_THREE;
`BCD_BIT_WIDTH'd4: display = `SSD_FOUR;
`BCD_BIT_WIDTH'd5: display = `SSD_FIVE;
`BCD_BIT_WIDTH'd6: display = `SSD_SIX;
`BCD_BIT_WIDTH'd7: display = `SSD_SEVEN;
`BCD_BIT_WIDTH'd8: display = `SSD_EIGHT;
`BCD_BIT_WIDTH'd9: display = `SSD_NINE;
default: display = `SSD_DEF;
endcase
endmodule

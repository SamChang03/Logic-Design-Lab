`define BCD_BIT_WIDTH 4 // bit width for BCD counter
`define ENABLED 1 // ENABLE indicator
`define DISABLED 0 // EIDABLE indicator
`define INCREMENT 1'b1 // increase by 1
`define BCD_ZERO 4'd0 // 0 for BCD
`define BCD_ONE 4'd1 // 1 for BCD
`define BCD_TWO 4'd2 // 2 for BCD
`define BCD_THREE 4'd3 // 3 for BCD
`define BCD_FOUR 4'd4 // 4 for BCD
`define BCD_FIVE 4'd5 // 5 for BCD
`define BCD_SIX 4'd6 // 6 for BCD
`define BCD_SEVEN 4'd7 // 7 for BCD
`define BCD_EIGHT 4'd8 // 8 for BCD
`define BCD_NINE 4'd9 // 9 for BCD
`define BCD_DEF 4'd15 // all 1

// For BCD to seven segment display decoder
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

// For adder
`define ADDER_IN_BIT_WIDTH 3// For decoder
`define CTL_BIT_WIDTH 3
`define CTL_BIT_WIDTH_L 2
`define BCD_BIT_EXT 3 // BCD bit width
// SSD display scan control
`define SSD_DIGIT_NUM 4 // number of SSD digit
`define SSD_SCAN_CTL_BIT_NUM 2 
// number of bits for ssd scan control
`define SSD_SCAN_CTL_DISP1 4'b1110 // set the value of SSD 1
`define SSD_SCAN_CTL_DISP2 4'b1101 // set the value of SSD 2
`define SSD_SCAN_CTL_DISP3 4'b1011 // set the value of SSD 3
`define SSD_SCAN_CTL_DISP4 4'b0111 // set the value of SSD 4

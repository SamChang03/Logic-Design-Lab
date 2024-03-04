// Clock Generator
`define DIV_BY_50M 50_000_000
`define DIV_BY_50M_BIT_WIDTH 27
`define DIV_BY_500K 500_000
`define DIV_BY_500K_BIT_WIDTH 20
`define DIV_BY_25K 25_000
`define DIV_BY_25K_BIT_WIDTH 15
`define BCD_BIT_WIDTH 4

//7-segment display
`define SSD_BIT_WIDTH 8 // 7-segment display control
`define SSD_NUM 4 //number of 7-segment display
`define SSD_ZERO   `SSD_BIT_WIDTH'b0000_0011 // 0
`define SSD_ONE    `SSD_BIT_WIDTH'b1001_1111 // 1
`define SSD_TWO    `SSD_BIT_WIDTH'b0010_0101 // 2
`define SSD_THREE  `SSD_BIT_WIDTH'b0000_1101 // 3
`define SSD_FOUR   `SSD_BIT_WIDTH'b1001_1001 // 4
`define SSD_FIVE   `SSD_BIT_WIDTH'b0100_1001 // 5
`define SSD_SIX    `SSD_BIT_WIDTH'b0100_0001 // 6
`define SSD_SEVEN  `SSD_BIT_WIDTH'b0001_1111 // 7
`define SSD_EIGHT  `SSD_BIT_WIDTH'b0000_0001 // 8
`define SSD_NINE   `SSD_BIT_WIDTH'b0000_1001 // 9

`define SSD_A   `SSD_BIT_WIDTH'b0001_0001 // a
`define SSD_B   `SSD_BIT_WIDTH'b1100_0001 // b
`define SSD_C   `SSD_BIT_WIDTH'b1110_0101 // c
`define SSD_D   `SSD_BIT_WIDTH'b1000_0101 // d
`define SSD_E   `SSD_BIT_WIDTH'b0110_0001 // e
`define SSD_F   `SSD_BIT_WIDTH'b0111_0001 // f
`define SSD_G   `SSD_BIT_WIDTH'b0100_0011 // g

`define SSD_DEF    `SSD_BIT_WIDTH'b0000_0000 // default, all LEDs being lighted


`define ENABLED 1'b1
`define DISABLED 1'b0

`define NINE 4'd9
`define EIGHT 4'd8
`define FIVE 4'd5
`define FOUR 4'd4
`define TWO 4'd2
`define THREE 4'd3
`define ONE 4'd1
`define ZERO 4'd0

`define freq_mid_Do 22'd191571
`define freq_mid_Re 22'd170648
`define freq_mid_Me 22'd151515
`define freq_mid_Fa 22'd143266
`define freq_mid_So 22'd127551
`define freq_mid_La 22'd113636
`define freq_mid_Si 22'd101214

`define freq_high_Do 22'd95419
`define freq_high_Re 22'd85034
`define freq_high_Me 22'd75757
`define freq_high_Fa 22'd71633
`define freq_high_So 22'd63775
`define freq_high_La 22'd56818
`define freq_high_Si 22'd50607
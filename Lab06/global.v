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
`define SSD_A   `SSD_BIT_WIDTH'b0000_0101 // a
`define SSD_B   `SSD_BIT_WIDTH'b1100_0001 // b
`define SSD_C   `SSD_BIT_WIDTH'b1110_0101 // c
`define SSD_D   `SSD_BIT_WIDTH'b1000_0101 // d
`define SSD_E   `SSD_BIT_WIDTH'b0110_0001 // e
`define SSD_F   `SSD_BIT_WIDTH'b0111_0001 // f
`define SSD_DEF    `SSD_BIT_WIDTH'b0000_0000 // default, all LEDs being lighted

// FSM State
`define TIME_DISP 5'b01_000
`define TIME_SETHOUR 5'b01_011
`define TIME_SETMIN 5'b01_010
`define TIME_SETSEC 5'b01_001
`define TIME_SETDAY 5'b01_100
`define TIME_SETMOUN 5'b01_101
`define TIME_SETYEAR 5'b01_110

`define STW_DISP 5'b10_000
`define STW_SETMIN 5'b10_010
`define STW_SETSEC 5'b10_001
`define STW_START 5'b10_011
`define STW_PAUSE 5'b10_100
`define STW_FREEZE 5'b10_101
`define STW_STOP 5'b10_111

`define ALM_DISP 5'b11_000
`define ALM_SETMIN 5'b11_010
`define ALM_SETSEC 5'b11_001
`define ALM_SETHOUR 5'b11_011
`define ALM_SETDAY 5'b11_100
`define ALM_SETMOUN 5'b11_101
`define ALM_SETYEAR 5'b11_110

`define SETMIN 6'b000010
`define SETSEC 6'b000001
`define SETHOUR 6'b000100
`define SETDAY 6'b001000
`define SETMOUN 6'b010000
`define SETYEAR 6'b100000


`define TIME 2'b01
`define STW 2'b10
`define ALM 2'b11



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

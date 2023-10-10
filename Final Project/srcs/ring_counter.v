`define N 8'b00010011
`define T 8'b01110011
`define H 8'b10010001
`define U 8'b10000011
`define E 8'b01100001
`define C 8'b01100011
`define S 8'b01001001
`define A 8'b00010001
`define I 8'b11110011
`define O 8'b00000011
`define L 8'b11100011
`define M 8'b00101011
`define F 8'b01110001
`define R 8'b00100001
`define D 8'b00000111
`define B 8'b11000001
`define dash 8'b 11111101
module ring_counter (
    output reg [7:0] T1, T2, T3, T4,
    input clk, 
    input game_start, gaming, game_over,         
    input reset            
);
  
   reg [7:0] R1, R2, R3, R4 ,R5, R6;
   reg [7:0] M1, M2, M3, M4, M5, M6;
   reg [7:0] S1, S2, S3, S4, S5, S6;
    
    always@(posedge clk or posedge reset) begin
        if (reset || (~game_start)) begin
            R1 <= `R;
            R2 <= `O;
            R3 <= `C;
            R4 <= `dash;
            R5 <= `U;   
            R6 <= 8'b11111111;  
        end
        else begin
            R1 <= R2;
            R2 <= R3;
            R3 <= R4;
            R4 <= R5;
            R5 <= R6;
            R6 <= R1;
        end
    end

always@(posedge clk or posedge reset) begin
    if (reset || (~gaming)) begin
        M1 <= `M;
        M2 <= `A;
        M3 <= `R;
        M4 <= `I;
        M5 <= `O;
        M6 <= 8'b11111111;
    end
    else begin
        M1 <= M2;
        M2 <= M3;
        M3 <= M4;
        M4 <= M5;
        M5 <= M6;
        M6 <= M1;
    end
end

always@(posedge clk or posedge reset) begin
    if (reset || (~game_over)) begin
        S1 <= `B;
        S2 <= `dash;
        S3 <= `S;
        S4 <= `A;
        S5 <= `D;   
        S6 <= 8'b11111111;
    end
    else begin
        S1 <= S2;
        S2 <= S3;
        S3 <= S4;
        S4 <= S5;
        S5 <= S6;
        S6 <= S1;
    end
end
  
always@* begin
    if (game_start) begin
        T1 <= R1;
        T2 <= R2;
        T3 <= R3;
        T4 <= R4;
    end
    else if (gaming)begin
        T1 <= M1;
        T2 <= M2;
        T3 <= M3;
        T4 <= M4;
    end
    else begin
        T1 <= S1;
        T2 <= S2;
        T3 <= S3;
        T4 <= S4;
    end
end  
endmodule
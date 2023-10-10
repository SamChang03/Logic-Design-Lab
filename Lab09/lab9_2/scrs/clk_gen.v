`define DIV_BIT_1HZ 26
`define DIV_BIT_100HZ 19

module clk_gen(
input clk,              // global clock
input rst_n,            // low avtive reset
output reg clk_10,       // 10HZ clock
output reg clk_100     // 100HZ clock
);
// declare internal node
reg [`DIV_BIT_1HZ-1:0]cnt_5M,cnt_5M_next;       // generate 1HZ clock
reg [`DIV_BIT_100HZ-1:0]cnt_500K,cnt_500K_next;   // generate 100HZ clock
reg clk_10_next;
reg clk_100_next;

// 1HZ clock counter opreation
always@*
    if(cnt_5M==`DIV_BIT_1HZ'd5000000)
    begin
        cnt_5M_next=`DIV_BIT_1HZ'd0;
        clk_10_next=~clk_10;
    end
    else
    begin
        cnt_5M_next=cnt_5M+`DIV_BIT_1HZ'd1;
        clk_10_next=clk_10;
    end
// Flip-Flop:Generate 1HZ Clock
always@(posedge clk or negedge rst_n)
    if(~rst_n)
    begin
        cnt_5M<=`DIV_BIT_1HZ'd0;
        clk_10<=0;
    end
    else
    begin
        cnt_5M<=cnt_5M_next;
        clk_10<=clk_10_next;
    end
// 100HZ clock counter opreation
always@*
    if(cnt_500K==`DIV_BIT_100HZ'd500000)
    begin
        cnt_500K_next=`DIV_BIT_100HZ'd0;
        clk_100_next=~clk_100;
    end
    else
    begin
        cnt_500K_next=cnt_500K+`DIV_BIT_100HZ'd1;
        clk_100_next=clk_100;
    end
// Flip-Flop: Generate 100HZ Clock
always@(posedge clk or negedge rst_n)
        if(~rst_n)
        begin
            cnt_500K<=`DIV_BIT_100HZ'd0;
            clk_100<=0;
        end
        else
        begin
            cnt_500K<=cnt_500K_next;
            clk_100<=clk_100_next;
        end
endmodule
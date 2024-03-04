`timescale 1ns / 1ps

module test();
wire [7:0]display;
wire [1:0]ssd_ctl;
reg b1;
reg b2;
reg clk;
reg rst;

stopwatch_disp U0( display,ssd_ctl,clk,rst,b1,b2);

initial 
begin 
    rst=1;
    clk=1;
    b1=0;
    b2=0;
    #20rst=0;
    #200 b1=1;
    #100 b1=0;
    #200 b1=1;
    #100 b1=0;
    
    #100 b1=0;
end

always
begin
 #10 clk = ~clk;
end

endmodule
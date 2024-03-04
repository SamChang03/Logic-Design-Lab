`timescale 1ns / 1ps

module test();
wire [7:0]display;
wire [1:0]ssd_ctl;
reg b1;
reg b2;
reg b3;
reg b4;
reg clk;
reg rst;
reg set;

lab5_3 U0(display,ssd_ctl,clk,set,rst,
          b1,b2,b3,b4);

initial 
begin 
    rst=0;
    clk=1;
    set=1;
    b1=0;
    b2=0;
    b3=0;
    b4=0;
    #10rst=1;
    #10rst=0;
    #10rst=1;
    #20 b3=1;
    #100 b3=0;
    #100 b3=1;
    #100 b3=0;
    #100 b3=1;
    #100 b3=0;
    set=0;
    #100 b1=1;
    #100 b1=0;
end

always
begin
 #10 clk = ~clk;
end

endmodule
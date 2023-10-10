`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 01:36:32
// Design Name: 
// Module Name: pipe_gen
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
`define SPACE 100

module pipe_gen(
    input clk_21,
    input clk,
    input rst,
    input [2:0]state,
    input [9:0]h_cnt,
    input [9:0]v_cnt,
    input new,
    output reg [10:0] pipe_h,
    output [11:0]pixel_pipebody,
    output pipebody_valid,
    output [11:0]pixel_pipemouth,
    output pipemouth_valid,
    output [11:0]pixel_pipebase,
    output pipebase_valid
    );
    
    wire [9:0] pixel_addr_body,pixel_addr_base,pixel_addr_mouth;
    reg [7:0]pipe_v,pipe_v_next;
    wire [7:0]pipe_v_new;
    reg [10:0]pipe_h_next;
    reg [2:0]state_delay;
    wire reset;
    
    LFSR LFSR_inst(.clk21(clk_21),.rst(rst),.random(pipe_v_new));
    
    assign reset = (state_delay != 3'd0 & state == 3'd0);
    assign pipebody_valid = (v_cnt < pipe_v | (v_cnt <= 415  & v_cnt > (pipe_v + `SPACE + 30)))
                            & (pipe_h >= 50 ? h_cnt >= (pipe_h - 50) & h_cnt < pipe_h : h_cnt < pipe_h);
    assign pixel_addr_body = (h_cnt - pipe_h + 4) % 50;      
    
    assign pipebase_valid =  (v_cnt >= pipe_v & v_cnt < pipe_v + 15)
                          & (pipe_h >= 50 ? h_cnt >= (pipe_h - 50) & h_cnt < pipe_h : h_cnt < pipe_h);
    assign pixel_addr_base = (h_cnt - pipe_h + 51) + (v_cnt - pipe_v) * 50;
    assign pipemouth_valid =  (v_cnt > (pipe_v + `SPACE + 15) & v_cnt <= (pipe_v + `SPACE + 30))
                          & (pipe_h >= 50 ? h_cnt >= (pipe_h - 50) & h_cnt < pipe_h : h_cnt < pipe_h);
    assign pixel_addr_mouth = (h_cnt - pipe_h + 51) + (v_cnt - pipe_v - `SPACE - 16) * 50;
    
    always @* begin
        if (new) begin
            pipe_h_next = 690;
            pipe_v_next = pipe_v_new % 220 + 60;
        end
        else if (state == 3'd1) begin       
            if (pipe_h > 0) begin
                pipe_h_next = pipe_h - 2;
                pipe_v_next = pipe_v;
            end
            else begin
                pipe_h_next = pipe_h;
                pipe_v_next = pipe_v;
            end
        end
        else begin
            pipe_h_next = pipe_h;
            pipe_v_next = pipe_v;
        end
    end
    
    always @(posedge clk_21 or posedge rst) begin
        if(rst)
        state_delay <= 0;
        state_delay <= state;
    end
    
    always @ (posedge clk_21 or posedge rst) begin
        if (rst|reset) begin
            pipe_h <= 0;
            pipe_v <= 0;
        end else begin
            pipe_h <= pipe_h_next;
            pipe_v <= pipe_v_next;
        end
    end
blk_mem_gen_8 mem_8_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr_body),
  .douta(pixel_pipebody)
);

blk_mem_gen_9 mem_9_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr_base),
  .douta(pixel_pipebase)
);

blk_mem_gen_10 mem_10_inst(
  .clka(clk),
  .wea(0),
  .dina(0),
  .addra(pixel_addr_mouth),
  .douta(pixel_pipemouth)
);

   
endmodule

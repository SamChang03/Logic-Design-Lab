`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 09:11:03
// Design Name: 
// Module Name: pipe
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
`define INTERVAL 80

module pipe(
  input clk_21,
  input clk,
  input rst,
  input [2:0]state,
  input [9:0]h_cnt,
  input [9:0]v_cnt,
  output reg [11:0]pixel_pipebody,
  output pipebody_valid,
  output reg [11:0]pixel_pipemouth,
  output pipemouth_valid,
  output reg [11:0]pixel_pipebase,
  output pipebase_valid,
  output reg [6:0]score
    );
    
    
  wire [3:0]body_valid,base_valid,mouth_valid;
  wire [11:0]pixel_pipebody0,pixel_pipebase0,pixel_pipemouth0;
  wire [11:0]pixel_pipebody1,pixel_pipebase1,pixel_pipemouth1;
  wire [11:0]pixel_pipebody2,pixel_pipebase2,pixel_pipemouth2;
  wire [11:0]pixel_pipebody3,pixel_pipebase3,pixel_pipemouth3;
  wire [10:0] pipe_h0,pipe_h1,pipe_h2,pipe_h3;
  reg [2:0]state_delay;
  wire [3:0]new;
  reg [7:0]cnt, cnt_next;
  reg [6:0]score_next;
  
  assign pipebody_valid = |body_valid;
  assign pipebase_valid = |base_valid;
  assign pipemouth_valid = |mouth_valid;
  assign new[0] = (cnt > `INTERVAL) & ~|pipe_h0;
  assign new[1] = (cnt > `INTERVAL) &  |pipe_h0 & ~|pipe_h1;
  assign new[2] = (cnt > `INTERVAL) &  |pipe_h0 &  |pipe_h1 & ~|pipe_h2;
  assign new[3] = (cnt > `INTERVAL) &  |pipe_h0 &  |pipe_h1 &  |pipe_h2 & ~|pipe_h3;
  
  always@(*)begin
    case(body_valid)
         4'b0001:   pixel_pipebody = pixel_pipebody0;
         4'b0010:   pixel_pipebody = pixel_pipebody1;
         4'b0100:   pixel_pipebody = pixel_pipebody2;
         4'b1000:   pixel_pipebody = pixel_pipebody3;
         default:   pixel_pipebody = pixel_pipebody0;
    endcase
  end
  
  always@(*)begin
    case(mouth_valid)
         4'b0001:   pixel_pipemouth = pixel_pipemouth0;
         4'b0010:   pixel_pipemouth = pixel_pipemouth1;
         4'b0100:   pixel_pipemouth = pixel_pipemouth2;
         4'b1000:   pixel_pipemouth = pixel_pipemouth3;
         default:   pixel_pipemouth = pixel_pipemouth0;
    endcase
  end
  
  always@(*)begin
    case(base_valid)
         4'b0001:   pixel_pipebase = pixel_pipebase0;
         4'b0010:   pixel_pipebase = pixel_pipebase1;
         4'b0100:   pixel_pipebase = pixel_pipebase2;
         4'b1000:   pixel_pipebase = pixel_pipebase3;
         default:   pixel_pipebase = pixel_pipebase0;
    endcase
  end
  
  always@(*)begin
    case(body_valid)
         4'b0001:   pixel_pipebody = pixel_pipebody0;
         4'b0010:   pixel_pipebody = pixel_pipebody1;
         4'b0100:   pixel_pipebody = pixel_pipebody2;
         4'b1000:   pixel_pipebody = pixel_pipebody3;
         default:   pixel_pipebody = pixel_pipebody0;
    endcase
  end
  
always @(posedge clk_21 or posedge rst) begin
  if(rst | (state_delay != 3'd0 && state == 3'd0)) begin
      state_delay <= 0;
      cnt <= 0;
      score <= 0;
  end
  else begin
      state_delay <= state;
      cnt <=  cnt_next;
      score <= score_next;
  end
end

always @* begin
if (state == 3'd1) begin
    if (cnt > `INTERVAL)
        cnt_next = 0;
    else
        cnt_next = cnt + 1;
    if (pipe_h0 == 200 | pipe_h1 == 200 | pipe_h2 == 200 | pipe_h3 == 200)
         score_next = score + 1;
     else
         score_next = score;
end 
else begin
    cnt_next = cnt;
    score_next = score;
end
end



pipe_gen g1(
.clk_21(clk_21),
.clk(clk),
.rst(rst),
.state(state),
.h_cnt(h_cnt),
.v_cnt(v_cnt),
.new(new[0]),
.pipe_h(pipe_h0),
.pixel_pipebody(pixel_pipebody0),
.pipebody_valid(body_valid[0]),
.pixel_pipemouth(pixel_pipemouth0),
.pipemouth_valid(mouth_valid[0]),
.pixel_pipebase(pixel_pipebase0),
.pipebase_valid(base_valid[0])
);

pipe_gen g2(
.clk_21(clk_21),
.clk(clk),
.rst(rst),
.state(state),
.h_cnt(h_cnt),
.v_cnt(v_cnt),
.new(new[1]),
.pipe_h(pipe_h1),
.pixel_pipebody(pixel_pipebody1),
.pipebody_valid(body_valid[1]),
.pixel_pipemouth(pixel_pipemouth1),
.pipemouth_valid(mouth_valid[1]),
.pixel_pipebase(pixel_pipebase1),
.pipebase_valid(base_valid[1])
);

pipe_gen g3(
.clk_21(clk_21),
.clk(clk),
.rst(rst),
.state(state),
.h_cnt(h_cnt),
.v_cnt(v_cnt),
.new(new[2]),
.pipe_h(pipe_h2),
.pixel_pipebody(pixel_pipebody2),
.pipebody_valid(body_valid[2]),
.pixel_pipemouth(pixel_pipemouth2),
.pipemouth_valid(mouth_valid[2]),
.pixel_pipebase(pixel_pipebase2),
.pipebase_valid(base_valid[2])
);

pipe_gen g4(
.clk_21(clk_21),
.clk(clk),
.rst(rst),
.state(state),
.h_cnt(h_cnt),
.v_cnt(v_cnt),
.new(new[3]),
.pipe_h(pipe_h3),
.pixel_pipebody(pixel_pipebody3),
.pipebody_valid(body_valid[3]),
.pixel_pipemouth(pixel_pipemouth3),
.pipemouth_valid(mouth_valid[3]),
.pixel_pipebase(pixel_pipebase3),
.pipebase_valid(base_valid[3])
);
    
endmodule

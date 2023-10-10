module mem_addr_gen(
  input clk,
  input rst,
  input [9:0] h_cnt,
  input [9:0] v_cnt,
  output reg [11:0] pixel_addr,
  output reg [8:0] position
);
    
reg [8:0] position_next;

always@*
  if(h_cnt<288 | h_cnt>351)
	pixel_addr = 0;
  else if(v_cnt<0+position | v_cnt>64+position)
    pixel_addr = 0;
  else pixel_addr = h_cnt-288 + (v_cnt-position)*64;

always@*
  if(rst)
    position_next = 0;
  else if(position < 416)
    position_next = position + 32;
  else
    position_next = 0;
	

always@(posedge clk or posedge rst)
	if(rst)
		position <= 8'b0;
	else position <= position_next;
    
endmodule

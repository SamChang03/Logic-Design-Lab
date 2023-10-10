module mem_addr_gen(
  input [9:0] h_cnt,
  input [9:0] v_cnt,
  output reg [11:0] pixel_addr
);

	always@*
		if(v_cnt < 128 | v_cnt >191)
			pixel_addr = 0;
		else if(h_cnt < 64)
			pixel_addr = (v_cnt-128)*64+h_cnt;
		else if(h_cnt < 128)
			pixel_addr = (v_cnt-128)*64+h_cnt-64;
		else if(h_cnt < 192)
			pixel_addr = (v_cnt-128)*64+h_cnt-128;
		else if(h_cnt < 256)
			pixel_addr = (v_cnt-128)*64+h_cnt-192;
		else if(h_cnt < 320)
			pixel_addr = (v_cnt-128)*64+h_cnt-256;
		else if(h_cnt < 384)
			pixel_addr = (v_cnt-128)*64+h_cnt-320;
		else if(h_cnt < 448)
			pixel_addr = (v_cnt-128)*64+h_cnt-384;
		else if(h_cnt < 512)
			pixel_addr = (v_cnt-128)*64+h_cnt-448;
		else if(h_cnt < 576)
			pixel_addr = (v_cnt-128)*64+h_cnt-512;
		else if(h_cnt < 640)
			pixel_addr = (v_cnt-128)*64+h_cnt-576;
		else pixel_addr = 0;
			
endmodule
module lab9_2(
    input clk,
    input rst,
    output reg [3:0] vgaRed,
    output reg [3:0] vgaGreen,
    output reg [3:0] vgaBlue,
    output hsync,
    output vsync,
	inout PS2_CLK,
	inout PS2_DATA
	);

	wire [511:0]key_down;
	wire [8:0]last_change;
	wire key_valid;
	wire clk_25MHz;
	wire clk_22;
	wire [3:0]decode_out;
	wire [2:0]state;
	wire [1:0]operation;
	wire [3:0]digit3, digit2, digit1, digit0;
	wire [3:0]add2;
	wire [3:0]add1;
	wire [3:0]add0;
	wire [3:0]sub1;
	wire [3:0]sub0;
	wire [3:0]mul3;
	wire [3:0]mul2;
	wire [3:0]mul1;
	wire [3:0]mul0;
	wire count;
	wire [11:0] data;
	wire [11:0] pixel_addr;
	wire valid;
	wire [9:0] h_cnt; //640
	wire [9:0] v_cnt;  //480
	wire [11:0] pixel0;
	wire [11:0] pixel1;
	wire [11:0] pixel2;
	wire [11:0] pixel3;
	wire [11:0] pixel4;
	wire [11:0] pixel5;
	wire [11:0] pixel6;
	wire [11:0] pixel7;
	wire [11:0] pixel8;
	wire [11:0] pixel9;
	wire [11:0] pixel_add;
	wire [11:0] pixel_equal;
	wire [11:0] pixel_multiply;
	wire [11:0] pixel_substract;
	
	KeyboardDecoder U0(
		.key_down(key_down),
		.last_change(last_change),
		.key_valid(key_valid),
		.PS2_DATA(PS2_DATA),
		.PS2_CLK(PS2_CLK),
		.rst(rst),
		.clk(clk)
		);
		
	clock_divisor U1(
		.clk(clk),
	    .clk1(clk_25MHz),
	    .clk22(clk_22)
		);
    
	decoder U2(
		.out(decode_out),
		.clk(clk),
		.in(last_change)
		);
	
	Finite_state U3(
		.state(state),
		.operation(operation),
		.in(decode_out),
		.valid(key_down[last_change])
		);
	
	reg_4d U4(
		.digit3(digit3),
		.digit2(digit2),
		.digit1(digit1),
		.digit0(digit0),
		.in(decode_out),
		.state_ctrl(state),
		.valid(key_down[last_change]),
		.rst(state==`STAT_DISPLAY)
		);
	
	adder_2d U5(
		.out2(add2),
		.out1(add1),
		.out0(add0),
		.in3(digit3),
		.in2(digit2),
		.in1(digit1),
		.in0(digit0)
		);
   wire sign;
	subtractor_2d U6(
	    .sign(sign),
		.out1(sub1),
		.out0(sub0),
		.in3(digit3),
		.in2(digit2),
		.in1(digit1),
		.in0(digit0)
		);
	
	
	multiplier_2d U7(
		.out3(mul3),
		.out2(mul2),
		.out1(mul1),
		.out0(mul0),
		.in3(digit3),
		.in2(digit2),
		.in1(digit1),
		.in0(digit0)
		);
		
	vga_controller U8(
	    .pclk(clk_25MHz),
	    .reset(rst),
	    .hsync(hsync),
	    .vsync(vsync),
	    .valid(valid),
	    .h_cnt(h_cnt),
	    .v_cnt(v_cnt)
		);
    
	mem_addr_gen U9(
		.h_cnt(h_cnt),
		.v_cnt(v_cnt),
		.pixel_addr(pixel_addr)
		);
		
	blk_mem_gen_0 Um0(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel0)
		); 
	
	blk_mem_gen_1 Um1(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel1)
		); 
	
	blk_mem_gen_2 Um2(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel2)
		); 
		
	blk_mem_gen_3 Um3(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel3)
		); 
		
	blk_mem_gen_4 Um4(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel4)
		);

	blk_mem_gen_5 Um5(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel5)
		);
		
	blk_mem_gen_6 Um6(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel6)
		);
		
	blk_mem_gen_7 Um7(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel7)
		);
		
	blk_mem_gen_8 Um8(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel8)
		);
		
	blk_mem_gen_9 Um9(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel9)
		);
		
	blk_mem_gen_A Um_add(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel_add)
		);
		
	blk_mem_gen_E Um_equal(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel_equal)
		);
		
	blk_mem_gen_M Um_multiply(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel_multiply)
		);
	
	blk_mem_gen_S Um_substract(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel_substract)
		);
	
    always@*
		if(v_cnt<128 | v_cnt>255)
			{vgaRed, vgaGreen, vgaBlue} = 12'h0;	       
		else if(h_cnt<64)
			case(digit3)
				4'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
				4'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
				4'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
				4'd3: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel3:12'h0;
				4'd4: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel4:12'h0;
				4'd5: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel5:12'h0;
				4'd6: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel6:12'h0;
				4'd7: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel7:12'h0;
				4'd8: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel8:12'h0;
				4'd9: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel9:12'h0;
				default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
			endcase
		else if(h_cnt<128)
			case(digit2)
				4'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
				4'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
				4'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
				4'd3: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel3:12'h0;
				4'd4: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel4:12'h0;
				4'd5: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel5:12'h0;
				4'd6: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel6:12'h0;
				4'd7: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel7:12'h0;
				4'd8: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel8:12'h0;
				4'd9: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel9:12'h0;
				default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
			endcase	
		else if(h_cnt<192)
		    if(state<`STAT_DIGIT2)
		       {vgaRed, vgaGreen, vgaBlue} = 12'hfff;
		    else
			case(operation)
				2'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel_add:12'h0;
				2'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel_substract:12'h0;
				2'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel_multiply:12'h0;
				default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
			endcase
		else if(h_cnt<256)
			case(digit1)
				4'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
				4'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
				4'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
				4'd3: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel3:12'h0;
				4'd4: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel4:12'h0;
				4'd5: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel5:12'h0;
				4'd6: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel6:12'h0;
				4'd7: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel7:12'h0;
				4'd8: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel8:12'h0;
				4'd9: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel9:12'h0;
				default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
			endcase	
		else if(h_cnt<320)
			case(digit0)
				4'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
				4'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
				4'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
				4'd3: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel3:12'h0;
				4'd4: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel4:12'h0;
				4'd5: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel5:12'h0;
				4'd6: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel6:12'h0;
				4'd7: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel7:12'h0;
				4'd8: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel8:12'h0;
				4'd9: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel9:12'h0;
				default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
			endcase
		else if(h_cnt<384)
			{vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel_equal:12'h0;
		else if(h_cnt<448)
			if(operation == 2'd0)
				{vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
		    else if(operation == 2'd1)
		       if (sign==1)
		         {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel_substract:12'h0;
		       else
		         {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
			else if(operation == 2'd2)
				case(mul3)
					4'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
					4'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
					4'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
					4'd3: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel3:12'h0;
					4'd4: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel4:12'h0;
					4'd5: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel5:12'h0;
					4'd6: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel6:12'h0;
					4'd7: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel7:12'h0;
					4'd8: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel8:12'h0;
					4'd9: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel9:12'h0;
					default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
				endcase
			else {vgaRed, vgaGreen, vgaBlue} = 12'h0;
		else if(h_cnt<512)
			if(operation == 2'd0)
				case(add2)
					4'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
					4'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
					4'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
					4'd3: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel3:12'h0;
					4'd4: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel4:12'h0;
					4'd5: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel5:12'h0;
					4'd6: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel6:12'h0;
					4'd7: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel7:12'h0;
					4'd8: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel8:12'h0;
					4'd9: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel9:12'h0;
					default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
				endcase
			else if(operation == 2'd1)
				{vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
			else if(operation == 2'd2)
				case(mul2)
					4'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
					4'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
					4'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
					4'd3: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel3:12'h0;
					4'd4: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel4:12'h0;
					4'd5: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel5:12'h0;
					4'd6: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel6:12'h0;
					4'd7: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel7:12'h0;
					4'd8: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel8:12'h0;
					4'd9: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel9:12'h0;
					default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
				endcase
			else {vgaRed, vgaGreen, vgaBlue} = 12'h0;
		else if(h_cnt<576)
			if(operation == 2'd0)
				case(add1)
					4'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
					4'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
					4'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
					4'd3: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel3:12'h0;
					4'd4: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel4:12'h0;
					4'd5: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel5:12'h0;
					4'd6: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel6:12'h0;
					4'd7: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel7:12'h0;
					4'd8: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel8:12'h0;
					4'd9: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel9:12'h0;
					default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
				endcase
			else if(operation == 2'd1)
				case(sub1)
					4'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
					4'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
					4'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
					4'd3: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel3:12'h0;
					4'd4: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel4:12'h0;
					4'd5: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel5:12'h0;
					4'd6: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel6:12'h0;
					4'd7: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel7:12'h0;
					4'd8: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel8:12'h0;
					4'd9: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel9:12'h0;
					default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
				endcase
			else if(operation == 2'd2)
				case(mul1)
					4'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
					4'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
					4'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
					4'd3: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel3:12'h0;
					4'd4: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel4:12'h0;
					4'd5: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel5:12'h0;
					4'd6: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel6:12'h0;
					4'd7: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel7:12'h0;
					4'd8: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel8:12'h0;
					4'd9: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel9:12'h0;
					default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
				endcase
			else {vgaRed, vgaGreen, vgaBlue} = 12'h0;
		else if(h_cnt<640)
			if(operation == 2'd0)
				case(add0)
					4'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
					4'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
					4'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
					4'd3: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel3:12'h0;
					4'd4: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel4:12'h0;
					4'd5: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel5:12'h0;
					4'd6: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel6:12'h0;
					4'd7: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel7:12'h0;
					4'd8: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel8:12'h0;
					4'd9: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel9:12'h0;
					default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
				endcase
			else if(operation == 2'd1)
				case(sub0)
					4'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
					4'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
					4'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
					4'd3: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel3:12'h0;
					4'd4: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel4:12'h0;
					4'd5: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel5:12'h0;
					4'd6: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel6:12'h0;
					4'd7: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel7:12'h0;
					4'd8: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel8:12'h0;
					4'd9: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel9:12'h0;
					default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
				endcase
			else if(operation == 2'd2)
				case(mul0)
					4'd0: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel0:12'h0;
					4'd1: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel1:12'h0;
					4'd2: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel2:12'h0;
					4'd3: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel3:12'h0;
					4'd4: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel4:12'h0;
					4'd5: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel5:12'h0;
					4'd6: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel6:12'h0;
					4'd7: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel7:12'h0;
					4'd8: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel8:12'h0;
					4'd9: {vgaRed, vgaGreen, vgaBlue} = (valid==1'b1) ? pixel9:12'h0;
					default: {vgaRed, vgaGreen, vgaBlue} = 12'h0;
				endcase
			else {vgaRed, vgaGreen, vgaBlue} = 12'h0;		
		else {vgaRed, vgaGreen, vgaBlue} = 12'h0;
			
endmodule
module lab9_3(
    input clk,
    input rst,
    output reg [3:0] vgaRed,
    output reg [3:0] vgaGreen,
    output reg [3:0] vgaBlue,
    output hsync,
    output vsync
	);
	 
	
	wire clk_25MHz;
	wire clk_22;
	wire clk_1Hz;
	wire clk_100Hz;
	wire [1:0]clk_ssd;
	wire [11:0]data;
	wire [2:0]random; 
	wire [11:0] pixel_addr;
	wire [8:0] position;
	wire [11:0] pixel0;
	wire [11:0] pixel1;
	wire [11:0] pixel2;
	wire [11:0] pixel3;
	wire [11:0] pixel4;
	wire [11:0] pixel5;
	wire [11:0] pixel6;
	wire valid;
	wire [9:0] h_cnt; //640
	wire [9:0] v_cnt;  //480
	
	// Frequency Divider
	clock_divisor U0(
	    .clk(clk),
	    .clk1(clk_25MHz),
	    .clk22(clk_22)
		);
		
	clock_generator U1(
		.clk_1Hz(clk_1Hz),  //generated 1Hz clock
		.clk_100Hz(clk_100Hz),  //generated 100Hz clock
		.clk_ssd(clk_ssd),  //generated clock for ssd_ctl
		.clk(clk)  //clock from crystal
		);
		
	Random U2(
		.q(random),
		.position(position),
		.rst(rst)
		);
		
	// Render the picture by VGA controller
	vga_controller U3(
	    .pclk(clk_25MHz),
	    .reset(rst),
	    .hsync(hsync),
	    .vsync(vsync),
	    .valid(valid),
	    .h_cnt(h_cnt),
	    .v_cnt(v_cnt)
		);
		
	mem_addr_gen U4(
	    .clk(clk_1Hz),
	    .rst(rst),
	    .h_cnt(h_cnt),
	    .v_cnt(v_cnt),
	    .pixel_addr(pixel_addr),
		.position(position)
		);
	
		
	blk_mem_gen_0 Up0(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel0)
		);

	blk_mem_gen_1 Up1(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel1)
		); 
		
	blk_mem_gen_0_2 Up2(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel2)
		); 
		
	blk_mem_gen_3 Up3(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel3)
		); 
		
	blk_mem_gen_4 Up4(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel4)
		); 
		
	blk_mem_gen_5 Up5(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel5)
		);

	blk_mem_gen_6 Up6(
	    .clka(clk_25MHz),
	    .wea(0),
	    .addra(pixel_addr),
	    .dina(data[11:0]),
	    .douta(pixel6)
		); 
		
    always@*
        if(h_cnt<192 | h_cnt>447)
            {vgaRed , vgaGreen , vgaBlue} = 12'h0;
		else if(random == 3'd0)
			if((v_cnt<position | v_cnt>position+64)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else if((h_cnt<288 | h_cnt>351)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else
				{vgaRed , vgaGreen , vgaBlue} = pixel0;
		else if(random == 3'd1)
			if((v_cnt<position | v_cnt>position+64)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else if((h_cnt<288 | h_cnt>351)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else
				{vgaRed , vgaGreen , vgaBlue} = pixel1;
		else if(random == 3'd2)
			if((v_cnt<position | v_cnt>position+64)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else if((h_cnt<288 | h_cnt>351)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else
				{vgaRed , vgaGreen , vgaBlue} = pixel2;
		else if(random == 3'd3)
			if((v_cnt<position | v_cnt>position+64)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else if((h_cnt<288 | h_cnt>351)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else
				{vgaRed , vgaGreen , vgaBlue} = pixel3;
		else if(random == 3'd4)
			if((v_cnt<position | v_cnt>position+64)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else if((h_cnt<288 | h_cnt>351)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else
				{vgaRed , vgaGreen , vgaBlue} = pixel4;
		else if(random == 3'd5)
			if((v_cnt<position | v_cnt>position+64)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else if((h_cnt<288 | h_cnt>351)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else
				{vgaRed , vgaGreen , vgaBlue} = pixel5;
		else
			if((v_cnt<position | v_cnt>position+64)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else if((h_cnt<288 | h_cnt>351)&valid)
				{vgaRed , vgaGreen , vgaBlue} = 12'hfff;
			else
				{vgaRed , vgaGreen , vgaBlue} = pixel6;
		
		
endmodule
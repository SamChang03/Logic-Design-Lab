`include "global.v"

module reg_4d(
	digit3,
	digit2,
	digit1,
	digit0,
	in,
	state_ctrl,
	valid,
	rst
    );
    
    output reg [3:0]digit3;
    output reg [3:0]digit2;
    output reg [3:0]digit1;
    output reg [3:0]digit0;
    
    input [3:0]in;
    input [2:0]state_ctrl;
    input valid;
    input rst;
    
    reg [3:0]digit3_tmp;
    reg [3:0]digit2_tmp;
    reg [3:0]digit1_tmp;
    reg [3:0]digit0_tmp;
    
    always@*
        if(rst)begin
                digit3_tmp = 0;
				digit2_tmp = 0;
				digit1_tmp = 0;
				digit0_tmp = 0;
        end  
        else if(state_ctrl == `STAT_DIGIT3)
			begin
				digit3_tmp = in;
				digit2_tmp = digit2;
				digit1_tmp = digit1;
				digit0_tmp = digit0;
			end
		else if(state_ctrl == `STAT_DIGIT2)
			if(in == `KEY_ADD | in == `KEY_SUBTRACT | in == `KEY_MULTIPLY | in == `KEY_ENTER)
				begin
					digit3_tmp = digit3;
					digit2_tmp = digit2;
					digit1_tmp = digit1;
					digit0_tmp = digit0;
				end
			else
				begin
					digit3_tmp = digit3;
					digit2_tmp = in;
					digit1_tmp = digit1;
					digit0_tmp = digit0;
				end
		else if(state_ctrl == `STAT_DIGIT1)
			begin
				digit3_tmp = digit3;
				digit2_tmp = digit2;
				digit1_tmp = in;
				digit0_tmp = digit0;
			end
		else if(state_ctrl == `STAT_DIGIT0)
			if(in == `KEY_ADD | in == `KEY_SUBTRACT | in == `KEY_MULTIPLY | in ==`KEY_ENTER)
				begin
					digit3_tmp = digit3;
					digit2_tmp = digit2;
					digit1_tmp = digit1;
					digit0_tmp = digit0;
				end
			else
				begin
					digit3_tmp = digit3;
					digit2_tmp = digit2;
					digit1_tmp = digit1;
					digit0_tmp = in;
				end
		else
			begin
				digit3_tmp = digit3;
				digit2_tmp = digit2;
				digit1_tmp = digit1;
				digit0_tmp = digit0;
			end
        
	always@(posedge valid)
		begin
			digit3 <= digit3_tmp;
			digit2 <= digit2_tmp;
			digit1 <= digit1_tmp;
			digit0 <= digit0_tmp;
		end
		
endmodule

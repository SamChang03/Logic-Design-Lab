module subtractor_2d(
    sign,
	out1,
	out0,
	in3,
	in2,
	in1,
	in0
	);
	output reg sign;
	output reg [3:0]out1;
	output reg [3:0]out0;
	
	input [3:0]in3;
	input [3:0]in2;
	input [3:0]in1;
	input [3:0]in0;
	
	reg [6:0]out;
	
	always@*
		if(10*in3+in2 < 10*in1+in0)
			begin
			    sign=1;
				out =  (10*in1+in0) - (10*in3+in2);
			end
		else
			begin
				sign=0;
				out = (10*in3+in2) - (10*in1+in0);
			end
	
	always@* begin		
	   out0 = out-10*out1;
	   out1 = out/10;
	end
endmodule
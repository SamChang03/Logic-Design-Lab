module adder_2d(
	out2,
	out1,
	out0,
	in3,
	in2,
	in1,
	in0
	);
	
	output reg [3:0]out2;
	output reg [3:0]out1;
	output reg [3:0]out0;
	
	input [3:0]in3;
	input [3:0]in2;
	input [3:0]in1;
	input [3:0]in0;
	
	reg carry;
	reg [7:0]out;
	
	always@* begin	
	   out =  (10*in1+in0) + (10*in3+in2);	
	   out0 = out-10*out1-100*out2;
	   out1 = (out-out2*100)/10;
	   out2 = out/100;
	end
		
			
endmodule

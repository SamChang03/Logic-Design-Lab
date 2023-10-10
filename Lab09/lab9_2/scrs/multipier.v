module multiplier_2d(
	out3,
	out2,
	out1,
	out0,
	in3,
	in2,
	in1,
	in0
    );
	
	output reg [3:0]out3;
	output reg [3:0]out2;
	output reg [3:0]out1;
	output reg [3:0]out0;
	
	input [3:0]in3;
	input [3:0]in2;
	input [3:0]in1;
	input [3:0]in0;
	
	reg [13:0]decimal;
	
	always@*
        decimal = (((in3 * 14'd10) + in2) * ((in1 * 14'd10) + in0));
        
    always@*
        begin
            out3 = (decimal / 14'd1000);
            out2 = (decimal / 14'd100) - (out3 * 14'd10);
            out1 = (decimal / 14'd10) - (out3 * 14'd100) - (out2 * 14'd10);
            out0 = decimal % 14'd10;
        end
	
endmodule

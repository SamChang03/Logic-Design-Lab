module Random(
	q,
	position,
	rst
    );
	
	output reg [2:0]q;
	input [8:0]position;
	input rst;
	
	wire tmp;
	reg pulse;
	
	assign tmp = q[2]^q[1];
	
	always@*
	   if(position == 8'b0)
	       pulse = 1'b1;
	   else pulse = 1'b0;
	
	always@(posedge pulse or posedge rst)
	   if(rst)
	   begin
          q[0] <= 1'b1;
          q[1] <= 1'b1;
          q[2] <= 1'b1;
       end
	   else
	   begin
	       q[0] <= tmp;
		   q[1] <= q[0];
		   q[2] <= q[1];
	   end
		
endmodule
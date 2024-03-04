module down_counter(b0,b1,state,clk,rst_n);
output reg [3:0] b0;
output reg [3:0] b1;
input state;
input clk;
input rst_n;

reg [3:0]b0_temp;
reg [3:0]b1_temp;

//combination
always @*
begin
   case(state)
   1'b1: begin 
        if(b0==4'd0 && b1==4'd0) begin b0_temp= 1'b0; b1_temp= 1'b0; end
        else if(b0==4'd0) begin  b0_temp= 4'd9; b1_temp= b1-1'b1; end
        else begin b0_temp= b0 - 1'd1; b1_temp= b1; end
        end
   1'b0: begin b0_temp=b0;b1_temp=b1;end
   default: begin b0_temp=b0;b1_temp=b1;end
   endcase 
end

//sequencial
always @(posedge clk or posedge rst_n) 
if (rst_n) begin
  b0 <= 4'd0;
  b1 <= 4'd5;
  end
  
else begin
  b0 <= b0_temp;
  b1 <= b1_temp;
end
endmodule


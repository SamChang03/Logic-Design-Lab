module clock_divisor(clk1, clk, clk21);
input clk;
output clk1;
output clk21;
reg [21:0] num;
wire [21:0] next_num;

always @(posedge clk) begin
  num <= next_num;
end

assign next_num = num + 1'b1;
assign clk1 = num[1];
assign clk21 = num[20];
endmodule
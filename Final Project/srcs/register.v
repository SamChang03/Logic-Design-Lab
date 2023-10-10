module register(reg_out,reg_in,load_en,rst,clk);
output reg [5:0]reg_out;
input [5:0]reg_in;
input load_en,rst;
input clk;

reg [5:0]reg_out_temp;

always@*begin
if(load_en)
reg_out_temp = reg_in;
else
reg_out_temp = reg_out;
end


always@(posedge clk or posedge rst)begin
    if(rst)
    reg_out <= 5'd0;
    else
    reg_out <= reg_out_temp;
end
endmodule
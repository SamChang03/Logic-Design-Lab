module volume(amplitude_def,level0,level1,rst_n,up,down,clk);

input up,down,rst_n,clk;
output [15:0]amplitude_def;
output [3:0]level0,level1;

reg [3:0]cnt_tmp, cnt;

wire enable_up,enable_down;
reg [3:0] value0,value1;

assign level0= value0;
assign level1= value1;
assign amplitude_def = cnt*(16'h0300);

always@*
    if (up && cnt != 4'd15)
        cnt_tmp = cnt + 1;
    else if (down && cnt != 4'd0)
        cnt_tmp = cnt - 1;
    else
        cnt_tmp = cnt;

always@(posedge clk or negedge rst_n)
    if (~rst_n)
        cnt <= 6;
    else
        cnt <= cnt_tmp;

always@*
    if (cnt < 4'd10)
        begin
            value1 = 4'd0;
            value0 = cnt ;
        end
    else
        begin
            value1 = 4'd1;
            value0 = cnt - 4'd10;
        end

endmodule
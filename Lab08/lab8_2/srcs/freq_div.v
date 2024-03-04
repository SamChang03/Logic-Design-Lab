module freq_div(
clk_out, // divided clock output
clk, // global clock input
rst // active high reset
);

output [1:0] clk_out; // divided output
input clk; // global clock input
input rst; // active high reset
reg [15:0] cnt; // remainder of the counter
reg [15:0] cnt_tmp; // input to dff (in always block)
wire [1:0] clk_out;

// Dividied frequency
assign clk_out[0] = cnt[14];
assign clk_out[1] = cnt[15];

// Combinational logics: increment, neglecting overflow 
always @(cnt)
cnt_tmp = cnt + 1'b1;

// Sequential logics: Flip flops
always @(posedge clk or negedge rst)
if (~rst) 
cnt<=16'd0;
else 
cnt<=cnt_tmp;
endmodule
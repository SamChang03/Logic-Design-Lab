module one_pulse(out,in,rst,clk);
output reg out;
input in;
input rst;
input clk;

wire in_debounced;

debounce U0(.rst(rst), .clk(clk), .push(in), .push_debounced(in_debounced));

// internal registers
reg out_next;
reg in_debounced_delay;

always @* begin
out_next = in_debounced & ~in_debounced_delay;
end

always @(posedge clk or negedge rst) begin

if (~rst) begin
out <= 1'b0; 
in_debounced_delay <= 1'b0; 
end 

else begin
out <= out_next;
in_debounced_delay <= in_debounced;
end
end 
endmodule

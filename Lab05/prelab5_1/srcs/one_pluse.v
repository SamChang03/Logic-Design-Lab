module one_pluse(signal,rst,buttone,clk);
output reg signal;
input buttone;
input rst;
input clk;

wire buttone_debounced;

debounce U0(.rst(rst), .clk(clk), .push(buttone), .push_debounced(buttone_debounced));

// internal registers
reg signal_next;
reg buttone_debounced_delay;

always @* begin
signal_next = buttone_debounced & ~buttone_debounced_delay;
end

always @(posedge clk or posedge rst) begin

if (rst) begin
signal <= 1'b0; 
buttone_debounced_delay <= 1'b0; 
end 

else begin
signal <= signal_next;
buttone_debounced_delay <= buttone_debounced;
end
end 
endmodule

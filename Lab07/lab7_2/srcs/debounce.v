module debounce (rst, clk, push, push_debounced);
input rst;
input clk;
input push;
output push_debounced;

// declare the outputs
reg push_debounced;

// declare the shifting registers
reg[3:0] push_window;

always @(posedge clk or negedge rst) 
begin
    if (~rst) begin
    push_window <= 4'b0;
    push_debounced <= 1'b0;
    end 

    else begin
    push_window<={push, push_window[3:1]};
    
    if (push_window[3:0] == 4'b1111) begin
    push_debounced <= 1'b1; 
    end 

    else begin
    push_debounced <= 1'b0; 
    end 

end
end 
endmodule
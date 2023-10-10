module one_pulse(
    input reset,                     
    input pb_in,                       
    input f_crystal,                     
    output reg pb_pulse          
   );
    reg pb_debounced;
    reg [3:0] pb_debounce_window;          
    reg pb_debounced_next;  
    reg pb_delay;           
    wire clk10, clk100;
    
    frequency_divider f0(
    .clk10(clk10),
    .clk100(clk100),
    .f_crystal(f_crystal),
    .reset(reset)
    );
 
/************* debounce ********************************************/
    always@ (posedge clk100 or posedge reset) begin
        if (reset) begin
           pb_debounce_window <= 4'b0000; 
         end
        else begin
          pb_debounce_window <= {pb_debounce_window[2:0], pb_in};    
        end
    end
 
   always@ (posedge clk100 or posedge reset) begin
     if (reset) begin
         pb_debounced <= 1'b0;       
      end
       else begin
         pb_debounced <= pb_debounced_next;         
       end 
   end
   
   always@* begin
        if (pb_debounce_window == 4'b1111) pb_debounced_next <= 1'b1;
        else pb_debounced_next <= 1'b0;        
    end
 
 /************************* one_pulse ********************************************/  
 always@ (posedge clk10 or posedge reset) begin
   if (reset) begin         
       pb_delay <= 1'b0;
    end
    else begin       
        pb_delay <= pb_debounced;
     end
  end
  
 assign pb_pulse_next = pb_debounced  & (~pb_delay);

     
 always@ (posedge clk10 or posedge reset) begin
     if (reset) begin         
         pb_pulse <= 1'b0;
     end
     else begin           
         pb_pulse <=  pb_pulse_next;
     end
   end
    
endmodule
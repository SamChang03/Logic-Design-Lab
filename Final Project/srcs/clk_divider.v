module clk_divider(
    input f_crystal,
    input reset,
    output audio_mclk,
    output audio_lrck,
    output sampling_clk
    );  
    reg [8:0] q, q_temp;
 
    always@* begin     
       q_temp <= q + 9'd1;   
    end
    
    always@(posedge f_crystal or posedge reset) begin   
        if (reset) begin          
           q <= 9'd0;         
         end          
        else begin       
           q <= q_temp;         
      end
    end 
    
 assign  audio_mclk = q[1];
 assign  audio_lrck = q[8];
 assign  sampling_clk = q[3];  
    
endmodule
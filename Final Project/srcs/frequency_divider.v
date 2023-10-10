`define DIV_BY_50M_BCD_BIT_WIDTH 26
`define DIV_BY_50M 50_000_000
`define DIV_BY_500k_BCD_BIT_WIDTH 20
`define  DIV_BY_500k 50_000
`define DIV_BY_5000k_BCD_BIT_WIDTH 23
`define DIV_BY_5000k 5000_000 

module frequency_divider(
    input  f_crystal,                       // global clock with 100MHZ
    output reg  clk1, clk100, clk10,                    // divided clock
    input reset,
    output reg [1:0] ssd_ctl_en_set,
    output reg [1:0] ssd_ctl_en
    );
    reg [`DIV_BY_50M_BCD_BIT_WIDTH - 1:0]q_temp_50M, q_50M;          // output of DFFs
    reg [`DIV_BY_500k_BCD_BIT_WIDTH - 1:0]q_temp_500k, q_500k;       // input for DFFs
    reg [`DIV_BY_5000k_BCD_BIT_WIDTH - 1:0]q_temp_5000k, q_5000k;
  /***************************** frequency 10 HZ ********************************************************/
 always@(q_5000k) begin                                           // combinational circuit
          q_temp_5000k <= q_5000k + `DIV_BY_5000k_BCD_BIT_WIDTH'd1;
      end 
      
      always@(posedge f_crystal or posedge reset) begin            // sequential circuit
       if (reset) begin
         q_5000k <= `DIV_BY_5000k_BCD_BIT_WIDTH'd0;
         clk10 <= 1'b0;
        end
        else if (q_5000k == (`DIV_BY_5000k - 1)) begin
           q_5000k <= `DIV_BY_5000k_BCD_BIT_WIDTH'd0;
           clk10 = ~clk10;
         end
        else  begin
           q_5000k <= q_temp_5000k;
        end   
          ssd_ctl_en_set <= q_50M[14:13]; 
    end
  
/*********************frequency 5HZ * ****************************************************** */ 
    always@(q_50M) begin                                           // combinational circuit
        q_temp_50M <= q_50M + `DIV_BY_50M_BCD_BIT_WIDTH'd1;
    end 
    
    always@(posedge f_crystal or posedge reset) begin            // sequential circuit
     if (reset) begin
       q_50M <= `DIV_BY_50M_BCD_BIT_WIDTH'd0;
       clk1 <= 1'b0;
      end
      else if (q_50M == (`DIV_BY_50M - 1)) begin
         q_50M <= `DIV_BY_50M_BCD_BIT_WIDTH'd0;
         clk1 = ~clk1;
       end
      else  begin
         q_50M <= q_temp_50M;
      end
      ssd_ctl_en <= q_50M[17:16];
  end
 
  /**********frequency for 100HZ  *********************************************************** */ 
    always@(q_500k) begin                                         // combinational circuit
        q_temp_500k <= q_500k + `DIV_BY_500k_BCD_BIT_WIDTH'd1;
    end 
    
     always@(posedge f_crystal or posedge reset) begin        // sequential circuit
       if (reset) begin
       q_500k <= `DIV_BY_500k_BCD_BIT_WIDTH'd0;
       clk100 <= 1'b0;
       end
       else if (q_500k == (`DIV_BY_500k - 1)) begin
            q_500k <= `DIV_BY_500k_BCD_BIT_WIDTH'd0;
             clk100 = ~clk100;
       end
       else  begin
        q_500k <= q_temp_500k;
      end
     
  end
 
endmodule
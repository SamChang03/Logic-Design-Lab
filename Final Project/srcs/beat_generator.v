module beat_generator(
    input  f_crystal,                                        
    input reset,  
    output reg bpm75, bpm125, bpm25 ,bpm200
    );
    reg [25:0]q_temp_14M, q_14M;
    reg [25:0]q_temp_10M, q_10M;  
    reg [25:0] q_temp_6M, q_6M;        
    reg [25:0] q_temp_4500K, q_4500K;
 
/********************* bpm200  * 4 * ****************************************************** */ 
    always@(*) begin                                           // combinational circuit
        q_temp_4500K <= q_4500K + 26'd1;
    end 
    
    always@(posedge f_crystal or posedge reset) begin            // sequential circuit
     if (reset) begin
       q_4500K <= 26'd0;
       bpm200 <= 1'b0;
      end
      else if (q_4500K == (4_500_000 - 1)) begin
         q_4500K <= 26'd0;
         bpm200 <= ~bpm200;
       end
      else  begin
         q_4500K <= q_temp_4500K;
          bpm200 <= bpm200;
      end   
  end
    
/********************* bpm75  * 4 * ****************************************************** */ 
    always@(*) begin                                           // combinational circuit
        q_temp_10M <= q_10M + 26'd1;
    end 
    
    always@(posedge f_crystal or posedge reset) begin            // sequential circuit
     if (reset) begin
       q_10M <= 26'd0;
       bpm75 <= 1'b0;
      end
      else if (q_10M == (10_000_000 - 1)) begin
         q_10M <= 26'd0;
         bpm75 <= ~bpm75;
       end
      else  begin
         q_10M <= q_temp_10M;
          bpm75 <= bpm75;
      end   
  end
  
 /* ********************* bpm25  * 4 * ****************************************************** */ 
    always@(*) begin                                           // combinational circuit
        q_temp_14M <= q_14M + 26'd1;
    end 
    
    always@(posedge f_crystal or posedge reset) begin            // sequential circuit
     if (reset) begin
       q_14M <= 26'd0;
       bpm25 <= 1'b0;
      end
      else if (q_14M == (14_000_000 - 1)) begin
         q_14M <= 26'd0;
         bpm25 <= ~bpm25;
       end
      else  begin
         q_14M <= q_temp_14M;
          bpm25 <= bpm25;
      end   
  end
 
/*******************bpm 125 * 4 **************************************************************************/ 
    always@(*) begin
         q_temp_6M <= q_6M + 26'd1;
    end
    
    always@(posedge f_crystal or posedge reset) begin
        if (reset) begin
            q_6M <= 26'd0;
            bpm125 <= 1'b0;
        end
        else if (q_6M == (6_000_000 - 1)) begin
            q_6M <= 26'd0;
            bpm125 <= ~bpm125;
        end
        else begin
            q_6M <= q_temp_6M;
            bpm125 <= bpm125;
        end
    end
endmodule

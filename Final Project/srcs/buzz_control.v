module buzz_control(
    input f_crystal,
    input reset,
    input BGM_on_off,
    input vol_up_pulse, vol_down_pulse,
    input [21:0] note_div1, note_div2, 
    output reg [15:0] audio1, audio2
    );
   reg [21:0] clk_cnt1, clk_cnt_next1;
   reg [21:0] clk_cnt2, clk_cnt_next2;   
   reg b_clk1, b_clk_next1; 
   reg b_clk2, b_clk_next2;
   reg [3:0] count, count_next;
   reg [15:0] volume_max;
   wire clk10;
 
 frequency_divider f0(
 .reset(reset),
 .f_crystal(f_crystal),
 .clk10(clk10)
 );
 
/********************** audio1**********************************************/
always@(posedge f_crystal or posedge reset) begin
    if (reset) begin
        clk_cnt1 <= 22'd0;
        b_clk1 <= 1'b0;
    end
    else begin
        clk_cnt1 <= clk_cnt_next1;
        b_clk1 <= b_clk_next1;
    end
end

always@* begin
   if (clk_cnt1 == note_div1) begin
       clk_cnt_next1 <= 22'd0;
       b_clk_next1 <= ~b_clk1;   
   end
   else begin
       clk_cnt_next1 <= clk_cnt1 + 1'b1;
       b_clk_next1 <= b_clk1;
   end  
end



/********************** audio2 **************************************/
always@(posedge f_crystal or posedge reset) begin
    if (reset) begin
        clk_cnt2 <= 22'd0;
        b_clk2 <= 1'b0;
    end
    else begin
        clk_cnt2 <= clk_cnt_next2;
        b_clk2 <= b_clk_next2;
    end
end

always@* begin
   if (clk_cnt2 == note_div2) begin
       clk_cnt_next2 <= 22'd0;
       b_clk_next2 <= ~b_clk2;   
   end
   else begin
       clk_cnt_next2 <= clk_cnt2 + 1'b1;
       b_clk_next2 <= b_clk2;
   end  
end

 /************  amplitude ******************************************/
 
 always@(posedge clk10 or posedge reset) begin
    if (reset) count <= 4'd15;
    else if (~BGM_on_off) count <= 4'd0;
    else count <= count_next;
 end
 
 always@(*) begin
    if (vol_up_pulse & (count<4'd15)) count_next <= count + 4'd1;
    else if (vol_down_pulse& (count>4'd0)) count_next <= count - 4'd1;
    else count_next <= count;
 end
 
     always@* begin
     case(count)
       4'd0: volume_max <= 16'h0000; 
       4'd1: volume_max <= 16'h0611;
       4'd2: volume_max <= 16'h0611;
       4'd3: volume_max <= 16'h0c22;
       4'd4: volume_max <= 16'h0c22;
       4'd5: volume_max <= 16'h1333;
       4'd6: volume_max <= 16'h1333;
       4'd7: volume_max <= 16'h1944;  
       4'd8: volume_max <= 16'h1944;
       4'd9: volume_max <= 16'h1f55;
       4'd10: volume_max <= 16'h1f55; 
       4'd11: volume_max <= 16'h2666;
       4'd12: volume_max <= 16'h2666;
       4'd13: volume_max <= 16'h2c77;
       4'd14: volume_max <= 16'h2c77;
       4'd15: volume_max <= 16'h3388;
       default: volume_max <= 16'h0000;   
    endcase 
 end 
 
 always@* begin
    if (b_clk1 == 1'b0) audio1 <= volume_max;
    else audio1 <= (~volume_max) + 16'd1;
 end
 
 always@* begin
    if (b_clk2 == 1'b0) audio2 <= volume_max;
    else audio2 <= (~volume_max) + 16'd1;
 end

endmodule
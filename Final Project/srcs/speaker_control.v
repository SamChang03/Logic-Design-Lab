module speaker_control(
    input f_crystal,
    input reset,
    input [15:0] audio1, audio2,
    output audio_mclk,      // 25MHZ
    output audio_lrck,      // 25/128 MHZ
    output audio_sck,       // 25/4 MHZ
    output reg audio_sdin
 );
    wire sampling_clk;
    reg audio_sdin_next;
    reg [4:0] count;
    reg [4:0] count_next;
    
    clk_divider U0(
    .f_crystal(f_crystal),
    .reset(reset),
    .audio_mclk(audio_mclk),
    .audio_lrck(audio_lrck),
    .sampling_clk(sampling_clk)
    );

     assign audio_sck = sampling_clk;

   always@(posedge sampling_clk) begin
       if (count == 5'd31) count_next <= 5'd0;
       else count_next <= count + 5'd1; 
   end
      
    always@(posedge sampling_clk or posedge reset) begin
        if (reset) count <= 5'd0;
        else count <= count_next;   
    end 
    
    always@(posedge sampling_clk or posedge reset) begin
        if (reset) audio_sdin <= 1'b0;
        else audio_sdin <= audio_sdin_next;  
    end
    
    always@* begin
        case(count)
            5'd0: audio_sdin_next  <= audio1[15];
            5'd1: audio_sdin_next  <= audio1[14];
            5'd2: audio_sdin_next  <= audio1[13];
            5'd3: audio_sdin_next  <= audio1[12];
            5'd4: audio_sdin_next  <= audio1[11];
            5'd5: audio_sdin_next  <= audio1[10];
            5'd6: audio_sdin_next  <= audio1[9];
            5'd7: audio_sdin_next  <= audio1[8];
            5'd8: audio_sdin_next  <= audio1[7];
            5'd9: audio_sdin_next  <= audio1[6];
            5'd10: audio_sdin_next  <= audio1[5];
            5'd11: audio_sdin_next  <= audio1[4];
            5'd12: audio_sdin_next  <= audio1[3];
            5'd13: audio_sdin_next  <= audio1[2];
            5'd14: audio_sdin_next  <= audio1[1];
            5'd15: audio_sdin_next  <= audio1[0];
            5'd16: audio_sdin_next  <= audio2[15];
            5'd17: audio_sdin_next  <= audio2[14];
            5'd18: audio_sdin_next  <= audio2[13];
            5'd19: audio_sdin_next  <= audio2[12];
            5'd20: audio_sdin_next  <= audio2[11];
            5'd21: audio_sdin_next  <= audio2[10];
            5'd22: audio_sdin_next  <= audio2[9];
            5'd23: audio_sdin_next  <= audio2[8];
            5'd24: audio_sdin_next  <= audio2[7];
            5'd25: audio_sdin_next  <= audio2[6];
            5'd26: audio_sdin_next  <= audio2[5];
            5'd27: audio_sdin_next  <= audio2[4];
            5'd28: audio_sdin_next  <= audio2[3];
            5'd29: audio_sdin_next  <= audio2[2];
            5'd30: audio_sdin_next  <= audio2[1];
            5'd31: audio_sdin_next  <= audio2[0];
            default: audio_sdin_next  <= audio_sdin;
        endcase
    end
    
endmodule
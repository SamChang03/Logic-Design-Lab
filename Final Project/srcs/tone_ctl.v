module tone_ctl(  
    input reset,
    input f_crystal,
    input game_start,
    input gaming,
    input game_over,
    input pause,
    output reg [21:0] note_div1, 
    output reg [21:0] note_div2
    );
    
    wire bpm75, bpm125,bpm25,bpm200;
    wire [21:0] note_div_Rock_1, note_div_Rock_2;
    wire [21:0] note_div_Sad1, note_div_Sad2;
    wire [21:0] note_div_Mario1, note_div_Mario2;
   
   
   beat_generator f0(
   .reset(reset),
   .f_crystal(f_crystal),
   .bpm75(bpm75),
   .bpm125(bpm125),
   .bpm25(bpm25),
   .bpm200(bpm200)
   );         
        
   Rock_You d0(
   .beat(bpm200),
   .reset(reset|pause|game_over|gaming),
   .note_div1(note_div_Rock_1),
   .note_div2(note_div_Rock_2)  
   );
   
   Big_Sad d1(
   .beat(bpm125),
   .reset(reset|pause|gaming|game_start),
   .note_div1(note_div_Sad1),
   .note_div2(note_div_Sad2)
   );
   
   Mario d2(
   .reset(reset|pause|game_over|game_start),
   .beat(bpm200),
   .note_div1(note_div_Mario1),
   .note_div2(note_div_Mario2)
   );
  
   always@* begin
      if (game_start) begin
        note_div1 <= note_div_Rock_1;
        note_div2 <= note_div_Rock_2;
       end
       else if (gaming) begin
        note_div1 <= note_div_Mario1;
        note_div2 <= 0;
       end
       else if(game_over) begin
        note_div1 <= note_div_Sad1;
        note_div2 <= note_div_Sad2;
       end
       else begin
        note_div1 <= 0;
        note_div2 <= 0;
       end
   end
endmodule

`define C4 191570
`define D4 170648
`define bE4 160704
`define E4 151515
`define F4 143266
`define G4 127551
`define bA4 120395
`define A4 113636
`define bB4 107259
`define B4 101239


`define C5 95419
`define D5 85134
`define bE5 80353 
`define E5 75843
`define A5 56818

`define bB3 214519
`define bA3 214517
`define G3 255105
`define F3 286346
`define bE3 321413
`define D3 340525
`define C3 382225

`define C6 47778

module Big_Sad(
    input beat,
    input reset,
    output reg [21:0] note_div1, note_div2
    );
    
    reg [6:0] count, count_next;
    reg [21:0] note_div1_next, note_div2_next;
 
    
 always@(posedge beat or posedge reset) begin
    if (reset) count <= 7'd71;                 
    else   count <= count_next;     
 end

always@* begin
    if (count == 7'd71) count_next <= 7'd0;
    else count_next <= count + 7'd1;
end
    
  always@(posedge beat or posedge reset) begin
    if (reset) begin
        note_div1 <= 22'd0;
        note_div2 <= 22'd0;          
    end
    else  begin
        note_div1 <= note_div1_next;
        note_div2 <= note_div2_next;    
     end
  end  
    
    
always@(*) begin
    case (count)
          7'd0: note_div1_next <= `C5;
          7'd1: note_div1_next <= 0;
          7'd2: note_div1_next <= `bB4;
          7'd3: note_div1_next <= 0;
          7'd4: note_div1_next <= `A4;
          7'd5: note_div1_next <= 0;
          7'd6: note_div1_next <= `F4;
          7'd7: note_div1_next <= 0;
          7'd8: note_div1_next <= `G4;
          7'd11: note_div1_next <= 0;
          7'd12: note_div1_next <= `G4;
          7'd13: note_div1_next <= 0;
          7'd14: note_div1_next <= `D5;
          7'd15: note_div1_next <= 0;
          7'd16: note_div1_next <= `C5;
          7'd20: note_div1_next <= `bB4;
          7'd24: note_div1_next <= `A4;
          7'd27: note_div1_next <= 0;
          7'd28: note_div1_next <= `A4;
          7'd29: note_div1_next <= 0;
          7'd30: note_div1_next <= `A4;
          7'd32: note_div1_next <= `C5;
          7'd36: note_div1_next <= `bB4;
          7'd37: note_div1_next <= 0;
          7'd38: note_div1_next <= `A4;
          7'd39: note_div1_next <= 0;
          7'd40: note_div1_next <= `G4;
          7'd43: note_div1_next <= 0;
          7'd44: note_div1_next <= `G4;
          7'd45: note_div1_next <= 0;
          7'd46: note_div1_next <= `C6;
          7'd47: note_div1_next <= 0;
          7'd48: note_div1_next <= `A5;
          7'd49: note_div1_next <= 0;
          7'd50: note_div1_next <= `C6;
          7'd51: note_div1_next <= 0;
          7'd52: note_div1_next <= `A5;
          7'd53: note_div1_next <= 0;
          7'd54: note_div1_next <= `C6;
          7'd55: note_div1_next <= 0;
          7'd56: note_div1_next <= `G4;
          7'd50: note_div1_next <= 0;
          7'd60: note_div1_next <= `G4;
          7'd61: note_div1_next <= 0;
          7'd62: note_div1_next <= `C6;
          7'd64: note_div1_next <= `A5;
          7'd65: note_div1_next <= 0;
          7'd66: note_div1_next <= `C6;
          7'd67: note_div1_next <= 0;
          7'd68: note_div1_next <= `A5;
          7'd69: note_div1_next <= 0;
          7'd70: note_div1_next <= `C6;
          7'd71: note_div1_next <= 0; 
          default: note_div1_next <= note_div1;      
    endcase
end    
 always@* begin   
    case(count)
        7'd8: note_div2_next <= `bE3;
        7'd10: note_div2_next <= `bE4;
        7'd12: note_div2_next <= `bE3;
        7'd14: note_div2_next <= `bE4;
        7'd16: note_div2_next <= `bE3;
        7'd18: note_div2_next <= `bE4;
        7'd20: note_div2_next <= `bE3;
        7'd22: note_div2_next <= `bE4;
        7'd24: note_div2_next <= `F3;
        7'd26: note_div2_next <= `F4;
        7'd28: note_div2_next <= `F3;
        7'd30: note_div2_next <= `F4;
        7'd32: note_div2_next <= `F3;
        7'd34: note_div2_next <= `F4;
        7'd36: note_div2_next <= `F3;
        7'd38: note_div2_next <= `F4;
        7'd40: note_div2_next <= `G3;
        7'd42: note_div2_next <= `G4;
        7'd44: note_div2_next <= `G3;
        7'd46: note_div2_next <= `G4;
        7'd48: note_div2_next <= `G3;
        7'd50: note_div2_next <= `G4;
        7'd52: note_div2_next <= `G3;
        7'd54: note_div2_next <= `G4;
        7'd56: note_div2_next <= `G3;
        7'd58: note_div2_next <= `G4;
        7'd60: note_div2_next <= `G3;
        7'd62: note_div2_next <= `G4;
        7'd64: note_div2_next <= `G3;
        7'd66: note_div2_next <= `G4;
        7'd68: note_div2_next <= `G3;
        7'd70: note_div2_next <= `G4;     
        default: note_div2_next <= note_div2;
        endcase
 end
endmodule
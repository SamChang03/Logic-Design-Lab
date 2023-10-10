`define C4 191570
`define D4 170648
`define E4 151515
`define F4 143266
`define bG4 135135
`define G4 127551
`define bA4 120395
`define A4 113636
`define bB4 107259
`define B4 101239

`define C5 95419
`define D5 85134
`define bE5 80353 
`define E5 75843
`define F5 71586
`define bG5 67568
`define G5 63776
`define A5 56818
`define B5 50619

`define G3 255105
`define F3 286346
`define E3 303379
`define bE3 321413
`define D3 340525
`define C3 382225

`define C6 47778

module Mario(
    input beat,
    input reset,
    output reg [21:0] note_div1, note_div2
    );
    
    reg [8:0] count, count_next;
    reg [21:0] note_div1_next, note_div2_next;
 
    
 always@(posedge beat or posedge reset) begin
    if (reset) count <= 9'd340;                 
    else   count <= count_next;     
 end

always@* begin
    if (count == 9'd340) count_next <= 9'd1;
    else count_next <= count + 9'd1;
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
    9'd0: note_div1_next <= 0;
    
    9'd1: note_div1_next <= `C5;
    9'd2: note_div1_next <= `C5;
    9'd3: note_div1_next <= `C5;
    9'd4: note_div1_next <= `C5;
    9'd5: note_div1_next <= `C5;
    9'd6: note_div1_next <= 0;
    9'd7: note_div1_next <= `G4;
    9'd8: note_div1_next <= `G4;
    
    9'd9: note_div1_next <= `G4;
    9'd10: note_div1_next <= `G4;
    9'd11: note_div1_next <= `G4;
    9'd12: note_div1_next <= 0;
    9'd13: note_div1_next <= `E4;
    9'd14: note_div1_next <= `E4;
    9'd15: note_div1_next <= `E4;
    9'd16: note_div1_next <= `E4;
    
    9'd17: note_div1_next <= `E4;
    9'd18: note_div1_next <= 0;
    9'd19: note_div1_next <= `A4;
    9'd20: note_div1_next <= `A4;
    9'd21: note_div1_next <= `A4;
    9'd22: note_div1_next <= 0;
    9'd23: note_div1_next <= `B4;
    9'd24: note_div1_next <= `B4;
    
    9'd25: note_div1_next <= `B4;
    9'd26: note_div1_next <= 0;
    9'd27: note_div1_next <= `bB4;
    9'd28: note_div1_next <= 0;
    9'd29: note_div1_next <= `A4;
    9'd30: note_div1_next <= `A4;
    9'd31: note_div1_next <= `D5;
    9'd32: note_div1_next <= 0;
    
    9'd33: note_div1_next <= `G4;
    9'd34: note_div1_next <= `G4;
    9'd35: note_div1_next <= `G4;
    9'd36: note_div1_next <= 0;
    9'd37: note_div1_next <= `E5;
    9'd38: note_div1_next <= `E5;
    9'd39: note_div1_next <= `E5;
    9'd40: note_div1_next <= 0;
    
    9'd41: note_div1_next <= `G5;
    9'd42: note_div1_next <= `G5;
    9'd43: note_div1_next <= `G5;
    9'd44: note_div1_next <= 0;
    9'd45: note_div1_next <= `A5;
    9'd46: note_div1_next <= `A5;
    9'd47: note_div1_next <= `A5;
    9'd48: note_div1_next <= 0;
    
    9'd49: note_div1_next <= `F5;
    9'd50: note_div1_next <= 0;
    9'd51: note_div1_next <= `G5;
    9'd52: note_div1_next <= `G5;
    9'd53: note_div1_next <= `G5;
    9'd54: note_div1_next <= 0;
    9'd55: note_div1_next <= `E5;
    9'd56: note_div1_next <= `E5;
    
    9'd57: note_div1_next <= `E5;
    9'd58: note_div1_next <= 0;
    9'd59: note_div1_next <= `C5;
    9'd60: note_div1_next <= 0;
    9'd61: note_div1_next <= `D5;
    9'd62: note_div1_next <= 0;
    9'd63: note_div1_next <= `B4;
    9'd64: note_div1_next <= `B4;
    
    9'd65: note_div1_next <= `B4;
    9'd66: note_div1_next <= 0;
    
    9'd67: note_div1_next <= `C5;
    9'd68: note_div1_next <= `C5;
    9'd69: note_div1_next <= `C5;
    9'd70: note_div1_next <= `C5;
    9'd71: note_div1_next <= `C5;
    9'd72: note_div1_next <= 0;
    9'd73: note_div1_next <= `G4;
    9'd74: note_div1_next <= `G4;
    
    9'd75: note_div1_next <= `G4;
    9'd76: note_div1_next <= `G4;
    9'd77: note_div1_next <= `G4;
    9'd78: note_div1_next <= 0;
    9'd79: note_div1_next <= `E4;
    9'd80: note_div1_next <= `E4;
    9'd81: note_div1_next <= `E4;
    9'd82: note_div1_next <= `E4;
    
    9'd83: note_div1_next <= `E4;
    9'd84: note_div1_next <= 0;
    9'd85: note_div1_next <= `A4;
    9'd86: note_div1_next <= `A4;
    9'd87: note_div1_next <= `A4;
    9'd88: note_div1_next <= 0;
    9'd89: note_div1_next <= `B4;
    9'd90: note_div1_next <= `B4;
    
    9'd91: note_div1_next <= `B4;
    9'd92: note_div1_next <= 0;
    9'd93: note_div1_next <= `bB4;
    9'd94: note_div1_next <= 0;
    9'd95: note_div1_next <= `A4;
    9'd96: note_div1_next <= `A4;
    9'd97: note_div1_next <= `D5;
    9'd98: note_div1_next <= 0;
    
    9'd99: note_div1_next <= `G4;
    9'd100: note_div1_next <= `G4;
    9'd101: note_div1_next <= `G4;
    9'd102: note_div1_next <= 0;
    9'd103: note_div1_next <= `E5;
    9'd104: note_div1_next <= `E5;
    9'd105: note_div1_next <= `E5;
    9'd106: note_div1_next <= 0;
    
    9'd107: note_div1_next <= `G5;
    9'd108: note_div1_next <= `G5;
    9'd109: note_div1_next <= `G5;
    9'd110: note_div1_next <= 0;
    9'd111: note_div1_next <= `A5;
    9'd112: note_div1_next <= `A5;
    9'd113: note_div1_next <= `A5;
    9'd114: note_div1_next <= 0;
    
    9'd115: note_div1_next <= `F5;
    9'd116: note_div1_next <= 0;
    9'd117: note_div1_next <= `G5;
    9'd118: note_div1_next <= `G5;
    9'd119: note_div1_next <= `G5;
    9'd120: note_div1_next <= 0;
    9'd121: note_div1_next <= `E5;
    9'd122: note_div1_next <= `E5;
    
    9'd123: note_div1_next <= `E5;
    9'd124: note_div1_next <= 0;
    9'd125: note_div1_next <= `C5;
    9'd126: note_div1_next <= 0;
    9'd127: note_div1_next <= `D5;
    9'd128: note_div1_next <= 0;
    9'd129: note_div1_next <= `B4;
    9'd130: note_div1_next <= `B4;
    
    9'd131: note_div1_next <= `B4;
    9'd132: note_div1_next <= 0;
    /*** ------------***/
    9'd133: note_div1_next <= `G5;
    9'd134: note_div1_next <= 0;
    9'd135: note_div1_next <= `bG5;
    9'd136: note_div1_next <= 0;
    
    9'd137: note_div1_next <= `F5;
    9'd138: note_div1_next <= 0;
    9'd139: note_div1_next <= `bE5;
    9'd140: note_div1_next <= `bE5;
    9'd141: note_div1_next <= `bE5;
    9'd142: note_div1_next <= 0;
    9'd143: note_div1_next <= `E5;
    9'd144: note_div1_next <= `E5;
    
    9'd145: note_div1_next <= `E5;
    9'd146: note_div1_next <= 0;
    9'd147: note_div1_next <= `bG4;
    9'd148: note_div1_next <= 0;
    9'd149: note_div1_next <= `A4;
    9'd150: note_div1_next <= 0;
    9'd151: note_div1_next <= `C5;
    9'd152: note_div1_next <= `C5;
    
    9'd153: note_div1_next <= `C5;
    9'd154: note_div1_next <= 0;
    9'd155: note_div1_next <= `A4;
    9'd156: note_div1_next <= 0;
    9'd157: note_div1_next <= `C5;
    9'd158: note_div1_next <= 0;
    9'd159: note_div1_next <= `D5;
    9'd160: note_div1_next <= 0;//D5
    
    9'd161: note_div1_next <= 0;
    9'd162: note_div1_next <= 0;
    9'd163: note_div1_next <= `G5;
    9'd164: note_div1_next <= 0;
    9'd165: note_div1_next <= `bG5;
    9'd166: note_div1_next <= 0;
    
    9'd167: note_div1_next <= `G5;
    9'd168: note_div1_next <= 0;
    9'd169: note_div1_next <= `bE5;
    9'd170: note_div1_next <= `bE5;
    9'd171: note_div1_next <= `bE5;
    9'd172: note_div1_next <= 0;
    9'd173: note_div1_next <= `E5;
    9'd174: note_div1_next <= `E5;
    
    9'd175: note_div1_next <= `E5;
    9'd176: note_div1_next <= 0;
    9'd177: note_div1_next <= `C6;
    9'd178: note_div1_next <= `C6;
    9'd179: note_div1_next <= `C6;
    9'd180: note_div1_next <= 0;
    9'd181: note_div1_next <= `C6;
    9'd182: note_div1_next <= 0;
    
    9'd183: note_div1_next <= `C6;
    9'd184: note_div1_next <= `C6;
    9'd185: note_div1_next <= `C6;
    9'd186: note_div1_next <= 0;
    9'd187: note_div1_next <= 0;
    9'd188: note_div1_next <= 0;
    9'd189: note_div1_next <= `G5;
    9'd190: note_div1_next <= 0;
    9'd191: note_div1_next <= `bG5;
    9'd192: note_div1_next <= 0;
    
    9'd193: note_div1_next <= `F5;
    9'd194: note_div1_next <= 0;
    9'd195: note_div1_next <= `bE5;
    9'd196: note_div1_next <= `bE5;
    9'd197: note_div1_next <= `bE5;
    9'd198: note_div1_next <= 0;
    9'd199: note_div1_next <= `E5;
    9'd200: note_div1_next <= `E5;
    
    9'd201: note_div1_next <= `E5;
    9'd202: note_div1_next <= 0;
    9'd203: note_div1_next <= `bG4;
    9'd204: note_div1_next <= 0;
    9'd205: note_div1_next <= `A4;
    9'd206: note_div1_next <= 0;
    9'd207: note_div1_next <= `C5;
    9'd208: note_div1_next <= `C5;
    
    9'd209: note_div1_next <= `C5;
    9'd210: note_div1_next <= 0;
    9'd211: note_div1_next <= `A4;
    9'd212: note_div1_next <= 0;
    9'd213: note_div1_next <= `C5;
    9'd214: note_div1_next <= 0;
    9'd215: note_div1_next <= `D5;
    9'd216: note_div1_next <= 0;
    
    9'd217: note_div1_next <= 0;
    9'd218: note_div1_next <= 0;
    9'd219: note_div1_next <= `bE5;
    9'd220: note_div1_next <= `bE5;
    9'd221: note_div1_next <= `bE5;
    9'd222: note_div1_next <= 0;
    9'd223: note_div1_next <= `D5;
    9'd224: note_div1_next <= `D5;
    
    9'd225: note_div1_next <= `D5;
    9'd226: note_div1_next <=  0;
    9'd227: note_div1_next <= `C5;
    9'd228: note_div1_next <= `C5;
    9'd229: note_div1_next <= `C5;
    9'd230: note_div1_next <= `C5;
    9'd231: note_div1_next <= `C5;
    9'd232: note_div1_next <= `C5;
    
    9'd233: note_div1_next <= `C5;
    9'd234: note_div1_next <= `C5;
    9'd235: note_div1_next <= `C5;
    9'd236: note_div1_next <= 0;
    9'd237: note_div1_next <= `C5;
    9'd238: note_div1_next <= 0;
    9'd239: note_div1_next <= `C5;
    9'd240: note_div1_next <= `C5;
    
    9'd241: note_div1_next <= `C5;
    9'd242: note_div1_next <= 0;
    9'd243: note_div1_next <= `C5;
    9'd244: note_div1_next <= `C5;
    9'd245: note_div1_next <= `C5;
    9'd246: note_div1_next <= 0;
    9'd247: note_div1_next <= `C5;
    9'd248: note_div1_next <= 0;
    
    9'd249: note_div1_next <= `D5;
    9'd250: note_div1_next <= `D5;
    9'd251: note_div1_next <= `D5;
    9'd252: note_div1_next <= 0;
    9'd253: note_div1_next <= `E5;
    9'd254: note_div1_next <= 0;
    9'd255: note_div1_next <= `C5;
    9'd256: note_div1_next <= `C5;
    
    9'd257: note_div1_next <= `C5;
    9'd258: note_div1_next <= 0;
    9'd259: note_div1_next <= `A4;
    9'd260: note_div1_next <= 0;
    9'd261: note_div1_next <= `G4;
    9'd262: note_div1_next <= `G4;
    9'd263: note_div1_next <= `G4;
    9'd264: note_div1_next <= 0;
    
    9'd265: note_div1_next <= `C5;
    9'd266: note_div1_next <= 0;
    9'd267: note_div1_next <= `C5;
    9'd268: note_div1_next <= `C5;
    9'd269: note_div1_next <= `C5;
    9'd270: note_div1_next <= 0;
    9'd271: note_div1_next <= `C5;
    9'd272: note_div1_next <= `C5;
    
    9'd273: note_div1_next <= `C5;
    9'd274: note_div1_next <= 0;
    9'd275: note_div1_next <= `C5;
    9'd276: note_div1_next <= 0;
    9'd277: note_div1_next <= `D5;
    9'd278: note_div1_next <= 0;
    9'd279: note_div1_next <= `E5;
    9'd280: note_div1_next <= `E5;
    
    9'd281: note_div1_next <= `E5;
    9'd282: note_div1_next <= `E5;
    9'd283: note_div1_next <= `E5;
    9'd284: note_div1_next <= `E5;
    9'd285: note_div1_next <= `E5;
    9'd286: note_div1_next <= `E5;
    9'd287: note_div1_next <= `E5;
    9'd288: note_div1_next <= 0;
   
    9'd289: note_div1_next <= `C5;
    9'd290: note_div1_next <= 0;
    9'd291: note_div1_next <= `C5;
    9'd292: note_div1_next <= `C5;
    
    9'd293: note_div1_next <= `C5;
    9'd294: note_div1_next <= 0;
    9'd295: note_div1_next <= `C5;
    9'd296: note_div1_next <= `C5;
    9'd297: note_div1_next <= `C5;
    9'd298: note_div1_next <= 0;
    9'd299: note_div1_next <= `C5;
    9'd300: note_div1_next <= 0;
    
    9'd301: note_div1_next <= `D5;
    9'd302: note_div1_next <= `D5;
    9'd303: note_div1_next <= `D5;
    9'd304: note_div1_next <= 0;
    9'd305: note_div1_next <= `E5;
    9'd306: note_div1_next <= 0;
    9'd307: note_div1_next <= `C5;
    9'd308: note_div1_next <= `C5;
    
    9'd309: note_div1_next <= `C5;
    9'd310: note_div1_next <= 0;
    9'd311: note_div1_next <= `A4;
    9'd312: note_div1_next <= 0;
    9'd313: note_div1_next <= `G4;
    9'd314: note_div1_next <= `G4;
    9'd315: note_div1_next <= `G4;
    9'd316: note_div1_next <= 0;
    
    9'd317: note_div1_next <= `E5;
    9'd318: note_div1_next <= 0;
    9'd319: note_div1_next <= `E5;
    9'd320: note_div1_next <= `E5;
    9'd321: note_div1_next <= `E5;
    9'd322: note_div1_next <= 0;
    9'd323: note_div1_next <= `E5;
    9'd324: note_div1_next <= `E5;
    
    9'd325: note_div1_next <= `E5;
    9'd326: note_div1_next <= 0;
    9'd327: note_div1_next <= `D5;
    9'd328: note_div1_next <= 0;
    9'd329: note_div1_next <= `E5;
    9'd330: note_div1_next <= `E5;
    9'd331: note_div1_next <= `E5;
    9'd332: note_div1_next <= 0;
    
    9'd333: note_div1_next <= `G5;
    9'd334: note_div1_next <= `G5;
    9'd335: note_div1_next <= `G5;
    9'd336: note_div1_next <= `G5;
    9'd337: note_div1_next <= `G5;
    9'd338: note_div1_next <= `G5;
    9'd339: note_div1_next <= `G5;
    9'd340: note_div1_next <= 0;
     
    default: note_div1_next <= note_div1;      
    endcase
end    
 always@* begin   
    case(count)
    9'd0: note_div2_next <= 0;
    
    9'd1: note_div2_next <= `C5;
    9'd2: note_div2_next <= `C5;
    9'd3: note_div2_next <= `C5;
    9'd4: note_div2_next <= `C5;
    9'd5: note_div2_next <= `C5;
    9'd6: note_div2_next <= 0;
    9'd7: note_div2_next <= `G4;
    9'd8: note_div2_next <= `G4;
    
    9'd9: note_div2_next <= `G4;
    9'd10: note_div2_next <= `G4;
    9'd11: note_div2_next <= `G4;
    9'd12: note_div2_next <= 0;
    9'd13: note_div2_next <= `E4;
    9'd14: note_div2_next <= `E4;
    9'd15: note_div2_next <= `E4;
    9'd16: note_div2_next <= `E4;
    
    9'd17: note_div2_next <= `E4;
    9'd18: note_div2_next <= 0;
    9'd19: note_div2_next <= `A4;
    9'd20: note_div2_next <= `A4;
    9'd21: note_div2_next <= `A4;
    9'd22: note_div2_next <= 0;
    9'd23: note_div2_next <= `B4;
    9'd24: note_div2_next <= `B4;
    
    9'd25: note_div2_next <= `B4;
    9'd26: note_div2_next <= 0;
    9'd27: note_div2_next <= `bB4;
    9'd28: note_div2_next <= 0;
    9'd29: note_div2_next <= `A4;
    9'd30: note_div2_next <= `A4;
    9'd31: note_div2_next <= `D5;
    9'd32: note_div2_next <= 0;
    
    9'd33: note_div2_next <= `G4;
    9'd34: note_div2_next <= `G4;
    9'd35: note_div2_next <= `G4;
    9'd36: note_div2_next <= 0;
    9'd37: note_div2_next <= `E5;
    9'd38: note_div2_next <= `E5;
    9'd39: note_div2_next <= `E5;
    9'd40: note_div2_next <= 0;
    
    9'd41: note_div2_next <= `G5;
    9'd42: note_div2_next <= `G5;
    9'd43: note_div2_next <= `G5;
    9'd44: note_div2_next <= 0;
    9'd45: note_div2_next <= `A5;
    9'd46: note_div2_next <= `A5;
    9'd47: note_div2_next <= `A5;
    9'd48: note_div2_next <= 0;
    
    9'd49: note_div2_next <= `F5;
    9'd50: note_div2_next <= 0;
    9'd51: note_div2_next <= `G5;
    9'd52: note_div2_next <= `G5;
    9'd53: note_div2_next <= `G5;
    9'd54: note_div2_next <= 0;
    9'd55: note_div2_next <= `E5;
    9'd56: note_div2_next <= `E5;
    
    9'd57: note_div2_next <= `E5;
    9'd58: note_div2_next <= 0;
    9'd59: note_div2_next <= `C5;
    9'd60: note_div2_next <= 0;
    9'd61: note_div2_next <= `D5;
    9'd62: note_div2_next <= 0;
    9'd63: note_div2_next <= `B4;
    9'd64: note_div2_next <= `B4;
    
    9'd65: note_div2_next <= `B4;
    9'd66: note_div2_next <= 0;
    
    9'd67: note_div2_next <= `C5;
    9'd68: note_div2_next <= `C5;
    9'd69: note_div2_next <= `C5;
    9'd70: note_div2_next <= `C5;
    9'd71: note_div2_next <= `C5;
    9'd72: note_div2_next <= 0;
    9'd73: note_div2_next <= `G4;
    9'd74: note_div2_next <= `G4;
    
    9'd75: note_div2_next <= `G4;
    9'd76: note_div2_next <= `G4;
    9'd77: note_div2_next <= `G4;
    9'd78: note_div2_next <= 0;
    9'd79: note_div2_next <= `E4;
    9'd80: note_div2_next <= `E4;
    9'd81: note_div2_next <= `E4;
    9'd82: note_div2_next <= `E4;
    
    9'd83: note_div2_next <= `E4;
    9'd84: note_div2_next <= 0;
    9'd85: note_div2_next <= `A4;
    9'd86: note_div2_next <= `A4;
    9'd87: note_div2_next <= `A4;
    9'd88: note_div2_next <= 0;
    9'd89: note_div2_next <= `B4;
    9'd90: note_div2_next <= `B4;
    
    9'd91: note_div2_next <= `B4;
    9'd92: note_div2_next <= 0;
    9'd93: note_div2_next <= `bB4;
    9'd94: note_div2_next <= 0;
    9'd95: note_div2_next <= `A4;
    9'd96: note_div2_next <= `A4;
    9'd97: note_div2_next <= `D5;
    9'd98: note_div2_next <= 0;
    
    9'd99: note_div2_next <= `G4;
    9'd100: note_div2_next <= `G4;
    9'd101: note_div2_next <= `G4;
    9'd102: note_div2_next <= 0;
    9'd103: note_div2_next <= `E5;
    9'd104: note_div2_next <= `E5;
    9'd105: note_div2_next <= `E5;
    9'd106: note_div2_next <= 0;
    
    9'd107: note_div2_next <= `G5;
    9'd108: note_div2_next <= `G5;
    9'd109: note_div2_next <= `G5;
    9'd110: note_div2_next <= 0;
    9'd111: note_div2_next <= `A5;
    9'd112: note_div2_next <= `A5;
    9'd113: note_div2_next <= `A5;
    9'd114: note_div2_next <= 0;
    
    9'd115: note_div2_next <= `F5;
    9'd116: note_div2_next <= 0;
    9'd117: note_div2_next <= `G5;
    9'd118: note_div2_next <= `G5;
    9'd119: note_div2_next <= `G5;
    9'd120: note_div2_next <= 0;
    9'd121: note_div2_next <= `E5;
    9'd122: note_div2_next <= `E5;
    
    9'd123: note_div2_next <= `E5;
    9'd124: note_div2_next <= 0;
    9'd125: note_div2_next <= `C5;
    9'd126: note_div2_next <= 0;
    9'd127: note_div2_next <= `D5;
    9'd128: note_div2_next <= 0;
    9'd129: note_div2_next <= `B4;
    9'd130: note_div2_next <= `B4;
    
    9'd131: note_div2_next <= `B4;
    9'd132: note_div2_next <= 0;
    /*** ------------***/
    9'd133: note_div2_next <= `G5;
    9'd134: note_div2_next <= 0;
    9'd135: note_div2_next <= `bG5;
    9'd136: note_div2_next <= 0;
    
    9'd137: note_div2_next <= `F5;
    9'd138: note_div2_next <= 0;
    9'd139: note_div2_next <= `bE5;
    9'd140: note_div2_next <= `bE5;
    9'd141: note_div2_next <= `bE5;
    9'd142: note_div2_next <= 0;
    9'd143: note_div2_next <= `E5;
    9'd144: note_div2_next <= `E5;
    
    9'd145: note_div2_next <= `E5;
    9'd146: note_div2_next <= 0;
    9'd147: note_div2_next <= `bA4;
    9'd148: note_div2_next <= 0;
    9'd149: note_div2_next <= `A4;
    9'd150: note_div2_next <= 0;
    9'd151: note_div2_next <= `C5;
    9'd152: note_div2_next <= `C5;
    
    9'd153: note_div2_next <= `C5;
    9'd154: note_div2_next <= 0;
    9'd155: note_div2_next <= `A4;
    9'd156: note_div2_next <= 0;
    9'd157: note_div2_next <= `C5;
    9'd158: note_div2_next <= 0;
    9'd159: note_div2_next <= `D5;
    9'd160: note_div2_next <= 0;//D5
    
    9'd161: note_div2_next <= 0;
    9'd162: note_div2_next <= 0;
    9'd163: note_div2_next <= `G5;
    9'd164: note_div2_next <= 0;
    9'd165: note_div2_next <= `bG5;
    9'd166: note_div2_next <= 0;
    
    9'd167: note_div2_next <= `G5;
    9'd168: note_div2_next <= 0;
    9'd169: note_div2_next <= `bE5;
    9'd170: note_div2_next <= `bE5;
    9'd171: note_div2_next <= `bE5;
    9'd172: note_div2_next <= 0;
    9'd173: note_div2_next <= `E5;
    9'd174: note_div2_next <= `E5;
    
    9'd175: note_div2_next <= `E5;
    9'd176: note_div2_next <= 0;
    9'd177: note_div2_next <= `C6;
    9'd178: note_div2_next <= `C6;
    9'd179: note_div2_next <= `C6;
    9'd180: note_div2_next <= 0;
    9'd181: note_div2_next <= `C6;
    9'd182: note_div2_next <= 0;
    
    9'd183: note_div2_next <= `C6;
    9'd184: note_div2_next <= `C6;
    9'd185: note_div2_next <= `C6;
    9'd186: note_div2_next <= 0;
    9'd187: note_div2_next <= 0;
    9'd188: note_div2_next <= 0;
    9'd189: note_div2_next <= `G5;
    9'd190: note_div2_next <= 0;
    9'd191: note_div2_next <= `bG5;
    9'd192: note_div2_next <= 0;
    
    9'd193: note_div2_next <= `F5;
    9'd194: note_div2_next <= 0;
    9'd195: note_div2_next <= `bE5;
    9'd196: note_div2_next <= `bE5;
    9'd197: note_div2_next <= `bE5;
    9'd198: note_div2_next <= 0;
    9'd199: note_div2_next <= `E5;
    9'd200: note_div2_next <= `E5;
    
    9'd201: note_div2_next <= `E5;
    9'd202: note_div2_next <= 0;
    9'd203: note_div2_next <= `bA4;
    9'd204: note_div2_next <= 0;
    9'd205: note_div2_next <= `A4;
    9'd206: note_div2_next <= 0;
    9'd207: note_div2_next <= `C5;
    9'd208: note_div2_next <= `C5;
    
    9'd209: note_div2_next <= `C5;
    9'd210: note_div2_next <= 0;
    9'd211: note_div2_next <= `A4;
    9'd212: note_div2_next <= 0;
    9'd213: note_div2_next <= `C5;
    9'd214: note_div2_next <= 0;
    9'd215: note_div2_next <= `D5;
    9'd216: note_div2_next <= 0;
    
    9'd217: note_div2_next <= 0;
    9'd218: note_div2_next <= 0;
    9'd219: note_div2_next <= `bE5;
    9'd220: note_div2_next <= `bE5;
    9'd221: note_div2_next <= `bE5;
    9'd222: note_div2_next <= 0;
    9'd223: note_div2_next <= `D5;
    9'd224: note_div2_next <= `D5;
    
    9'd225: note_div2_next <= `D5;
    9'd226: note_div2_next <=  0;
    9'd227: note_div2_next <= `C5;
    9'd228: note_div2_next <= `C5;
    9'd229: note_div2_next <= `C5;
    9'd230: note_div2_next <= `C5;
    9'd231: note_div2_next <= `C5;
    9'd232: note_div2_next <= `C5;
    
    9'd233: note_div2_next <= `C5;
    9'd234: note_div2_next <= `C5;
    9'd235: note_div2_next <= `C5;
    9'd236: note_div2_next <= 0;
    9'd237: note_div2_next <= `C5;
    9'd238: note_div2_next <= 0;
    9'd239: note_div2_next <= `C5;
    9'd240: note_div2_next <= `C5;
    
    9'd241: note_div2_next <= `C5;
    9'd242: note_div2_next <= 0;
    9'd243: note_div2_next <= `C5;
    9'd244: note_div2_next <= `C5;
    9'd245: note_div2_next <= `C5;
    9'd246: note_div2_next <= 0;
    9'd247: note_div2_next <= `C5;
    9'd248: note_div2_next <= 0;
    
    9'd249: note_div2_next <= `D5;
    9'd250: note_div2_next <= `D5;
    9'd251: note_div2_next <= `D5;
    9'd252: note_div2_next <= 0;
    9'd253: note_div2_next <= `E5;
    9'd254: note_div2_next <= 0;
    9'd255: note_div2_next <= `C5;
    9'd256: note_div2_next <= `C5;
    
    9'd257: note_div2_next <= `C5;
    9'd258: note_div2_next <= 0;
    9'd259: note_div2_next <= `A4;
    9'd260: note_div2_next <= 0;
    9'd261: note_div2_next <= `G4;
    9'd262: note_div2_next <= `G4;
    9'd263: note_div2_next <= `G4;
    9'd264: note_div2_next <= 0;
    
    9'd265: note_div2_next <= `C5;
    9'd266: note_div2_next <= 0;
    9'd267: note_div2_next <= `C5;
    9'd268: note_div2_next <= `C5;
    9'd269: note_div2_next <= `C5;
    9'd270: note_div2_next <= 0;
    9'd271: note_div2_next <= `C5;
    9'd272: note_div2_next <= `C5;
    
    9'd273: note_div2_next <= `C5;
    9'd274: note_div2_next <= 0;
    9'd275: note_div2_next <= `C5;
    9'd276: note_div2_next <= 0;
    9'd277: note_div2_next <= `D5;
    9'd278: note_div2_next <= 0;
    9'd279: note_div2_next <= `E5;
    9'd280: note_div2_next <= `E5;
    
    9'd281: note_div2_next <= `E5;
    9'd282: note_div2_next <= `E5;
    9'd283: note_div2_next <= `E5;
    9'd284: note_div2_next <= `E5;
    9'd285: note_div2_next <= `E5;
    9'd286: note_div2_next <= `E5;
    9'd287: note_div2_next <= `E5;
    9'd288: note_div2_next <= 0;
   
    9'd289: note_div2_next <= `C5;
    9'd290: note_div2_next <= 0;
    9'd291: note_div2_next <= `C5;
    9'd292: note_div2_next <= `C5;
    
    9'd293: note_div2_next <= `C5;
    9'd294: note_div2_next <= 0;
    9'd295: note_div2_next <= `C5;
    9'd296: note_div2_next <= `C5;
    9'd297: note_div2_next <= `C5;
    9'd298: note_div2_next <= 0;
    9'd299: note_div2_next <= `C5;
    9'd300: note_div2_next <= 0;
    
    9'd301: note_div2_next <= `D5;
    9'd302: note_div2_next <= `D5;
    9'd303: note_div2_next <= `D5;
    9'd304: note_div2_next <= 0;
    9'd305: note_div2_next <= `E5;
    9'd306: note_div2_next <= 0;
    9'd307: note_div2_next <= `C5;
    9'd308: note_div2_next <= `C5;
    
    9'd309: note_div2_next <= `C5;
    9'd310: note_div2_next <= 0;
    9'd311: note_div2_next <= `A4;
    9'd312: note_div2_next <= 0;
    9'd313: note_div2_next <= `G4;
    9'd314: note_div2_next <= `G4;
    9'd315: note_div2_next <= `G4;
    9'd316: note_div2_next <= 0;
    
    9'd317: note_div2_next <= `E5;
    9'd318: note_div2_next <= 0;
    9'd319: note_div2_next <= `E5;
    9'd320: note_div2_next <= `E5;
    9'd321: note_div2_next <= `E5;
    9'd322: note_div2_next <= 0;
    9'd323: note_div2_next <= `E5;
    9'd324: note_div2_next <= `E5;
    
    9'd325: note_div2_next <= `E5;
    9'd326: note_div2_next <= 0;
    9'd327: note_div2_next <= `D5;
    9'd328: note_div2_next <= 0;
    9'd329: note_div2_next <= `E5;
    9'd330: note_div2_next <= `E5;
    9'd331: note_div2_next <= `E5;
    9'd332: note_div2_next <= 0;
    
    9'd333: note_div2_next <= `G5;
    9'd334: note_div2_next <= `G5;
    9'd335: note_div2_next <= `G5;
    9'd336: note_div2_next <= `G5;
    9'd337: note_div2_next <= `G5;
    9'd338: note_div2_next <= `G5;
    9'd339: note_div2_next <= `G5;
    9'd340: note_div2_next <= 0;
    
    default: note_div2_next <= note_div2;
    endcase
 end
endmodule
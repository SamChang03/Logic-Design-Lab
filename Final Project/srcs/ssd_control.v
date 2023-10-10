module ssd_control(   
    input f_crystal,  
    input reset,
    input game_start,
    input gaming,
    input game_over,
    output reg [7:0] display,
    output reg [3:0] ssd_ctl
    );
    
    wire [1:0] ssd_ctl_en;
    wire clk1;
    wire [7:0] T1, T2, T3, T4;
  
  frequency_divider f0(
  .reset(reset),
  .f_crystal(f_crystal),
  .clk1(clk1),
  .ssd_ctl_en(ssd_ctl_en)
  );
  
  ring_counter f1(
  .reset(reset),
  .clk(clk1),
  .game_start(game_start),
  .gaming(gaming),
  .game_over(game_over),
  .T1(T1),
  .T2(T2),
  .T3(T3),
  .T4(T4)
  );  
  
 
 
    always@(*) begin                    
        case(ssd_ctl_en)
            2'b00: display <= T4;      
            2'b01: display <= T3;  
            2'b10: display <= T2;
            2'b11: display <= T1;           
           default: display <= 8'd0;
        endcase
    end
    
    always@(*) begin        
        case({ssd_ctl_en,reset})
            3'b000: ssd_ctl <= 4'b1110;
            3'b010: ssd_ctl <= 4'b1101;  
            3'b100: ssd_ctl <= 4'b1011;
            3'b110: ssd_ctl <= 4'b0111;            
            default: ssd_ctl <= 4'b1111;
        endcase
    end
   
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/07 04:32:39
// Design Name: 
// Module Name: bull_cow
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bull_cow(
    input [3:0] secret1,
    input [3:0] secret0,
    input [3:0] guess1,
    input [3:0] guess0,
    output reg [1:0] bull,
    output reg [1:0] cow,
    output reg [1:0] other
    );
    
    always@*
    begin
      if(secret1 > 4'd9 || guess1 > 4'd9 || secret0> 4'd9 || guess0> 4'd9)begin  // no defination
      bull<=2'b00;
      cow<=2'b00;
      other<=2'b00;
      end
      
      else if(secret1==guess1 && secret0==guess0)begin //determine # of bulls
      bull<=2'b11;
      cow<=2'b00;
      other<=2'b00;
      end
      
      else if (secret1==guess1 || secret0==guess0)begin
      bull<=2'b01;
      cow<=2'b00;
      other<=2'b1;
      end
      
      else if(secret1==guess0 && secret0==guess1)begin//determine # of cows
      bull<=2'b00;
      cow<=2'b11;
      other<=2'b00;
      end
      
      else if(secret1==guess0 || secret0==guess1)begin
      bull<=2'b00;
      cow<=2'b01;
      other<=2'b01;
      end
      
      else begin
      bull<=2'b00;
      cow<=2'b00;
      other<=2'b11;
      end
    
    end
   
endmodule

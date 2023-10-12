`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/03/03 02:13:43
// Design Name: 
// Module Name: seg
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


module seg(i,d,SSD);
   
   input [3:0] i;
   output d;
   output SSD;
   reg [3:0] d;
   reg [7:0] SSD;
   integer  idx ;
   
   always@(i)
   begin
   
      for(idx=0; idx < 4; idx = idx +1) //assign 4-bit binary
      begin
         d[idx] <= i[idx];
       end
   
      SSD[1]= ~(((~i[2]) & (~i[0])) | ((i[2]) & (i[1])) | ((i[3]) & (~i[0]))| ((~i[3]) & (i[1]))| ((i[3]) & (~i[2]) & (~i[1]))| ((~i[3]) & (i[2]) & (i[0])));
      SSD[2]= ~(((~i[3]) & (~i[2])) | ((~i[2]) & (~i[1])) | ((~i[2]) & (~i[0])) | ((~i[3]) & (~i[1]) & (~i[0]))| (~(i[3]) & (i[1]) & (i[0]))| ((i[3]) & (~i[1]) & (i[0])));
      SSD[3]= ~(((~i[3]) & (~i[1])) | ((i[3]) & (~i[2])) | ((~i[3]) & (i[0])) | ((~i[1]) & (i[0])) | ((~i[3]) & (i[2])));
      SSD[4]= ~(((i[3]) & (~i[1])) | ((~i[3]) & (~i[2]) & (~i[0])) | ((~i[2]) & (i[1]) & (i[0]))| ((i[2]) & (i[1]) & (~i[0])) | ((i[2]) & (~i[1]) & (i[0])));
      SSD[5]= ~((~(i[2]) & (~i[0])) | ((i[3]) & (i[2])) |  ((i[1]) & (~i[0]))| ((i[1]) & (i[3])));
      SSD[6]= ~(((~i[1]) & (~i[0])) |((i[1]) & (i[3])) |((i[2]) & (~i[0])) |((i[3]) & (~i[2])) | (~(i[3]) & (i[2]) & (~i[1])));
      SSD[7]= ~(((~i[2]) & (i[1])) |((i[1]) & (~i[0])) |((i[3]) & (i[0])) |((i[3]) & (~i[2])) | (~(i[3]) & (i[2]) & (~i[1])));
      SSD[0] <= 1;// unused
   end
endmodule
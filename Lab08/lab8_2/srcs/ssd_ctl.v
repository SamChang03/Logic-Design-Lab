`define S0 2'b00
`define S1 2'b01
`define S2 2'b10
`define S3 2'b11

module ssd_ctl(display_c, display, ssd_ctl_en, display0, display1, display2, display3,state,rst);
input rst;
input [1:0]state;
input [1:0] ssd_ctl_en;
input [7:0] display0, display1, display2, display3; 

output [7:0] display;
output [3:0] display_c;

reg [3:0] display_c;
reg [7:0] display;

always @(ssd_ctl_en or display0 or display1 or display2 or display3 or rst)
// display value selection
if(~rst)
display = 8'd0;

else begin
case(ssd_ctl_en)
2'b00: display = display0;
2'b01: display = display1;
2'b10: display = display2;
2'b11: display = display3;
default : display = 8'd0;
endcase
end

// 7-segment control
always @(state or ssd_ctl_en or rst)
if(~rst)
    case(ssd_ctl_en)
    2'b00: display_c = 4'b1111;
    2'b01: display_c = 4'b1111;
    2'b10: display_c = 4'b1111; 
    2'b11: display_c = 4'b1111; 
    default : display_c = 4'b1111;
    endcase

else if (state==`S0) begin
    case(ssd_ctl_en)
    2'b00: display_c = 4'b1111;
    2'b01: display_c = 4'b1111;
    2'b10: display_c = 4'b1111; 
    2'b11: display_c = 4'b1111; 
    default : display_c = 4'b1111;
    endcase
end

else if (state==`S1) begin
    case(ssd_ctl_en)
    2'b00: display_c = 4'b1111;
    2'b01: display_c = 4'b1111;
    2'b10: display_c = 4'b1111; 
    2'b11: display_c = 4'b0111; 
    default : display_c = 4'b1111;
    endcase
end

else if (state==`S2) begin
    case(ssd_ctl_en)
    2'b00: display_c = 4'b1111;
    2'b01: display_c = 4'b1111;
    2'b10: display_c = 4'b1111; 
    2'b11: display_c = 4'b0111; 
    default : display_c = 4'b1111;
    endcase
end

else if (state==`S3) begin
    case(ssd_ctl_en)
    2'b00: display_c = 4'b1110;
    2'b01: display_c = 4'b1101;
    2'b10: display_c = 4'b1011; 
    2'b11: display_c = 4'b0111; 
    default : display_c = 4'b1111;
    endcase
end   
else begin
    case(ssd_ctl_en)
    2'b00: display_c = 4'b1110;
    2'b01: display_c = 4'b1101;
    2'b10: display_c = 4'b1011; 
    2'b11: display_c = 4'b0111; 
    default : display_c = 4'b1111;
    endcase
end
endmodule
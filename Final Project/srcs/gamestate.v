`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/10 00:23:22
// Design Name: 
// Module Name: gamestate
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


module gamestate(
input clk,
input rst,
input key1,
input key2,
input crash,
output reg [2:0] state
    );
    
reg [2:0] state_next;
reg key1_delay,key2_delay;
wire pulse1,pulse2;

assign pulse1 = key1 & ~key1_delay;
assign pulse2 = key2 & ~key2_delay;

always@(*)begin
    case(state)
    3'd0:begin
        if(pulse1) begin
            state_next = 3'd1;
        end
        else state_next = 3'd0;
    end
    3'd1:
        if(crash) state_next = 3'd3;
        else if(pulse2) state_next = 3'd2;
        else state_next = 3'd1;
    3'd2:
        if(pulse1) state_next = 3'd1;
        else if(pulse2) begin
            state_next = 3'd0;
        end
        else state_next = 3'd2;
    3'd3:
        if(pulse2) begin
            state_next = 3'd0;
        end
        else state_next = 3'd3;
    default:
        state_next = 3'd0;
    endcase
end

always@(posedge clk or posedge rst)begin
    if(rst) begin
        state <= 3'd0;
        key1_delay = 0;
        key2_delay = 0;
    end
    else begin
        state <= state_next;
        key1_delay <= key1;
        key2_delay <= key2;
    end
end
endmodule

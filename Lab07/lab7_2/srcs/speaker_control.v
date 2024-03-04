module speaker_control(
input clk, 
input rst_n, 
input [15:0] audio_in_left,
input [15:0] audio_in_right, 
output audio_mclk, 
output audio_lrck, 
output audio_sck,
output reg audio_sdin 
);

reg [8:0] cnt;
reg [8:0] cnt_next;

reg [4:0] sdin_cnt;
reg [4:0] sdin_cnt_next;

reg [15:0] audio_left,audio_right;

//conbination
always@(cnt)
cnt_next= cnt + 1'd1;

always@(sdin_cnt)
sdin_cnt_next= sdin_cnt + 1'd1;

assign audio_mclk = cnt[1];
assign audio_lrck = cnt[8];
assign audio_sck = cnt[3];

//sequencial
always@(posedge clk or negedge rst_n)begin
    if (~rst_n) 
        cnt<=9'd0;
    else 
        cnt<=cnt_next;
end

always@(posedge audio_lrck or negedge rst_n)
    if (~rst_n)
    begin
        audio_left <= 16'd0;
        audio_right <= 16'd0;
    end
    else
    begin
        audio_left <= audio_in_left;
        audio_right <= audio_in_right;
    end

always@(posedge audio_sck or negedge rst_n)
    if(~rst_n)
        sdin_cnt<=5'd0;
    else
        sdin_cnt <= sdin_cnt_next;
        
always@*
    case(sdin_cnt)
        5'b00000: audio_sdin = audio_right[0];
        5'b00001: audio_sdin = audio_left[15];
        5'b00010: audio_sdin = audio_left[14];
        5'b00011: audio_sdin = audio_left[13];
        5'b00100: audio_sdin = audio_left[12];
        5'b00101: audio_sdin = audio_left[11];
        5'b00110: audio_sdin = audio_left[10];
        5'b00111: audio_sdin = audio_left[9];
        5'b01000: audio_sdin = audio_left[8];
        5'b01001: audio_sdin = audio_left[7];
        5'b01010: audio_sdin = audio_left[6];
        5'b01011: audio_sdin = audio_left[5];
        5'b01100: audio_sdin = audio_left[4];
        5'b01101: audio_sdin = audio_left[3];
        5'b01110: audio_sdin = audio_left[2];
        5'b01111: audio_sdin = audio_left[1];
        5'b10000: audio_sdin = audio_left[0];
        5'b10001: audio_sdin = audio_right[15];
        5'b10010: audio_sdin = audio_right[14];
        5'b10011: audio_sdin = audio_right[13];
        5'b10100: audio_sdin = audio_right[12];
        5'b10101: audio_sdin = audio_right[11];
        5'b10110: audio_sdin = audio_right[10];
        5'b10111: audio_sdin = audio_right[9];
        5'b11000: audio_sdin = audio_right[8];
        5'b11001: audio_sdin = audio_right[7];
        5'b11010: audio_sdin = audio_right[6];
        5'b11011: audio_sdin = audio_right[5];
        5'b11100: audio_sdin = audio_right[4];
        5'b11101: audio_sdin = audio_right[3];
        5'b11110: audio_sdin = audio_right[2];
        5'b11111: audio_sdin = audio_right[1];
        default: audio_sdin = 1'b0;
    endcase
endmodule
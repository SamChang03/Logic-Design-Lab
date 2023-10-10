`include "global.v"

module decoder(
    out,
    clk,
    in
    );
    
    output reg [3:0]out;
    reg [3:0]out_tmp;
    input clk;
    input [8:0]in;
    
    always@*
        case(in)
            9'h069: out_tmp = `KEY_1;
            9'h072: out_tmp = `KEY_2;
            9'h07a: out_tmp = `KEY_3;
            9'h06b: out_tmp = `KEY_4;
            9'h073: out_tmp = `KEY_5;
            9'h074: out_tmp = `KEY_6;
            9'h06c: out_tmp = `KEY_7;
            9'h075: out_tmp = `KEY_8;
            9'h07d: out_tmp = `KEY_9;
            9'h070: out_tmp = `KEY_0;
            9'h079: out_tmp = `KEY_ADD;
            9'h07b: out_tmp = `KEY_SUBTRACT;
            9'h07c: out_tmp = `KEY_MULTIPLY;
            9'h05a: out_tmp = `KEY_ENTER;
            default: out_tmp = out;
        endcase
        
    always@(posedge clk)
        out <= out_tmp;
    
endmodule
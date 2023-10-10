`include "global.v"
module Finite_state(
	state,
    operation,
    in,
    valid
    );
    
	output reg [2:0]state;
    output reg [1:0]operation;
    
    input [3:0]in;
    input valid;
    
    reg [2:0]next_state;
    reg [1:0]operation_next;
    
    
    always@*
        case(state)
            `STAT_DIGIT3:
                if(in == 4'd0 | in == 4'd1 | in == 4'd2 | in == 4'd3 | in == 4'd4 | 
                   in == 4'd5 | in == 4'd6 | in == 4'd7 | in == 4'd8 | in == 4'd9)
                    begin
                        next_state = `STAT_DIGIT2;
                        operation_next = operation;
                    end
                else
                    begin
                        next_state = `STAT_DIGIT3;
                        operation_next = operation;
                    end 
            `STAT_DIGIT2:
                if(in == `KEY_ADD)
                    begin
                        next_state = `STAT_DIGIT1;
                        operation_next = 2'd0;
                    end
                else if(in == `KEY_SUBTRACT)
                    begin
                        next_state = `STAT_DIGIT1;
                        operation_next = 2'd1;
                    end
                else if(in == `KEY_MULTIPLY)
                    begin
                        next_state = `STAT_DIGIT1;
                        operation_next = 2'd2;
                    end
                else
                    begin
                        next_state = `STAT_DIGIT2;
                        operation_next = operation;
                    end
            `STAT_DIGIT1:
                if(in == 4'd0 | in == 4'd1 | in == 4'd2 | in == 4'd3 | in == 4'd4 | 
                   in == 4'd5 | in == 4'd6 | in == 4'd7 | in == 4'd8 | in == 4'd9)
                    begin
                        next_state = `STAT_DIGIT0;
                        operation_next = operation;
                    end
                else
                    begin
                        next_state = `STAT_DIGIT1;
                        operation_next = operation;
                    end
            `STAT_DIGIT0:
                if(in == `KEY_ENTER)
                    begin
                        next_state = `STAT_DISPLAY;
                        operation_next = operation;
                    end
                else
                    begin
                        next_state = `STAT_DIGIT0;
                        operation_next = operation;
                    end
            `STAT_DISPLAY:
                if(in == `KEY_ENTER)
                    begin
                        next_state = `STAT_DIGIT3;
                        operation_next = operation;
                    end
                else
                    begin
                        next_state = `STAT_DISPLAY;
                        operation_next = operation;
                    end
            default:
                begin
                    next_state = `STAT_DIGIT3;
                    operation_next = operation;
                end
        endcase
        
    always@(posedge valid)
        begin
            state <= next_state;
            operation <= operation_next;
        end    
    
endmodule

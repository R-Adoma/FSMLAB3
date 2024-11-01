module f1_fsm (
    input   logic       rst,
    input   logic       en,
    input   logic       clk,
    input logic trigger,
    output  logic [7:0] data_out,
    output logic cmd_seq,
    output logic cmd_delay,
);
    //Define States
    typedef enum  {S0, S1, S2, S3, S4, S5, S6, S7, S8} my_state;
    my_state current_state, next_state;

    //output
    logic [7:0] output_val;
 
    //State registers
    always_ff @(posedge clk, posedge rst)
        cmd_seq = (current_state != S0);
        if (rst) current_state <= S0;
        else if (trigger) current_state <= next_state;

    //Next State Logic
    always_comb
        case (current_state)
            S0: begin 
                next_state = S1;
                output_val = 8'b0;
            end
            S1: begin 
                next_state = S2;
                output_val = 8'b1;
            end
            S2: begin 
                next_state = S3;
                output_val = 8'b11;
            end
            S3: begin 
                next_state = S4;
                output_val = 8'b111;
            end
            S4: begin 
                next_state = S5;
                output_val = 8'b1111;
            end
            S5: begin 
                next_state = S6;
                output_val = 8'b11111;
            end    
            S6: begin 
                next_state = S7;
                output_val = 8'b111111;
            end  
            S7: begin 
                next_state = S8;
                output_val = 8'b1111111;
            end  
            S8: begin 
                next_state = S0;
                output_val = 8'b11111111;
            end  
            default: begin
                next_state = S0;
                output_val = 8'b0;
            end
        endcase

    




    //output logic
    assign data_out = output_val;
endmodule

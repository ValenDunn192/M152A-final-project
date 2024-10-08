`timescale 1ns / 1ps

module random(
    input clk,
    output [2:0] random_out
);
//pushed out new arrows in a semi-random way
    parameter U = 3'b100;
    parameter D = 3'b101;
    parameter L = 3'b110;
    parameter R = 3'b111;
    
    reg [3:0] total = 0;
    reg [2:0] random_temp; 
    
    always @(posedge clk) begin
        total = total + 1'b1;
        case (total)
            0: random_temp = U; 
            1: random_temp = D;
            2: random_temp = L;
            3: random_temp = R;
            4: random_temp = D; 
            5: random_temp = U;
            6: random_temp = R;
            7: random_temp = D;
            8: random_temp = L; 
            9: random_temp = R;
            10: random_temp = L;
            11: random_temp = U;
            12: random_temp = D;
            13: random_temp = R; 
            14: random_temp = L;
            15: random_temp = U;
        endcase
    end
    
    assign random_out = random_temp; 
    
endmodule

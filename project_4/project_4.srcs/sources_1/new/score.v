`timescale 1ns / 1ps

module score(
    input reset,
    input [6:0] score_update,
    input clk,
    output [3:0] score0, score1, score2 ,score3
    );
   
    reg [13:0] total = 0;
    reg [13:0] totalt = 0;
    reg [3:0] s0,s1,s2,s3 = 0;
   //turning the score into data the seven segment display can parse
    always @(posedge clk) begin
        if (reset == 1) begin
            total = 0;
        end else begin
            total = total + score_update;
            totalt = total;
            s0 = total % 10;
            total = total/10;
            s1 = total % 10;
            total = total/10;
            s2 = total % 10;
            total = total/10;
            s3 = total % 10;
            total = totalt;
       end
    end
   
    assign total_score = total;
    assign score0 = s0;
    assign score1 = s1;
    assign score2 = s2;
    assign score3 = s3;
   
endmodule




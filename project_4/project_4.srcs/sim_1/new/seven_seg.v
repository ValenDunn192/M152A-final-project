`timescale 1ns / 1ps


module seven_seg(
    input [3:0] score0,
    input [3:0] score1,
    input [3:0] score2,
    input [3:0] score3,
    input clock_output500,
    output [6:0] seg,
    output [3:0] an
    );
   

parameter ZERO = 7'b1000000;
parameter ONE = 7'b1111001;
parameter TWO = 7'b0100100;
parameter THREE = 7'b0110000;
parameter FOUR = 7'b0011001;
parameter FIVE = 7'b0010010;
parameter SIX = 7'b0000010;
parameter SEVEN = 7'b1111000;
parameter EIGHT = 7'b0000000;
parameter NINE = 7'b0010000;

integer count = 0;
reg[3:0] select;
reg[3:0] anode;
reg[6:0] segment;

always @(posedge clock_output500) begin 
    if(count == 4)begin
        count = 0;
     end
     case(count)
        0: begin
            anode = 4'b1110;             
            select = score0;
        end
        1: begin
            anode = 4'b1101;      
            select = score1;
        end
        2: begin
            anode = 4'b1011;
            select = score2;
        end
        3: begin
            anode = 4'b0111;
            select = score3;
        end
     endcase
     case(select)
        0: segment = ZERO;
        1: segment = ONE;
        2: segment = TWO;
        3: segment = THREE;
        4: segment = FOUR;
        5: segment = FIVE;
        6: segment = SIX;
        7: segment = SEVEN;
        8: segment = EIGHT;
        9: segment = NINE;
//        10: segment = 7'b111_1111;
     endcase
    count = count + 1;
end 


assign an = anode;
assign seg = segment;
endmodule

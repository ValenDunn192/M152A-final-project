`timescale 1ns / 1ps

module arrows(
    input up_state,
    input down_state,
    input left_state,
    input right_state,
    input rst_state,
    input pause,
    input clk_1,
    input clk_500,
    input clk_2,
    output [10:0] arrows0,
    output [10:0] arrows1,
    output [10:0] arrows2,
    output [10:0] arrows3,
    output [10:0] arrows4,
    output [10:0] arrows5,
    output [10:0] arrows6,
    output [10:0] arrows7,
    output [10:0] arrows8,
    output [10:0] arrows9,
    output [6:0] score_update
    );
     
     wire clock; 
     //creating and updating arrows to move down the screen
     parameter UP = 3'b100;
     parameter DOWN = 3'b101;
     parameter LEFT = 3'b110;
     parameter RIGHT = 3'b111;
     parameter IDLE = 3'b000;
     
     reg [2:0] direction = 0;
     reg [10:0] curarr = 0;
     reg [6:0] hit = 0;
     integer i;
     
     reg [10:0] arrows_temp [9:0]; // Declaration
     integer k;
     initial begin
            arrows_temp[0] = {1'b1, UP, 7'b0001001};
            arrows_temp[1] = {1'b1, DOWN, 7'b0001000};
            arrows_temp[2] = {1'b1, LEFT, 7'b0000111};
            arrows_temp[3] = {1'b1, RIGHT, 7'b0000110};
            arrows_temp[4] = {1'b1, UP, 7'b0000101};
            arrows_temp[5] = {1'b1, DOWN, 7'b0000100};
            arrows_temp[6] = {1'b1, RIGHT, 7'b0000011};
            arrows_temp[7] = {1'b1, LEFT, 7'b0000010};
            arrows_temp[8] = {1'b1, RIGHT, 7'b0000001};
            arrows_temp[9] = {1'b1, UP, 7'b0000000};
     end
     
     wire [2:0] rand_direction;
     random random1(clk_1, rand_direction);
     
     reg [9:0] counter = 10'b0;
    
    
     always @(*) begin 
         if (up_state == 1) begin
            direction = UP;
         end else if (down_state == 1) begin
            direction = DOWN;
         end else if (left_state == 1) begin
            direction = LEFT;
         end else if (right_state == 1) begin
            direction = RIGHT;
         end else begin
            direction = IDLE;
         end
     end 
     
     
     
     always @(posedge clk_1) begin  //or posedge rst_state or posedge pause
         counter = counter + 1'b1;
         if (rst_state == 1) begin
            arrows_temp[0] = {1'b1, UP, 7'b0001001};
            arrows_temp[1] = {1'b1, DOWN, 7'b0001000};
            arrows_temp[2] = {1'b1, LEFT, 7'b0000111};
            arrows_temp[3] = {1'b1, RIGHT, 7'b0000110};
            arrows_temp[4] = {1'b1, UP, 7'b0000101};
            arrows_temp[5] = {1'b1, DOWN, 7'b0000100};
            arrows_temp[6] = {1'b1, RIGHT, 7'b0000011};
            arrows_temp[7] = {1'b1, LEFT, 7'b0000010};
            arrows_temp[8] = {1'b1, RIGHT, 7'b0000001};
            arrows_temp[9] = {1'b1, UP, 7'b0000000};
            hit = 0; 
         end
         else if (pause == 1 && rst_state == 0) begin
            arrows_temp[0] = arrows_temp[0];
            arrows_temp[1] = arrows_temp[1];
            arrows_temp[2] = arrows_temp[2];
            arrows_temp[3] = arrows_temp[3];
            arrows_temp[4] = arrows_temp[4];
            arrows_temp[5] = arrows_temp[5];
            arrows_temp[6] = arrows_temp[6];
            arrows_temp[7] = arrows_temp[7];
            arrows_temp[8] = arrows_temp[8];
            arrows_temp[9] = arrows_temp[9];
            hit = 0; 
         end
         else begin
            if (counter < 20) begin 
                for (i = 0; i < 10; i = i + 1) begin
                    arrows_temp[i][6:0] = arrows_temp[i][6:0] + 1'b1; // movement down the screen
                end
            end if (counter >= 20) begin
                for (i = 0; i < 10; i = i + 1) begin
                     arrows_temp[i][6:0] = arrows_temp[i][6:0] + 2'b10; // Speed up by incrementing by 2
                end
            end 
            curarr = arrows_temp[0];
            if (curarr[10] != 0 && (curarr[9:7] != direction) && curarr[6:0] >= 30) begin // gets to end of screen without being hit //destroy missed
                hit = 0; 
                arrows_temp[0] <= arrows_temp[1]; // rotate
                arrows_temp[1] <= arrows_temp[2];
                arrows_temp[2] <= arrows_temp[3];
                arrows_temp[3] <= arrows_temp[4];
                arrows_temp[4] <= arrows_temp[5];
                arrows_temp[5] <= arrows_temp[6];
                arrows_temp[6] <= arrows_temp[7];
                arrows_temp[7] <= arrows_temp[8];
                arrows_temp[8] <= arrows_temp[9];
                arrows_temp[9] <= {1'b1, rand_direction, 7'b0000000}; //generate new random arrow
            end
            else if (curarr[10] != 0 && (curarr[9:7] == direction) && curarr[6:0] <= 30) begin // is hit
                hit = curarr[6:0];//score update
                //rotate
                arrows_temp[0] <= arrows_temp[1];
                arrows_temp[1] <= arrows_temp[2];
                arrows_temp[2] <= arrows_temp[3];
                arrows_temp[3] <= arrows_temp[4];
                arrows_temp[4] <= arrows_temp[5];
                arrows_temp[5] <= arrows_temp[6];
                arrows_temp[6] <= arrows_temp[7];
                arrows_temp[7] <= arrows_temp[8];
                arrows_temp[8] <= arrows_temp[9];
                arrows_temp[9] <= {1'b1, rand_direction, 7'b0000000}; //generate new random arrow
            end else begin
                hit = 0; 
                arrows_temp[0] <= arrows_temp[0];
                arrows_temp[1] <= arrows_temp[1];
                arrows_temp[2] <= arrows_temp[2];
                arrows_temp[3] <= arrows_temp[3];
                arrows_temp[4] <= arrows_temp[4];
                arrows_temp[5] <= arrows_temp[5];
                arrows_temp[6] <= arrows_temp[6];
                arrows_temp[7] <= arrows_temp[7];
                arrows_temp[8] <= arrows_temp[8];
                arrows_temp[9] <= arrows_temp[9];
            end
         end
     end
     
     assign arrows0 = arrows_temp[0];
     assign arrows1 = arrows_temp[1];
     assign arrows2 = arrows_temp[2];
     assign arrows3 = arrows_temp[3];
     assign arrows4 = arrows_temp[4];
     assign arrows5 = arrows_temp[5];
     assign arrows6 = arrows_temp[6];
     assign arrows7 = arrows_temp[7];
     assign arrows8 = arrows_temp[8];
     assign arrows9 = arrows_temp[9];
     assign score_update = hit;
     
   
endmodule






`timescale 1ns / 1ps

module tb();
    reg clkt = 0;
    
    wire sys_clk_pin;
    wire sw = 0;
    wire btnL = 0;
    wire btnU = 0;
    wire btnR = 0;
    wire btnD = 0;
    wire btnC = 0;
    
    wire [6:0] seg;
    wire [3:0] an;

    wire pause_state = sw;
    wire clock_output1, clock_output2, clock_output4, clock_output500;
//    wire [3:0] sec0_count, sec1_count, min0_count, min1_count;  
    wire rst_state, up_state, down_state, left_state, right_state;
    wire [5:0] score_update;
    wire [3:0] score0,score1,score2,score3;
    wire [9:0] arrows0, arrows1,arrows2,arrows3,arrows4,arrows5,arrows6,arrows7,arrows8,arrows9;
    
    wire [9:0] x,y;
    wire video_on;
    wire p_tick;
    wire [11:0] rgb_next;
    reg [11:0] rgb_reg;
    
	debouncer reset_btn(
        btnC,
        sys_clk_pin,
        rst_state
    );
   
   
    debouncer up_btn(
        btnU,
        sys_clk_pin,
        up_state
);


    debouncer down_btn(
        btnD,
        sys_clk_pin,
        down_state
);

    debouncer left_btn(
        btnL,
        sys_clk_pin,
        left_state
);

    debouncer right_btn(
        btnR,
        sys_clk_pin,
        right_state
);
   
    clock clock1(
        sys_clk_pin,
        clock_output1,
        clock_output2,
        clock_output4,
        clock_output500
        );
   
    seven_seg seven_seg1(
        score0,
        score1,
        score2,
        score3,
        clock_output500,
        seg,
        an
        );
       
    score score_mod(
        rst_state,
        score_update,
        clock_output500,
        score0,
        score1,
        score2,
        score3
    );
   
   arrows arrows_com(
        up_state,
        down_state,
        left_state,
        right_state,
        rst_state,
        pause_state,
        clock_output500,
        arrows0,
        arrows1,
        arrows2,
        arrows3,
        arrows4,
        arrows5,
        arrows6,
        arrows7,
        arrows8,
        arrows9,
        score_update
        );
    vga_controller controlvga(
            sys_clk_pin,
            rst_state,       // system reset
            video_on,    // ON while pixel counts for x and y and within display area
            hsync,       // horizontal sync
            vsync,       // vertical sync
            p_tick,      // the 25MHz pixel/second rate signal, pixel tick
            x,     // pixel count/position of pixel x, max 0-799
            y      // pixel count/position of pixel y, max 0-524
            );

     VGA VGA1(
            sys_clk_pin,
            arrows0,
            arrows1,
            arrows2,
            arrows3,
            arrows4,
            arrows5,
            arrows6,
            arrows7,
            arrows8,
            arrows9,
            x,
            y,
            rgb_next
            );
   
//    always @(posedge sys_clk_pin) begin
//        if(p_tick)
//            rgb_reg <= rgb_next;
//     end            
//    initial begin 
//// individual test cases
//        #2;
//        $display(" arrow0 = %b \n arrow1 = %b \n arrow2 = %b \n arrow3 = %b \n arrow4 = %b \n arrow5 = %b \n arrow6 = %b \n arrow7 = %b \n arrow8 = %b \n arrow9 = %b", arrows0, arrows1, arrows2, arrows3, arrows4, arrows5, arrows6, arrows7, arrows8, arrows9);
//    end 
    
    always begin
        #0.05 clkt = ~clkt;
//        $display(" arrow0 = %b \n arrow1 = %b \n arrow2 = %b \n arrow3 = %b \n arrow4 = %b \n arrow5 = %b \n arrow6 = %b \n arrow7 = %b \n arrow8 = %b \n arrow9 = %b", arrows0, arrows1, arrows2, arrows3, arrows4, arrows5, arrows6, arrows7, arrows8, arrows9);
    end

assign sys_clk_pin = clkt;        

endmodule

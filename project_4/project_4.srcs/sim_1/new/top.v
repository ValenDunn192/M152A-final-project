`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Top module for running everything
module top(
    input sys_clk_pin,
    input sw,
    input btnL,
    input btnU,
    input btnR,
    input btnD,
    input btnC,
    output [6:0] seg,
    output [3:0] an,
    output hsync,
    output vsync,
    output [11:0] rgb
    //output [3:0] vgaRed, vgaBlue, vgaGreen
    );
   
    wire pause_state = sw;
    wire clock_output1, clock_output2, clock_output4, clock_output500;
    wire [3:0] sec0_count, sec1_count, min0_count, min1_count;  
    wire rst_state, up_state, down_state, left_state, right_state;
    wire [6:0] score_update;
    wire [3:0] score0,score1,score2,score3;
    wire [10:0] arrows0, arrows1,arrows2,arrows3,arrows4,arrows5,arrows6,arrows7,arrows8,arrows9;
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
        clock_output500,
        clock_output4
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
        clock_output1,
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
        clock_output1,
        clock_output500,
        clock_output2,
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
            //sys_clk_pin,
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
            video_on,
            x,
            y,
            rgb_next
            );
   
    always @(posedge sys_clk_pin) begin
        if(p_tick)
            rgb_reg <= rgb_next;
     end            
//      // output
assign rgb = rgb_reg;

endmodule

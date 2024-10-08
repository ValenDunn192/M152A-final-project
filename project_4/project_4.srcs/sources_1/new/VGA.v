`timescale 1ns / 1ps


module VGA(
    input [10:0]arrows0,
    input [10:0] arrows1,
    input [10:0]arrows2,
    input [10:0]arrows3,
    input [10:0]arrows4,
    input [10:0]arrows5,
    input [10:0]arrows6,
    input [10:0]arrows7,
    input [10:0]arrows8,
    input [10:0] arrows9,
    input video_on,
    input [9:0] x, y,
    output reg [11:0] rgb
    );
    reg [10:0] arrows [9:0];
    
    // RGB Color Values
    parameter RED    = 12'h00F;
    parameter GREEN  = 12'h0F0;
    parameter BLUE   = 12'hF00;
    parameter YELLOW = 12'h0FF;     // RED and GREEN
    parameter AQUA   = 12'hFF0;     // GREEN and BLUE
    parameter VIOLET = 12'hF0F;     // RED and BLUE
    parameter WHITE  = 12'hFFF;     // all ON
    parameter BLACK  = 12'hFFF;     // all OFF
    parameter GRAY   = 12'hAAA;     // some of each color
    
    // Pixel Location Status Signals
    wire u_white_on, u_yellow_on, u_aqua_on, u_green_on, u_violet_on, u_red_on, u_blue_on;
    wire l_blue_on, l_black1_on, l_violet_on, l_gray_on, l_aqua_on, l_black2_on, l_white_on;
    reg arrow;
    reg [2:0] dir;
    reg [1:0] cdir;
    reg [10:0] curarr;
    reg [8:0] data;
    integer ux,dx,rx,lx;
    integer tx;
    integer ay;
    integer i;
    
    // Drivers for Status Signals
    // Upper Sections
    assign u_white_on  = ((x >= 0)   && (x < 91)   &&  (y >= 0) && (y < 412));
    assign u_yellow_on = ((x >= 91)  && (x < 182)  &&  (y >= 0) && (y < 412));
    assign u_aqua_on   = ((x >= 182) && (x < 273)  &&  (y >= 0) && (y < 412));
    assign u_green_on  = ((x >= 273) && (x < 364)  &&  (y >= 0) && (y < 412));
    assign u_violet_on = ((x >= 364) && (x < 455)  &&  (y >= 0) && (y < 412));
    assign u_red_on    = ((x >= 455) && (x < 546)  &&  (y >= 0) && (y < 412));
    assign u_blue_on   = ((x >= 546) && (x < 640)  &&  (y >= 0) && (y < 412));
    // Lower Sections
    assign l_blue_on   = ((x >= 0)   && (x < 91)   &&  (y >= 412) && (y < 480));
    assign l_black1_on = ((x >= 91)  && (x < 182)  &&  (y >= 412) && (y < 480));
    assign l_violet_on = ((x >= 182) && (x < 273)  &&  (y >= 412) && (y < 480));
    assign l_gray_on   = ((x >= 273) && (x < 364)  &&  (y >= 412) && (y < 480));
    assign l_aqua_on   = ((x >= 364) && (x < 455)  &&  (y >= 412) && (y < 480));
    assign l_black2_on = ((x >= 455) && (x < 546)  &&  (y >= 412) && (y < 480));
    assign l_white_on  = ((x >= 546) && (x < 640)  &&  (y >= 412) && (y < 480));
    
    // Set RGB output value based on status signals
    
    //initially used a loop for the arrows, but there was a timing issue so we unwrapped it.
    always @* begin
        ux = 80;
        dx = 240;
        rx = 400;
        lx = 560;
        arrow = 1'b0;
        curarr = arrows0;
        dir = curarr[9:7];
        if(curarr[10] == 1) begin
            dir = curarr[9:7]; 
                if(dir == 3'b100)
                    tx = ux;
                else if (dir == 3'b101)
                    tx = dx;
                else if(dir == 3'b110)
                    tx = rx;
                else if (dir == 3'b111)
                    tx = lx;
                ay = curarr[6:0];
                ay = ay * 16;
                if((x >= tx && x < tx + 8) && (y >= ay && y < ay + 16)) begin
                    cdir = curarr[8:7];
                    case(cdir) //drawing the arrows based on which way they are turned
                        2'b00: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00111100;
                                4'b00010: data =8'b01111110;
                                4'b00011: data =8'b11111111;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b00011000;
                                4'b01101: data = 8'b00011000;
                                4'b01110: data = 8'b00011000;
                                4'b01111: data = 8'b00011000;
                            endcase                        
                        end
                        2'b01: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00011000;
                                4'b00010: data =8'b00011000;
                                4'b00011: data =8'b00011000;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b11111111;
                                4'b01101: data = 8'b01111110;
                                4'b01110: data = 8'b00111100;
                                4'b01111: data = 8'b00011000;
                            endcase
                        end
                        2'b11: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00010000;
                                4'b00101: data =8'b00110000;
                                4'b00110: data =8'b01110000;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b01110000;
                                4'b01010: data =8'b00110000;
                                4'b01011: data =8'b00010000;
                                4'b01100: data = 8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end 
                        2'b10: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00001000;
                                4'b00101: data =8'b00001100;
                                4'b00110: data =8'b00001110;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b00001110;
                                4'b01010: data =8'b00001100;
                                4'b01011: data =8'b00001000;
                                4'b01100: data =8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end
                    endcase
                    arrow = data[x[3:0]];
                end else begin
                    arrow = arrow;
                end
                
            end 
        curarr = arrows1;
        dir = curarr[9:7];
        if(curarr[10] == 1) begin
            dir = curarr[9:7]; 
                if(dir == 3'b100)
                    tx = ux;
                else if (dir == 3'b101)
                    tx = dx;
                else if(dir == 3'b110)
                    tx = rx;
                else if (dir == 3'b111)
                    tx = lx;
                ay = curarr[6:0];
                ay = ay * 16;
                if((x >= tx && x < tx + 8) && (y >= ay && y < ay + 16)) begin
                    cdir = curarr[8:7];
                    case(cdir)
                        2'b00: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00111100;
                                4'b00010: data =8'b01111110;
                                4'b00011: data =8'b11111111;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b00011000;
                                4'b01101: data = 8'b00011000;
                                4'b01110: data = 8'b00011000;
                                4'b01111: data = 8'b00011000;
                            endcase                        
                        end
                        2'b01: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00011000;
                                4'b00010: data =8'b00011000;
                                4'b00011: data =8'b00011000;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b11111111;
                                4'b01101: data = 8'b01111110;
                                4'b01110: data = 8'b00111100;
                                4'b01111: data = 8'b00011000;
                            endcase
                        end
                        2'b11: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00010000;
                                4'b00101: data =8'b00110000;
                                4'b00110: data =8'b01110000;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b01110000;
                                4'b01010: data =8'b00110000;
                                4'b01011: data =8'b00010000;
                                4'b01100: data = 8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end 
                        2'b10: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00001000;
                                4'b00101: data =8'b00001100;
                                4'b00110: data =8'b00001110;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b00001110;
                                4'b01010: data =8'b00001100;
                                4'b01011: data =8'b00001000;
                                4'b01100: data =8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end
                    endcase
                    arrow = data[x[3:0]];
                end else begin
                    arrow = arrow;
                end
            end
        curarr = arrows2;
        dir = curarr[9:7];
        if(curarr[10] == 1) begin
            dir = curarr[9:7]; 
                if(dir == 3'b100)
                    tx = ux;
                else if (dir == 3'b101)
                    tx = dx;
                else if(dir == 3'b110)
                    tx = rx;
                else if (dir == 3'b111)
                    tx = lx;
                ay = curarr[6:0];
                ay = ay * 16;
                if((x >= tx && x < tx + 8) && (y >= ay && y < ay + 16)) begin
                    cdir = curarr[8:7];
                    case(cdir)
                        2'b00: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00111100;
                                4'b00010: data =8'b01111110;
                                4'b00011: data =8'b11111111;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b00011000;
                                4'b01101: data = 8'b00011000;
                                4'b01110: data = 8'b00011000;
                                4'b01111: data = 8'b00011000;
                            endcase                        
                        end
                        2'b01: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00011000;
                                4'b00010: data =8'b00011000;
                                4'b00011: data =8'b00011000;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b11111111;
                                4'b01101: data = 8'b01111110;
                                4'b01110: data = 8'b00111100;
                                4'b01111: data = 8'b00011000;
                            endcase
                        end
                        2'b11: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00010000;
                                4'b00101: data =8'b00110000;
                                4'b00110: data =8'b01110000;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b01110000;
                                4'b01010: data =8'b00110000;
                                4'b01011: data =8'b00010000;
                                4'b01100: data = 8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end 
                        2'b10: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00001000;
                                4'b00101: data =8'b00001100;
                                4'b00110: data =8'b00001110;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b00001110;
                                4'b01010: data =8'b00001100;
                                4'b01011: data =8'b00001000;
                                4'b01100: data =8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end
                    endcase
                    arrow = data[x[3:0]];
                end else begin
                    arrow = arrow;
                end
                
            end
        curarr = arrows3;
        dir = curarr[9:7];
        if(curarr[10] == 1) begin
            dir = curarr[9:7]; 
                if(dir == 3'b100)
                    tx = ux;
                else if (dir == 3'b101)
                    tx = dx;
                else if(dir == 3'b110)
                    tx = rx;
                else if (dir == 3'b111)
                    tx = lx;
                ay = curarr[6:0];
                ay = ay * 16;
                if((x >= tx && x < tx + 8) && (y >= ay && y < ay + 16)) begin
                    cdir = curarr[8:7];
                    case(cdir)
                        2'b00: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00111100;
                                4'b00010: data =8'b01111110;
                                4'b00011: data =8'b11111111;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b00011000;
                                4'b01101: data = 8'b00011000;
                                4'b01110: data = 8'b00011000;
                                4'b01111: data = 8'b00011000;
                            endcase                        
                        end
                        2'b01: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00011000;
                                4'b00010: data =8'b00011000;
                                4'b00011: data =8'b00011000;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b11111111;
                                4'b01101: data = 8'b01111110;
                                4'b01110: data = 8'b00111100;
                                4'b01111: data = 8'b00011000;
                            endcase
                        end
                        2'b11: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00010000;
                                4'b00101: data =8'b00110000;
                                4'b00110: data =8'b01110000;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b01110000;
                                4'b01010: data =8'b00110000;
                                4'b01011: data =8'b00010000;
                                4'b01100: data = 8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end 
                        2'b10: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00001000;
                                4'b00101: data =8'b00001100;
                                4'b00110: data =8'b00001110;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b00001110;
                                4'b01010: data =8'b00001100;
                                4'b01011: data =8'b00001000;
                                4'b01100: data =8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end
                    endcase
                    arrow = data[x[3:0]];
                end else begin
                    arrow = arrow;
                end
                
            end
        curarr = arrows4;
        dir = curarr[9:7];
        if(curarr[10] == 1) begin
            dir = curarr[9:7]; 
                if(dir == 3'b100)
                    tx = ux;
                else if (dir == 3'b101)
                    tx = dx;
                else if(dir == 3'b110)
                    tx = rx;
                else if (dir == 3'b111)
                    tx = lx;
                ay = curarr[6:0];
                ay = ay * 16;
                if((x >= tx && x < tx + 8) && (y >= ay && y < ay + 16)) begin
                    cdir = curarr[8:7];
                    case(cdir)
                        2'b00: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00111100;
                                4'b00010: data =8'b01111110;
                                4'b00011: data =8'b11111111;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b00011000;
                                4'b01101: data = 8'b00011000;
                                4'b01110: data = 8'b00011000;
                                4'b01111: data = 8'b00011000;
                            endcase                        
                        end
                        2'b01: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00011000;
                                4'b00010: data =8'b00011000;
                                4'b00011: data =8'b00011000;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b11111111;
                                4'b01101: data = 8'b01111110;
                                4'b01110: data = 8'b00111100;
                                4'b01111: data = 8'b00011000;
                            endcase
                        end
                        2'b11: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00010000;
                                4'b00101: data =8'b00110000;
                                4'b00110: data =8'b01110000;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b01110000;
                                4'b01010: data =8'b00110000;
                                4'b01011: data =8'b00010000;
                                4'b01100: data = 8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end 
                        2'b10: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00001000;
                                4'b00101: data =8'b00001100;
                                4'b00110: data =8'b00001110;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b00001110;
                                4'b01010: data =8'b00001100;
                                4'b01011: data =8'b00001000;
                                4'b01100: data =8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end
                    endcase
                    arrow = data[x[3:0]];
                end else begin
                    arrow = arrow;
                end
                
            end
        curarr = arrows5;
        dir = curarr[9:7];
        if(curarr[10] == 1) begin
            dir = curarr[9:7]; 
                if(dir == 3'b100)
                    tx = ux;
                else if (dir == 3'b101)
                    tx = dx;
                else if(dir == 3'b110)
                    tx = rx;
                else if (dir == 3'b111)
                    tx = lx;
                ay = curarr[6:0];
                ay = ay * 16;
                if((x >= tx && x < tx + 8) && (y >= ay && y < ay + 16)) begin
                    cdir = curarr[8:7];
                    case(cdir)
                        2'b00: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00111100;
                                4'b00010: data =8'b01111110;
                                4'b00011: data =8'b11111111;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b00011000;
                                4'b01101: data = 8'b00011000;
                                4'b01110: data = 8'b00011000;
                                4'b01111: data = 8'b00011000;
                            endcase                        
                        end
                        2'b01: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00011000;
                                4'b00010: data =8'b00011000;
                                4'b00011: data =8'b00011000;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b11111111;
                                4'b01101: data = 8'b01111110;
                                4'b01110: data = 8'b00111100;
                                4'b01111: data = 8'b00011000;
                            endcase
                        end
                        2'b11: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00010000;
                                4'b00101: data =8'b00110000;
                                4'b00110: data =8'b01110000;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b01110000;
                                4'b01010: data =8'b00110000;
                                4'b01011: data =8'b00010000;
                                4'b01100: data = 8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end 
                        2'b10: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00001000;
                                4'b00101: data =8'b00001100;
                                4'b00110: data =8'b00001110;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b00001110;
                                4'b01010: data =8'b00001100;
                                4'b01011: data =8'b00001000;
                                4'b01100: data =8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end
                    endcase
                    arrow = data[x[3:0]];
                end else begin
                    arrow = arrow;
                end
                
            end 
        curarr = arrows6;
        dir = curarr[9:7];
        if(curarr[10] == 1) begin
            dir = curarr[9:7]; 
                if(dir == 3'b100)
                    tx = ux;
                else if (dir == 3'b101)
                    tx = dx;
                else if(dir == 3'b110)
                    tx = rx;
                else if (dir == 3'b111)
                    tx = lx;
                ay = curarr[6:0];
                ay = ay * 16;
                if((x >= tx && x < tx + 8) && (y >= ay && y < ay + 16)) begin
                    cdir = curarr[8:7];
                    case(cdir)
                        2'b00: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00111100;
                                4'b00010: data =8'b01111110;
                                4'b00011: data =8'b11111111;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b00011000;
                                4'b01101: data = 8'b00011000;
                                4'b01110: data = 8'b00011000;
                                4'b01111: data = 8'b00011000;
                            endcase                        
                        end
                        2'b01: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00011000;
                                4'b00010: data =8'b00011000;
                                4'b00011: data =8'b00011000;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b11111111;
                                4'b01101: data = 8'b01111110;
                                4'b01110: data = 8'b00111100;
                                4'b01111: data = 8'b00011000;
                            endcase
                        end
                        2'b11: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00010000;
                                4'b00101: data =8'b00110000;
                                4'b00110: data =8'b01110000;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b01110000;
                                4'b01010: data =8'b00110000;
                                4'b01011: data =8'b00010000;
                                4'b01100: data = 8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end 
                        2'b10: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00001000;
                                4'b00101: data =8'b00001100;
                                4'b00110: data =8'b00001110;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b00001110;
                                4'b01010: data =8'b00001100;
                                4'b01011: data =8'b00001000;
                                4'b01100: data =8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end
                    endcase
                    arrow = data[x[3:0]];
                end else begin
                    arrow = arrow;
                end
            end
        curarr = arrows7;
        dir = curarr[9:7];
        if(curarr[10] == 1) begin
            dir = curarr[9:7]; 
                if(dir == 3'b100)
                    tx = ux;
                else if (dir == 3'b101)
                    tx = dx;
                else if(dir == 3'b110)
                    tx = rx;
                else if (dir == 3'b111)
                    tx = lx;
                ay = curarr[6:0];
                ay = ay * 16;
                if((x >= tx && x < tx + 8) && (y >= ay && y < ay + 16)) begin
                    cdir = curarr[8:7];
                    case(cdir)
                        2'b00: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00111100;
                                4'b00010: data =8'b01111110;
                                4'b00011: data =8'b11111111;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b00011000;
                                4'b01101: data = 8'b00011000;
                                4'b01110: data = 8'b00011000;
                                4'b01111: data = 8'b00011000;
                            endcase                        
                        end
                        2'b01: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00011000;
                                4'b00010: data =8'b00011000;
                                4'b00011: data =8'b00011000;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b11111111;
                                4'b01101: data = 8'b01111110;
                                4'b01110: data = 8'b00111100;
                                4'b01111: data = 8'b00011000;
                            endcase
                        end
                        2'b11: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00010000;
                                4'b00101: data =8'b00110000;
                                4'b00110: data =8'b01110000;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b01110000;
                                4'b01010: data =8'b00110000;
                                4'b01011: data =8'b00010000;
                                4'b01100: data = 8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end 
                        2'b10: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00001000;
                                4'b00101: data =8'b00001100;
                                4'b00110: data =8'b00001110;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b00001110;
                                4'b01010: data =8'b00001100;
                                4'b01011: data =8'b00001000;
                                4'b01100: data =8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end
                    endcase
                    arrow = data[x[3:0]];
                end else begin
                    arrow = arrow;
                end
                
            end
        curarr = arrows8;
        dir = curarr[9:7];
        if(curarr[10] == 1) begin
            dir = curarr[9:7]; 
                if(dir == 3'b100)
                    tx = ux;
                else if (dir == 3'b101)
                    tx = dx;
                else if(dir == 3'b110)
                    tx = rx;
                else if (dir == 3'b111)
                    tx = lx;
                ay = curarr[6:0];
                ay = ay * 16;
                if((x >= tx && x < tx + 8) && (y >= ay && y < ay + 16)) begin
                    cdir = curarr[8:7];
                    case(cdir)
                        2'b00: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00111100;
                                4'b00010: data =8'b01111110;
                                4'b00011: data =8'b11111111;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b00011000;
                                4'b01101: data = 8'b00011000;
                                4'b01110: data = 8'b00011000;
                                4'b01111: data = 8'b00011000;
                            endcase                        
                        end
                        2'b01: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00011000;
                                4'b00010: data =8'b00011000;
                                4'b00011: data =8'b00011000;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b11111111;
                                4'b01101: data = 8'b01111110;
                                4'b01110: data = 8'b00111100;
                                4'b01111: data = 8'b00011000;
                            endcase
                        end
                        2'b11: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00010000;
                                4'b00101: data =8'b00110000;
                                4'b00110: data =8'b01110000;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b01110000;
                                4'b01010: data =8'b00110000;
                                4'b01011: data =8'b00010000;
                                4'b01100: data = 8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end 
                        2'b10: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00001000;
                                4'b00101: data =8'b00001100;
                                4'b00110: data =8'b00001110;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b00001110;
                                4'b01010: data =8'b00001100;
                                4'b01011: data =8'b00001000;
                                4'b01100: data =8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end
                    endcase
                    arrow = data[x[3:0]];
                end else begin
                    arrow = arrow;
                end
                
            end
        curarr = arrows9;
        dir = curarr[9:7];
        if(curarr[10] == 1) begin
            dir = curarr[9:7]; 
                if(dir == 3'b100)
                    tx = ux;
                else if (dir == 3'b101)
                    tx = dx;
                else if(dir == 3'b110)
                    tx = rx;
                else if (dir == 3'b111)
                    tx = lx;
                ay = curarr[6:0];
                ay = ay * 16;
                if((x >= tx && x < tx + 8) && (y >= ay && y < ay + 16)) begin
                    cdir = curarr[8:7];
                    case(cdir)
                        2'b00: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00111100;
                                4'b00010: data =8'b01111110;
                                4'b00011: data =8'b11111111;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b00011000;
                                4'b01101: data = 8'b00011000;
                                4'b01110: data = 8'b00011000;
                                4'b01111: data = 8'b00011000;
                            endcase                        
                        end
                        2'b01: begin
                            case(y[3:0])
                                4'b00000: data =8'b00011000;
                                4'b00001: data =8'b00011000;
                                4'b00010: data =8'b00011000;
                                4'b00011: data =8'b00011000;
                                4'b00100: data =8'b00011000;
                                4'b00101: data =8'b00011000;
                                4'b00110: data =8'b00011000;
                                4'b00111: data =8'b00011000;
                                4'b01000: data = 8'b00011000;
                                4'b01001: data = 8'b00011000;
                                4'b01010: data = 8'b00011000;
                                4'b01011: data = 8'b00011000;
                                4'b01100: data = 8'b11111111;
                                4'b01101: data = 8'b01111110;
                                4'b01110: data = 8'b00111100;
                                4'b01111: data = 8'b00011000;
                            endcase
                        end
                        2'b11: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00010000;
                                4'b00101: data =8'b00110000;
                                4'b00110: data =8'b01110000;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b01110000;
                                4'b01010: data =8'b00110000;
                                4'b01011: data =8'b00010000;
                                4'b01100: data = 8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end 
                        2'b10: begin
                            case(y[3:0])
                                4'b00000: data =8'b00000000;
                                4'b00001: data =8'b00000000;
                                4'b00010: data =8'b00000000;
                                4'b00011: data =8'b00000000;
                                4'b00100: data =8'b00001000;
                                4'b00101: data =8'b00001100;
                                4'b00110: data =8'b00001110;
                                4'b00111: data =8'b11111111;
                                4'b01000: data =8'b11111111;
                                4'b01001: data =8'b00001110;
                                4'b01010: data =8'b00001100;
                                4'b01011: data =8'b00001000;
                                4'b01100: data =8'b00000000;
                                4'b01101: data = 8'b00000000;
                                4'b01110: data = 8'b00000000;
                                4'b01111: data = 8'b00000000;
                            endcase
                        end
                    endcase
                    arrow = data[x[3:0]];
                end else begin
                    arrow = arrow;
                end
            end
    end  
    always @(video_on, x, y)
        if(~video_on)
            rgb = 12'hF00;
        else
            if(arrow)
                rgb = 12'hFF0;  
            else if(u_white_on)
                rgb = 12'h00F;
            else if(u_yellow_on)
                rgb = 12'h00F;
            else if(u_aqua_on)
                rgb = 12'h00F;
            else if(u_green_on)
                rgb = 12'h00F;
            else if(u_violet_on)
                rgb = 12'h00F;
            else if(u_red_on)
                rgb = 12'h00F;
            else if(u_blue_on)
                rgb = 12'h00F;
            else if(l_blue_on)
                rgb = 12'h00F;
            else if(l_black1_on)
                rgb = 12'h00F;
            else if(l_violet_on)
                rgb = 12'h00F;
            else if(l_gray_on)
                rgb = 12'h00F;
            else if(l_aqua_on)
                rgb = 12'h00F;
            else if(l_black2_on)
                rgb = 12'h00F;
            else if(l_white_on)
                rgb = 12'h00F;
   
endmodule  

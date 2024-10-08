`timescale 1ns / 1ps

module clock(
    //Input
    sys_clk, 
    //Ouput
    onehz_clk, twohz_clk, fast_clk, blink_clk
    );
// Master clock: 100 MHz
input sys_clk;


// 1 Hz clock
// 100,000,000 clock cycles for onehz_clk to go high and return to low
// Thus, it takes half (i.e. 50,000,000) for onehz_clk to go high
output wire onehz_clk;
reg onehz_clk_temp;
// 2 Hz clock
// 50,000,000 clock cycles for twohz_clk to go high and return to low
// Thus, it takes half (i.e. 25,000,000) for twohz_clk to go high
output wire twohz_clk;
reg twohz_clk_temp;
// 400 Hz clock
// 250,000 clock cycles for fasthz_clk to go high and return to low
// Thus, it takes half (i.e. 125,000) for fasthz_clk to go high
output wire fast_clk;
reg fast_clk_temp;
// 4 Hz clock
// 25,000,000 clock cycles for blinkhz_clk to go high and return to low
// Thus, it takes half (i.e. 12,500,000) for blinkhz_clk to go high
output wire blink_clk;
reg blink_clk_temp;

// Counters to count the clock cycles before the specified clock goes high
reg [31:0] onehz_count;
reg [31:0] twohz_count;
reg [31:0] fasthz_count;
reg [31:0] blinkhz_count;

    // 1 Hz Clock Implementation
    always @ (posedge sys_clk) begin
        if (onehz_count == 32'd50000000 - 32'b1) begin
            onehz_count <= 32'b0;
            onehz_clk_temp <= ~onehz_clk;
        end
        else begin
            onehz_count <= onehz_count + 32'b1;
            onehz_clk_temp <= onehz_clk;
        end
    end
    // 2 Hz Clock Implementation
    always @ (posedge sys_clk) begin
        if (twohz_count == 32'd25000000 - 32'b1) begin
            twohz_count <= 32'b0;
            twohz_clk_temp <= ~twohz_clk;
        end
        else begin
            twohz_count <= twohz_count + 32'b1;
            twohz_clk_temp <= twohz_clk;
        end
    end
    // Fast (400 Hz) Clock Implementation
    always @ (posedge sys_clk) begin
        if (fasthz_count == 32'd125000 - 32'b1) begin
            fasthz_count <= 32'b0;
            fast_clk_temp <= ~fast_clk;
        end
        else begin
            fasthz_count <= fasthz_count + 32'b1;
            fast_clk_temp <= fast_clk;
        end
    end
    // Blink (4 Hz) Clock Implementation
    always @ (posedge sys_clk) begin
        if (blinkhz_count == 32'd12500000 - 32'b1) begin
            blinkhz_count <= 32'b0;
            blink_clk_temp <= ~blink_clk;
        end
        else begin
            blinkhz_count <= blinkhz_count + 32'b1;
            blink_clk_temp <= blink_clk;
        end
    end
	 
	 assign onehz_clk = onehz_clk_temp;
	 assign twohz_clk = twohz_clk_temp;
	 assign fast_clk = fast_clk_temp;
	 assign blink_clk = blink_clk_temp;
	 
endmodule

//module clock(
//    input clk, 
//    output clock_output1,
//    output clock_output2,
//    output clock_output4,
//    output clock_output500
//    );
    
//    integer counter = 0;
    
//    reg temp1, temp2, temp3, temp4;
    
//    //for testing (tb)
    
////    always @ (posedge clk) begin 
////        if (counter%1 == 0) begin 
////            temp4 = 1'b0;
////        end 
////        if (counter%2 == 0) begin 
////            temp4 = 1'b1;
////        end
////        if (counter%125 == 0) begin 
////            temp3 = 1'b0;
////        end 
////        if (counter%250 == 0) begin
////            temp3 = 1'b1;
////            temp2 = 1'b0;
////        end
////        if(counter%500 == 0) begin
////            temp2 = 1'b1;
////            temp1 = 1'b0;
////        end
////        if (counter == 1000) begin 
////            temp1 = 1'b1;
////            counter = 0;
////        end 
////        if (clk == 1) begin 
////           counter = counter + 1;
////        end 
////    end 
    
//    //for synthesis
    
//    always @ (posedge clk) begin 
//        if (counter%100000 == 0) begin 
//            temp4 = 1'b0;
//        end 
//        if (counter%200000 == 0) begin 
//            temp4 = 1'b1;
//        end
//        if (counter%12500000 == 0) begin 
//            temp3 = 1'b0;
//        end 
//        if (counter%25000000 == 0) begin
//            temp3 = 1'b1;
//            temp2 = 1'b0;
//        end
//        if(counter%50000000 == 0) begin
//            temp2 = 1'b1;
//            temp1 = 1'b0;
//        end
//        if (counter == 100000000) begin 
//            temp1 = 1'b1;
//            counter = 0;
//        end 
//        if (clk == 1) begin 
//           counter = counter + 1;
//        end 
//    end 
    
//    assign clock_output1 = temp1;
//    assign clock_output2 = temp2;
//    assign clock_output4 = temp3;
//    assign clock_output500 = temp4;

//endmodule

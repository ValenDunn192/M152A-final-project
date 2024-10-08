`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// NOT OUR CODE TAKEN FROM FPGA DUDE VGA FULL SCREEN TEXT EDITOR
//https://github.com/FPGADude/Digital-Design/blob/main/FPGA%20Projects/VGA%20Projects/VGA%20Full%20Screen%20Text%20Editor/simple_dual_one_clock.v
// 
//////////////////////////////////////////////////////////////////////////////////


module ram
    #(
        parameter DATA_SIZE = 7,
        parameter ADDR_SIZE = 12
    )
    (
    input clk,
    input we,
    input [ADDR_SIZE-1:0] addr_a, addr_b,
    input [DATA_SIZE-1:0] din_a,
    output [DATA_SIZE-1:0] dout_a, dout_b
    );
    
    // Infer the RAM as block ram
    (* ram_style = "block" *) reg [DATA_SIZE-1:0] ram [2**ADDR_SIZE-1:0];
    
    reg [ADDR_SIZE-1:0] addr_a_reg, addr_b_reg;
    
    // body
    always @(posedge clk) begin
        if(we)      // write operation
            ram[addr_a] <= din_a;
        addr_a_reg <= addr_a;
        addr_b_reg <= addr_b;
    end
    
    // two read operations        
    assign dout_a = ram[addr_a_reg];
    assign dout_b = ram[addr_b_reg];
    
endmodule

`timescale 1ns / 1ps

module select_clock(
	input clk, 
	input clk_adj,
	input adj,
	output clock
    );

reg clock_reg;

always @* begin
	if (adj == 0) begin
		clock_reg = clk;
	end
	else begin //if (adjust) begin
		clock_reg = clk_adj;
	end
end

assign clock = clock_reg;

endmodule
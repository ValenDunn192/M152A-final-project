`timescale 1ns / 1ps

module counter(
	input reset,
	input pause,
	input clk,
	input clk_adj,
	output [3:0] min0,
	output [3:0] min1,
	output [3:0] sec0,
	output [3:0] sec1
    );

    reg [3:0] min1_count = 4'b0000;
	reg [3:0] min0_count = 4'b0000;
	reg [3:0] sec1_count = 4'b0000;
	reg [3:0] sec0_count = 4'b0000;

	wire clock;
	wire paused;
	
	always @ (posedge clk or posedge pause) begin
		if (pause) begin
			paused <= ~paused;
		end
		else begin
			paused <= paused;
		end
	end
	
	always @(posedge clock or posedge reset) begin
		
		if (reset) begin
			min0_count <= 4'b0000;
			min1_count <= 4'b0000;
			sec0_count <= 4'b0000;
			sec1_count <= 4'b0000;
		end


		else if (adj == 0 && ~paused) begin
			if (sec0_count == 9 && sec1_count == 5) begin
				sec0_count <= 0;
				sec1_count <= 0;
				
				if (min0_count == 9 && min1_count == 9) begin
					min0_count <= 4'b0;
					min1_count <= 4'b0;
				end
				else if (min0_count == 9) begin
					min0_count <= 4'b0;
					min1_count <= min1_count + 4'b1;
				end
				else begin
					min0_count <= min0_count + 4'b1;
				end
			end
			else if (sec0_count == 9) begin
				sec0_count <= 4'b0;
				sec1_count <= sec1_count + 4'b1;
			end
			else begin
				sec0_count <= sec0_count + 4'b1;
			end
		end

		else if (adj == 1 && ~paused && sel) begin
			if (sec0_count == 9 && sec1_count == 5) begin
				sec0_count <= 0;
				sec1_count <= 0;
			end
			else if (sec0_count == 9) begin
				sec0_count <= 4'b0;
				sec1_count <= sec1_count + 4'b1;
			end
			else begin
				sec0_count <= sec0_count + 4'b1;
			end
		end
		else if (adj == 1 && ~paused && ~sel) begin
			if (min0_count == 9 && min1_count == 9) begin
				min0_count <= 0;
				min1_count <= 0;
			end
			else if (min0_count == 9) begin
				min0_count <= 4'b0;
				min1_count <= min1_count + 4'b1;
			end
			else begin
				min0_count <= min0_count + 4'b1;
			end
		end
		
	end

	assign min1 = min1_count;
	assign min0 = min0_count;
	assign sec1 = sec1_count;
	assign sec0 = sec0_count;

endmodule
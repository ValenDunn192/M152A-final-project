`timescale 1ns / 1ps

module debouncer(
  //Inputs
  input button, 
  input clk,
  //Outputs
  output bounce_state
);

  reg debounce_temp = 0;
  reg [7:0] counter; // Changed counter width to 8 bits for increased sensitivity

  reg sync_to_clk0;
  reg sync_to_clk1;

  always @ (posedge clk) begin
    sync_to_clk0 <= button;
  end
  
  always @ (posedge clk) begin
    sync_to_clk1 <= sync_to_clk0;
  end

  always @ (posedge clk) begin
    if (debounce_temp == sync_to_clk1) begin
      counter <= 0;
    end else begin
      counter <= counter + 1'b1;
      if (counter == 8'h20) begin // Decreased counter value for increased sensitivity
        debounce_temp <= ~bounce_state;
      end
    end
  end
  
  assign bounce_state = debounce_temp;
  
endmodule


//`timescale 1ns / 1ps

//module debounce(
//    input clk,      // 100MHz
//    input btn_in,
//    output btn_out
//    );
    
//    reg r1, r2, r3;
    
//    always @(posedge clk) begin
//        r1 <= btn_in;
//        r2 <= r1;
//        r3 <= r2;
//    end
    
//    assign btn_out = r3;
    
//endmodule
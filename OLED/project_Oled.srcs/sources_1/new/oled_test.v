`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2025 21:33:22
// Design Name: 
// Module Name: oled_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module oled_test (
  input clk,            // 100 MHz
  input rst,
  output spi_clk,
  output spi_mosi,
  output spi_cs,
  output oled_dc,
  output oled_res
);

  reg init_done = 0;
  reg [7:0] cmd [0:15];
  reg [7:0] data;
  wire busy;

  initial begin
    // Basic init sequence (simplified)
    cmd[0] = 8'hAE; // Display OFF
    cmd[1] = 8'hA0; // Color remap
    cmd[2] = 8'h72;
    cmd[3] = 8'hA1; // Start Line
    cmd[4] = 8'h00;
    cmd[5] = 8'hA2; // Display Offset
    cmd[6] = 8'h00;
    cmd[7] = 8'hAF; // Display ON
  end

  reg [3:0] state = 0;
  reg start_tx = 0;
  reg [7:0] tx_data = 0;
  reg dc = 0;

  always @(posedge clk) begin
    if (rst) begin
      state <= 0;
    end else begin
      if (!busy && !init_done) begin
        case (state)
          0: begin tx_data <= cmd[0]; dc <= 0; start_tx <= 1; state <= state + 1; end
          1: begin tx_data <= cmd[1]; dc <= 0; start_tx <= 1; state <= state + 1; end
          2: begin tx_data <= cmd[2]; dc <= 0; start_tx <= 1; state <= state + 1; end
          3: begin tx_data <= cmd[3]; dc <= 0; start_tx <= 1; state <= state + 1; end
          4: begin tx_data <= cmd[4]; dc <= 0; start_tx <= 1; state <= state + 1; end
          5: begin tx_data <= cmd[5]; dc <= 0; start_tx <= 1; state <= state + 1; end
          6: begin tx_data <= cmd[6]; dc <= 0; start_tx <= 1; state <= state + 1; end
          7: begin tx_data <= cmd[7]; dc <= 0; start_tx <= 1; state <= 8; end
          8: begin init_done <= 1; end
        endcase
      end else begin
        start_tx <= 0;
      end
    end
  end

  spi_master spi (
    .clk(clk),
    .start(start_tx),
    .data_in(tx_data),
    .mosi(spi_mosi),
    .sclk(spi_clk),
    .cs(spi_cs),
    .dc(oled_dc),
    .busy(busy)
  );

  assign oled_res = ~rst; // active low reset
endmodule


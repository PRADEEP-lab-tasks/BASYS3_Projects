`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2025 21:38:40
// Design Name: 
// Module Name: spi_master
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


module spi_master (
  input clk,               // System clock
  input start,             // Start transmission
  input [7:0] data_in,     // Byte to transmit
  output reg mosi,         // SPI MOSI
  output reg sclk,         // SPI Clock
  output reg cs,           // Chip Select (active low)
  output reg dc,           // Data/Command pin
  output reg busy
);

  reg [3:0] bit_cnt = 0;
  reg [7:0] shift_reg = 0;

  parameter CLK_DIV = 100; // For slow SPI (adjust for your speed)

  reg [6:0] clk_cnt = 0;

  always @(posedge clk) begin
    if (start && !busy) begin
      cs <= 0;
      busy <= 1;
      shift_reg <= data_in;
      bit_cnt <= 0;
    end else if (busy) begin
      if (clk_cnt == CLK_DIV) begin
        clk_cnt <= 0;
        mosi <= shift_reg[7];
        shift_reg <= {shift_reg[6:0], 1'b0};
        bit_cnt <= bit_cnt + 1;
        sclk <= ~sclk;

        if (bit_cnt == 8) begin
          busy <= 0;
          cs <= 1;
          sclk <= 0;
        end
      end else begin
        clk_cnt <= clk_cnt + 1;
      end
    end else begin
      cs <= 1;
      sclk <= 0;
      busy <= 0;
    end
  end
endmodule


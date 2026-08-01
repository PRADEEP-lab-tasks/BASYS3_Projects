`timescale 1ns / 1ps

// ------------------------------------------------------------
// SPI byte master, Mode 0, active-low CS. One-byte transactions.
// ce should be a 1-cycle enable at desired SCLK/2 rate.
// ------------------------------------------------------------
module spi_byte_master #(
    parameter CPOL = 0,
    parameter CPHA = 0
)(
    input  wire clk,
    input  wire ce,
    input  wire start,
    input  wire [7:0] tx_byte,
    output reg  busy = 0,
    output reg  sclk = 0,
    output reg  mosi = 0,
    output reg  cs_n = 1
);
    reg [2:0] bitpos = 3'd7;
    reg [7:0] shreg = 8'h00;
    reg phase = 0;

    initial begin
        sclk = CPOL ? 1'b1 : 1'b0;
        cs_n = 1'b1;
    end

    always @(posedge clk) begin
        if (!busy) begin
            if (start) begin
                busy  <= 1;
                cs_n  <= 0;
                shreg <= tx_byte;
                bitpos<= 3'd7;
                phase <= 0;
                sclk  <= CPOL ? 1'b1 : 1'b0;
                mosi  <= tx_byte[7];
            end
        end else begin
            if (ce) begin
                // Mode 0: sample on rising, change on falling
                phase <= ~phase;
                if (phase == 0) begin
                    sclk <= 1'b1;
                end else begin
                    sclk <= 1'b0;
                    if (bitpos == 0) begin
                        busy <= 0;
                        cs_n <= 1;
                    end else begin
                        bitpos <= bitpos - 1;
                        shreg <= {shreg[6:0],1'b0};
                        mosi  <= shreg[6];
                    end
                end
            end
        end
    end
endmodule

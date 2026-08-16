// top.v
// Top level for Basys 3: displays the 16 slide switches, read as an
// unsigned binary number, as a 5-digit decimal value on a Pmod OLED
// plugged into the JB connector.

module top (
    input  wire        clk,     // 100 MHz onboard oscillator (W5)
    input  wire [15:0] sw,      // SW0-SW15
    input  wire        btnC,    // center button = manual reset/redraw

    output wire oled_cs,
    output wire oled_sdin,
    output wire oled_sclk,
    output wire oled_dc,
    output wire oled_res,
    output wire oled_vbat,
    output wire oled_vdd
);

    // Short power-on-reset pulse generated from FPGA configuration,
    // OR'd with the center button so the user can force a manual redraw.
    reg [3:0] por_cnt = 4'd0;
    reg       por_reset = 1'b1;
    always @(posedge clk) begin
        if (por_cnt != 4'hF) begin
            por_cnt   <= por_cnt + 1'b1;
            por_reset <= 1'b1;
        end else begin
            por_reset <= 1'b0;
        end
    end
    wire reset = por_reset | btnC;

    wire [3:0] d4, d3, d2, d1, d0;

    bin2bcd u_bcd (
        .bin_in(sw),
        .d4(d4), .d3(d3), .d2(d2), .d1(d1), .d0(d0)
    );

    oled_ssd1306 u_oled (
        .clk   (clk),
        .reset (reset),
        .d4(d4), .d3(d3), .d2(d2), .d1(d1), .d0(d0),
        .oled_cs   (oled_cs),
        .oled_sdin (oled_sdin),
        .oled_sclk (oled_sclk),
        .oled_dc   (oled_dc),
        .oled_res  (oled_res),
        .oled_vbat (oled_vbat),
        .oled_vdd  (oled_vdd)
    );

endmodule

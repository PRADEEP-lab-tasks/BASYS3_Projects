// Created by Pradeep with the help of AI


`timescale 1ns/1ns

module tb_oled;

    reg clk = 0;
    reg reset = 1;
    reg [15:0] sw = 16'd1234;

    wire [3:0] d4, d3, d2, d1, d0;
    bin2bcd u_bcd (.bin_in(sw), .d4(d4), .d3(d3), .d2(d2), .d1(d1), .d0(d0));

    wire oled_cs, oled_sdin, oled_sclk, oled_dc, oled_res, oled_vbat, oled_vdd;

    // Small parameter overrides so power-up delays complete quickly in sim
    oled_ssd1306 #(
        .TICK_DIV       (4),
        .RES_LOW_CYCLES (20),
        .WAIT_SHORT     (40),
        .WAIT_VBAT      (60)
    ) dut (
        .clk(clk), .reset(reset),
        .d4(d4), .d3(d3), .d2(d2), .d1(d1), .d0(d0),
        .oled_cs(oled_cs), .oled_sdin(oled_sdin), .oled_sclk(oled_sclk),
        .oled_dc(oled_dc), .oled_res(oled_res), .oled_vbat(oled_vbat), .oled_vdd(oled_vdd)
    );

    always #5 clk = ~clk; // 100MHz

    // ---- Behavioral SPI bus monitor: purely watches the pins, exactly
    // ---- like an external logic analyzer / the real SSD1306 would.
    integer bitcnt = 0;
    reg [7:0] shiftreg = 0;
    reg last_sclk = 0;

    integer byte_count = 0;
    reg [7:0] captured_bytes [0:1200];
    reg       captured_dc    [0:1200];

    always @(posedge clk) begin
        last_sclk <= oled_sclk;
        if (!oled_cs && oled_sclk && !last_sclk) begin // rising edge, CS active
            shiftreg <= {shiftreg[6:0], oled_sdin};
            bitcnt <= bitcnt + 1;
            if (bitcnt == 7) begin
                captured_bytes[byte_count] <= {shiftreg[6:0], oled_sdin};
                captured_dc[byte_count]    <= oled_dc;
                byte_count <= byte_count + 1;
                bitcnt <= 0;
            end
        end
    end

    // Reference model of the pixel font, matching the design under test,
    // used only to independently check the captured frame bytes.
    function [7:0] ref_font;
        input [3:0] digit; input [2:0] col;
        reg [39:0] glyph;
        begin
            case (digit)
                4'd0: glyph = {8'h3E,8'h51,8'h49,8'h45,8'h3E};
                4'd1: glyph = {8'h00,8'h42,8'h7F,8'h40,8'h00};
                4'd2: glyph = {8'h42,8'h61,8'h51,8'h49,8'h46};
                4'd3: glyph = {8'h21,8'h41,8'h45,8'h4B,8'h31};
                4'd4: glyph = {8'h18,8'h14,8'h12,8'h7F,8'h10};
                4'd5: glyph = {8'h27,8'h45,8'h45,8'h45,8'h39};
                4'd6: glyph = {8'h3C,8'h4A,8'h49,8'h49,8'h30};
                4'd7: glyph = {8'h01,8'h71,8'h09,8'h05,8'h03};
                4'd8: glyph = {8'h36,8'h49,8'h49,8'h49,8'h36};
                default: glyph = {8'h06,8'h49,8'h49,8'h29,8'h1E};
            endcase
            ref_font = glyph >> (8*(4-col));
        end
    endfunction

    function [7:0] ref_pixel;
        input [8:0] page; input [7:0] col;
        input [3:0] g4,g3,g2,g1,g0;
        reg [7:0] off; reg [3:0] idx; reg [2:0] sub; reg [3:0] dsel;
        begin
            ref_pixel = 8'h00;
            if (page == 1 && col >= 20) begin
                off = col - 20; idx = off/8; sub = off%8;
                if (idx < 5 && sub < 5) begin
                    case(idx)
                        0: dsel=g4; 1: dsel=g3; 2: dsel=g2; 3: dsel=g1; default: dsel=g0;
                    endcase
                    ref_pixel = ref_font(dsel, sub);
                end
            end
        end
    endfunction

    task check_value(input [15:0] value, input [3:0] eg4, eg3, eg2, eg1, eg0, input integer framestart);
        integer i, errors;
        reg [8:0] page_i; reg [7:0] col_i; reg [7:0] expect_b;
        begin
            $display("--- Checking rendered value %0d (expect digits %0d%0d%0d%0d%0d) ---",
                       value, eg4, eg3, eg2, eg1, eg0);
            errors = 0;
            for (i = 0; i < 512; i = i + 1) begin
                page_i = i / 128;
                col_i  = i % 128;
                expect_b = ref_pixel(page_i, col_i, eg4, eg3, eg2, eg1, eg0);
                if (captured_dc[framestart+i] !== 1'b1) begin
                    $display("  ERROR byte %0d: expected DC=1 (data), got %0d", i, captured_dc[framestart+i]);
                    errors = errors + 1;
                end
                if (captured_bytes[framestart+i] !== expect_b) begin
                    $display("  ERROR byte %0d (page %0d col %0d): expected %02h got %02h",
                             i, page_i, col_i, expect_b, captured_bytes[framestart+i]);
                    errors = errors + 1;
                end
            end
            if (errors == 0)
                $display("  PASS: all 512 frame bytes match expected render for %0d", value);
            else
                $display("  FAIL: %0d mismatches", errors);
        end
    endtask

    task print_ascii(input integer framestart);
        integer col, row, i;
        reg [7:0] b;
        reg [1023:0] line;
        begin
            for (row = 0; row < 7; row = row + 1) begin
                line = "";
                for (col = 0; col < 60; col = col + 1) begin
                    b = captured_bytes[framestart + 128 + col]; // page 1 starts at frame offset 128
                    if (b[row]) line = {line, "#"}; else line = {line, "."};
                end
                $display("%0s", line);
            end
        end
    endtask

    initial begin
        $dumpfile("oled.vcd");
        $dumpvars(0, tb_oled);

        #20 reset = 0;

        // Wait for first frame to finish: watch for byte_count to reach
        // 24(init) + 6(window) + 1(dispon) + 512(frame) = 543, then settle
        wait (byte_count == 543);
        #100;
        $display("");
        $display("=== First power-up sequence ===");
        $display("Init command bytes (DC=0), first 24:");
        for (byte_count = byte_count; 0 == 1; ) ; // no-op guard (unused)
        begin : show_init
            integer k;
            for (k = 0; k < 24; k = k + 1)
                $write("%02h ", captured_bytes[k]);
            $display("");
        end
        $display("Window+DispOn bytes (DC=0), next 7:");
        begin : show_win
            integer k;
            for (k = 24; k < 31; k = k + 1)
                $write("%02h ", captured_bytes[k]);
            $display("");
        end

        check_value(1234, 0, 1, 2, 3, 4, 31);
        $display("ASCII render of digits (page 1, cols 20-79):");
        print_ascii(31);

        // Now change the switches and confirm it auto-redraws with new digits
        sw = 16'd65535;
        $display("");
        $display("=== Changing switches to 65535, waiting for auto-redraw ===");
        wait (byte_count == 543 + 512);
        #100;
        check_value(65535, 6, 5, 5, 3, 5, 543);
        $display("ASCII render of digits (page 1, cols 20-79):");
        print_ascii(543);

        // Also confirm oled_vdd / oled_vbat were asserted (active-low = 0) by now
        if (oled_vdd !== 1'b0) $display("ERROR: oled_vdd not asserted low");
        else $display("PASS: oled_vdd asserted low (supply enabled)");
        if (oled_vbat !== 1'b0) $display("ERROR: oled_vbat not asserted low");
        else $display("PASS: oled_vbat asserted low (supply enabled)");

        $display("");
        $display("=== ALL CHECKS COMPLETE ===");
        $finish;
    end

    // Safety timeout
    initial begin
        #2_000_000;
        $display("TIMEOUT - simulation did not complete");
        $finish;
    end

endmodule

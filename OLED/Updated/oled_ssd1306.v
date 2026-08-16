## Created by Pradeep with the help of AI


// oled_ssd1306.v
// Drives a Digilent Pmod OLED (128x32, SSD1306 controller) over its
// 4-wire SPI-like interface and displays five decimal digits (00000-65535).
//
// The SSD1306 has its own internal display RAM and keeps showing the last
// image written to it with no help from the FPGA ("refreshing and updating
// is handled internally" - Digilent PmodOLED reference manual). So this
// driver only has to (1) run the power-up/init sequence once, then
// (2) write a new 512-byte frame whenever the requested digits change.
//
// Pmod OLED pinout (12-pin connector, per Digilent PmodOLED reference manual):
//   Pin 1 CS, Pin 2 SDIN(MOSI), Pin 3 N/C, Pin 4 SCLK,
//   Pin 7 D/C, Pin 8 RES, Pin 9 VBATC, Pin 10 VDDC   (5/11=GND, 6/12=VCC)
// VDDC/VBATC have pull-ups that turn the associated supply OFF when the pin
// is left floating, so both are driven LOW to turn the supply ON.

module oled_ssd1306 #(
    parameter CLK_FREQ_HZ    = 100_000_000,
    parameter TICK_DIV       = 50,      // clk cycles per SPI half-bit -> 1MHz SCLK
    parameter RES_LOW_CYCLES = 1000,    // >=3us reset pulse (10us @100MHz)
    parameter WAIT_SHORT     = 100_000, // ~1ms settle delays
    parameter WAIT_VBAT      = 1_000_000 // OLED cap charge delay before turning display on
)(
    input  wire       clk,
    input  wire        reset,
    input  wire [3:0]  d4, d3, d2, d1, d0,  // digits to display, MSD first

    output reg         oled_cs,
    output reg         oled_sdin,
    output reg         oled_sclk,
    output reg         oled_dc,
    output reg         oled_res,
    output reg         oled_vbat,
    output reg         oled_vdd
);

    // ------------------------------------------------------------------
    // 5x7 font ROM (verified column-byte values, bit0 = top pixel row)
    // ------------------------------------------------------------------
    function [7:0] font_col;
        input [3:0] digit;
        input [2:0] col;      // 0-4
        reg [39:0] glyph;     // 5 columns packed MSB(col0)..LSB(col4)
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
                default: glyph = {8'h06,8'h49,8'h49,8'h29,8'h1E}; // 9
            endcase
            font_col = glyph >> (8 * (4 - col));
        end
    endfunction

    // ------------------------------------------------------------------
    // Layout: 5 digits, 5px glyph + 3px gap = 8px pitch, drawn on page 1
    // ------------------------------------------------------------------
    localparam X_START     = 20;
    localparam PITCH       = 8;
    localparam GLYPH_W     = 5;
    localparam RENDER_PAGE = 1;

    function [7:0] pixel_byte;
        input [8:0] page;   // 0-3
        input [7:0] col;    // 0-127
        input [3:0] dig4, dig3, dig2, dig1, dig0;
        reg [7:0] off;
        reg [3:0] idx;
        reg [2:0] sub;
        reg [3:0] dsel;
        begin
            pixel_byte = 8'h00;
            if (page == RENDER_PAGE && col >= X_START) begin
                off = col - X_START;
                idx = off / PITCH;
                sub = off % PITCH;
                if (idx < 5 && sub < GLYPH_W) begin
                    case (idx)
                        4'd0: dsel = dig4;
                        4'd1: dsel = dig3;
                        4'd2: dsel = dig2;
                        4'd3: dsel = dig1;
                        default: dsel = dig0;
                    endcase
                    pixel_byte = font_col(dsel, sub);
                end
            end
        end
    endfunction

    // ------------------------------------------------------------------
    // Init command ROM (all commands use D/C=0). Display-ON (0xAF) is
    // sent separately after VBAT has been enabled and allowed to settle.
    // ------------------------------------------------------------------
    localparam INIT_LEN = 24;
    reg [7:0] init_rom [0:INIT_LEN-1];
    initial begin
        init_rom[0]  = 8'hAE; // Display OFF
        init_rom[1]  = 8'hD5; init_rom[2]  = 8'h80; // Clock divide
        init_rom[3]  = 8'hA8; init_rom[4]  = 8'h1F; // Multiplex ratio = 31 (32 rows)
        init_rom[5]  = 8'hD3; init_rom[6]  = 8'h00; // Display offset = 0
        init_rom[7]  = 8'h40;                       // Display start line = 0
        init_rom[8]  = 8'h8D; init_rom[9]  = 8'h14; // Charge pump enable
        init_rom[10] = 8'h20; init_rom[11] = 8'h00; // Memory addr mode = horizontal
        init_rom[12] = 8'hA1;                       // Segment remap
        init_rom[13] = 8'hC8;                       // COM scan direction remapped
        init_rom[14] = 8'hDA; init_rom[15] = 8'h02; // COM pins config (128x32)
        init_rom[16] = 8'h81; init_rom[17] = 8'h8F; // Contrast
        init_rom[18] = 8'hD9; init_rom[19] = 8'hF1; // Pre-charge period
        init_rom[20] = 8'hDB; init_rom[21] = 8'h40; // VCOMH deselect level
        init_rom[22] = 8'hA4;                       // Entire display on (resume RAM)
        init_rom[23] = 8'hA6;                       // Normal (non-inverted) display
    end

    // Column/page address window, sent once after init (auto-wraps after
    // each full 512-byte pass, so it never needs to be resent).
    localparam WIN_LEN = 6;
    reg [7:0] win_rom [0:WIN_LEN-1];
    initial begin
        win_rom[0] = 8'h21; win_rom[1] = 8'h00; win_rom[2] = 8'h7F; // columns 0-127
        win_rom[3] = 8'h22; win_rom[4] = 8'h00; win_rom[5] = 8'h03; // pages 0-3
    end

    // ------------------------------------------------------------------
    // Low-level SPI byte engine: MSB-first, data set up while SCLK low,
    // sampled by the display on the SCLK rising edge.
    // ------------------------------------------------------------------
    reg [7:0]  tx_data;
    reg        tx_dc;
    reg        tx_start;
    reg        tx_busy;
    reg        tx_done;
    reg [2:0]  tx_bit;
    reg [7:0]  tx_shift;
    reg        tx_phase;      // 0 = setup (SCLK low), 1 = pulse (SCLK high)

    // Slow tick generator for the SPI bit engine
    localparam TICK_CNT_W = 32;
    reg [TICK_CNT_W-1:0] tick_cnt;
    reg tick;
    always @(posedge clk) begin
        if (reset) begin
            tick_cnt <= 0;
            tick     <= 0;
        end else if (tick_cnt == TICK_DIV - 1) begin
            tick_cnt <= 0;
            tick     <= 1;
        end else begin
            tick_cnt <= tick_cnt + 1;
            tick     <= 0;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            tx_busy   <= 1'b0;
            tx_done   <= 1'b0;
            oled_sclk <= 1'b0;
            oled_sdin <= 1'b0;
            tx_phase  <= 1'b0;
        end else begin
            tx_done <= 1'b0; // single-cycle pulse
            if (!tx_busy) begin
                // Accept a new byte the instant tx_start pulses - this
                // must NOT wait for 'tick', or a start pulse and the slow
                // tick strobe can permanently miss each other (livelock).
                if (tx_start) begin
                    tx_shift  <= tx_data;
                    oled_dc   <= tx_dc;
                    tx_bit    <= 3'd0;
                    tx_phase  <= 1'b0;
                    tx_busy   <= 1'b1;
                    oled_sclk <= 1'b0;
                end
            end else if (tick) begin
                // Once busy, the bit shifting itself is paced by 'tick'.
                if (tx_phase == 1'b0) begin
                    // setup phase: place MSB on SDIN, clock low
                    oled_sdin <= tx_shift[7];
                    oled_sclk <= 1'b0;
                    tx_phase  <= 1'b1;
                end else begin
                    // pulse phase: raise SCLK, display samples SDIN
                    oled_sclk <= 1'b1;
                    if (tx_bit == 3'd7) begin
                        tx_busy <= 1'b0;
                        tx_done <= 1'b1;
                    end else begin
                        tx_bit   <= tx_bit + 1'b1;
                        tx_shift <= tx_shift << 1;
                    end
                    tx_phase <= 1'b0;
                end
            end
        end
    end

    // ------------------------------------------------------------------
    // High-level sequencer FSM
    // ------------------------------------------------------------------
    localparam S_WAIT_A     = 0,  // settle before enabling VDD
               S_VDD_ON     = 1,
               S_WAIT_B     = 2,  // settle before reset pulse
               S_RES_LOW    = 3,
               S_RES_HIGH   = 4,
               S_WAIT_C     = 5,  // settle before sending commands
               S_INIT_CMD   = 6,  // stream init_rom[]
               S_VBAT_ON    = 7,
               S_WAIT_D     = 8,  // let OLED supply settle
               S_SEND_WIN   = 9,  // stream win_rom[] (once)
               S_DISP_ON    = 10, // send single 0xAF
               S_ARM_FRAME  = 11, // latch digits, start frame write
               S_SEND_FRAME = 12, // stream 512 pixel bytes
               S_IDLE       = 13;

    reg [4:0]  state;
    reg [31:0] wait_cnt;
    reg [4:0]  rom_idx;
    reg [8:0]  frame_idx;      // 0-511
    reg [3:0]  snap_d4, snap_d3, snap_d2, snap_d1, snap_d0;

    wire digits_changed = (d4 != snap_d4) || (d3 != snap_d3) || (d2 != snap_d2) ||
                          (d1 != snap_d1) || (d0 != snap_d0);

    always @(posedge clk) begin
        if (reset) begin
            state     <= S_WAIT_A;
            wait_cnt  <= 0;
            rom_idx   <= 0;
            frame_idx <= 0;
            oled_cs   <= 1'b1;
            oled_res  <= 1'b1;
            oled_vdd  <= 1'b1; // idle-high (supply OFF, active-low enable)
            oled_vbat <= 1'b1; // idle-high (supply OFF, active-low enable)
            oled_dc   <= 1'b0;
            tx_start  <= 1'b0;
            snap_d4 <= 4'hF; snap_d3 <= 4'hF; snap_d2 <= 4'hF; // force first draw
            snap_d1 <= 4'hF; snap_d0 <= 4'hF;
        end else begin
            tx_start <= 1'b0; // default: only pulse for one cycle

            case (state)
                S_WAIT_A: begin
                    if (wait_cnt == WAIT_SHORT-1) begin
                        wait_cnt <= 0;
                        state    <= S_VDD_ON;
                    end else if (tick) wait_cnt <= wait_cnt + 1;
                end

                S_VDD_ON: begin
                    oled_vdd <= 1'b0; // enable logic supply
                    state    <= S_WAIT_B;
                end

                S_WAIT_B: begin
                    if (wait_cnt == WAIT_SHORT-1) begin
                        wait_cnt <= 0;
                        state    <= S_RES_LOW;
                    end else if (tick) wait_cnt <= wait_cnt + 1;
                end

                S_RES_LOW: begin
                    oled_res <= 1'b0;
                    if (wait_cnt == RES_LOW_CYCLES-1) begin
                        wait_cnt <= 0;
                        state    <= S_RES_HIGH;
                    end else wait_cnt <= wait_cnt + 1; // every clk, not just tick
                end

                S_RES_HIGH: begin
                    oled_res <= 1'b1;
                    state    <= S_WAIT_C;
                end

                S_WAIT_C: begin
                    if (wait_cnt == WAIT_SHORT-1) begin
                        wait_cnt <= 0;
                        rom_idx  <= 0;
                        state    <= S_INIT_CMD;
                    end else if (tick) wait_cnt <= wait_cnt + 1;
                end

                S_INIT_CMD: begin
                    oled_cs <= 1'b0;
                    if (!tx_busy && !tx_start && !tx_done) begin
                        tx_data  <= init_rom[rom_idx];
                        tx_dc    <= 1'b0;
                        tx_start <= 1'b1;
                    end
                    if (tx_done) begin
                        if (rom_idx == INIT_LEN-1) begin
                            state <= S_VBAT_ON;
                        end else begin
                            rom_idx <= rom_idx + 1;
                        end
                    end
                end

                S_VBAT_ON: begin
                    oled_vbat <= 1'b0; // enable OLED panel supply
                    state     <= S_WAIT_D;
                end

                S_WAIT_D: begin
                    if (wait_cnt == WAIT_VBAT-1) begin
                        wait_cnt <= 0;
                        rom_idx  <= 0;
                        state    <= S_SEND_WIN;
                    end else if (tick) wait_cnt <= wait_cnt + 1;
                end

                S_SEND_WIN: begin
                    if (!tx_busy && !tx_start && !tx_done) begin
                        tx_data  <= win_rom[rom_idx];
                        tx_dc    <= 1'b0;
                        tx_start <= 1'b1;
                    end
                    if (tx_done) begin
                        if (rom_idx == WIN_LEN-1) begin
                            state <= S_DISP_ON;
                        end else begin
                            rom_idx <= rom_idx + 1;
                        end
                    end
                end

                S_DISP_ON: begin
                    if (!tx_busy && !tx_start && !tx_done) begin
                        tx_data  <= 8'hAF;
                        tx_dc    <= 1'b0;
                        tx_start <= 1'b1;
                    end
                    if (tx_done) state <= S_ARM_FRAME;
                end

                S_ARM_FRAME: begin
                    snap_d4 <= d4; snap_d3 <= d3; snap_d2 <= d2;
                    snap_d1 <= d1; snap_d0 <= d0;
                    frame_idx <= 0;
                    state <= S_SEND_FRAME;
                end

                S_SEND_FRAME: begin
                    if (!tx_busy && !tx_start && !tx_done) begin
                        tx_data <= pixel_byte(frame_idx[8:7], frame_idx[6:0],
                                               snap_d4, snap_d3, snap_d2, snap_d1, snap_d0);
                        tx_dc    <= 1'b1;
                        tx_start <= 1'b1;
                    end
                    if (tx_done) begin
                        if (frame_idx == 9'd511) begin
                            state <= S_IDLE;
                        end else begin
                            frame_idx <= frame_idx + 1;
                        end
                    end
                end

                S_IDLE: begin
                    // SSD1306 holds the image on its own; only redraw
                    // when the switches produce a new value.
                    if (digits_changed) state <= S_ARM_FRAME;
                end

                default: state <= S_WAIT_A;
            endcase
        end
    end

endmodule

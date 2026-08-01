// ============================================================
// Basys3 -> Pmod OLED RGB (SSD1331) : show A+B in hex
// A = SW[3:0], B = SW[7:4], S = A + B (0x00..0x1E)
// Clock: 100 MHz
// SPI: Mode 0, ~10 MHz
// ============================================================

module top_basys3_oled_adder (
    input  wire        clk_100mhz,
    input  wire [7:0]  sw,
    output wire        oled_cs_n,
    output wire        oled_sclk,
    output wire        oled_mosi,
    output wire        oled_dc,     // 1=data, 0=cmd
    output wire        oled_res_n   // active low reset
);

    // Split switches into 4-bit operands
    wire [3:0] A = sw[3:0];
    wire [3:0] B = sw[7:4];
    wire [4:0] S = A + B;

    // Generate a slower SPI clock enable for ~10 MHz from 100 MHz
    // We'll clock the SPI shifter at clk_100mhz but gate edges by ce_spi.
    localparam integer DIV = 5; // 100MHz/(2*DIV) = 10 MHz
    reg [2:0] divcnt = 0;
    reg       ce_spi = 0;
    always @(posedge clk_100mhz) begin
        if (divcnt == (DIV-1)) begin
            divcnt <= 0;
            ce_spi <= 1;
        end else begin
            divcnt <= divcnt + 1;
            ce_spi <= 0;
        end
    end

    // SPI master (byte-oriented, CPOL=0, CPHA=0)
    wire       spi_busy;
    reg        spi_start = 0;
    reg  [7:0] spi_tx = 8'h00;
    reg        spi_dc = 0; // pass-thru to oled_dc
    wire       spi_sclk, spi_mosi, spi_cs_n;

    spi_byte_master #(.CPOL(0), .CPHA(0)) u_spi (
        .clk        (clk_100mhz),
        .ce         (ce_spi),
        .start      (spi_start),
        .tx_byte    (spi_tx),
        .busy       (spi_busy),
        .sclk       (spi_sclk),
        .mosi       (spi_mosi),
        .cs_n       (spi_cs_n)
    );

    assign oled_sclk = spi_sclk;
    assign oled_mosi = spi_mosi;
    assign oled_cs_n = spi_cs_n;
    assign oled_dc   = spi_dc;

    // OLED controller FSM (SSD1331): reset, init, clear, draw
    reg [23:0] reset_cnt = 0;
    reg        res_n = 0;
    assign oled_res_n = res_n;

    // Simple state machine
    localparam S_RSTL   = 0,
               S_RSTH   = 1,
               S_INIT   = 2,
               S_CLEAR  = 3,
               S_DRAW   = 4,
               S_IDLE   = 5,
               S_UPDATE = 6;

    reg [2:0] state = S_RSTL;

    // Init sequence for SSD1331 (common working set)
    // If your panel needs tweaks (color remap, contrast), we can adjust.
    reg [7:0] init_rom [0:63];
    integer init_len = 0;
    initial begin
        // Display off
        init_rom[0]  = 8'hAE;
        // Set remap & color depth: 65k color, RGB, COM split, etc.
        init_rom[1]  = 8'hA0; init_rom[2] = 8'h72;
        // Set display start line
        init_rom[3]  = 8'hA1; init_rom[4] = 8'h00;
        // Set display offset
        init_rom[5]  = 8'hA2; init_rom[6] = 8'h00;
        // Normal display (not inverted)
        init_rom[7]  = 8'hA6;
        // Set multiplex ratio (height-1 = 63)
        init_rom[8]  = 8'hA8; init_rom[9] = 8'h3F;
        // Set master configuration (external VCC)
        init_rom[10] = 8'hAD; init_rom[11]= 8'h8E;
        // Power/contrast settings (reasonable defaults)
        init_rom[12] = 8'h81; init_rom[13]= 8'h91; // contrast for A
        init_rom[14] = 8'h82; init_rom[15]= 8'h50; // contrast for B
        init_rom[16] = 8'h83; init_rom[17]= 8'h7D; // contrast for C
        // Phase length
        init_rom[18] = 8'hB1; init_rom[19]= 8'hF1;
        // Display clock div
        init_rom[20] = 8'hB3; init_rom[21]= 8'hF0;
        // Precharge levels
        init_rom[22] = 8'h8A; init_rom[23]= 8'h64;
        init_rom[24] = 8'h8B; init_rom[25]= 8'h78;
        init_rom[26] = 8'h8C; init_rom[27]= 8'h64;
        // Precharge speed (color)
        init_rom[28] = 8'hBB; init_rom[29]= 8'h3A;
        // VCOMH
        init_rom[30] = 8'hBE; init_rom[31]= 8'h3E;
        // Display on
        init_rom[32] = 8'hAF;
        init_len = 33;
    end

    // Clear screen helper: set window full, then write black pixels
    reg [7:0] clear_stage = 0;
    reg [15:0] clear_px_cnt = 0; // 96*64 = 6144 pixels
    localparam integer WIDTH = 96, HEIGHT = 64, PIXELS = 6144;

   // Small hex font (8x8, MSB left). 16 chars: 0..F
reg [7:0] font8x8 [0:16*8-1];
initial begin
    // 0
    font8x8[0]=8'b00111100; font8x8[1]=8'b01100110; font8x8[2]=8'b01101110; font8x8[3]=8'b01110110;
    font8x8[4]=8'b01100110; font8x8[5]=8'b01100110; font8x8[6]=8'b00111100; font8x8[7]=8'b00000000;
    // 1
    font8x8[8]=8'b00011000; font8x8[9]=8'b00111000; font8x8[10]=8'b00011000; font8x8[11]=8'b00011000;
    font8x8[12]=8'b00011000; font8x8[13]=8'b00011000; font8x8[14]=8'b00111100; font8x8[15]=8'b00000000;
    // 2
    font8x8[16]=8'b00111100; font8x8[17]=8'b01100110; font8x8[18]=8'b00000110; font8x8[19]=8'b00001100;
    font8x8[20]=8'b00110000; font8x8[21]=8'b01100000; font8x8[22]=8'b01111110; font8x8[23]=8'b00000000;
    // 3
    font8x8[24]=8'b00111100; font8x8[25]=8'b01100110; font8x8[26]=8'b00000110; font8x8[27]=8'b00011100;
    font8x8[28]=8'b00000110; font8x8[29]=8'b01100110; font8x8[30]=8'b00111100; font8x8[31]=8'b00000000;
    // 4
    font8x8[32]=8'b00001100; font8x8[33]=8'b00011100; font8x8[34]=8'b00101100; font8x8[35]=8'b01001100;
    font8x8[36]=8'b01111110; font8x8[37]=8'b00001100; font8x8[38]=8'b00011110; font8x8[39]=8'b00000000;
    // 5
    font8x8[40]=8'b01111110; font8x8[41]=8'b01100000; font8x8[42]=8'b01111100; font8x8[43]=8'b00000110;
    font8x8[44]=8'b00000110; font8x8[45]=8'b01100110; font8x8[46]=8'b00111100; font8x8[47]=8'b00000000;
    // 6
    font8x8[48]=8'b00111100; font8x8[49]=8'b01100110; font8x8[50]=8'b01100000; font8x8[51]=8'b01111100;
    font8x8[52]=8'b01100110; font8x8[53]=8'b01100110; font8x8[54]=8'b00111100; font8x8[55]=8'b00000000;
    // 7
    font8x8[56]=8'b01111110; font8x8[57]=8'b00000110; font8x8[58]=8'b00001100; font8x8[59]=8'b00011000;
    font8x8[60]=8'b00110000; font8x8[61]=8'b00110000; font8x8[62]=8'b00110000; font8x8[63]=8'b00000000;
    // 8
    font8x8[64]=8'b00111100; font8x8[65]=8'b01100110; font8x8[66]=8'b01100110; font8x8[67]=8'b00111100;
    font8x8[68]=8'b01100110; font8x8[69]=8'b01100110; font8x8[70]=8'b00111100; font8x8[71]=8'b00000000;
    // 9
    font8x8[72]=8'b00111100; font8x8[73]=8'b01100110; font8x8[74]=8'b01100110; font8x8[75]=8'b00111110;
    font8x8[76]=8'b00000110; font8x8[77]=8'b01100110; font8x8[78]=8'b00111100; font8x8[79]=8'b00000000;
    // A
    font8x8[80]=8'b00111100; font8x8[81]=8'b01100110; font8x8[82]=8'b01100110; font8x8[83]=8'b01111110;
    font8x8[84]=8'b01100110; font8x8[85]=8'b01100110; font8x8[86]=8'b01100110; font8x8[87]=8'b00000000;
    // b
    font8x8[88]=8'b01100000; font8x8[89]=8'b01100000; font8x8[90]=8'b01111100; font8x8[91]=8'b01100110;
    font8x8[92]=8'b01100110; font8x8[93]=8'b01100110; font8x8[94]=8'b01111100; font8x8[95]=8'b00000000;
    // C
    font8x8[96]=8'b00111100; font8x8[97]=8'b01100110; font8x8[98]=8'b01100000; font8x8[99]=8'b01100000;
    font8x8[100]=8'b01100000; font8x8[101]=8'b01100110; font8x8[102]=8'b00111100; font8x8[103]=8'b00000000;
    // d
    font8x8[104]=8'b00000110; font8x8[105]=8'b00000110; font8x8[106]=8'b00111110; font8x8[107]=8'b01100110;
    font8x8[108]=8'b01100110; font8x8[109]=8'b01100110; font8x8[110]=8'b00111110; font8x8[111]=8'b00000000;
    // E
    font8x8[112]=8'b01111110; font8x8[113]=8'b01100000; font8x8[114]=8'b01111100; font8x8[115]=8'b01100000;
    font8x8[116]=8'b01100000; font8x8[117]=8'b01100000; font8x8[118]=8'b01111110; font8x8[119]=8'b00000000;
    // F
    font8x8[120]=8'b01111110; font8x8[121]=8'b01100000; font8x8[122]=8'b01111100; font8x8[123]=8'b01100000;
    font8x8[124]=8'b01100000; font8x8[125]=8'b01100000; font8x8[126]=8'b01100000; font8x8[127]=8'b00000000;
end

    // Helper: hex nibble to font index 0..15
    function [3:0] hex_index(input [3:0] nib);
        hex_index = nib[3:0];
    endfunction

    // Drawing engine signals
    reg [7:0]  cmdq [0:15]; // small queue for commands/params
    integer    qlen = 0, qptr = 0;
    reg        sending = 0;

    // Pack a short sequence to send (cmd then params)
    task start_send;
    begin
        qptr <= 0;
        sending <= 1;
        spi_start <= 0;
    end
    endtask

    // Load a byte to SPI (with dc select)
    task send_byte(input [7:0] b, input is_data);
    begin
        if (!spi_busy && !spi_start) begin
            spi_tx   <= b;
            spi_dc   <= is_data;
            spi_start<= 1'b1;
        end
    end
    endtask

    // One-shot start pulse handling
    always @(posedge clk_100mhz) begin
        if (spi_start && ce_spi) spi_start <= 1'b0;
    end

    // FSM
    integer i;
    reg [7:0] init_idx = 0;
    reg [7:0] cx = 30; // left character x
    reg [7:0] cy = 28; // top character y
    reg [7:0] hi_nib, lo_nib;
   reg [3:0] draw_phase = 0;
    reg [6:0] px = 0, py = 0; // within char 8x8
    reg [7:0] font_row;
    reg [15:0] pixels_to_go;
    localparam [15:0] BLACK = 16'h0000;
    localparam [15:0] WHITE = 16'hFFFF;

    always @(posedge clk_100mhz) begin
        case (state)
            S_RSTL: begin
                res_n <= 0;
                reset_cnt <= reset_cnt + 1;
                
if (reset_cnt == 24'd500000) begin // ~5 ms at 100 MHz
                    reset_cnt <= 0;
                    state <= S_RSTH;
                end
            end
            S_RSTH: begin
                res_n <= 1;
                reset_cnt <= reset_cnt + 1;
                if (reset_cnt == 24'd5_000_00) begin
                    reset_cnt <= 0;
                    state <= S_INIT;
                    init_idx <= 0;
                end
            end
            S_INIT: begin
                // Send init bytes as commands
                if (!spi_busy && !spi_start) begin
                    if (init_idx < init_len) begin
                        spi_dc   <= 1'b0; // command
                        spi_tx   <= init_rom[init_idx];
                        spi_start<= 1'b1;
                        init_idx <= init_idx + 1;
                    end else begin
                        state <= S_CLEAR;
                        clear_stage <= 0;
                        clear_px_cnt <= 0;
                    end
                end
            end
            S_CLEAR: begin
                // Set column addr (0..95), row addr (0..63), then write BLACK pixels
                if (!spi_busy && !spi_start) begin
                    if (clear_stage == 0) begin
                        // Column address
                        spi_dc<=0; spi_tx<=8'h15; spi_start<=1; clear_stage<=1;
                    end else if (clear_stage == 1) begin
                        spi_dc<=0; spi_tx<=8'h00; spi_start<=1; clear_stage<=2;
                    end else if (clear_stage == 2) begin
                        spi_dc<=0; spi_tx<=8'h5F; spi_start<=1; clear_stage<=3; // 0x5F = 95
                    end else if (clear_stage == 3) begin
                        // Row address
                        spi_dc<=0; spi_tx<=8'h75; spi_start<=1; clear_stage<=4;
                    end else if (clear_stage == 4) begin
                        spi_dc<=0; spi_tx<=8'h00; spi_start<=1; clear_stage<=5;
                    end else if (clear_stage == 5) begin
                        spi_dc<=0; spi_tx<=8'h3F; spi_start<=1; clear_stage<=6; // 0x3F = 63
                        pixels_to_go <= PIXELS;
                    end else if (clear_stage == 6) begin
                        // Stream pixel data: 16bpp 5:6:5
                        if (pixels_to_go != 0) begin
                            spi_dc<=1; spi_tx<=BLACK[15:8]; spi_start<=1;
                            clear_stage<=7;
                        end else begin
                            state <= S_DRAW;
                            draw_phase <= 0;
                        end
                    end else if (clear_stage == 7) begin
                        spi_dc<=1; spi_tx<=BLACK[7:0]; spi_start<=1;
                        clear_stage<=6;
                        pixels_to_go <= pixels_to_go - 1;
                    end
                end
            end

                       S_DRAW: begin
                // Compute hex chars for sum
                hi_nib <= {3'b000, S[4]}; // 0 or 1
                lo_nib <= {1'b0, S[3:0]}; // 0..15 (still in 0..14)
                px <= 0; py <= 0; draw_phase <= 0;
                state <= S_UPDATE;
            end

            S_UPDATE: begin
                // Draw two 8x8 chars at (cx,cy) and (cx+10,cy)
                // We set a window for each char and stream 64 pixels (WHITE for 1-bits, BLACK for 0)
                if (!spi_busy && !spi_start) begin
                    case (draw_phase)
                        // Left char window
                        4'd0:  begin spi_dc <= 1'b0; spi_tx <= 8'h15;       spi_start <= 1'b1; draw_phase <= 4'd1;  end
                        4'd1:  begin spi_dc <= 1'b0; spi_tx <= cx;          spi_start <= 1'b1; draw_phase <= 4'd2;  end
                        4'd2:  begin spi_dc <= 1'b0; spi_tx <= cx + 8'd7;   spi_start <= 1'b1; draw_phase <= 4'd3;  end
                        4'd3:  begin spi_dc <= 1'b0; spi_tx <= 8'h75;       spi_start <= 1'b1; draw_phase <= 4'd4;  end
                        4'd4:  begin spi_dc <= 1'b0; spi_tx <= cy;          spi_start <= 1'b1; draw_phase <= 4'd5;  end
                        4'd5:  begin spi_dc <= 1'b0; spi_tx <= cy + 8'd7;   spi_start <= 1'b1; draw_phase <= 4'd6; py <= 0; px <= 0; end

                        // Stream 8x8 pixels for left char (hi_nib)
                        4'd6: begin
                            font_row <= font8x8[( {hex_index(hi_nib), 3'b000} + py )];
                            if (font_row[7 - px[2:0]]) begin
                                spi_dc <= 1'b1; spi_tx <= WHITE[15:8]; spi_start <= 1'b1; draw_phase <= 4'd7;
                            end else begin
                                spi_dc <= 1'b1; spi_tx <= BLACK[15:8]; spi_start <= 1'b1; draw_phase <= 4'd7;
                            end
                        end
                        4'd7: begin
                            if (font_row[7 - px[2:0]]) begin
                                spi_dc <= 1'b1; spi_tx <= WHITE[7:0]; spi_start <= 1'b1;
                            end else begin
                                spi_dc <= 1'b1; spi_tx <= BLACK[7:0]; spi_start <= 1'b1;
                            end
                            // advance px/py
                            if (px == 7) begin
                                px <= 0;
                                if (py == 7) begin
                                    py <= 0; draw_phase <= 4'd8;
                                end else begin
                                    py <= py + 1; draw_phase <= 4'd6;
                                end
                            end else begin
                                px <= px + 1; draw_phase <= 4'd6;
                            end
                        end

                        // Right char window
                        4'd8:  begin spi_dc <= 1'b0; spi_tx <= 8'h15;        spi_start <= 1'b1; draw_phase <= 4'd9;  end
                        4'd9:  begin spi_dc <= 1'b0; spi_tx <= cx + 8'd10;   spi_start <= 1'b1; draw_phase <= 4'd10; end
                        4'd10: begin spi_dc <= 1'b0; spi_tx <= cx + 8'd17;   spi_start <= 1'b1; draw_phase <= 4'd11; end
                        4'd11: begin spi_dc <= 1'b0; spi_tx <= 8'h75;        spi_start <= 1'b1; draw_phase <= 4'd12; end
                        4'd12: begin spi_dc <= 1'b0; spi_tx <= cy;           spi_start <= 1'b1; draw_phase <= 4'd13; end
                        4'd13: begin spi_dc <= 1'b0; spi_tx <= cy + 8'd7;    spi_start <= 1'b1; draw_phase <= 4'd14; py <= 0; px <= 0; end
                        4'd14: begin
                            font_row <= font8x8[( {hex_index(lo_nib), 3'b000} + py )];
                            if (font_row[7 - px[2:0]]) begin
                                spi_dc <= 1'b1; spi_tx <= WHITE[15:8]; spi_start <= 1'b1; draw_phase <= 4'd15;
                            end else begin
                                spi_dc <= 1'b1; spi_tx <= BLACK[15:8]; spi_start <= 1'b1; draw_phase <= 4'd15;
                            end
                        end
                        4'd15: begin
                            if (font_row[7 - px[2:0]]) begin
                                spi_dc <= 1'b1; spi_tx <= WHITE[7:0]; spi_start <= 1'b1;
                            end else begin
                                spi_dc <= 1'b1; spi_tx <= BLACK[7:0]; spi_start <= 1'b1;
                            end
                            if (px == 7) begin
                                px <= 0;
                                if (py == 7) begin
                                    py <= 0; state <= S_IDLE;
                                end else begin
                                    py <= py + 1; draw_phase <= 4'd14;
                                end
                            end else begin
                                px <= px + 1; draw_phase <= 4'd14;
                            end
                        end

                        default: draw_phase <= 4'd0;
                    endcase
                end
            end

            S_IDLE: begin
                // Wait for switches to change; redraw if needed
                state <= S_DRAW;
            end

            default: state <= S_RSTL;
        endcase
    end // always
endmodule
// Created by Pradeep with the help of AI

// bin2bcd.v
// Converts a 16-bit unsigned binary value into 5 BCD digits (0-65535)
// using the classic "double dabble" (shift-and-add-3) algorithm.
// Purely combinational - synthesizes to a small adder network.

module bin2bcd (
    input  wire [15:0] bin_in,
    output wire [3:0]  d4,  // ten-thousands
    output wire [3:0]  d3,  // thousands
    output wire [3:0]  d2,  // hundreds
    output wire [3:0]  d1,  // tens
    output wire [3:0]  d0   // units
);

    function [35:0] double_dabble;
        input [15:0] binary;
        integer i;
        reg [35:0] r; // [35:16] = 5 BCD nibbles, [15:0] = binary being shifted in
        begin
            r = {20'd0, binary};
            for (i = 0; i < 16; i = i + 1) begin
                if (r[19:16] >= 5) r[19:16] = r[19:16] + 4'd3;
                if (r[23:20] >= 5) r[23:20] = r[23:20] + 4'd3;
                if (r[27:24] >= 5) r[27:24] = r[27:24] + 4'd3;
                if (r[31:28] >= 5) r[31:28] = r[31:28] + 4'd3;
                if (r[35:32] >= 5) r[35:32] = r[35:32] + 4'd3;
                r = r << 1;
            end
            double_dabble = r;
        end
    endfunction

    wire [35:0] result = double_dabble(bin_in);

    assign d0 = result[19:16];
    assign d1 = result[23:20];
    assign d2 = result[27:24];
    assign d3 = result[31:28];
    assign d4 = result[35:32];

endmodule

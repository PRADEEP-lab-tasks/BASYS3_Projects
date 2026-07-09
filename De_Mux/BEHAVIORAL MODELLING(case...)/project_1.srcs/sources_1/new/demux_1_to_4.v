`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2023 11:13:45 AM
// Design Name: 
// Module Name: demux_1_to_4
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


module demux_1_to_4(input [3:0] din, input [1:0] sel, output reg y0, y1, y2, y3);
    always @ (din or sel)
        case(sel)
            2'b00: begin y0 = din[0]; y1 = 1'b0; y2 = 1'b0; y3 = 1'b0; end
            2'b01: begin y0 = 1'b0; y1 = din[1]; y2 = 1'b0; y3 = 1'b0; end
            2'b10: begin y0 = 1'b0; y1 = 1'b0; y2 = din[2]; y3 = 1'b0; end
            2'b11: begin y0 = 1'b0; y1 = 1'b0; y2 = 1'b0; y3 = din[3]; end
        endcase
endmodule

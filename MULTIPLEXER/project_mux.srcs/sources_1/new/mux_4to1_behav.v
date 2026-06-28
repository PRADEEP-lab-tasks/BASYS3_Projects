`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: PRADEEP
// 
// Create Date: 05/07/2024 07:46:00 PM
// Design Name: 
// Module Name: mux_4to1_behav
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_4to1_behav(out, a, b, c, d, sel);
    output reg out;
    input a, b, c, d;
    input [1:0] sel;

    always @(*)
        case (sel)
            2'b00: out = a;
            2'b01: out = b;
            2'b10: out = c;
            2'b11: out = d;
        endcase
endmodule


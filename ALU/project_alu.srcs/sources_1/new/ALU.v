`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2024 05:26:23 PM
// Design Name: 
// Module Name: ALU
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

module ALU (
    input [7:0] A, B, // 8-bit inputs
    input [1:0] ALU_Sel, // 2-bit control input
    output reg [7:0] ALU_Out // 8-bit output
);
    always @(*) begin
        case (ALU_Sel)
            2'b00: ALU_Out = A + B; // Addition
            2'b01: ALU_Out = A - B; // Subtraction
            2'b10: ALU_Out = A & B; // AND
            2'b11: ALU_Out = A | B; // OR
        endcase
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: PRADEEP
// 
// Create Date: 05/07/2024 07:12:01 PM
// Design Name: 
// Module Name: carry_lookahead_adder
// Project Name: CLA_adder
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

module carry_lookahead_adder(input [3:0] A, B, output [3:0] SUM, output CARRY);
    wire [3:0] G, P, C;
    
    // Generate and Propagate signals
    assign G = A & B;
    assign P = A ^ B;
    
    // Carry signals
    assign C[0] = G[0];
    assign C[1] = G[1] | (P[1] & G[0]);
    assign C[2] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]);
    assign C[3] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
    
    // Sum signals
    assign SUM = P ^ C;
    
    // Carry out
    assign CARRY = C[3];
endmodule

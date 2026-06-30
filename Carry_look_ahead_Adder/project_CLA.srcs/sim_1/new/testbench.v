`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2024 07:12:19 PM
// Design Name: 
// Module Name: testbench
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


module testbench;
    reg [3:0] A, B;
    wire [3:0] SUM;
    wire CARRY;

    // Instantiate the carry_lookahead_adder
    carry_lookahead_adder cla(A, B, SUM, CARRY);

    initial begin
        // Initialize inputs
        A = 4'b0000;
        B = 4'b0000;

        // Apply test vectors
        #10 A = 4'b0101; B = 4'b0011;  // Test case 1: 5 + 3
        #10 A = 4'b1111; B = 4'b0001;  // Test case 2: 15 + 1
        #10 A = 4'b1010; B = 4'b1010;  // Test case 3: 10 + 10
        #10 A = 4'b0110; B = 4'b0111;  // Test case 4: 6 + 7
    end

    initial begin
        $monitor($time, " A=%b B=%b SUM=%b CARRY=%b", A, B, SUM, CARRY);
    end
endmodule

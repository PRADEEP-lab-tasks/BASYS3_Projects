`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2024 08:04:43 PM
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
    reg clk;
    reg reset;
    reg shift_in;
    wire [3:0] shift_out;

    // Instantiate the shift register
    shift_register u1 (
        .clk(clk),
        .reset(reset),
        .shift_in(shift_in),
        .shift_out(shift_out)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        shift_in = 0;

        #10 reset = 0;
        #10 shift_in = 1;
        #10 shift_in = 0;
        #10 shift_in = 1;
        #10 shift_in = 1;
        #10 shift_in = 0;

        // End simulation
        #10 $finish;
    end
endmodule

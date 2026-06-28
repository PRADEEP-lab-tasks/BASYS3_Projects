`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: PRADEEP
// Create Date: 05/07/2024 07:47:17 PM
// Design Name: 
// Module Name: tb_mux_4to1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Dependencies: 

// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_mux_4to1;
    reg a, b, c, d;
    wire out;
    reg [1:0] sel;

    mux_4to1_behav uut (
        .out(out),
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel)
    );

        $dumpfile("dump.vcd");
    $dumpvars(0, tb_mux);
    
    initial begin
        // Initialize inputs
        a = 1'b0;
        b = 1'b1;
        c = 1'b0;
        d = 1'b1;
        sel = 2'b00;

        // Apply different select values
        #10 sel = 2'b01;
        #10 sel = 2'b10;
        #10 sel = 2'b11;

        // Add more test cases as needed

        $display("Output: %b", out);
        $finish;
    end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2023 02:56:18 PM
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


module testbench();
    reg [3:0] din;
    reg [1:0] sel;
    wire y0, y1, y2, y3;
    demux_1_to_4 dut(din, sel, y0, y1, y2, y3);
    initial begin
        din = 4'b0000;
        sel = 2'b00;
        #10 din = 4'b0001;
        #10 sel = 2'b01;
        #10 din = 4'b0010;
        #10 sel = 2'b10;
        #10 din = 4'b1000;
        #10 sel = 2'b11;
        #10 $finish;
    end
endmodule

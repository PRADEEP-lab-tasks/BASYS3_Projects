`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2024 19:16:13
// Design Name: 
// Module Name: wrappper_out
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


module wrappper_out(input clk, input rst, input en, input [3:0] load, output [3:0] count);
oneHz_gen clk_div(.clk_100MHz(clk), .reset(rst), .clk_1Hz(clk_1Hz));
counter counter_tst( .clk(clk_1Hz), .rst(rst), .en(en), .load(load) , .count(count));
endmodule
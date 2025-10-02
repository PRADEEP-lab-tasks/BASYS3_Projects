`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/17/2024 04:43:05 PM
// Design Name: 
// Module Name: sim
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


module sim ();
wire [3:0] count;
reg clk, rst, en;
reg [3:0] load;

counter tst( .clk(clk), .rst(rst), .en(en), .load(load), .count(count) );
always #5 clk=~clk;
initial
begin
    clk = 1'b0;
    rst = 1'b1;
    en = 1'b0;
   #10 rst = 1'b0;
   #20 en =1'b1 ; load =7;
   #10 en = 0;
   #100 rst = 1'b1; en = 0;
   #20 rst = 1'b0;
end
endmodule


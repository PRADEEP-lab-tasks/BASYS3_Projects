`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2024 08:03:58 PM
// Design Name: 
// Module Name: shift_register
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


module shift_register (
    input wire clk,
    input wire reset,
    input wire shift_in,
    output wire [3:0] shift_out
);

    reg [3:0] register;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            register <= 4'b0000;
        end else begin
            register <= {register[2:0], shift_in};
        end
    end

    assign shift_out = register;
endmodule


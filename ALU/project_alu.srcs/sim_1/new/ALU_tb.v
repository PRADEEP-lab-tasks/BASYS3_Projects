`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2024 05:26:47 PM
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb;
    reg [7:0] A, B;
    reg [1:0] ALU_Sel;
    wire [7:0] ALU_Out;

    // Instantiate the ALU
    ALU u1 (
        .A(A),
        .B(B),
        .ALU_Sel(ALU_Sel),
        .ALU_Out(ALU_Out)
    );

    initial begin
        // Test Addition
      //  A = 8'b00001111; B = 8'b00000001; ALU_Sel = 2'b00;
     //   #10;
        
        // Test Subtraction
        A = 8'b00001111; B = 8'b00000001; ALU_Sel = 2'b01;
        #10;
        
        // Test AND
      //  A = 8'b00001111; B = 8'b00000001; ALU_Sel = 2'b10;
      //  #10;
        
        // Test OR
      //  A = 8'b00000001; B = 8'b00000001; ALU_Sel = 2'b11;
      //  #10;
    end

    initial begin
        $monitor("At time %d, A = %b, B = %b, ALU_Sel = %b, ALU_Out = %b",
                 $time, A, B, ALU_Sel, ALU_Out);
    end
endmodule

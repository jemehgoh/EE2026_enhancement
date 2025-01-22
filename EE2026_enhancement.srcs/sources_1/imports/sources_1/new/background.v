`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2024 21:45:56
// Design Name: 
// Module Name: background
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


module background(
    input clk25M,
    input [6:0] x,
    output reg [15:0] pixel_data
    );
    
    always@(posedge clk25M)
    begin
        if(((x/6)%2) == 0)
            pixel_data <= 16'b00000_100001_00110;
        else
            pixel_data <= 16'b11111_000000_01000;
    end
endmodule

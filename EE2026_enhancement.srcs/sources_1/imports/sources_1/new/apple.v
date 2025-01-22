`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2024 17:39:52
// Design Name: 
// Module Name: apple
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


module apple(
    input clk25M, green,
    input [6:0] x, centreX,
    input [5:0] y, centreY,
    output reg pixInRange,
    output reg [15:0] pixel_data
    );
    
    always@(posedge clk25M)
    begin
        if ((x >= centreX - 1 && x <= centreX + 1 && (y == centreY - 3 || y == centreY + 3))||
            ((x == centreX - 3 || x == centreX + 3) && y >= centreY - 1 && y <= centreY + 1)||
            ((x == centreX + 2 || x == centreX - 2) && (y == centreY + 2 || y == centreY - 2))||
            (x == centreX && y == centreY - 2))
        begin
            pixInRange <= 1;
            pixel_data <= 16'b10001_010110_00000;
        end
        else if ((x == centreX && y == centreY + 1)||
                 (x == centreX + 1 && y == centreY))
        begin
            pixInRange <= 1;
            pixel_data <= 16'b11111_111110_01110;
        end
        else if ((x >= centreX - 1 && x <= centreX + 1 && (y == centreY - 2 || y == centreY + 2))||
                 (x >= centreX - 2 && x <= centreX + 2 && y >= centreY - 1 && y <= centreY + 1))
        begin
                pixInRange <= 1;
                pixel_data <= (green) ? 16'b00100_111111_00000 : 16'b11111_000000_00100;
        end
        else
            pixInRange <= 0;
    end
    
endmodule

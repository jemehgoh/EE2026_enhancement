`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2024 21:01:40
// Design Name: 
// Module Name: bigApple
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


module bigApple(
    input clk25M, green,
    input [6:0] x, centreX,
    input [5:0] y, centreY,
    output reg pixInRange,
    output reg [15:0] pixel_data
    );
    
    wire [31:0] radius2;
    assign radius2 = (x > centreX) ?
                     (y > centreY) ? (x - centreX)*(x - centreX) + (y - centreY)*(y - centreY) :
                                     (x - centreX)*(x - centreX) + (centreY - y)*(centreY - y) :
                     (y > centreY) ? (centreX - x)*(centreX - x) + (y - centreY)*(y - centreY) :
                                     (centreX - x)*(centreX - x) + (centreY - y)*(centreY - y);
    
    always@(posedge clk25M)
    begin
        if ((radius2 <= 90 && radius2 >= 65)||
            (x >= centreX - 1 && x <= centreX + 1 && y >= centreY - 8 && y <= centreY - 6))
        begin
            pixInRange <= 1;
            pixel_data <= 16'b10001_010110_00000;
        end
        else if ((x >= centreX + 1 && x <= centreX + 2 && y == centreY + 5)||
                 (x >= centreX + 2 && x <= centreX + 3 && y == centreY + 4)||
                 (x >= centreX + 3 && x <= centreX + 4 && y == centreY + 3)||
                 (x >= centreX + 4 && x <= centreX + 5 && y == centreY + 2)||
                 (x == centreX + 5 && y >= centreY && y <= centreY + 1)||
                 (x == centreX + 6 && y >= centreY - 1 && y <= centreY))
        begin
            pixInRange <= 1;
            pixel_data <= 16'b11111_111110_01110;
        end
        else if (radius2 <= 64)
        begin
                pixInRange <= 1;
                pixel_data <= (green) ? 16'b00100_111111_00000 : 16'b11111_000000_00100;
        end
        else
            pixInRange <= 0;
    end
endmodule

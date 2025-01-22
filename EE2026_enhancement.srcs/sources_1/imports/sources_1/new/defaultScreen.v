`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2024 16:20:40
// Design Name: 
// Module Name: defaultScreen
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


module defaultScreen(
    input clk25M,
    input [6:0] x_raw,
    input [5:0] y_raw,
    output reg [15:0] pixel_data
    );
    
    wire [6:0] x;
    wire [5:0] y;
    
    assign x = 95 - x_raw;
    assign y = 63 - y_raw;
    
    // From Highest Layer
    wire pixInFgba; wire [15:0] fgba_data;
    foreground1 fgBigApple(clk25M, x, y, pixInFgba, fgba_data);
    
    wire pixInFga; wire [15:0] fga_data;
    foreground2 fgApple(clk25M, x, y, pixInFga, fga_data);
    
    wire [15:0] bg_data;
    background background1(clk25M, x, bg_data);
    //To Lowest Layer
    
    always@(posedge clk25M)
    begin
        if (pixInFgba)
            pixel_data <= fgba_data;
        else if (pixInFga)
            pixel_data <= fga_data;
        else
            pixel_data <= bg_data;
    end
    
endmodule

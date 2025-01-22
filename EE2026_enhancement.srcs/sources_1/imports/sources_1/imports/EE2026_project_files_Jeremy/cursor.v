`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2024 23:19:42
// Design Name: 
// Module Name: cursor
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


module cursor(input clk25m, mouse_l_click, enable, input [6:0] cursor_x, pixel_x, 
        input [5:0] cursor_y, pixel_y, output reg pixel_match = 0, 
        output reg [15:0] cursor_colour = 0);
        
    // Colours
    parameter BLACK = 16'b00000_000000_00000;
    parameter WHITE = 16'b11111_111111_11111;
    parameter YELLOW = 16'b11111_111111_00000;
    
    wire [12:0] diff_x, diff_y;
    wire [12:0] product_x, product_y;
    
    // Compute distance between current pixel on OLED and centre coords
    assign diff_x = {6'b0, (pixel_x < cursor_x) ? (cursor_x - pixel_x) : (pixel_x - cursor_x)};
    assign diff_y = {7'b0, (pixel_y < cursor_y) ? (cursor_y - pixel_y) : (pixel_y - cursor_y)};
    
    assign product_x = diff_x * diff_x;
    assign product_y = diff_y * diff_y;
    
    always @ (posedge clk25m) begin 
        if (enable == 0) begin
            pixel_match <= 1'b0;
            cursor_colour <= BLACK;
        end
        else begin
            if ((product_x + product_y) < 4) begin
                pixel_match <= 1'b1;
                cursor_colour <= (mouse_l_click) ? YELLOW : WHITE;
            end
            else if ((product_x + product_y) <= 9) begin
                pixel_match <= 1'b1;
                cursor_colour <= BLACK;       
            end
            else begin
                pixel_match <= 1'b0;
                cursor_colour <= BLACK;
            end
        end
    end
    
endmodule

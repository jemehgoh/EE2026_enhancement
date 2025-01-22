`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2024 22:34:25
// Design Name: 
// Module Name: mouse_cursor_mapper
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


module mouse_cursor_mapper(input [11:0] mouse_xpos, mouse_ypos, 
        output [6:0] cursor_x, output [5:0] cursor_y);
        
    wire [11:0] y_intermediate;
    
    assign cursor_x =  mouse_xpos[6:0];
    
    assign y_intermediate = ((mouse_ypos * 63) / 95);
    
    assign cursor_y = y_intermediate[5:0];

endmodule

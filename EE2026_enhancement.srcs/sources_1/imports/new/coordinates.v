`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2024 03:09:10 PM
// Design Name: 
// Module Name: coordinates
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


module coordinates(input[12:0]pixel_index, output [5:0] x_length, output [5:0] y_length, output [6:0] x, output [5:0] y);
// X coordinate (0 to 95)  // Y coordinate (0 to 63)
assign x = pixel_index%96;
assign y = pixel_index/96;


reg [5:0] centre_x = 47;
reg [4:0] centre_y = 31;

assign x_length  = (x > centre_x) ? (x - centre_x) : (centre_x - x) ;
assign y_length  = (y > centre_y) ? (y - centre_y) : (centre_y - y) ;


endmodule

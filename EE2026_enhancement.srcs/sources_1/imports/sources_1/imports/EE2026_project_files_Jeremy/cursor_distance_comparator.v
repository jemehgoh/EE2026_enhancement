`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2024 09:11:10
// Design Name: 
// Module Name: cursor_distance_comparator
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


module cursor_distance_comparator(input [13:0] cursor_dist_0, cursor_dist_1,
        cursor_dist_2, cursor_dist_3, cursor_dist_4, cursor_dist_5, cursor_dist_6,
        cursor_dist_7, output [13:0] closest_distance);
        
    wire [13:0] min_dist_01, min_dist_23, min_dist_45, min_dist_67;
    wire [13:0] min_dist_03, min_dist_47;
    
    assign min_dist_01 = (cursor_dist_0 < cursor_dist_1) ? cursor_dist_0 : cursor_dist_1;
    assign min_dist_23 = (cursor_dist_2 < cursor_dist_3) ? cursor_dist_2 : cursor_dist_3;
    assign min_dist_45 = (cursor_dist_4 < cursor_dist_5) ? cursor_dist_4 : cursor_dist_5;
    assign min_dist_67 = (cursor_dist_6 < cursor_dist_7) ? cursor_dist_6 : cursor_dist_7;

    assign min_dist_03 = (min_dist_01 < min_dist_23) ? min_dist_01 : min_dist_23;
    assign min_dist_47 = (min_dist_45 < min_dist_67) ? min_dist_45 : min_dist_67;
    
    assign closest_distance = (min_dist_03 < min_dist_47) ? min_dist_03 : min_dist_47;          
endmodule

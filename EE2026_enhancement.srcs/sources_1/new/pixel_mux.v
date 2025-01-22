`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2024 14:47:14
// Design Name: 
// Module Name: pixel_mux
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


module pixel_mux(input clk25m, input [2:0] mode, 
    input [15:0] main_screen_data, difficulty_screen_data,
    start_game_data, helper_screen_data, end_game_data, 
    output reg [15:0] pixel_data = 0, pixel_data_h = 0);
        
    parameter difficulty_highlighted = 3'b000;
    parameter start_highlighted = 3'b001;
    parameter difficulty_easy = 3'b010;
    parameter difficulty_hard = 3'b011;
    parameter start_game = 3'b100;
    parameter end_game = 3'b101;
    
    always @ (posedge clk25m) begin
    
    case (mode)
//        main:  
//        begin
//            pixel_data <= main_screen_data;
//            pixel_data_h <= 0;
//        end 
        
        difficulty_highlighted:
        begin
            pixel_data <= main_screen_data;
            pixel_data_h <= 0;
        end
        
        start_highlighted:
        begin
            pixel_data <= main_screen_data;
            pixel_data_h <= 0;
        end
        
        difficulty_easy:  //default easy 
        begin
            pixel_data <= difficulty_screen_data;
            pixel_data_h <= 0;
        end
        
        difficulty_hard:
        begin
            pixel_data <= difficulty_screen_data;
            pixel_data_h <= 0;
        end
            
        start_game: //actual game
        begin
            pixel_data <= start_game_data;
            pixel_data_h <= helper_screen_data;  
        end
        
        end_game:
        begin
            pixel_data <= end_game_data;
            pixel_data_h <= 0;
        end
        
        default:
        begin
            pixel_data <= end_game_data;
            pixel_data_h <= 0;
        end 
        
    endcase 
    end
        
endmodule

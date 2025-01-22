`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2024 02:43:28 PM
// Design Name: 
// Module Name: difficultyScreenAlt
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


module difficultyScreen(input clk25M, input difficulty, input [6:0]x, input [5:0] y, output reg[15:0]pixel_data = 16'h07E0);
parameter [15:0] VIOLET = 16'h897B;
parameter [15:0] INDIGO = 16'h4810; 
parameter [15:0] BLUE = 16'h8E7D ; //baby blue    
parameter [15:0] GREEN = 16'b00000_111111_00000;
parameter [15:0] YELLOW = 16'hFEE0; // Golden yellow 
parameter [15:0] ORANGE = 16'hFFA0;
parameter [15:0] RED = 16'b11111_000000_00000;

parameter [15:0] WHITE = 16'b11111_111111_11111;
//button and button select
parameter [15:0] PINK = 16'hFDF9;

parameter [15:0] CARRIBBEAN = 16'h0653;

parameter [15:0] TEAL = 16'h07FD;
parameter [15:0] INVERTEAL = 16'h3F1E;  //red

parameter difficulty_easy = 0;
parameter difficulty_hard = 1;

always @(posedge clk25M)
begin
    //rectangle 2px border 3 px from edge
    // combine all 4 rectangles in the if statement with OR || operator Clockwise
        if ((x > 2 && x < 94 && y > 2 && y < 5)|| (x > 90 && x < 93 && y > 2 && y < 62) || (x > 2 && x < 94 && y > 59 && y < 62) || (x > 3 && x < 6 && y > 2 && y < 62))
            pixel_data = TEAL;
            
        else if (
            //D
            (x > 20 && x < 25 && (y == 11 || y == 17) ) ||
            ((x == 25 || x == 21) && y > 11 && y < 17) ||
            
            //I
            ((x > 26 && x < 30 || x > 42 && x < 46) && (y == 11 || y == 17)) ||
            ((x == 28 || x == 44) && y > 11 && y < 17)||
            
            //F
            ( ((x > 30 && x < 36) || (x > 36 && x < 42)) && y == 11) ||
            ( (x == 31 || x == 37) && y > 11 && y < 18) ||
            ( ((x > 31 && x < 34) || (x > 37 && x < 40)) && y == 13) ||
        
            //C
            (x == 47 && y > 11 && y < 17) ||
            (x > 47 && x < 52 && (y == 11 || y == 17) ) ||
            (x == 52 && (y == 12 || y == 16) ) ||
            
            //U
            ( (x == 54 || x == 58) && y > 10 && y < 17) ||
            ( x > 54 && x < 58 && y == 17) ||
            
            //L
            (x == 60 && y > 10 && y < 18) ||
            (x > 60 && x < 65 && y == 17) ||
            
            //T
            (x > 65 && x < 71 && y == 11)||
            (x == 68 && y > 11 && y < 18) ||
            
            //Y
            ((x == 76 || x == 72) && y == 11) ||
            ((x == 73 || x == 75) && y == 12) ||
            (x == 74 && y > 12 && y < 18) 
            )
            begin
            pixel_data = CARRIBBEAN; 
            end

// EASY OR HARD STARTS HERE
        else if ( 
        //E 
        ((x == 38) && y > 28 && y < 34) || 
        (x > 38 && x < 42 && (y == 33 || y == 29)) || 
        (x > 37 && x < 40 && y == 31)|| 
        
        //A 
        ((x == 44 || x == 45) && (y == 29 || y == 31))||
        ((x == 43 || x == 46) && (y > 29 && y < 34))||
        
        //S
        (x > 48 && x < 52 && y == 29) || 
        ( x == 48 && y == 30) || 
        ( x == 51 && y == 32) || 
        (x > 48 && x < 51 && y == 31)||
        (x > 47 && x < 51 && y == 33) || 
        
        //Y
        ((x == 53 || x == 57) && y > 28 && y < 31)||
        (x > 53 && x < 57 && y == 31) || 
        (x == 55 && (y == 33 || y == 32))
        )
        begin 
        pixel_data <= (difficulty == difficulty_easy) ? GREEN : RED ; 
        end
        
        else if(
        //H
        ((x == 39 || x == 42) && (y > 47 && y < 53))||
        ((x == 40 || x == 41) && y == 50)||
        
        //A
        ((x == 45 || x == 46) && (y == 50 || y == 48) )||
        ((x == 44 || x == 47) && (y > 48 && y < 53))||
        
        //R 
        (x == 49 && y > 47 && y < 53) ||
        (x > 49 && x < 52 && (y == 48 || y == 50)) ||
        (x == 52 && (y == 49 || y == 52)) ||
        (x == 51 && y == 51) ||
        
        //D
        ((x == 54 || x == 57) && y > 48 && y < 52 ) ||
        (x > 53 && x < 57 && (y == 48 || y == 52))
        )
        begin
        pixel_data <= (difficulty == difficulty_easy) ? CARRIBBEAN : RED; 
        end
        
        else if (x > 14 && x < 82 && y > 24  && y < 37 )
            pixel_data <= (difficulty == difficulty_easy) ? TEAL : PINK ;
                    
        else if (x > 14 && x < 82 && y > 43 && y < 56 )
            pixel_data <= (difficulty == difficulty_easy) ? PINK : TEAL;
            
        else pixel_data = 16'b00000_000000_00000;

end 

endmodule

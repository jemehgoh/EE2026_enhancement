`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2024 02:54:51 PM
// Design Name: 
// Module Name: main_screen_alt
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


module main_screen_alt(input clk25M, input mode, input [6:0] x, input [5:0] y, output reg[15:0]pixel_data = 16'h07E0);

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

parameter difficulty_highlighted = 3'b001;
parameter start_highlighted = 3'b010;

always @(posedge clk25M)
begin
    //rectangle 2px border 3 px from edge
    // combine all 4 rectangles in the if statement with OR || operator Clockwise
    if ((x > 2 && x < 94 && y > 2 && y < 5)|| (x > 90 && x < 93 && y > 2 && y < 62) || (x > 2 && x < 94 && y > 59 && y < 62) || (x > 3 && x < 6 && y > 2 && y < 62))
        pixel_data = TEAL;
        
    //Spot It! S
    else if (
    (x > 10 && x < 18  && y == 7 ) || 
    (x == 10 && y == 8)  ||
    (x > 7 && x < 10  && y == 9 ) || 
    (x == 7  && y > 9 && y < 14) || 
    (x == 8  && y > 12 && y < 15) || 
    (x == 9  && y == 14) || 
    (x > 9 && x < 13  && y == 15 ) || 
    (x > 11 && x < 15  && y == 16 ) || 
    (x == 14  && y > 16 && y < 21 ) || 
    (x > 11 && x < 14  && y == 20 ) || 
    (x > 4 && x < 13  && y == 21 )
    )
        begin
        pixel_data = RED;
        end
        
    //Spot It! P
    else if (
    (x > 23 && x < 31  && y == 7 ) || 
    (x == 30 && y > 7 && y < 12)  ||
    (x == 29 && y > 10 && y < 14 ) || 
    (x > 25 && x < 29 && y == 12 ) || 
    (x > 21 && x < 27 && y == 13 ) || 
    (x == 23  && y > 9 && y < 13) || 
    (x == 24  && y > 7 && y < 10) || 
    
    (x == 22 && y == 14 ) || 
    (x == 21  && y > 14 && y < 17 ) ||
    (x == 20  && y > 15 && y < 19 ) ||
    (x == 19  && y > 17 && y < 21 ) ||
    (x == 18  && y > 19 && y < 22 ) ||
    (x == 17  && y > 20 && y < 23 ) ||
    (x == 16 && y == 22 )
    )
        begin
        pixel_data = ORANGE;
        end
        
    //Spot It! O
    else if (
    (x > 35 && x < 41  && y == 7 ) || 
    ((x == 35 || x == 41) && y == 8) ||
    ((x == 34 || x == 42) && y == 9) ||
    ((x == 33 || x == 43) && (y == 10 || y == 11)) ||
    ((x == 37 || x == 39) && y == 11) ||
    (x == 38 && y == 10 ) || 
    ((x == 32 || x == 36 || x == 40 || x == 44) && y > 11 && y < 17) ||
    ((x == 33 || x == 37 || x == 39 || x == 43) && y == 17) ||
    ((x == 33 || x == 38 || x == 43) && y == 18) ||
    ((x == 34 || x == 42) && y == 19) ||
    ((x == 35 || x == 41) && y == 20) ||
    (x > 35 && x < 41 && y == 21) 
    )
        begin
        pixel_data = YELLOW;
        end
    
    //Spot It! T
    else if (
    (x > 44 && x < 59  && y == 7 ) || 
    ((x == 51 || x == 52) && y == 8) ||
    (x == 51 && y == 9) ||
    (x == 50 && (y == 10 || y == 11)) ||
    (x == 49 && y > 10 && y < 15) ||
    (x == 48 && y > 13 && y < 17) ||
    (x == 47 && (y == 17 || y == 18)) ||
    (x == 46 && y > 17 && y < 21) ||
    (x == 45 && y > 19 && y < 23)
    )
        begin
        pixel_data = GREEN;
        end
    
    //Spot It! I
    else if (
    (x > 63 && x < 73  && y == 7 ) || 
    ((x == 68 || x == 69) && y == 8) ||
    (x == 68 && (y == 9 || y == 10)) ||
    
    (x == 67 && y > 9 && y < 13) ||
    (x == 66 && (y == 13 || y == 14)) ||
    (x == 65 && (y == 15 || y == 17)) ||
    
    (x == 64 && (y == 17 || y == 19)) ||
    (x == 63 && y > 18 && y < 22) ||
    (x == 62 && y == 21) ||
    (x > 58 && x < 69  && y == 22 ) 
    )
        begin
        pixel_data = BLUE;
        end    
        
    //Spot It! T
    else if (
    (x > 74 && x < 85  && y == 7 ) || 
    ((x == 79 || x == 80) && y == 8) ||
    (x == 79 && (y == 9 || y == 10)) ||
    
    (x == 78 && y > 9 && y < 13) ||
    (x == 77 && (y == 13 || y == 14)) ||
    (x == 76 && (y == 15 || y == 17)) ||
    
    (x == 75 && y > 16 && y < 20) ||
    (x == 74 && y > 18 && y < 22) ||
    (x == 73 && (y == 21 || y == 22)) ||
    
    (x == 72 && y == 22)
    )
        begin
        pixel_data = INDIGO;
        end
        
    //Spot It! !
    else if (
    (x == 89 && y == 7) ||
    (x == 90 && y == 7) ||
    (x == 88 && y == 8) ||
    (x == 89 && y == 8) ||
    
    (x == 88 && y > 7 && y < 11) ||
    (x == 87 && y > 9 && y < 13) ||
    
    (x == 86 && (y == 13 || y == 14)) ||
    (x == 85 && y > 14 && y < 18) ||
    (x == 84 && y > 16 && y < 20) ||
    (x == 83 && y == 19 ) ||
    //(x == 83 && y == 20) ||
    (x == 81 && y == 22) ||
    (x == 82 && y == 22) 
    )
        begin
        pixel_data = VIOLET;
        end

    else if( 
        //D
        (x == 24 && y > 27 && y < 33) ||
        ((x == 25 || x == 26) && (y == 28 || y == 32)) ||
        (x == 27 && y > 28 && y < 32) ||
        
        //I
        ((x > 28 && x < 32 || x > 42 && x < 46) && (y == 28 || y == 32)) ||
        ((x == 30 || x == 44) && y > 28 && y < 32)||
        
        //F
        ( ((x > 32 && x < 37) || (x > 37 && x < 42)) && y == 28) ||
        ( (x == 33 || x == 38) && y > 28 && y < 33) ||
        ( ((x > 33 && x < 36) || (x > 38 && x < 41)) && y == 30) ||
    
        //C
        (x == 47 && y > 28 && y < 32) ||
        (x > 47 && x < 50 && (y == 28 || y == 32) ) ||
        (x == 50 && (y == 29 || y == 31) ) ||
        
        //U
        ( (x == 52 || x == 55) && y > 27 && y < 32) ||
        ( (x == 53 || x == 54) && y == 32) ||
        
        //L
        (x == 57 && y > 27 && y < 33) ||
        (x > 57 && x < 61 && y == 32) ||
        
        //T
        (x > 61 && x < 67 && y == 28)||
        (x == 64 && y > 28 && y < 33) ||
        
        //Y
        ( (x == 68 || x == 72) && y > 27 && y < 30) ||
        (x > 69 && x < 72 && y == 30) ||
        (x == 70 && y > 30 && y < 33) 
        )
            begin
            pixel_data <= (mode == difficulty_highlighted) ? RED : (mode == start_highlighted) ? CARRIBBEAN : pixel_data;
            end
            
    else if(        
        //S
        (x > 35 && x < 39 && y == 47) ||
        (x == 35 && y == 48) ||
        (x > 35 && x < 38 && y == 49) ||
        (x == 38 && y == 50) ||
        (x > 34 && x < 39 && y == 51) ||
    
        
        //T
        ( ( (x > 39 && x < 44) || (x > 55 && x < 61) ) && y == 47) ||
        ( (x == 42 || x == 58) && y > 47 && y < 52)||
        
        //A
        ( (x == 47 || x == 48) && (y == 47 || y == 49) )||
        ( (x == 46 || x == 49) && y > 47 && y < 52)||
        
        //R
        (x == 51 && y > 46 && y < 52)||
        ((x == 52 || x == 53) && (y == 47 || y == 49))||
        (x == 53 && y == 50)||
        (x == 54 && (y == 48 || y == 51))
        )
            begin
            pixel_data <= (mode == difficulty_highlighted) ? CARRIBBEAN : (mode == start_highlighted) ? TEAL : pixel_data;
            end
        
    else if (x > 14 && x < 82 && y > 24  && y < 37 )
        pixel_data <= (mode == difficulty_highlighted) ? TEAL : (mode == start_highlighted) ? PINK : pixel_data;
        
    else if (x > 14 && x < 82 && y > 43 && y < 56 )
        pixel_data <= (mode == difficulty_highlighted) ? PINK : (mode == start_highlighted) ? RED : pixel_data;            
            
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2024 03:07:47 PM
// Design Name: 
// Module Name: end_game_screen
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

module end_game_screen(input clk_5, input clk25M, input difficulty, input [6:0] x, input [5:0] y, output reg[15:0]pixel_data = 16'h07E0);

parameter [15:0] BLUE = 16'h012C ; //Royal blue (traditional)
parameter [15:0] BLACK = 0 ; 
    

parameter [15:0] ORANGE = 16'hFFA0;
parameter [15:0] PYELLOW = 16'hFFF3; //Canary Yellow

parameter [15:0] GREEN = 16'b00000_111111_00000;
parameter [15:0] YELLOW = 16'hFEE0; // Golden yellow 
parameter [15:0] TEAL = 16'h07FD;
parameter [15:0] RED = 16'b11111_000000_00000;
parameter [15:0] GOLD = 16'hFEE0;  // golden yellow

parameter [15:0] PINK = 16'hFDF9;
parameter [15:0] CARRIBBEAN = 16'h0653;

reg[1:0]state = 0;
reg[6:0] x_low, x_mid, x_top, x_exp;

always @(posedge clk_5)
begin
    state <= state + 1; 

    case (state)
        2'b00: 
            begin
            x_low <= 11;
            x_mid <= 83;
            x_top <= 59;
            x_exp <= 32; // rectangle's bottom left
            end
            
        2'b01:
            begin
            x_low <= 35;
            x_mid <= 11;
            x_top <= 83;
            x_exp <= 56;
            end
        
        2'b10:
            begin
            x_low <= 59;
            x_mid <= 35;
            x_top <= 11;
            x_exp <= 80;
            end
        
        2'b11:
            begin
            x_low <= 83;
            x_mid <= 59;
            x_top <= 35;
            x_exp <= 8;
            end
    endcase
    end

always@(posedge clk25M)
begin
    //patterns relative to x_low, 
    //colour according to state
    if (x >= x_low && x <= (x_low + 1) && y >= 44 && y <= 45)
        pixel_data <= (state == 2'b00)? RED : (state == 2'b01)? TEAL : (state == 2'b10)? GREEN : (state == 2'b11)? YELLOW : BLACK;
      
//    //patterns relative to x_mid ,
//    //colour according to state
    else if (x >= x_mid && x <= (x_mid + 1) && y >= 34 && y <= 35)
        pixel_data <= (state == 2'b00)? YELLOW : (state == 2'b01)? RED : (state == 2'b10)? TEAL : (state == 2'b11)? GREEN : BLACK;


    //patterns relative to x_top ,
    //colour according to state  
    else if (x >= x_top && x <= (x_top + 1) && y >= 24 && y <= 25)
        pixel_data <= (state == 2'b00)? GREEN : (state == 2'b01)? YELLOW : (state == 2'b10)? RED : (state == 2'b11)? TEAL : BLACK;
      

    //explode patterns relative to x_exp ,
    // 4 rectangles, 8 squares 
    //colour according to state      
    else if (
        (difficulty == 0) && (
        // x-axis rectangles
            (((x >= x_exp && x <= (x_exp + 2)) || (x >= (x_exp + 5) && x <= (x_exp + 7))) && (y == 24 || y == 25)) ||
                
            // y-axis rectangles
            ((x >= (x_exp + 3) && x <= (x_exp + 4)) && ((y >= 21 && y <= 23) || (y >= 26 && y <= 28))) ||
            
            // outer unique px
            (((x == (x_exp + 1) || x == (x_exp + 6)) && (y == 22 || y == 27)) ||
            
            // inner unique px
            ((x == (x_exp + 2) || x == (x_exp + 5)) && (y == 23 || y == 26)))
        )
    )
        pixel_data <= (state == 2'b00)? TEAL : (state == 2'b01)? GREEN : (state == 2'b10)? YELLOW : (state == 2'b11)? RED : BLACK;
        
    //explode patterns relative to x_exp ,
    // 4 long rectangles, 8 squares , 4 big squares
    //colour according to state      
    else if (
        (difficulty == 1) && (
        // x-axis rectangles
            (((x >= (x_exp - 3) && x <= (x_exp + 2)) || (x >= (x_exp + 5) && x <= (x_exp + 10))) && (y == 24 || y == 25)) ||
                
            // y-axis rectangles
            ((x >= (x_exp + 3) && x <= (x_exp + 4)) && ((y >= 18 && y <= 23) || (y >= 26 && y <= 31))) || 
            
            // outer unique px
            (((x == (x_exp + 1) || x == (x_exp + 6)) && (y == 22 || y == 27)) ||
            
            // inner unique px
            ((x == (x_exp + 2) || x == (x_exp + 5)) && (y == 23 || y == 26)))
        )
    )
        pixel_data <= (state == 2'b00)? TEAL : (state == 2'b01)? GREEN : (state == 2'b10)? YELLOW : (state == 2'b11)? RED : BLACK;
    
    else if (
        (difficulty == 1) && (
            // left big square , right big square
            (x == (x_exp - 1) || x == x_exp  || x == (x_exp + 7) || x == (x_exp + 8)) && ((y >= 20 && y <= 21) || (y >= 28 && y <= 29))
        )
    )
                pixel_data <= GOLD;    
    
    
    else if( 
    (x >= 9 && x <= 15) || (x >= 33 && x <= 38) || (x >= 57 && x <= 62) || (x >= 81 && x <= 86)
    )
        begin
        //top of launcher  , then base of launcher
        pixel_data <= (y == 54 || y == 55) ? ORANGE : (y >= 56 && y <= 63) ? PYELLOW : BLACK;
        end
        
    else pixel_data <= BLACK;

end


endmodule

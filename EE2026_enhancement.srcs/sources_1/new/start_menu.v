`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2024 08:50:10 PM
// Design Name: 
// Module Name: top_module
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


// add 2 displays


module start_menu(input CLOCK, input btnD, input btnU, input btnC, input select_start, output[7:0] JB);

wire dbtnD;  //btnd
wire dbtnU;  //btnu
wire dbtnC;  //btnc

debouncing_button btn1( CLOCK, btnD, dbtnD);
debouncing_button btn2( CLOCK, btnU, dbtnU);
debouncing_button btn3( CLOCK, btnC, dbtnC);

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

wire clk6p25m; 
reg [31:0] my_625_value = 32'd7;
flexible_clock clk625m(CLOCK, my_625_value, clk6p25m);

wire clk_1kHz;
parameter [31:0] my_1k_value = 32'd49999;
flexible_clock clk1k(CLOCK, my_1k_value, clk_1kHz);

wire clk25M; 
parameter [31:0] my_25M_value = 32'd1;
flexible_clock clk25m(CLOCK, my_25M_value, clk25M);

reg [15:0] pixel_data = 16'h07E0;    //binary 00000_111111_00000
wire frame_begin;
wire [12:0]pixel_index;
wire sending_pixels;
wire sample_pixel;
wire reset = 0;
Oled_Display Oled_Display(clk6p25m, reset, frame_begin, sending_pixels,
  sample_pixel, pixel_index, pixel_data, JB[0], JB[1], JB[3], JB[4], JB[5], JB[6], JB[7]);

wire [5:0] x_length;
wire [5:0] y_length;
wire [6:0] x;
wire [5:0] y;
coordinates coordinates(pixel_index, x_length, y_length, x, y);
wire [2:0] x_mod;
wire [2:0] y_mod;

wire difficulty = 0;

reg[2:0] mode = 3'b000;
parameter main_screen = 3'b000; //start screen
parameter difficulty_highlighted = 3'b001;
parameter start_highlighted = 3'b010;
parameter difficulty_screen = 3'b011;
parameter start_game = 3'b100;
//parameter  = 3'b101;
//parameter  = 3'b110;
parameter  end_game = 3'b111;


wire EN;


always @(posedge clk_1kHz)
begin 
    //RST 
    if (select_start == 0)
        mode <= main_screen;
    

case (mode)
    main_screen:  
    begin
    mode <= (dbtnU) ? difficulty_highlighted : ((dbtnD) ? start_highlighted : mode) ;
    end 
    
    difficulty_highlighted:
    begin
    mode <= (dbtnC)? difficulty_screen : ((dbtnU) ? start_highlighted : ((dbtnD) ? start_highlighted : mode)) ;
    end
    
    start_highlighted:
    begin
    //game_finished <= (dbtnC) ? 0 : 1 ;
    mode <= (dbtnC)? start_game : ((dbtnU) ? difficulty_highlighted : ((dbtnD) ? difficulty_highlighted : mode)) ;
    end
    
    difficulty_screen:
    begin
    mode <= (dbtnC)? start_game : mode ;
    end
    
    
endcase 
end

always @(posedge clk25M)
begin

case (mode)
    
    3'b000:  //main 
    begin
    //rectangle 2px border 3 px from edge
    // combine all 4 rectangles in the if statement with OR || operator Clockwise
    if ((x > 2 && x < 94 && y > 2 && y < 5)|| (x > 90 && x < 93 && y > 2 && y < 62) || (x > 2 && x < 94 && y > 59 && y < 62) || (x > 3 && x < 6 && y > 2 && y < 62))
        pixel_data = TEAL;
    
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
    (x == 70 && y > 30 && y < 33) ||
    
    
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
        pixel_data = CARRIBBEAN;
        end
        
    else if ((x > 14 && x < 82 && y > 24  && y < 37 )|| (x > 14 && x < 82 && y > 43 && y < 56 ))
        pixel_data = PINK;
    
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
        
    else pixel_data = 16'b00000_000000_00000;
    end

    3'b001:  //difficulty highlighted 
    begin
    //rectangle 2px border 3 px from edge
    // combine all 4 rectangles in the if statement with OR || operator Clockwise
    if ((x > 2 && x < 94 && y > 2 && y < 5)|| (x > 90 && x < 93 && y > 2 && y < 62) || (x > 2 && x < 94 && y > 59 && y < 62) || (x > 3 && x < 6 && y > 2 && y < 62))
        pixel_data = TEAL;
        
    else if (x > 14 && x < 82 && y > 24 && y < 37 )
        pixel_data = TEAL;
    
    else if (x > 14 && x < 82 && y > 43 && y < 56 )
        pixel_data = PINK;
        
    else pixel_data = 16'b00000_000000_00000;

    end
    
    3'b010:  //START highlighted
    begin
    //rectangle 2px border 3 px from edge
    // combine all 4 rectangles in the if statement with OR || operator Clockwise
    if ((x > 2 && x < 94 && y > 2 && y < 5)|| (x > 90 && x < 93 && y > 2 && y < 62) || (x > 2 && x < 94 && y > 59 && y < 62) || (x > 3 && x < 6 && y > 2 && y < 62))
        pixel_data = TEAL;
        
    else if (x > 14 && x < 82 && y > 24 && y < 37 )
        pixel_data = PINK;
    
    else if (x > 14 && x < 82 && y > 43 && y < 56 )
        pixel_data = TEAL;
        
    else pixel_data = 16'b00000_000000_00000;
    
    end
   
    3'b011:  //difficulty screen
    begin
    
    if ((x > 2 && x < 94 && y > 2 && y < 5)|| (x > 90 && x < 93 && y > 2 && y < 62) || (x > 2 && x < 94 && y > 59 && y < 62) || (x > 3 && x < 6 && y > 2 && y < 62))
            pixel_data = TEAL;
            
    else pixel_data = 16'b00000_000000_00000;

    end

//    start_game:
    
//    game game (.EN (en), . );
      
    
    
endcase    
end

endmodule

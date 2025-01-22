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


module top_module(input CLOCK, input btnD, input btnU, input btnC, output [4:0] led, output[7:0] JXADC, output[7:0] JC, output [3:0] an, output [7:0] seg,
        inout PS2Clk, PS2Data);

wire dbtnD;  //btnd
wire dbtnU;  //btnu
wire dbtnC;  //btnc

debouncing_button btn1( CLOCK, btnD, dbtnD);
debouncing_button btn2( CLOCK, btnU, dbtnU);
debouncing_button btn3( CLOCK, btnC, dbtnC);

wire clk6p25m; 
reg [31:0] my_625_value = 32'd7;
flexible_clock clk625m(CLOCK, my_625_value, clk6p25m);

wire clk25M; 
parameter [31:0] my_25M_value = 32'd1;
flexible_clock clk25m(CLOCK, my_25M_value, clk25M);  

wire clk_1kHz;
parameter [31:0] my_1k_value = 32'd49999;
flexible_clock clk1k(CLOCK, my_1k_value, clk_1kHz);

wire clk_400;
parameter [31:0] my_400_value = 32'd124_999;
flexible_clock clk400(CLOCK, my_400_value, clk_400);

wire clk_5;
parameter [31:0] my_5_value = 32'd999_9999;
flexible_clock clk5(CLOCK, my_5_value, clk_5); 

wire clk_1;
parameter [31:0] my_1_value = 32'd4999_9999;
flexible_clock clk1(CLOCK, my_1_value, clk_1); 


reg[2:0] mode = 3'b000;
parameter difficulty_highlighted = 3'b000;  //START screen
parameter start_highlighted = 3'b001;
parameter difficulty_easy = 3'b010;
parameter difficulty_hard = 3'b011;
parameter start_game = 3'b100;
parameter end_game = 3'b101;
//parameter  = 3'b110;
//parameter  = 3'b111;


wire game_end;
reg difficulty = 0;
//reg cos need to assign in always block
reg EN = 0; //enable, when does the game start?
reg rst = 0;  //end_game OR start_game finished
reg rst_flag = 0;
wire [7:0] differences;
wire correct_answer, wrong_answer;
pseudo_generator p_gen (CLOCK, EN, differences);
seven_seg_control sev_seg_control (EN, rst, correct_answer, wrong_answer, clk_5, clk_400, clk_1kHz, differences, an, seg, game_end);


wire [15:0] pixel_data; 
wire [15:0] main_screen_data, 
difficulty_screen_data, 
start_game_data,
helper_screen_data,
end_game_data;

wire frame_begin;
wire [12:0] pixel_index;
wire sending_pixels;
wire sample_pixel;
wire reset = 0;
Oled_Display Oled_Display (clk6p25m, reset, frame_begin, sending_pixels,
  sample_pixel, pixel_index, pixel_data, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7]);

//Helper screen
wire frame_begin_h;
wire [12:0] pixel_index_h;
wire [15:0] pixel_data_h;
wire sending_pixels_h;
wire sample_pixel_h;
wire reset_h = 0;
Oled_Display Oled_Display_h (clk6p25m, reset_h, frame_begin_h, sending_pixels_h,
  sample_pixel_h, pixel_index_h, pixel_data_h, JXADC[0], JXADC[1], JXADC[3], JXADC[4], JXADC[5], JXADC[6], JXADC[7]);

wire [5:0] x_length;
wire [5:0] y_length;
wire [6:0] x;
wire [5:0] y;
coordinates coordinates(pixel_index, x_length, y_length, x, y);

wire [5:0] x_length_h;
wire [5:0] y_length_h;
wire [6:0] x_h;
wire [5:0] y_h;
coordinates coordinates_h (pixel_index_h, x_length_h, y_length_h, x_h, y_h);

wire [11:0] mouse_x, mouse_y;
wire [3:0] mouse_z;
wire mouse_rst = 0, setx = 0, sety = 0, setmax_x = 1, setmax_y = 1;
wire left_click, right_click, middle_click, ne;
wire [11:0] value = 12'd95;
MouseCtl mouse(
    CLOCK, mouse_rst, mouse_x, mouse_y, mouse_z,
    left_click, middle_click, right_click, ne,
    value, setx, sety, setmax_x, setmax_y,
    PS2Clk, PS2Data
);


// SCREENS //////////////////////////////////////////////////////////////////////////////////////////
gameScreen game(
    .EN(EN), .clk1k(clk_1kHz), .clk25M(clk25M), .difficulty(difficulty), .left_click(left_click),
    .mouse_x(mouse_x), .mouse_y(mouse_y),
    .x(x),
    .y(y),
    .randomSeed(~differences),
    .correct_line(correct_answer), .wrong_line(wrong_answer),
    .pixel_data(start_game_data),
    .led(led));
    
defaultScreen helper_screen(
        clk25M, x_h, y_h, helper_screen_data
        );

// difficulty_highlighted_screen && start_highlighted_screen
main_screen duShen (clk25M, mode, x, y, main_screen_data);
difficultyScreen difficultySelect (clk25M, difficulty, x, y, difficulty_screen_data);
//difficultyScreen difficultyHard (clk25M, difficulty, x, y, difficulty_hard_data);
end_game_screen endScreen (clk_5, clk25M, difficulty, x, y, end_game_data);

pixel_mux pmux (clk25M, mode, 
        main_screen_data, difficulty_screen_data, 
        start_game_data, helper_screen_data, end_game_data, 
        pixel_data, pixel_data_h);       
// SCREENS  END //////////////////////////////////////////////////////////////////////////////////////
        

always @(posedge clk_1kHz) begin 
        
// settle button and display logic
    case (mode)
        difficulty_highlighted:  // START screen
        begin
            EN <= 0;
            mode <= (dbtnC)? (difficulty == 0) ? difficulty_easy : difficulty_hard : ((dbtnU || dbtnD) ? start_highlighted : mode) ;
            if (~rst & ~rst_flag) begin
                rst <= 1;
                rst_flag <= 1;
            end
            else if (rst_flag & rst) begin
                rst <= 0;
            end
        end 
        
//        difficulty_highlighted:
//        begin
//            mode <= (dbtnC)? difficulty_screen : ((dbtnU || dbtnD) ? start_highlighted : mode) ;
//            rst <= 0;
//            rst_flag <= 0;
//        end
        
        start_highlighted:
        begin
            //game_finished <= (dbtnC) ? 0 : 1 ;
            mode <= (dbtnC)? start_game : ((dbtnU || dbtnD) ? difficulty_highlighted : mode) ;
            EN <= (dbtnC)? 1 : 0;
            rst <= 0;
            rst_flag <= 0;
        end
        
        difficulty_easy:  //default easy 
        begin
            EN <= 0;
            mode <= (dbtnC)? difficulty_highlighted : ((dbtnU || dbtnD) ? difficulty_hard : mode);
            difficulty <= 0;
            rst <= 0;
            rst_flag <= 0;
        end
        
        difficulty_hard: 
        //combine difficulty_screen_data & difficulty_hard_data into one wire, multiplex in difficultyScreen module (delete module)
        begin
            EN <= 0;
            mode <= (dbtnC)? difficulty_highlighted : ((dbtnU || dbtnD) ? difficulty_easy : mode);
            difficulty <= 1;
            rst <= 0;
            rst_flag <= 0;
        end
            
        start_game: //actual game
        begin
            mode <= (dbtnC)? difficulty_highlighted :  (game_end == 1)? end_game : mode;
            EN <= 1;  
            rst <= 0;
            rst_flag <= 0;
           
            
        end
        
        end_game:
        begin
            if (dbtnC)
                begin
                mode <= difficulty_highlighted;
                end
            EN <= 0;
            rst <= 0;
            rst_flag <= 0;
        end
        
    endcase 
end



    
endmodule

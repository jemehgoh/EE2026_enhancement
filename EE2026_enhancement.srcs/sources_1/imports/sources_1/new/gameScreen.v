`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.10.2024 17:01:20
// Design Name: 
// Module Name: gameScreen
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


module gameScreen(
    input EN, clk1k, clk25M, difficulty, left_click,
    input [11:0] mouse_x, mouse_y,
    input [6:0] x,
    input [5:0] y,
    input [7:0] randomSeed,
    output correct_line, wrong_line,
    output reg [15:0] pixel_data,
    output [4:0] led
    );
    
    wire [6:0] cursor_x; wire [5:0] cursor_y;
    mouse_cursor_mapper mouseToCursor(mouse_x, mouse_y, cursor_x, cursor_y);
    
    wire leftDeb;
    debouncer leftClickDebounce(clk1k, left_click, leftDeb);
    
    wire green = 1;
    wire red = 0;
    
    // From Highest Layer
    wire pixInCursor; wire [15:0] cursor_data;
    cursor cursorDisplay(clk25M, left_click, EN, cursor_x, x, cursor_y, y, pixInCursor, cursor_data);
    
    wire pixInFgba; wire [15:0] fgba_data;
    foreground1 fgBigApple(clk25M, x, y, pixInFgba, fgba_data);
    
    wire pixInApple1; wire [6:0] apple1CX = 7'd14; wire [5:0] apple1CY = 6'd21; wire [15:0] apple1_data;
    apple apple1(clk25M, green, x, apple1CX, y, apple1CY, pixInApple1, apple1_data);
    
    wire pixInApple2; wire [6:0] apple2CX = 7'd20; wire [5:0] apple2CY = 6'd3; wire [15:0] apple2_data;
    apple apple2(clk25M, green, x, apple2CX, y, apple2CY, pixInApple2, apple2_data);
    
    wire pixInApple3; wire [6:0] apple3CX = 7'd38; wire [5:0] apple3CY = 6'd61; wire [15:0] apple3_data;
    apple apple3(clk25M, red, x, apple3CX, y, apple3CY, pixInApple3, apple3_data);
    
    wire pixInApple4; wire [6:0] apple4CX = 7'd42; wire [5:0] apple4CY = 6'd2; wire [15:0] apple4_data;
    apple apple4(clk25M, green, x, apple4CX, y, apple4CY, pixInApple4, apple4_data);

    wire pixInApple5; wire [6:0] apple5CX = 7'd47; wire [5:0] apple5CY = 6'd34; wire [15:0] apple5_data;
    apple apple5(clk25M, red, x, apple5CX, y, apple5CY, pixInApple5, apple5_data);
    
    wire pixInApple6; wire [6:0] apple6CX = 7'd55; wire [5:0] apple6CY = 6'd29; wire [15:0] apple6_data;
    apple apple6(clk25M, green, x, apple6CX, y, apple6CY, pixInApple6, apple6_data);
    
    wire pixInApple7; wire [6:0] apple7CX = 7'd62; wire [5:0] apple7CY = 6'd2; wire [15:0] apple7_data;
    apple apple7(clk25M, red, x, apple7CX, y, apple7CY, pixInApple7, apple7_data);
    
    wire pixInApple8; wire [6:0] apple8CX = 7'd77; wire [5:0] apple8CY = 6'd62; wire [15:0] apple8_data;
    apple apple8(clk25M, red, x, apple8CX, y, apple8CY, pixInApple8, apple8_data);
    
    wire pixInFga; wire [15:0] fga_data;
    foreground2 fgApple(clk25M, x, y, pixInFga, fga_data);
    
    wire [15:0] bg_data;
    background background1(clk25M, x, bg_data);
    //To Lowest Layer
    
    wire [7:0] selected_entity, entity_select; wire [13:0] closest_distance;
    cursor_distance_checker cdc(
        clk25M, EN,
        randomSeed[0], randomSeed[1], randomSeed[2], randomSeed[3],
        randomSeed[4], randomSeed[5], randomSeed[6], randomSeed[7],
        cursor_x,
        apple1CX, apple2CX, apple3CX, apple4CX,
        apple5CX, apple6CX, apple7CX, apple8CX, 
        cursor_y,
        apple1CY, apple2CY, apple3CY, apple4CY,
        apple5CY, apple6CY, apple7CY, apple8CY,  
        selected_entity, entity_select, closest_distance
        );
    
    wire hold;
    entity_click_detector clickDetect(
        clk1k, EN, entity_select, leftDeb, hold,
        correct_line, wrong_line, selected_entity
        );
    
    led_interface ledControl (clk25M, EN, difficulty, correct_line, wrong_line, closest_distance, led, hold);
    
    always@(posedge clk25M)
    begin
        if (pixInCursor)
            pixel_data <= cursor_data;
        else if (pixInFgba)
            pixel_data <= fgba_data;
        else if (randomSeed[0] && pixInApple1)
            pixel_data <= apple1_data;
        else if (randomSeed[1] && pixInApple2)
            pixel_data <= apple2_data;
        else if (randomSeed[2] && pixInApple3)
            pixel_data <= apple3_data;
        else if (randomSeed[3] && pixInApple4)
            pixel_data <= apple4_data;
        else if (randomSeed[4] && pixInApple5)
            pixel_data <= apple5_data;
        else if (randomSeed[5] && pixInApple6)
            pixel_data <= apple6_data;
        else if (randomSeed[6] && pixInApple7)
            pixel_data <= apple7_data;
        else if (randomSeed[7] && pixInApple8)
            pixel_data <= apple8_data;
        else if (pixInFga)
            pixel_data <= fga_data;
        else
            pixel_data <= bg_data;
    end
    
endmodule

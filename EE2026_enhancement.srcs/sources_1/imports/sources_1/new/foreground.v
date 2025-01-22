`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2024 11:15:05
// Design Name: 
// Module Name: foreground
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


module foreground1(
    input clk25M,
    input [6:0] x,
    input [5:0] y,
    output pixInFg,
    output reg [15:0] fg_data
    );
    
    wire green = 1;
    wire red = 0;
    
    // Bottom row
    wire pixInBigApple1; wire [6:0] bigApple1CX = 7'd7; wire [5:0] bigApple1CY = 6'd54; wire [15:0] bigApple1_data;
    bigApple bigApple1(clk25M, red, x, bigApple1CX, y, bigApple1CY, pixInBigApple1, bigApple1_data);
    
    wire pixInBigApple2; wire [6:0] bigApple2CX = 7'd28; wire [5:0] bigApple2CY = 6'd54; wire [15:0] bigApple2_data;
    bigApple bigApple2(clk25M, green, x, bigApple2CX, y, bigApple2CY, pixInBigApple2, bigApple2_data);
    
    wire pixInBigApple3; wire [6:0] bigApple3CX = 7'd48; wire [5:0] bigApple3CY = 6'd54; wire [15:0] bigApple3_data;
    bigApple bigApple3(clk25M, red, x, bigApple3CX, y, bigApple3CY, pixInBigApple3, bigApple3_data);
    
    wire pixInBigApple4; wire [6:0] bigApple4CX = 7'd69; wire [5:0] bigApple4CY = 6'd53; wire [15:0] bigApple4_data;
    bigApple bigApple4(clk25M, green, x, bigApple4CX, y, bigApple4CY, pixInBigApple4, bigApple4_data);
    
    wire pixInBigApple5; wire [6:0] bigApple5CX = 7'd89; wire [5:0] bigApple5CY = 6'd54; wire [15:0] bigApple5_data;
    bigApple bigApple5(clk25M, green, x, bigApple5CX, y, bigApple5CY, pixInBigApple5, bigApple5_data);
    // Bottom row
    
    // 2nd Bottom row
    wire pixInBigApple6; wire [6:0] bigApple6CX = 7'd15; wire [5:0] bigApple6CY = 6'd40; wire [15:0] bigApple6_data;
    bigApple bigApple6(clk25M, red, x, bigApple6CX, y, bigApple6CY, pixInBigApple6, bigApple6_data);
    
    wire pixInBigApple7; wire [6:0] bigApple7CX = 7'd36; wire [5:0] bigApple7CY = 6'd39; wire [15:0] bigApple7_data;
    bigApple bigApple7(clk25M, green, x, bigApple7CX, y, bigApple7CY, pixInBigApple7, bigApple7_data);
    
    wire pixInBigApple8; wire [6:0] bigApple8CX = 7'd56; wire [5:0] bigApple8CY = 6'd40; wire [15:0] bigApple8_data;
    bigApple bigApple8(clk25M, red, x, bigApple8CX, y, bigApple8CY, pixInBigApple8, bigApple8_data);
    
    wire pixInBigApple9; wire [6:0] bigApple9CX = 7'd77; wire [5:0] bigApple9CY = 6'd39; wire [15:0] bigApple9_data;
    bigApple bigApple9(clk25M, red, x, bigApple9CX, y, bigApple9CY, pixInBigApple9, bigApple9_data);
    // 2nd Bottom row
    
    // 2nd Top row
    wire pixInBigApple10; wire [6:0] bigApple10CX = 7'd3; wire [5:0] bigApple10CY = 6'd26; wire [15:0] bigApple10_data;
    bigApple bigApple10(clk25M, green, x, bigApple10CX, y, bigApple10CY, pixInBigApple10, bigApple10_data);
    
    wire pixInBigApple11; wire [6:0] bigApple11CX = 7'd24; wire [5:0] bigApple11CY = 6'd24; wire [15:0] bigApple11_data;
    bigApple bigApple11(clk25M, red, x, bigApple11CX, y, bigApple11CY, pixInBigApple11, bigApple11_data);
    
    wire pixInBigApple12; wire [6:0] bigApple12CX = 7'd45; wire [5:0] bigApple12CY = 6'd23; wire [15:0] bigApple12_data;
    bigApple bigApple12(clk25M, red, x, bigApple12CX, y, bigApple12CY, pixInBigApple12, bigApple12_data);
    
    wire pixInBigApple13; wire [6:0] bigApple13CX = 7'd66; wire [5:0] bigApple13CY = 6'd24; wire [15:0] bigApple13_data;
    bigApple bigApple13(clk25M, green, x, bigApple13CX, y, bigApple13CY, pixInBigApple13, bigApple13_data);
    
    wire pixInBigApple14; wire [6:0] bigApple14CX = 7'd87; wire [5:0] bigApple14CY = 6'd22; wire [15:0] bigApple14_data;
    bigApple bigApple14(clk25M, red, x, bigApple14CX, y, bigApple14CY, pixInBigApple14, bigApple14_data);
    // 2nd Top row
    
    // Top row
    wire pixInBigApple15; wire [6:0] bigApple15CX = 7'd10; wire [5:0] bigApple15CY = 6'd10; wire [15:0] bigApple15_data;
    bigApple bigApple15(clk25M, red, x, bigApple15CX, y, bigApple15CY, pixInBigApple15, bigApple15_data);
    
    wire pixInBigApple16; wire [6:0] bigApple16CX = 7'd31; wire [5:0] bigApple16CY = 6'd9; wire [15:0] bigApple16_data;
    bigApple bigApple16(clk25M, green, x, bigApple16CX, y, bigApple16CY, pixInBigApple16, bigApple16_data);
    
    wire pixInBigApple17; wire [6:0] bigApple17CX = 7'd52; wire [5:0] bigApple17CY = 6'd10; wire [15:0] bigApple17_data;
    bigApple bigApple17(clk25M, red, x, bigApple17CX, y, bigApple17CY, pixInBigApple17, bigApple17_data);
    
    wire pixInBigApple18; wire [6:0] bigApple18CX = 7'd73; wire [5:0] bigApple18CY = 6'd9; wire [15:0] bigApple18_data;
    bigApple bigApple18(clk25M, red, x, bigApple18CX, y, bigApple18CY, pixInBigApple18, bigApple18_data);
    // Top row
    
    assign pixInFg = pixInBigApple1 | pixInBigApple2 | pixInBigApple3 | pixInBigApple4 | pixInBigApple5 |
                     pixInBigApple6 | pixInBigApple7 | pixInBigApple8 | pixInBigApple9 |
                     pixInBigApple10 | pixInBigApple11 | pixInBigApple12 | pixInBigApple13 | pixInBigApple14 |
                     pixInBigApple15 | pixInBigApple16 | pixInBigApple17 | pixInBigApple18;
    
    always@(posedge clk25M)
    begin
        if (pixInBigApple1)
            fg_data <= bigApple1_data;
        else if (pixInBigApple2)
            fg_data <= bigApple2_data;
        else if (pixInBigApple3)
            fg_data <= bigApple3_data;
        else if (pixInBigApple4)
            fg_data <= bigApple4_data;
        else if (pixInBigApple5)
            fg_data <= bigApple5_data;
        else if (pixInBigApple6)
            fg_data <= bigApple6_data;
        else if (pixInBigApple7)
            fg_data <= bigApple7_data;
        else if (pixInBigApple8)
            fg_data <= bigApple8_data;
        else if (pixInBigApple9)
            fg_data <= bigApple9_data;
        else if (pixInBigApple10)
            fg_data <= bigApple10_data;
        else if (pixInBigApple11)
            fg_data <= bigApple11_data;
        else if (pixInBigApple12)
            fg_data <= bigApple12_data;
        else if (pixInBigApple13)
            fg_data <= bigApple13_data;
        else if (pixInBigApple14)
            fg_data <= bigApple14_data;
        else if (pixInBigApple15)
            fg_data <= bigApple15_data;
        else if (pixInBigApple16)
            fg_data <= bigApple16_data;
        else if (pixInBigApple17)
            fg_data <= bigApple17_data;
        else if (pixInBigApple18)
            fg_data <= bigApple18_data;
    end
    
endmodule

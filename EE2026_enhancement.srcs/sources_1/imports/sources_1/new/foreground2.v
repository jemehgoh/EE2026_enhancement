`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.10.2024 14:46:05
// Design Name: 
// Module Name: foreground2
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


module foreground2(
    input clk25M,
    input [6:0] x,
    input [5:0] y,
    output pixInFg,
    output reg [15:0] fg_data
    );
    
    wire green = 1;
    wire red = 0;
    
    wire pixInApple1; wire [6:0] apple1CX = 7'd2; wire [5:0] apple1CY = 6'd39; wire [15:0] apple1_data;
    apple apple1(clk25M, green, x, apple1CX, y, apple1CY, pixInApple1, apple1_data);
    
    wire pixInApple2; wire [6:0] apple2CX = 7'd17; wire [5:0] apple2CY = 6'd61; wire [15:0] apple2_data;
    apple apple2(clk25M, red, x, apple2CX, y, apple2CY, pixInApple2, apple2_data);
    
    wire pixInApple3; wire [6:0] apple3CX = 7'd42; wire [5:0] apple3CY = 6'd2; wire [15:0] apple3_data;
    apple apple3(clk25M, red, x, apple3CX, y, apple3CY, pixInApple3, apple3_data);
    
    wire pixInApple4; wire [6:0] apple4CX = 7'd47; wire [5:0] apple4CY = 6'd34; wire [15:0] apple4_data;
    apple apple4(clk25M, green, x, apple4CX, y, apple4CY, pixInApple4, apple4_data);
    
    wire pixInApple5; wire [6:0] apple5CX = 7'd55; wire [5:0] apple5CY = 6'd29; wire [15:0] apple5_data;
    apple apple5(clk25M, red, x, apple5CX, y, apple5CY, pixInApple5, apple5_data);
    
    wire pixInApple6; wire [6:0] apple6CX = 7'd57; wire [5:0] apple6CY = 6'd62; wire [15:0] apple6_data;
    apple apple6(clk25M, red, x, apple6CX, y, apple6CY, pixInApple6, apple6_data);
    
    wire pixInApple7; wire [6:0] apple7CX = 7'd62; wire [5:0] apple7CY = 6'd60; wire [15:0] apple7_data;
    apple apple7(clk25M, green, x, apple7CX, y, apple7CY, pixInApple7, apple7_data);
    
    wire pixInApple8; wire [6:0] apple8CX = 7'd62; wire [5:0] apple8CY = 6'd2; wire [15:0] apple8_data;
    apple apple8(clk25M, green, x, apple8CX, y, apple8CY, pixInApple8, apple8_data);
    
    wire pixInApple9; wire [6:0] apple9CX = 7'd83; wire [5:0] apple9CY = 6'd2; wire [15:0] apple9_data;
    apple apple9(clk25M, red, x, apple9CX, y, apple9CY, pixInApple9, apple9_data);
    
    wire pixInApple10; wire [6:0] apple10CX = 7'd87; wire [5:0] apple10CY = 6'd8; wire [15:0] apple10_data;
    apple apple10(clk25M, green, x, apple10CX, y, apple10CY, pixInApple10, apple10_data);
    
    wire pixInApple11; wire [6:0] apple11CX = 7'd89; wire [5:0] apple11CY = 6'd35; wire [15:0] apple11_data;
    apple apple11(clk25M, red, x, apple11CX, y, apple11CY, pixInApple11, apple11_data);
    
    wire pixInApple12; wire [6:0] apple12CX = 7'd92; wire [5:0] apple12CY = 6'd2; wire [15:0] apple12_data;
    apple apple12(clk25M, green, x, apple12CX, y, apple12CY, pixInApple12, apple12_data);
    
    wire pixInApple13; wire [6:0] apple13CX = 7'd92; wire [5:0] apple13CY = 6'd41; wire [15:0] apple13_data;
    apple apple13(clk25M, green, x, apple13CX, y, apple13CY, pixInApple13, apple13_data);
    
    wire pixInApple14; wire [6:0] apple14CX = 7'd93; wire [5:0] apple14CY = 6'd10; wire [15:0] apple14_data;
    apple apple14(clk25M, red, x, apple14CX, y, apple14CY, pixInApple14, apple14_data);
    
    assign pixInFg = pixInApple1 | pixInApple2 | pixInApple3 | pixInApple4 | pixInApple5 | pixInApple6 | pixInApple7 |
                     pixInApple8 | pixInApple9 | pixInApple10 | pixInApple11 | pixInApple12 | pixInApple13 | pixInApple14;
    
    always@(posedge clk25M)
    begin
        if (pixInApple1)
            fg_data <= apple1_data;
        else if (pixInApple2)
            fg_data <= apple2_data;
        else if (pixInApple3)
            fg_data <= apple3_data;
        else if (pixInApple4)
            fg_data <= apple4_data;
        else if (pixInApple5)
            fg_data <= apple5_data;
        else if (pixInApple6)
            fg_data <= apple6_data;
        else if (pixInApple7)
            fg_data <= apple7_data;
        else if (pixInApple8)
            fg_data <= apple8_data;
        else if (pixInApple9)
            fg_data <= apple9_data;
        else if (pixInApple10)
            fg_data <= apple10_data;
        else if (pixInApple11)
            fg_data <= apple11_data;
        else if (pixInApple12)
            fg_data <= apple12_data;
        else if (pixInApple13)
            fg_data <= apple13_data;
        else if (pixInApple14)
            fg_data <= apple14_data;
    end
    
endmodule

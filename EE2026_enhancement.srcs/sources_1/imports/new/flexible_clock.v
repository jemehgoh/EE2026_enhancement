`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2024 09:23:28 AM
// Design Name: 
// Module Name: flexible_clock
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

//m = 3b'111 = 7

module flexible_clock(input CLOCK, input[31:0] my_m_value, output reg clk = 0);
    reg[31:0]counter = 0;
    always @(posedge CLOCK)
    begin
    counter <= (counter == my_m_value) ? 0 : counter + 1; // 6.25 MHz
    clk <= (counter == 0) ? ~clk : clk;
    end  
endmodule

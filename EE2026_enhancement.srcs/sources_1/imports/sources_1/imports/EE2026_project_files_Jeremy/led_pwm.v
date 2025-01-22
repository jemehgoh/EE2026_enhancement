`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.10.2024 09:55:05
// Design Name: 
// Module Name: led_pwm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 8-bit PWM module (at 25MHz frequency)
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module led_pwm(input clk25m, input [7:0] compare, output reg led_signal = 0);
    
    reg [7:0] counter = 0;
    
    always @ (posedge clk25m) begin
        if (counter == 0) begin
            led_signal <= 1;
        end
        else if (counter == compare) begin
            led_signal <= 0;
        end
        
        counter <= counter + 1;
    end
endmodule

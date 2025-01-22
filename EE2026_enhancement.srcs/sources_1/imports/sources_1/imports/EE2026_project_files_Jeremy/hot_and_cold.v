`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2024 09:53:06
// Design Name: 
// Module Name: hot_and_cold
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


module hot_and_cold(input clk25m, clk10, enable, difficulty, input [13:0] closest_distance,
    output reg [4:0] led = 0);
    
    wire pwm_signal;
    
    reg [7:0] compare = 0;
    
    // 8-bit PWM module
    led_pwm l_pwm (.clk25m(clk25m), .compare(compare), .led_signal(pwm_signal));
    
    always @ (posedge clk25m, negedge enable) begin
        if (enable == 0) begin
            led <= 5'b00000;
            compare <= 0;
        end
        else if (difficulty == 0) begin
            // Enable system if difficulty is easy (0 == easy, 1 == hard)
            if (closest_distance <= 32) begin
                led[4] <= clk10;
                led[3] <= clk10;
                led[2] <= clk10;
                led[1] <= clk10;
                led[0] <= clk10;
            end
            else if (closest_distance <= 72) begin
                compare <= 255 - ((closest_distance * (63 - 0)) / (72 - 33));
                led[4] <= 0;
                led[3] <= pwm_signal;
                led[2] <= pwm_signal;
                led[1] <= pwm_signal;
                led[0] <= pwm_signal;                 
            end
            else if (closest_distance <= 128) begin 
                compare <= 255 - ((closest_distance * (127 - 64)) / (128 - 73));
                led[4:3] <= 2'b00;
                led[2] <= pwm_signal;
                led[1] <= pwm_signal;
                led[0] <= pwm_signal;                
            end
            else if (closest_distance <= 200) begin 
                compare <= 255 - ((closest_distance * (191 - 128)) / (200 - 129));
                led[4:2] <= 3'b000;
                led[1] <= pwm_signal;
                led[0] <= pwm_signal;
            end
            else if (closest_distance <= 288) begin 
                compare <= 255 - ((closest_distance * (255 - 192)) / (288 - 201));
                led[4:1] <= 4'b0000;
                led[0] <= pwm_signal;
            end
            else begin 
                led <= 5'b00000;
            end                                  
        end
    end
endmodule

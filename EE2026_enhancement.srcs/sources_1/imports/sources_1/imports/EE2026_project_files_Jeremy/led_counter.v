`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2024 14:47:48
// Design Name: 
// Module Name: led_counter
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


module led_counter(input clk25m, enable, difficulty, output reg [4:0] led = 5'b00000,
        output reg done = 0);
        
    wire clk640, pwm_signal;
    
    reg [7:0] led_brightness = 255;
    reg [2:0] led_count = 5;
    
    flexible_clock cd640 (clk25m, 32'd19531, clk640);

    // 8-bit PWM module
    led_pwm l_pwm (.clk25m(clk25m), .compare(led_brightness), .led_signal(pwm_signal));    
    
    always @ (posedge clk640, negedge enable) begin
        if (enable == 0) begin
            led <= 5'b00000;
            led_brightness <= 255;
            led_count <= 5;
            done <= 0;
        end
        else begin
            if (led_count == 5) begin
                led_brightness <= led_brightness - 1;
                
                if (difficulty == 0) begin
                    led[4] <= pwm_signal;
                    led[3:0] <= 4'b1111;
                end
                else begin
                    led[4] <= ~pwm_signal;                
                    led[3:1] <= 3'b000;
                    led[0] <= ~pwm_signal;
                end
                
                led_count <= (led_brightness == 0) ? led_count - 1 : led_count; 
            end
            else if (led_count == 4) begin
                led_brightness <= led_brightness - 1;
                
                if (difficulty == 0) begin
                    led[4] <= 1'b0;
                    led[3] <= pwm_signal;
                    led[2:0] <= 3'b111; 
                end
                else begin
                    led[4] <= 1'b1;
                    led[3] <= ~pwm_signal;                
                    led[2] <= 1'b0;
                    led[1] <= ~pwm_signal; 
                    led[0] <= 1'b1;               
                end    
                           
                led_count <= (led_brightness == 0) ? led_count - 1 : led_count; 
            end
            else if (led_count == 3) begin
                led_brightness <= led_brightness - 1;
                
                if (difficulty == 0) begin
                    led[4:3] <= 2'b00;
                    led[2] <= pwm_signal;
                    led[1:0] <= 2'b11;
                end
                else begin
                    led[4:3] <= 2'b11;
                    led[2] <= ~pwm_signal;
                    led[1:0] <= 2'b11;
                end                 
                led_count <= (led_brightness == 0) ? led_count - 1 : led_count; 
            end
            else if (led_count == 2) begin
                led_brightness <= led_brightness - 1;
                
                if (difficulty == 0) begin
                    led[4:2] <= 3'b000;
                    led[1] <= pwm_signal;
                    led[0] <= 1'b1;
                end
                else begin
                    led[4] <= pwm_signal;                
                    led[3:1] <= 3'b111;
                    led[0] <= pwm_signal;                
                end
                                       
                led_count <= (led_brightness == 0) ? led_count - 1 : led_count; 
            end  
            else if (led_count == 1) begin
                led_brightness <= led_brightness - 1;
                
                if (difficulty == 0) begin
                    led[4:1] <= 4'b0000;
                    led[0] <= pwm_signal;
                end 
                else begin
                    led[4] <= 1'b0;                
                    led[3] <= pwm_signal;
                    led[2] <= pwm_signal;
                    led[1] <= pwm_signal;
                    led[0] <= 1'b0;                 
                end            
                     
                led_count <= (led_brightness == 0) ? led_count - 1 : led_count; 
            end  
            else begin
                done <= 1;              
            end                                            
        end
    end
endmodule

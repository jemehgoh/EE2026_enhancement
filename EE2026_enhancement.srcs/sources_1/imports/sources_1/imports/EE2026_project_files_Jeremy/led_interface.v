`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.10.2024 15:21:30
// Design Name: 
// Module Name: led_interface
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


module led_interface(input clk25m, enable, difficulty, correct, wrong, input [13:0] closest_distance,
        output reg [4:0] led = 5'b00000, output reg hold = 0);
    
    parameter HAC = 2'b01;
    parameter COUNTER = 2'b10;
    parameter WRONG = 2'b11;
    
    reg [1:0] mode;
    wire [4:0] hac_led;
    wire [4:0] counter_led;
    wire done, clk10;
 
    // 10 Hz clock divider
    flexible_clock cd10 (clk25m, 32'd1_249_999, clk10);
       
    // Component modules - led signal generators  
    hot_and_cold hac (.clk25m(clk25m), .clk10(clk10), .enable(mode[0]), .difficulty(difficulty), 
            .closest_distance(closest_distance), .led(hac_led)); 
    led_counter l_ctr (.clk25m(clk25m), .enable(mode[1]), .difficulty(difficulty), .led(counter_led),
            .done(done));   
    
    always @ (posedge clk25m, negedge enable) begin
        if (enable == 0) begin
            mode <= 0;
            led <= 5'b00000;
            hold <= 0;
        end
        else begin
            if (mode == COUNTER) begin
                led <= counter_led;
                mode <= (done == 1) ? HAC : COUNTER;
                hold <= 1;
            end
            else if (mode == WRONG) begin
                led <= hac_led;
                mode <= (done == 1) ? HAC : WRONG;
                hold <= 1;              
            end
            else begin
                led <= hac_led;
                mode <= (correct == 1) ? COUNTER : ((wrong == 1) ? WRONG : HAC);
                hold <= (correct == 1 || wrong == 1) ? 1 : 0;
            end
        end
    end      
endmodule

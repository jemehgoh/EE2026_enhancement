`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.10.2024 10:27:11
// Design Name: 
// Module Name: entity_click_detector
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


module entity_click_detector(input clk1k, enable, input [7:0] cursor_matches, input deb_mouse_l, input hold,
    output reg correct = 0, output reg wrong = 0, output reg [7:0] selected_entity = 0);
        
    always @ (posedge clk1k) begin
        if (enable == 0) begin
            correct <= 0;
            wrong <= 0;
            selected_entity <= 0;
        end
        else if (deb_mouse_l == 1 && hold == 0) begin
            // Only correct if cursor is close enough to entity
            if (cursor_matches[0]) begin
                correct <= 1;
                wrong <= 0;
                selected_entity[0] <= 1;
            end
            else if (cursor_matches[1]) begin
                correct <= 1;
                wrong <= 0;
                selected_entity[1] <= 1;
            end
            else if (cursor_matches[2]) begin
                correct <= 1;
                wrong <= 0;
                selected_entity[2] <= 1;
            end
            else if (cursor_matches[3]) begin
                correct <= 1;
                wrong <= 0;
                selected_entity[3] <= 1;
            end
            else if (cursor_matches[4]) begin
                correct <= 1;
                wrong <= 0;
                selected_entity[4] <= 1;
            end
            else if (cursor_matches[5]) begin
                correct <= 1;
                wrong <= 0;
                selected_entity[5] <= 1;
            end
            else if (cursor_matches[6]) begin
                correct <= 1;
                wrong <= 0;
                selected_entity[6] <= 1;
            end
            else if (cursor_matches[7]) begin
                correct <= 1;
                wrong <= 0;
                selected_entity[7] <= 1;
            end
            else begin
                correct <= 0;
                wrong <= 1;
            end           
        end
        else begin
            correct <= 0;
            wrong <= 0;
        end
    end
endmodule

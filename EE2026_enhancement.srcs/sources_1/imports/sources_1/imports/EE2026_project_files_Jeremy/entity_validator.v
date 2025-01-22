`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.10.2024 16:02:33
// Design Name: 
// Module Name: entity_validator
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


module entity_validator(input clk25m, entity_enable, entity_selected, 
        input [13:0] cursor_sq_dist, output reg [13:0] valid_sq_dist = 9216);

    always @ (posedge clk25m) begin
        if (entity_enable && !entity_selected) begin
            valid_sq_dist <= cursor_sq_dist;
        end
        else begin
            valid_sq_dist <= 9216;
        end
    end
endmodule

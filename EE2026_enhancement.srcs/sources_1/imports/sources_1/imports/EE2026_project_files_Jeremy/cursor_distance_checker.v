`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2024 10:59:21
// Design Name: 
// Module Name: cursor_distance_checker
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


module cursor_distance_checker(input clk25m, enable,
        entity_0_en, entity_1_en, entity_2_en, entity_3_en,
        entity_4_en, entity_5_en, entity_6_en, entity_7_en,
        input [6:0] cursor_x,
        entity_0_centre_x, entity_1_centre_x, entity_2_centre_x, entity_3_centre_x,
        entity_4_centre_x, entity_5_centre_x, entity_6_centre_x, entity_7_centre_x, 
        input [5:0] cursor_y,
        entity_0_centre_y, entity_1_centre_y, entity_2_centre_y, entity_3_centre_y,
        entity_4_centre_y, entity_5_centre_y, entity_6_centre_y, entity_7_centre_y,  
        input [7:0] selected_entity,
        output reg [7:0] entity_select = 0, output [13:0] closest_distance);
    
    wire [13:0] cursor_x_dist_0, cursor_y_dist_0, cursor_sq_dist_0, valid_sq_dist_0; 
    wire [13:0] cursor_x_dist_1, cursor_y_dist_1, cursor_sq_dist_1, valid_sq_dist_1;     
    wire [13:0] cursor_x_dist_2, cursor_y_dist_2, cursor_sq_dist_2, valid_sq_dist_2; 
    wire [13:0] cursor_x_dist_3, cursor_y_dist_3, cursor_sq_dist_3, valid_sq_dist_3;     
    wire [13:0] cursor_x_dist_4, cursor_y_dist_4, cursor_sq_dist_4, valid_sq_dist_4; 
    wire [13:0] cursor_x_dist_5, cursor_y_dist_5, cursor_sq_dist_5, valid_sq_dist_5;     
    wire [13:0] cursor_x_dist_6, cursor_y_dist_6, cursor_sq_dist_6, valid_sq_dist_6; 
    wire [13:0] cursor_x_dist_7, cursor_y_dist_7, cursor_sq_dist_7, valid_sq_dist_7; 
    
    // Cursor distance computations
    assign cursor_x_dist_0 = {7'b0, (cursor_x > entity_0_centre_x) ? 
            (cursor_x - entity_0_centre_x) : (entity_0_centre_x - cursor_x)};
    assign cursor_y_dist_0 = {8'b0, (cursor_y > entity_0_centre_y) ? 
            (cursor_y - entity_0_centre_y) : (entity_0_centre_y - cursor_y)};
    
    assign cursor_sq_dist_0 = (cursor_x_dist_0 * cursor_x_dist_0) + 
            (cursor_y_dist_0 * cursor_y_dist_0); 
          
    assign cursor_x_dist_1 = {7'b0, (cursor_x > entity_1_centre_x) ? 
            (cursor_x - entity_1_centre_x) : (entity_1_centre_x - cursor_x)};
    assign cursor_y_dist_1 = {8'b0, (cursor_y > entity_1_centre_y) ? 
            (cursor_y - entity_1_centre_y) : (entity_1_centre_y - cursor_y)};
            
    assign cursor_sq_dist_1 = (cursor_x_dist_1 * cursor_x_dist_1) + 
            (cursor_y_dist_1 * cursor_y_dist_1);
            
    assign cursor_x_dist_2 = {7'b0, (cursor_x > entity_2_centre_x) ? 
            (cursor_x - entity_2_centre_x) : (entity_2_centre_x - cursor_x)};
    assign cursor_y_dist_2 = {8'b0, (cursor_y > entity_2_centre_y) ? 
            (cursor_y - entity_2_centre_y) : (entity_2_centre_y - cursor_y)};
    
    assign cursor_sq_dist_2 = (cursor_x_dist_2 * cursor_x_dist_2) + 
            (cursor_y_dist_2 * cursor_y_dist_2); 
          
    assign cursor_x_dist_3 = {7'b0, (cursor_x > entity_3_centre_x) ? 
            (cursor_x - entity_3_centre_x) : (entity_3_centre_x - cursor_x)};
    assign cursor_y_dist_3 = {8'b0, (cursor_y > entity_3_centre_y) ? 
            (cursor_y - entity_3_centre_y) : (entity_3_centre_y - cursor_y)};
            
    assign cursor_sq_dist_3 = (cursor_x_dist_3 * cursor_x_dist_3) + 
            (cursor_y_dist_3 * cursor_y_dist_3);
            
    assign cursor_x_dist_4 = {7'b0, (cursor_x > entity_4_centre_x) ? 
            (cursor_x - entity_4_centre_x) : (entity_4_centre_x - cursor_x)};
    assign cursor_y_dist_4 = {8'b0, (cursor_y > entity_4_centre_y) ? 
            (cursor_y - entity_4_centre_y) : (entity_4_centre_y - cursor_y)};
    
    assign cursor_sq_dist_4 = (cursor_x_dist_4 * cursor_x_dist_4) + 
            (cursor_y_dist_4 * cursor_y_dist_4); 
          
    assign cursor_x_dist_5 = {7'b0, (cursor_x > entity_5_centre_x) ? 
            (cursor_x - entity_5_centre_x) : (entity_5_centre_x - cursor_x)};
    assign cursor_y_dist_5 = {8'b0, (cursor_y > entity_5_centre_y) ? 
            (cursor_y - entity_5_centre_y) : (entity_5_centre_y - cursor_y)};
            
    assign cursor_sq_dist_5 = (cursor_x_dist_5 * cursor_x_dist_5) + 
            (cursor_y_dist_5 * cursor_y_dist_5);
            
    assign cursor_x_dist_6 = {7'b0, (cursor_x > entity_6_centre_x) ? 
            (cursor_x - entity_6_centre_x) : (entity_6_centre_x - cursor_x)};
    assign cursor_y_dist_6 = {8'b0, (cursor_y > entity_6_centre_y) ? 
            (cursor_y - entity_6_centre_y) : (entity_6_centre_y - cursor_y)};
    
    assign cursor_sq_dist_6 = (cursor_x_dist_6 * cursor_x_dist_6) + 
            (cursor_y_dist_6 * cursor_y_dist_6); 
          
    assign cursor_x_dist_7 = {7'b0, (cursor_x > entity_7_centre_x) ? 
            (cursor_x - entity_7_centre_x) : (entity_7_centre_x - cursor_x)};
    assign cursor_y_dist_7 = {8'b0, (cursor_y > entity_7_centre_y) ? 
            (cursor_y - entity_7_centre_y) : (entity_7_centre_y - cursor_y)};
            
    assign cursor_sq_dist_7 = (cursor_x_dist_7 * cursor_x_dist_7) + 
            (cursor_y_dist_7 * cursor_y_dist_7);
    
    entity_validator ev0 (.clk25m(clk25m), .entity_enable(entity_0_en), 
            .entity_selected(selected_entity[0]), .cursor_sq_dist(cursor_sq_dist_0), 
            .valid_sq_dist(valid_sq_dist_0));
    entity_validator ev1 (.clk25m(clk25m), .entity_enable(entity_1_en), 
            .entity_selected(selected_entity[1]), .cursor_sq_dist(cursor_sq_dist_1), 
            .valid_sq_dist(valid_sq_dist_1));      
    entity_validator ev2 (.clk25m(clk25m), .entity_enable(entity_2_en), 
            .entity_selected(selected_entity[2]), .cursor_sq_dist(cursor_sq_dist_2), 
            .valid_sq_dist(valid_sq_dist_2));
    entity_validator ev3 (.clk25m(clk25m), .entity_enable(entity_3_en), 
            .entity_selected(selected_entity[3]), .cursor_sq_dist(cursor_sq_dist_3), 
            .valid_sq_dist(valid_sq_dist_3));      
    entity_validator ev4 (.clk25m(clk25m), .entity_enable(entity_4_en), 
            .entity_selected(selected_entity[4]), .cursor_sq_dist(cursor_sq_dist_4), 
            .valid_sq_dist(valid_sq_dist_4));
    entity_validator ev5 (.clk25m(clk25m), .entity_enable(entity_5_en), 
            .entity_selected(selected_entity[5]), .cursor_sq_dist(cursor_sq_dist_5), 
            .valid_sq_dist(valid_sq_dist_5));      
    entity_validator ev6 (.clk25m(clk25m), .entity_enable(entity_6_en), 
            .entity_selected(selected_entity[6]), .cursor_sq_dist(cursor_sq_dist_6), 
            .valid_sq_dist(valid_sq_dist_6));
    entity_validator ev7 (.clk25m(clk25m), .entity_enable(entity_7_en), 
            .entity_selected(selected_entity[7]), .cursor_sq_dist(cursor_sq_dist_7), 
            .valid_sq_dist(valid_sq_dist_7));            
            
    cursor_distance_comparator cdc (.cursor_dist_0(valid_sq_dist_0), .cursor_dist_1(valid_sq_dist_1),
            .cursor_dist_2(valid_sq_dist_2), .cursor_dist_3(valid_sq_dist_3), .cursor_dist_4(valid_sq_dist_4), 
            .cursor_dist_5(valid_sq_dist_5), .cursor_dist_6(valid_sq_dist_6), .cursor_dist_7(valid_sq_dist_7), 
            .closest_distance(closest_distance));
            
    always @ (posedge clk25m, negedge enable) begin
        if (enable == 0) begin
            entity_select <= 0;
        end
        else begin
            if (entity_0_en && valid_sq_dist_0 <= 16) begin
                entity_select[0] <= 1;
            end
            else if (entity_1_en && valid_sq_dist_1 <= 16) begin
                entity_select[1] <= 1;
            end
            else if (entity_2_en && valid_sq_dist_2 <= 16) begin
                entity_select[2] <= 1;
            end
            else if (entity_3_en && valid_sq_dist_3 <= 16) begin
                entity_select[3] <= 1;
            end
            else if (entity_4_en && valid_sq_dist_4 <= 16) begin
                entity_select[4] <= 1;
            end
            else if (entity_5_en && valid_sq_dist_5 <= 16) begin
                entity_select[5] <= 1;
            end
            else if (entity_6_en && valid_sq_dist_6 <= 16) begin
                entity_select[6] <= 1;
            end
            else if (entity_7_en && valid_sq_dist_7 <= 16) begin
                entity_select[7] <= 1;
            end
            else begin
                entity_select <= 0;
            end
        end
    end
     
endmodule

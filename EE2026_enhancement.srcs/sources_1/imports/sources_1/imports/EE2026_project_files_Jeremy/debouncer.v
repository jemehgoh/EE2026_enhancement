`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.10.2024 23:56:15
// Design Name: 
// Module Name: debouncer
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


module debouncer(input clk1k, btn, output reg deb_btn = 0);
    reg [31:0] counter = 1;
    reg can_update = 1;
    
    always @ (posedge clk1k) begin
        if (btn == 1 && can_update == 1) begin
            deb_btn <= btn;
            counter <= 1;
            can_update <= 0;
        end
        else if (can_update == 0) begin
            deb_btn <= 0;
            counter <= (counter == 200) ? 0 : counter + 1;
            can_update <= (counter == 0) ? 1 : 0;
        end
        else begin
            deb_btn <= btn;
        end
    end
endmodule

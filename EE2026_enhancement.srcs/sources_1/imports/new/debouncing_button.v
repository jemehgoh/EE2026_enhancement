`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2024 12:53:18 AM
// Design Name: 
// Module Name: debouncing_button
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


module debouncing_button(input CLOCK, input sw, output reg debounced_btn=0);
wire clk_1kHz;
reg [31:0] my_1k_value = 32'd49999;
flexible_clock clk1k(CLOCK, my_1k_value, clk_1kHz);

reg flag = 0;
reg [31:0] counter = 32'd0;

always @(posedge clk_1kHz)
begin
    if (sw && counter == 0)
    begin
    debounced_btn <= 1;
    flag <= 1;
    end

    if(flag == 1)
    begin
    debounced_btn <= 0;
    counter = (counter == 200) ? counter == 200 : counter +1 ;
    
        if (counter == 200 && sw == 0)
        begin
        flag <= 0;
        counter <= 32'd0;
        end
        
    end
     
end
endmodule

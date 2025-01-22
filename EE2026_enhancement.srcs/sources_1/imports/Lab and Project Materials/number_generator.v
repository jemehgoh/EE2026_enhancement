`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2024 10:07:42
// Design Name: 
// Module Name: number_generator
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


module pseudo_generator(input clock, input EN, output reg [7:0] Q = 0);

    always @ (posedge clock) begin
        if (~EN) begin
            Q <= {~(Q[5]^Q[4]), ~Q[7], Q[1]&Q[2], Q[3], Q[2], Q[1], Q[0], Q[7]};
        end
        else begin
            Q <= Q;
        end
    end

endmodule

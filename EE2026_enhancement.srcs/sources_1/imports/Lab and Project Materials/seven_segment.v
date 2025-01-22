`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2024 09:59:02
// Design Name: 
// Module Name: seven_segment
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



module seven_seg_control(input EN, reset, correct_answer, wrong_answer, clock_5hz, clock_400hz, clock_1Khz, input [7:0] number,
output reg [3:0] an = 4'b1111, output reg [7:0] seg = 8'b1111_1111, output reg ending_screen = 0);
    reg [2:0] state = 0; //correct
    reg [2:0] state2 = 0; //spot it
    reg [3:0] state3 = 0; //try again
    reg [3:0] state4 = 0; //good job
    reg [1:0] counter = 0; //counter to output the 7-seg
    reg [3:0] difference_count = 0; //track the difference_count
    reg [3:0] difference_found = 0;
    reg difference_flag = 0;
    reg [3:0] difference_left = 0;
    reg correct_answer_flag = 0;
    reg wrong_answer_flag = 0;
    reg [11:0] counter1 = 0;
    

    always @ (posedge clock_5hz) begin
        if (ending_screen) begin
            state4 = (state4 == 8) ? 0 : state4 + 1;
        end
        else if (~ending_screen & ~EN) begin
            state2 = (state2 == 7) ? 0 : state2 + 1;
        end
        else if (~ending_screen & EN & (wrong_answer | wrong_answer_flag)) begin
            state3 = (state3 == 9) ? 0 : state3 + 1;
        end
        
        else if (~ending_screen & EN & ~(wrong_answer | wrong_answer_flag) & (correct_answer | correct_answer_flag)) begin
            state = (state == 7) ? 0 : state + 1;
        end
        else if (~ending_screen & EN & ~wrong_answer & ~correct_answer) begin
            state = 0;
            state2 = 0;
            state3 = 0;
            state4 = 0;
        end
    end
    
    always @ (posedge clock_400hz) begin
        counter <= (counter == 2'b11) ? 0 : counter + 1;
    end
    
    always @ (posedge clock_1Khz) begin
        if (correct_answer_flag | wrong_answer_flag) begin
            counter1 = (counter1 == 2000) ? 0 : counter1 + 1;
        end
        else begin
            counter1 = 0;
        end
        if (reset) begin
            ending_screen = 0;
        end
        else if (~reset & ending_screen) begin
            if (state4 == 0) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1010_0001) : (8'b1100_0000)) : (counter[0] ? (8'b1100_0000) : (8'b1100_0010)));
            end
            else if (state4 == 1) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1111_1111) : (8'b1010_0001)) : (counter[0] ? (8'b1100_0000) : (8'b1100_0000)));
            end
            else if (state4 == 2) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1111_0001) : (8'b1111_1111)) : (counter[0] ? (8'b1010_0001) : (8'b1100_0000)));
            end
            else if (state4 == 3) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1100_0000) : (8'b1111_0001)) : (counter[0] ? (8'b1111_1111) : (8'b1010_0001)));
            end
            else if (state4 == 4) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1000_0011) : (8'b1100_0000)) : (counter[0] ? (8'b1111_0001) : (8'b1111_1111)));
            end
            else if (state4 == 5) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1111_1111) : (8'b1000_0011)) : (counter[0] ? (8'b1100_0000) : (8'b1111_0001)));
            end
            else if (state4 == 6) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1100_0010) : (8'b1111_1111)) : (counter[0] ? (8'b1000_0011) : (8'b1100_0000)));
            end
            else if (state4 == 7) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1100_0000) : (8'b1100_0010)) : (counter[0] ? (8'b1111_1111) : (8'b1000_0011)));
            end
            else if (state4 == 8) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1100_0000) : (8'b1100_0000)) : (counter[0] ? (8'b1100_0010) : (8'b1111_1111)));
            end
        end
        else if (~reset & ~ending_screen & ~EN) begin
            difference_found <= 0;
            difference_count <= 0;
            difference_flag <= 0;
            if (state2 == 0) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1000_0111) : (8'b1100_0000)) : (counter[0] ? (8'b1000_1100) : (8'b1001_0010)));
            end
            else if (state2 == 1) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1111_1111) : (8'b1000_0111)) : (counter[0] ? (8'b1100_0000) : (8'b1000_1100)));
            end
            else if (state2 == 2) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1111_1001) : (8'b1111_1111)) : (counter[0] ? (8'b1000_0111) : (8'b1100_0000)));
            end
            else if (state2 == 3) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1000_0111) : (8'b1111_1001)) : (counter[0] ? (8'b1111_1111) : (8'b1000_0111)));
            end
            else if (state2 == 4) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1111_1111) : (8'b1000_0111)) : (counter[0] ? (8'b1111_1001) : (8'b1111_1111)));
            end
            else if (state2 == 5) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1001_0010) : (8'b1111_1111)) : (counter[0] ? (8'b1000_0111) : (8'b1111_1001)));
            end
            else if (state2 == 6) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1000_1100) : (8'b1001_0010)) : (counter[0] ? (8'b1111_1111) : (8'b1000_0111)));
            end
            else if (state2 == 7) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1100_0000) : (8'b1000_1100)) : (counter[0] ? (8'b1001_0010) : (8'b1111_1111)));
            end
        end
        else if (~reset & EN & ~ending_screen & (wrong_answer | wrong_answer_flag)) begin
            if (wrong_answer & (wrong_answer_flag == 0)) begin
                wrong_answer_flag = 1;
            end
            else if ((wrong_answer_flag == 1) & (counter1 == 0)) begin
                wrong_answer_flag = 0;
            end
            difference_flag <= 0;
            if (state3 == 0) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1111_1111) : (8'b1001_1001)) : (counter[0] ? (8'b1010_1111) : (8'b1000_0111)));
            end
            else if (state3 == 1) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1000_1000) : (8'b1111_1111)) : (counter[0] ? (8'b1001_1001) : (8'b1010_1111)));
            end
            else if (state3 == 2) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1100_0010) : (8'b1000_1000)) : (counter[0] ? (8'b1111_1111) : (8'b1001_1001)));
            end
            else if (state3 == 3) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1000_1000) : (8'b1100_0010)) : (counter[0] ? (8'b1000_1000) : (8'b1111_1111)));
            end
            else if (state3 == 4) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1111_1001) : (8'b1000_1000)) : (counter[0] ? (8'b1100_0010) : (8'b1000_1000)));
            end
            else if (state3 == 5) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1100_1000) : (8'b1111_1001)) : (counter[0] ? (8'b1000_1000) : (8'b1100_0010)));
            end
            else if (state3 == 6) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1111_1111) : (8'b1100_1000)) : (counter[0] ? (8'b1111_1001) : (8'b1000_1000)));
            end
            else if (state3 == 7) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1000_0111) : (8'b1111_1111)) : (counter[0] ? (8'b1100_1000) : (8'b1111_1001)));
            end
            else if (state3 == 8) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1010_1111) : (8'b1000_0111)) : (counter[0] ? (8'b1111_1111) : (8'b1100_1000)));
            end
            else if (state3 == 9) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1001_1001) : (8'b1010_1111)) : (counter[0] ? (8'b1000_0111) : (8'b1111_1111)));
            end
        end
        else if (~reset & EN & ~ending_screen & ~(wrong_answer | wrong_answer_flag) & (correct_answer | correct_answer_flag)) begin
            if (correct_answer & (correct_answer_flag == 0)) begin
                correct_answer_flag = 1;
            end
            else if ((correct_answer_flag == 1) & (counter1 == 0)) begin
                correct_answer_flag = 0;
            end
            if (difference_flag == 0) begin
                difference_found <= difference_found + 1;
                difference_flag = 1;
            end
            if (state == 0) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1010_1111) : (8'b1010_1111)) : (counter[0] ? (8'b1010_0011) : (8'b1010_0111)));
            end
            else if (state == 1) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1000_0110) : (8'b1010_1111)) : (counter[0] ? (8'b1010_1111) : (8'b1010_0011)));
            end
            else if (state == 2) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1010_0111) : (8'b1000_0110)) : (counter[0] ? (8'b1010_1111) : (8'b1010_1111)));
            end
            else if (state == 3) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1000_0111) : (8'b1010_0111)) : (counter[0] ? (8'b1000_0110) : (8'b1010_1111)));
            end
            else if (state == 4) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1111_1111) : (8'b1000_0111)) : (counter[0] ? (8'b1010_0111) : (8'b1000_0110)));
            end
            else if (state == 5) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1010_0111) : (8'b1111_1111)) : (counter[0] ? (8'b1000_0111) : (8'b1010_0111)));
            end
            else if (state == 6) begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1010_0011) : (8'b1010_0111)) : (counter[0] ? (8'b1111_1111) : (8'b1000_0111)));
            end
            else begin
                an <= (counter[1] ? (counter[0] ? (4'b1110) : (4'b1101)) : (counter[0] ? (4'b1011) : (4'b0111)));
                seg <= (counter[1] ? (counter[0] ? (8'b1010_1111) : (8'b1010_0011)) : (counter[0] ? (8'b1010_0111) : (8'b1111_1111)));
            end
        end
        else begin
            difference_flag <= 0;
            if (difference_count == 0) begin
                if (~number[0]) begin
                    difference_count = difference_count + 1;
                end
                if (~number[1]) begin
                    difference_count = difference_count + 1;
                end
                if (~number[2]) begin
                    difference_count = difference_count + 1;
                end
                if (~number[3]) begin
                    difference_count = difference_count + 1;
                end
                if (~number[4]) begin
                    difference_count = difference_count + 1;
                end
                if (~number[5]) begin
                    difference_count = difference_count + 1;
                end
                if (~number[6]) begin
                    difference_count = difference_count + 1;
                end
                if (~number[7]) begin
                    difference_count = difference_count + 1;
                end
            end
            difference_left = difference_count - difference_found;
            an <= 4'b1110;
            if (difference_left == 1) begin
                seg <= 8'b1111_1001;
            end
            else if (difference_left == 2) begin
                seg <= 8'b1010_0100;
            end
            else if (difference_left == 3) begin
                seg <= 8'b1011_0000;
            end
            else if (difference_left == 4) begin
                seg <= 8'b1001_1001;
            end
            else if (difference_left == 5) begin
                seg <= 8'b1001_0010;
            end
            else if (difference_left == 6) begin
                seg <= 8'b1000_0010;
            end
            else if (difference_left == 7) begin
                seg <= 8'b1111_1000;
            end
            else if (difference_left == 8) begin
                seg <= 8'b1000_0000;
            end
            else begin
                seg <= 8'b1100_0000;
            end
            if (difference_left == 0) begin
                ending_screen = 1;
            end
        end
    end
endmodule


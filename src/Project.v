`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:05:02 04/17/2025 
// Design Name: 
// Module Name:    Project
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Project(
    input wire G1,
    input wire A1,
    input wire B1,
    output reg Y10,
    output reg Y11,
    output reg Y12,
    output reg Y13,

    input wire G2,
    input wire A2,
    input wire B2,
    output reg Y20,
    output reg Y21,
    output reg Y22,
    output reg Y23
);

    wire [1:0] sel1 = {B1, A1};
    wire [1:0] sel2 = {B2, A2};

    always @(*) begin
        {Y10, Y11, Y12, Y13} = 4'b1111;
        if (G1 == 1'b0) begin
            case (sel1)
                2'b00: Y10 = 1'b0;
                2'b01: Y11 = 1'b0;
                2'b01: Y11 = 1'b0;
                2'b10: Y12 = 1'b0;
                2'b11: Y13 = 1'b0;
            endcase
        end
    end

    always @(*) begin
        {Y20, Y21, Y22, Y23} = 4'b1111;
        if (G2 == 1'b0) begin
            case (sel2)
                2'b00: Y20 = 1'b0;
                2'b01: Y21 = 1'b0;
                2'b10: Y22 = 1'b0;
                2'b11: Y23 = 1'b0;
            endcase
        end
    end

endmodule

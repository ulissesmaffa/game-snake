`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.12.2022 14:40:00
// Design Name: 
// Module Name: game_snake
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


module mem
import game_snake_pkg::*;
(
    input logic clk, 
    input logic clr,
    input logic [7:0] data_a,
    input logic [7:0] data_b,
    input logic wren_a,
    input logic wren_b,
    input logic [5:0] address_a,
    input logic [5:0] address_b,
    input logic byreena_a,
    output logic [7:0] q_a,
    output logic [7:0] q_b    
);



endmodule
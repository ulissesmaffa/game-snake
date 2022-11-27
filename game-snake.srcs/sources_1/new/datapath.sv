`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2022 11:25:07
// Design Name: 
// Module Name: datapath
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


module datapath
import game_snake_pkg::*;
(
    input logic rst_n,
    input logic clk,
    input logic dp_ctrl,
    output logic dp_flag
);

    logic [7:0][7:0] ram [7:0];
    logic [7:0]  reg_head;
    logic [7:0]  reg_2;
    logic [63:0][7:0] fifo;


endmodule

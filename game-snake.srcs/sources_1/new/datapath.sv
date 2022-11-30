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
    control_snake_if.slave ctrl
);

    logic [7:0][7:0] ram [7:0];
    logic [7:0]  reg_head = '{ default : 'd1};
    logic [7:0]  reg_2    = '{ default : 'd0};
    logic [63:0][7:0] fifo;

    always_comb begin
        if(ctrl.fsm_init_signal_x_start)begin
            reg_head = 8'b00000000;
        end
    end


endmodule

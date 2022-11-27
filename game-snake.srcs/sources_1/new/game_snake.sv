`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2022 11:25:07
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


module game_snake
import game_snake_pkg::*;
(
    input logic rst_n,
    input logic clk,
    input logic [3:0] buttons
);


    decoded_direction_type direction_sync_s;
    logic cnt_rdy_s;
    logic dp_ctrl_s;
    logic dp_flag_s;
    
    button_handler button_handler_i(
        .rst_n(rst_n),
        .clk(clk),
        .direction_sync(direction_sync_s),
        .cnt_rdy(cnt_rdy_s),
        .buttons(buttons)
    );
    
    step_counter step_counter_i(
        .rst_n(rst_n),
        .clk(clk),
        .cnt_rdy(cnt_rdy_s)
    );

    datapath datapath_i(
        .rst_n(rst_n),
        .clk(clk),
        .dp_ctrl(dp_ctrl_s),
        .dp_flag(dp_flag_s)
    );

    control_snake control_snake_i(
        .rst_n(rst_n),
        .clk(clk),
        .dp_ctrl(dp_ctrl_s),
        .dp_flag(dp_flag_s),
        .direction_sync(direction_sync_s),
        .cnt_rdy(cnt_rdy_s)
    );
    
endmodule
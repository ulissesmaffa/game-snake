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
    input  logic       clk,
    input  logic       rst_n,
    input  logic [3:0] sys_direction,
    input  logic       sys_step_jumper,
    input  logic [5:0] test_mem_b_addr,
    output logic       test_idle_state,
    output logic       test_go_state,
    output logic [7:0] test_mem_b_data
);


    direction                 sys_direction_synched_s;
    logic                     sys_step_jumper_synched_s;
    logic                     cnt_rdy_s;
    datapath_ctrl_flags       dp_ctrl_s;
    datapath_flags            dp_flags_s;
    logic               [5:0] mem_b_addr_s;
    logic               [7:0] mem_b_data_s;
    logic                     vga_if_clk_s;
    logic               [3:0] cnt_value_s;

    
    button_handler button_handler_i(
        .clk(clk),
        .rst_n(rst_n),
        .load_regs(cnt_rdy_s),
        .sys_direction(sys_direction),
        .sys_step_jumper(sys_step_jumper),
        .direction_sync(sys_direction_synched_s),
        .step_jumper_sync(sys_step_jumper_synched_s)
    );
    
    step_counter step_counter_i(
        .clk(clk),
        .rst_n(rst_n),
        .cnt_rdy(cnt_rdy_s),
        .cnt_value(cnt_value_s)
    );

    datapath datapath_i(
        .clk(clk),
        .rst_n(rst_n),
        .mem_b_addr(mem_b_addr_s),
        .ctrl_ctrl(dp_ctrl_s),
        .mem_b_data(mem_b_data_s),
        .ctrl_flags(dp_flags_s)
    );

    control_snake control_snake_i(
        .clk(clk),
        .rst_n(rst_n),
        .sys_direction(sys_direction_synched_s),
        .cnt_rdy(cnt_rdy_s),
        .dp_flags(dp_flags_s),
        .dp_ctrl(dp_ctrl_s),
        .test_idle_state(test_idle_state),
        .test_go_state(test_go_state)
    );

endmodule
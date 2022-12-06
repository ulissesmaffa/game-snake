`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2022 11:25:07
// Design Name: 
// Module Name: control_snake
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


module control_snake
import game_snake_pkg::*;
(
    input  logic               clk,
    input  logic               rst_n,
    input  direction           sys_direction,
    input  logic               cnt_rdy,
    input  datapath_flags      dp_flags,
    output datapath_ctrl_flags dp_ctrl,
    output logic               test_idle_state,
    output logic               test_go_state  
);

    // sinais da fsm_main para outras fsms
    logic init_start_s;
    logic food_start_s;
    logic step_start_s;
    // sinais das outras fsms para a fsm_main
    logic init_done_s;
    logic food_done_s;
    logic step_done_s;
    logic game_over_s;
    // sinais do control datapath
    CONTROL_SELECT select_fsm_s;
    datapath_ctrl_flags init_control_s;
    datapath_ctrl_flags food_control_s;
    datapath_ctrl_flags step_control_s;
    logic test_go_state_s = 'd0;

    fsm_main fsm_main_i(
        .clk(clk),
        .rst_n(rst_n),
        .cnt_rdy(cnt_rdy),
        .cmp_food_flag(dp_flags.cmp_food_flag),
        .fsm_i_done(init_done_s),
        .fsm_f_done(food_done_s),
        .fsm_s_done(step_done_s),
        .fsm_s_game_over(game_over_s),
        .con_sel(select_fsm_s),
        .fsm_i_start(init_start_s),
        .fsm_f_start(food_start_s),
        .fsm_s_start(step_start_s)     
    );

    fsm_init fsm_init_i(
        .clk(clk),
        .rst_n(rst_n),
        .fsm_m_start(init_start_s),
        .ofc_of_x(dp_flags.ofc_of_x),
        .ofc_of_y(dp_flags.ofc_of_y),
        .dp_ctrl(init_control_s),
        .fsm_m_done(init_done_s)
    );
 
    fsm_food fsm_food_i(
        .clk(clk),
        .rst_n(rst_n),
        .fsm_m_start(food_start_s),
        .cmp_body_flag(dp_flags.cmp_body_flag),
        .ofc_of_x(dp_flags.ofc_of_x),
        .dp_ctrl(food_control_s),
        .fsm_m_done(food_done_s)
    );

    fsm_step fsm_step_i(
        .clk(clk),
        .rst_n(rst_n),
        .fsm_m_start(step_start_s),
        .cmp_food_flag(dp_flags.cmp_food_flag),
        .cmp_body_flag(dp_flags.cmp_body_flag),
        .sys_direction(sys_direction),
        .dp_ctrl(step_control_s),
        .fsm_m_done(step_done_s),
        .fsm_m_game_over(game_over_s)
    );

    always_comb begin
        if (select_fsm_s == INIT_CON) begin
            dp_ctrl <= init_control_s;
        end
        else if (select_fsm_s == FOOD_CON) begin
            dp_ctrl <= food_control_s;
        end
        else if (select_fsm_s == STEP_CON) begin
            dp_ctrl <= step_control_s;
        end
    end

    assign test_idle_state = (~init_start_s) & (~food_start_s) & (~step_start_s);

    assign test_go_state = game_over_s;

    always @(game_over_s) begin
        if(game_over_s) begin
            test_go_state_s <= 'd1;
        end
    end


endmodule

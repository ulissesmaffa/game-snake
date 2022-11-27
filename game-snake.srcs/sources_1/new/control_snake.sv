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
    input logic rst_n,
    input logic clk,
    input logic cnt_rdy,
    input logic direction_sync,
    input dp_flag_type dp_flag,
    output dp_ctrl_type dp_ctrl
);

    logic start_init = 'b0;
    logic done_init = 'b0;
    logic start_food = 'b0;
    logic done_food = 'b0;
    logic start_step = 'b0;
    logic done_step = 'b0;

    typedef enum logic [2:0] {
        INIT_ACTIVATION = 4'h0,
        FOOD_ACTIVATION = 4'h1,
        IDLE            = 4'h2,
        STEP_ACTIVATION = 4'h3,
        GAME_OVER       = 4'h4
    } state_main_type;

    typedef enum logic [1:0] {
        READY       = 4'h0,
        RESET_ROW   = 4'h1,
        JUMP_ROW    = 4'h2,
        WRITTE_HEAD = 4'h3
    } state_init_type;

    typedef enum logic [1:0] {
        READY   = 4'h0,
        GEN_NUM = 4'h1,
        ADD_X   = 4'h2,
        ADD_Y   = 4'h3
    } state_food_type;

     typedef enum logic [1:0] {
        READY          = 4'h0,
        NEW_POSITION   = 4'h1,
        CHECK          = 4'h2,
        POP_WRITE_TAIL = 4'h3
     } state_step_type;

    state_main_type state_main = INIT_ACTIVATION;
    state_init_type state_init = READY;
    state_food_type state_food = READY;
    state_step_type state_step = READY;


    always_ff @(posedge clk) begin : FSM_MAIN
        if (~rst_n) begin
            state_main <= INIT_ACTIVATION;
        end else begin
            case (state_main)
                INIT_ACTIVATION: begin
                    if(done_init) begin
                        state_main <= FOOD_ACTIVATION;
                    end
                    else begin
                        state_main <= INIT_ACTIVATION;
                    end
                end

                FOOD_ACTIVATION: begin
                    if(done_food) begin
                        state_main <= IDLE;
                    end
                    else begin
                        state_main <= FOOD_ACTIVATION;
                    end
                end

                IDLE: begin
                    if(cnt_rdy) begin
                        state_main <= STEP_ACTIVATION;
                    end
                end

                STEP_ACTIVATION: begin
                    if(done_step) begin
                        if(dp_flag.comparator_signal == BODY) begin
                            state_main <= GAME_OVER;
                        end
                        else if(dp_flag.comparator_signal == FOOD) begin
                            state_main <= FOOD_ACTIVATION;
                        end
                        else begin
                            state_main <= IDLE;
                        end
                    end
                    else begin
                        state_main <= STEP_ACTIVATION;
                    end
                end

                GAME_OVER: begin
                    state_main <= GAME_OVER;
                end

            endcase 
        end
    end // FSM_MAIN

    always_comb begin
        case (state_main)
            INIT_ACTIVATION: begin
                if(done_init) begin
                    done_init <= 'd0;
                end
                else begin
                    start_init <= 'd1;
                end
            end

            FOOD_ACTIVATION: begin
                if(done_food) begin
                    done_food <= 'd0;
                end
                else begin
                    food_init <= 'd1;
                end
            end

            STEP_ACTIVATION: begin
                if(done_step) begin
                    done_step <= 'd0;
                end
                else begin
                    start_step <= 'd1;
                end
            end

        endcase
    end

    always_ff @(posedge clk) begin : FSM_INIT
        if (~rst_n) begin
            state_init <= READY;
        end else begin
            case (state_init)
                READY: begin
                    if(start_init) begin
                        state_init <= RESET_ROW;
                    end
                    else begin
                        state_init <= READY;
                    end
                end

                RESET_ROW: begin
                    if(dp_flag.reg_bank_signal_x_finish) begin
                        state_init <= JUMP_ROW;
                    end
                    else begin
                        state_init <= RESET_ROW;
                    end
                end

                JUMP_ROW: begin
                    if(dp_flag.reg_bank_signal_y_finish) begin
                        state_init <= WRITE_HEAD;
                    end
                    else begin
                        state_init <= RESET_ROW;
                    end
                end

                WRITE_HEAD: begin
                    if(dp_flag.reg_bank_signal_write_head_finish) begin
                        state_init <= READY;
                    end
                    else begin
                        state_init <= WRITE_HEAD;
                    end
                end

            endcase 
        end
    end // FSM_INIT

    always_comb begin
        case (state_init)
            READY: begin
                if(start_init) begin
                    start_init <= 'd0;
                end
            end

            RESET_ROW: begin
                dp_ctrl.fsm_init_signal_x_start <= 'd1;
                if(dp_flag.reg_bank_signal_x_finish) begin
                    dp_ctrl.fsm_init_signal_x_start <= 'd0;
                end
            end

            WRITE_HEAD: begin
                dp_ctrl.fsm_init_signal_write_head <= 'd1;
                if(dp_flag.reg_bank_signal_write_head_finish) begin
                    done_init <= 'd1;
                end
            end
        endcase
    end

    always_ff @(posedge clk) begin : FSM_FOOD
        if (~rst_n) begin
            state_food <= READY;
        end else begin
            case (state_food)
                READY: begin
                    if(start_food) begin
                        state_food <= GEN_NUM;
                    end
                    else begin
                        state_food <= READY;
                    end
                end

                GEN_NUM: begin
                    if(dp_flag.food_num_gen_finish) begin
                        state_food <= ADD_X;
                    end
                    else begin
                        state_food <= GEN_NUM;
                    end
                end

                ADD_X: begin
                    if(dp_flag.comparator_signal == BLANK && ~dp_flag.reg_bank_signal_x_finish) begin
                        state_food <= READY;
                    end
                    else if(dp_flag.reg_bank_signal_x_finish) begin
                        state_food <= ADD_Y;
                    end
                    else begin
                        state_food <= ADD_X;
                    end
                end

                ADD_Y: begin
                    if(dp_flag.comparator_signal == BLANK) begin
                        state_food <= READY;
                    end
                    else begin
                        state_food <= ADD_X;
                    end
                end

            endcase 
        end
    end // FSM_FOOD

    always_comb begin
        case (state_food)
            READY: begin
                if(start_food) begin
                    start_food <= 'd0;
                end
            end

            GEN_NUM: begin
                dp_ctrl.fsm_food_signal_num_gen <= 'd1;
                if(dp_flag.food_num_gen_finish) begin
                    dp_ctrl.fsm_food_signal_num_gen <= 'd0;
                end
            end

            ADD_X: begin
                dp_ctrl.fsm_food_signal_add_x <= 'd1;
                if(dp_flag.comparator_signal == BLANK && ~dp_flag.reg_bank_signal_x_finish) begin
                    dp_ctrl.fsm_food_signal_add_x <= 'd0;
                    done_food <= 'd1;
                end
                else if(dp_flag.reg_bank_signal_x_finish) begin
                    dp_ctrl.fsm_food_signal_add_x <= 'd0;
                end
            end

            ADD_Y: begin
                dp_ctrl.fsm_food_signal_add_y <= 'd1;
                if(dp_flag.comparator_signal == BLANK) begin
                    dp_ctrl.fsm_food_signal_add_y <= 'd0;
                    done_food <= 'd1;
                end
                else begin
                    dp_ctrl.fsm_food_signal_add_y <= 'd0;
                end
            end
        endcase 
    end

    always_ff @(posedge clk) begin : FSM_STEP
        if (~rst_n) begin
            state_step <= READY;
        end else begin
            case (state_step)
                READY: begin
                    if(start_step) begin
                        state_step <= NEW_POSITION;
                    end
                    else begin
                        state_step <= READY;
                    end
                end

                NEW_POSITION: begin
                    if(dp_flag.new_position_finish) begin
                        state_step <= CHECK;
                    end
                    else begin
                        state_step <= NEW_POSITION;
                    end
                end

                CHECK: begin
                    if(dp_flag.comparator_signal == BODY || dp_flag.comparator_signal == FOOD) begin
                        state_step <= READY;
                    end
                    else begin
                        state_step <= POP_WRITE_TAIL;
                    end
                end

                POP_WRITE_TAIL: begin
                    if(pop_write_tail_finish) begin
                        state_step <= READY;
                    end
                    else begin
                        state_step <= POP_WRITE_TAIL;
                    end
                end

            endcase 
        end
    end // FSM_STEP

    always_comb begin
        case (state_step)
            READY: begin
                if(start_step) begin
                    start_step <= 'd0;
                end
            end

            NEW_POSITION: begin
                dp_ctrl.fsm_step_signal_reg_bank <= 'd1;
                if(dp_flag.new_position_finish) begin
                    dp_ctrl.fsm_step_signal_reg_bank <= 'd0;
                end
            end

            CHECK: begin
                if(dp_flag.comparator_signal == BODY || dp_flag.comparator_signal == FOOD) begin
                    done_step <= 'd1;
                end
            end

            POP_WRITE_TAIL: begin
                dp_ctrl.fsm_food_pop_write_tail <= 'd1;
                if(pop_write_tail_finish) begin
                    dp_ctrl.fsm_food_pop_write_tail <= 'd0;
                    done_step <= 'd1;
                end
            end

        endcase 
    end

endmodule

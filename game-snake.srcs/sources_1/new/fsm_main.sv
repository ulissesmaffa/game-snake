`timescale 1ns / 1ps

module fsm_main
import game_snake_pkg::*;
(
    input  logic          clk,            
    input  logic          rst_n,            
    input  logic          cnt_rdy,     
    input  logic          cmp_food_flag,  
    input  logic          fsm_i_done,     
    input  logic          fsm_f_done,     
    input  logic          fsm_s_done,     
    input  logic          fsm_s_game_over,
    output CONTROL_SELECT con_sel,
    output logic          fsm_i_start,
    output logic          fsm_f_start,
    output logic          fsm_s_start
);

    typedef enum logic[2:0] {
        INIT_ACTIVATION,
        FOOD_ACTIVATION,
        IDLE,
        STEP_ACTIVATION,
        GAME_OVER      
    } STATE_TYPE_MAIN;

    STATE_TYPE_MAIN STATE, NEXT_STATE;

    always_ff @(posedge clk) begin
        if(rst_n) begin
            STATE <= NEXT_STATE;
        end
        else begin
            STATE <= INIT_ACTIVATION;
        end
    end

    always @ (cnt_rdy, cmp_food_flag, fsm_i_done, fsm_f_done, fsm_s_done, fsm_s_game_over, STATE) begin
        case (STATE)
            INIT_ACTIVATION: begin
                if(fsm_i_done) begin
                    NEXT_STATE <= FOOD_ACTIVATION;
                end
                else begin
                    NEXT_STATE <= INIT_ACTIVATION;
                end
            end

            FOOD_ACTIVATION: begin
                if(fsm_f_done) begin
                    NEXT_STATE <= IDLE;
                end
                else begin
                    NEXT_STATE <= FOOD_ACTIVATION;
                end
            end

            IDLE: begin
                if(cnt_rdy) begin
                    NEXT_STATE <= STEP_ACTIVATION;
                end
                else begin
                    NEXT_STATE <= IDLE;
                end
            end

            STEP_ACTIVATION: begin
                if (fsm_s_game_over) begin
                    NEXT_STATE <= GAME_OVER;
                end
                else if(cmp_food_flag) begin
                    NEXT_STATE <= FOOD_ACTIVATION;
                end
                else if(fsm_s_done) begin
                    NEXT_STATE <= IDLE;
                end
                else begin
                    NEXT_STATE <= STEP_ACTIVATION;
                end
            end

            GAME_OVER: begin
                NEXT_STATE <= GAME_OVER;
            end

        endcase
    end

    always @(STATE) begin
        case (STATE)
            INIT_ACTIVATION: begin
                con_sel <= INIT_CON;
                fsm_i_start <= 'd1;
                fsm_f_start <= 'd0;
                fsm_s_start <= 'd0;
            end

            FOOD_ACTIVATION: begin
                con_sel <= FOOD_CON;
                fsm_i_start <= 'd0;
                fsm_f_start <= 'd1;
                fsm_s_start <= 'd0;
            end

            IDLE: begin
                con_sel <= STEP_CON;
                fsm_i_start <= 'd0;
                fsm_f_start <= 'd0;
                fsm_s_start <= 'd0;
            end

            STEP_ACTIVATION: begin
                con_sel <= STEP_CON;
                fsm_i_start <= 'd0;
                fsm_f_start <= 'd0;
                fsm_s_start <= 'd1;
            end

            GAME_OVER: begin
                con_sel <= STEP_CON;
                fsm_i_start <= 'd0;
                fsm_f_start <= 'd0;
                fsm_s_start <= 'd0;
            end

        endcase
    end

endmodule

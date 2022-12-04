`timescale 1ns / 1ps

module fsm_step
import game_snake_pkg::*;
(
    input logic                clk,
    input logic                rst_n,
    input logic                fsm_m_start,
    input logic                cmp_food_flag,
    input logic                cmp_body_flag,
    input direction            sys_direction,
    output datapath_ctrl_flags dp_ctrl,
    output logic               fsm_m_done,
    output logic               fsm_m_game_over 
);

    typedef enum logic[1:0] {
        READY, 
        NEW_POSITION, 
        CHECK, 
        POP_WRITE_TAIL   
    } STATE_TYPE_STEP;

    STATE_TYPE_STEP STATE, NEXT_STATE;
    logic [1:0] CMP_FLAGS;

    assign CMP_FLAGS = cmp_food_flag & cmp_body_flag;

    always_ff @(posedge clk) begin
        if(rst_n) begin
            STATE <= NEXT_STATE;
        end
        else begin
            STATE <= READY;
        end
    end

    always @ (fsm_m_start, cmp_body_flag, cmp_food_flag, sys_direction, STATE) begin
        case (STATE)
            READY: begin
                if(fsm_m_start) begin
                    NEXT_STATE <= NEW_POSITION;
                end
                else begin
                    NEXT_STATE <= READY;
                end
            end

            NEW_POSITION: begin 
                NEXT_STATE <= CHECK;
            end

            CHECK: begin
                if(cmp_food_flag) begin
                    NEXT_STATE <= READY;
                end
                else begin
                    NEXT_STATE <= POP_WRITE_TAIL;
                end
            end

            POP_WRITE_TAIL: begin 
                NEXT_STATE <= READY;
            end

        endcase
    end

    always @(fsm_m_start, CMP_FLAGS, sys_direction, STATE) begin
        case (STATE)
            READY: begin
                case (fsm_m_start)
                    'd0: begin
                        dp_ctrl <= {
                            ng_one_gen    : 'd0,
                            ng_pos_neg    : 'd0,
                            ng_one_three  : 'd0,
                            alu_x_y       : 'd0,
                            alu_pass_calc : 'd0,
                            rb_head_en    : 'd0,
                            rb_reg2_en    : 'd0,
                            rb_fifo_en    : 'd0,
                            rb_fifo_pop   : 'd0,
                            rb_out_sel    : HEAD_OUT,
                            cg_sel        : BLANK,
                            mem_w_e       : 'd0
                        };

                        fsm_m_done      <= 'd0;
                        fsm_m_game_over <= 'd0;
                    end

                    'd1: begin
                        dp_ctrl <= {
                            ng_one_gen    : 'd0,
                            ng_pos_neg    : 'd0,
                            ng_one_three  : 'd0,
                            alu_x_y       : 'd0,
                            alu_pass_calc : 'd0,
                            rb_head_en    : 'd0,
                            rb_reg2_en    : 'd0,
                            rb_fifo_en    : 'd0,
                            rb_fifo_pop   : 'd0,
                            rb_out_sel    : HEAD_OUT,
                            cg_sel        : S_BODY,
                            mem_w_e       : 'd1
                        };

                        fsm_m_done      <= 'd0;
                        fsm_m_game_over <= 'd0;
                    end

                endcase
            end

            NEW_POSITION: begin
                case (sys_direction)
                    S_LEFT: begin
                        dp_ctrl <= {
                            ng_one_gen    : 'd0,
                            ng_pos_neg    : 'd1,
                            ng_one_three  : 'd0,
                            alu_x_y       : 'd0,
                            alu_pass_calc : 'd1,
                            rb_head_en    : 'd1,
                            rb_reg2_en    : 'd0,
                            rb_fifo_en    : 'd1,
                            rb_fifo_pop   : 'd0,
                            rb_out_sel    : HEAD_OUT,
                            cg_sel        : BLANK,
                            mem_w_e       : 'd0
                        };

                        fsm_m_done      <= 'd0;
                        fsm_m_game_over <= 'd0;
                    end

                    S_RIGHT: begin
                        dp_ctrl <= {
                            ng_one_gen    : 'd0,
                            ng_pos_neg    : 'd0,
                            ng_one_three  : 'd0,
                            alu_x_y       : 'd0,
                            alu_pass_calc : 'd1,
                            rb_head_en    : 'd1,
                            rb_reg2_en    : 'd0,
                            rb_fifo_en    : 'd1,
                            rb_fifo_pop   : 'd0,
                            rb_out_sel    : HEAD_OUT,
                            cg_sel        : BLANK,
                            mem_w_e       : 'd0
                        };

                        fsm_m_done      <= 'd0;
                        fsm_m_game_over <= 'd0;
                    end

                    S_UP: begin
                        dp_ctrl <= {
                            ng_one_gen    : 'd0,
                            ng_pos_neg    : 'd1,
                            ng_one_three  : 'd0,
                            alu_x_y       : 'd1,
                            alu_pass_calc : 'd1,
                            rb_head_en    : 'd1,
                            rb_reg2_en    : 'd0,
                            rb_fifo_en    : 'd1,
                            rb_fifo_pop   : 'd0,
                            rb_out_sel    : HEAD_OUT,
                            cg_sel        : BLANK,
                            mem_w_e       : 'd0
                        };

                        fsm_m_done      <= 'd0;
                        fsm_m_game_over <= 'd0;
                    end

                    S_DOWN: begin
                        dp_ctrl <= {
                            ng_one_gen    : 'd0,
                            ng_pos_neg    : 'd0,
                            ng_one_three  : 'd0,
                            alu_x_y       : 'd1,
                            alu_pass_calc : 'd1,
                            rb_head_en    : 'd1,
                            rb_reg2_en    : 'd0,
                            rb_fifo_en    : 'd1,
                            rb_fifo_pop   : 'd0,
                            rb_out_sel    : HEAD_OUT,
                            cg_sel        : BLANK,
                            mem_w_e       : 'd0
                        };

                        fsm_m_done      <= 'd0;
                        fsm_m_game_over <= 'd0;
                    end

                endcase
            end

            CHECK: begin
                case (CMP_FLAGS)
                    2'b00: begin
                        fsm_m_done      <= 'd0;
                        fsm_m_game_over <= 'd0;
                    end

                    2'b10: begin
                        fsm_m_done      <= 'd1;
                        fsm_m_game_over <= 'd0;
                    end

                    (2'b01 | 2'b11): begin
                        fsm_m_done      <= 'd0;
                        fsm_m_game_over <= 'd1;
                    end

                endcase

                case (sys_direction)
                    S_LEFT: begin
                        dp_ctrl <= {
                            ng_one_gen    : 'd0,
                            ng_pos_neg    : 'd0,
                            ng_one_three  : 'd0,
                            alu_x_y       : 'd0,
                            alu_pass_calc : 'd0,
                            rb_head_en    : 'd0,
                            rb_reg2_en    : 'd0,
                            rb_fifo_en    : 'd0,
                            rb_fifo_pop   : 'd0,
                            rb_out_sel    : HEAD_OUT,
                            cg_sel        : HEAD_LEFT,
                            mem_w_e       : 'd1
                        };
                    end

                    S_RIGHT: begin
                        dp_ctrl <= {
                            ng_one_gen    : 'd0,
                            ng_pos_neg    : 'd0,
                            ng_one_three  : 'd0,
                            alu_x_y       : 'd0,
                            alu_pass_calc : 'd0,
                            rb_head_en    : 'd0,
                            rb_reg2_en    : 'd0,
                            rb_fifo_en    : 'd0,
                            rb_fifo_pop   : 'd0,
                            rb_out_sel    : HEAD_OUT,
                            cg_sel        : HEAD_RIGHT,
                            mem_w_e       : 'd1
                        };
                    end

                    S_UP: begin
                        dp_ctrl <= {
                            ng_one_gen    : 'd0,
                            ng_pos_neg    : 'd0,
                            ng_one_three  : 'd0,
                            alu_x_y       : 'd0,
                            alu_pass_calc : 'd0,
                            rb_head_en    : 'd0,
                            rb_reg2_en    : 'd0,
                            rb_fifo_en    : 'd0,
                            rb_fifo_pop   : 'd0,
                            rb_out_sel    : HEAD_OUT,
                            cg_sel        : HEAD_UP,
                            mem_w_e       : 'd1
                        };
                    end

                    S_DOWN: begin
                        dp_ctrl <= {
                            ng_one_gen    : 'd0,
                            ng_pos_neg    : 'd0,
                            ng_one_three  : 'd0,
                            alu_x_y       : 'd0,
                            alu_pass_calc : 'd0,
                            rb_head_en    : 'd0,
                            rb_reg2_en    : 'd0,
                            rb_fifo_en    : 'd0,
                            rb_fifo_pop   : 'd0,
                            rb_out_sel    : HEAD_OUT,
                            cg_sel        : HEAD_DOWN,
                            mem_w_e       : 'd1
                        };
                    end

                endcase
            end

            POP_WRITE_TAIL: begin
                dp_ctrl <= {
                    ng_one_gen    : 'd0,
                    ng_pos_neg    : 'd0,
                    ng_one_three  : 'd0,
                    alu_x_y       : 'd0,
                    alu_pass_calc : 'd0,
                    rb_head_en    : 'd0,
                    rb_reg2_en    : 'd0,
                    rb_fifo_en    : 'd0,
                    rb_fifo_pop   : 'd1,
                    rb_out_sel    : FIFO_OUT,
                    cg_sel        : BLANK,
                    mem_w_e       : 'd1
                };

                fsm_m_done      <= 'd1;
                fsm_m_game_over <= 'd0;
            end

        endcase
    end

endmodule

`timescale 1ns / 1ps

module fsm_food
import game_snake_pkg::*;
(
    input logic                clk,
    input logic                rst_n,
    input logic                fsm_m_start,
    input logic                cmp_body_flag,
    input logic                ofc_of_x,
    output datapath_ctrl_flags dp_ctrl,   
    output logic               fsm_m_done
);

    typedef enum logic[2:0] {
        READY,
        GEN_NUM,
        ADD_X,
        ADD_Y,
        FOOD_OK     
    } STATE_TYPE_FOOD;

    STATE_TYPE_FOOD STATE, NEXT_STATE;

    always_ff @(posedge clk) begin
        if(rst_n) begin
            STATE <= NEXT_STATE;
        end
        else begin
            STATE <= READY;
        end
    end

    always @ (fsm_m_start, ofc_of_x, cmp_body_flag, STATE) begin
        case (STATE)
            READY: begin
                if (fsm_m_start) begin
                    NEXT_STATE <= GEN_NUM;
                end
                else begin
                    NEXT_STATE <= READY;
                end
            end

            GEN_NUM: begin 
                NEXT_STATE <= ADD_X;
            end

            ADD_X: begin
                if (cmp_body_flag) begin
                    NEXT_STATE <= FOOD_OK;
                end
                else begin
                    if (ofc_of_x) begin
                        NEXT_STATE <= ADD_X;
                    end
                    else begin
                        NEXT_STATE <= ADD_Y;
                    end
                end
            end

            FOOD_OK: begin 
                NEXT_STATE <= READY;
            end

            ADD_Y: begin
                if (cmp_body_flag) begin
                    NEXT_STATE <= ADD_X;
                end
                else begin
                    NEXT_STATE <= FOOD_OK;
                end
            end
        endcase
    end

    always @(STATE) begin
        case (STATE)
             READY: begin
                dp_ctrl <= {
                    ng_one_gen     : 'd1,
                    ng_pos_neg     : 'd0,
                    ng_one_three   : 'd0,
                    alu_x_y        : 'd0,
                    alu_pass_calc  : 'd1,
                    rb_head_en     : 'd0,
                    rb_reg2_en     : 'd1,
                    rb_fifo_en     : 'd0,
                    rb_fifo_pop    : 'd0,
                    rb_out_sel     : REG2_OUT,
                    cg_sel         : FOOD,
                    mem_w_e        : 'd0
                };
                fsm_m_done <= 'd0;
            end

            GEN_NUM: begin
                dp_ctrl <= {
                    ng_one_gen     : 'd1,
                    ng_pos_neg     : 'd0,
                    ng_one_three   : 'd0,
                    alu_x_y        : 'd0,
                    alu_pass_calc  : 'd1,
                    rb_head_en     : 'd0,
                    rb_reg2_en     : 'd1,
                    rb_fifo_en     : 'd0,
                    rb_fifo_pop    : 'd0,
                    rb_out_sel     : REG2_OUT,
                    cg_sel         : FOOD,
                    mem_w_e        : 'd0
                };
                fsm_m_done <= 'd0;
            end

            ADD_X: begin
                dp_ctrl <= {
                    ng_one_gen     : 'd0,
                    ng_pos_neg     : 'd0,
                    ng_one_three   : 'd1,
                    alu_x_y        : 'd0,
                    alu_pass_calc  : 'd1,
                    rb_head_en     : 'd0,
                    rb_reg2_en     : 'd1,
                    rb_fifo_en     : 'd0,
                    rb_fifo_pop    : 'd0,
                    rb_out_sel     : REG2_OUT,
                    cg_sel         : FOOD,
                    mem_w_e        : 'd0
                };
                fsm_m_done <= 'd0;
            end

            ADD_Y: begin
                dp_ctrl <= {
                    ng_one_gen     : 'd0,
                    ng_pos_neg     : 'd0,
                    ng_one_three   : 'd0,
                    alu_x_y        : 'd1,
                    alu_pass_calc  : 'd1,
                    rb_head_en     : 'd0,
                    rb_reg2_en     : 'd1,
                    rb_fifo_en     : 'd0,
                    rb_fifo_pop    : 'd0,
                    rb_out_sel     : REG2_OUT,
                    cg_sel         : FOOD,
                    mem_w_e        : 'd0
                };
                fsm_m_done <= 'd0;
            end

            FOOD_OK: begin
                dp_ctrl <= {
                    ng_one_gen     : 'd0,
                    ng_pos_neg     : 'd0,
                    ng_one_three   : 'd0,
                    alu_x_y        : 'd1,
                    alu_pass_calc  : 'd0,
                    rb_head_en     : 'd0,
                    rb_reg2_en     : 'd1,
                    rb_fifo_en     : 'd0,
                    rb_fifo_pop    : 'd0,
                    rb_out_sel     : REG2_OUT,
                    cg_sel         : FOOD,
                    mem_w_e        : 'd1
                };
                fsm_m_done <= 'd1;
            end

        endcase
    end

endmodule

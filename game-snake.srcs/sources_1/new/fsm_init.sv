`timescale 1ns / 1ps

module fsm_init
import game_snake_pkg::*;
(
    input  logic               clk,
    input  logic               rst_n,
    input  logic               fsm_m_start,
    input  logic               ofc_of_x,
    input  logic               ofc_of_y,
    output datapath_ctrl_flags dp_ctrl,
    output logic               fsm_m_done
);

    typedef enum logic[1:0] {
        READY, 
        RESET_ROW, 
        JUMP_ROW,
        WRITE_HEAD     
    } STATE_TYPE_INIT;

    STATE_TYPE_INIT STATE, NEXT_STATE;
    integer i;

    always_ff @(posedge clk) begin
        if(rst_n) begin
            STATE <= NEXT_STATE;
        end
        else begin
            STATE <= READY;
        end
    end

    always @ (fsm_m_start, ofc_of_x, ofc_of_y, STATE) begin
        case (STATE)
            READY:
                if (fsm_m_start) begin
                    NEXT_STATE <= RESET_ROW;
                end
                else begin
                    NEXT_STATE <= READY;
                end

            RESET_ROW:
                if (ofc_of_x) begin
                    NEXT_STATE <= JUMP_ROW;
                end
                else begin
                    NEXT_STATE <= RESET_ROW;
                end

            JUMP_ROW:
                if (ofc_of_y) begin
                    NEXT_STATE <= WRITE_HEAD;
                end
                else if (~ofc_of_y) begin
                    NEXT_STATE <= RESET_ROW;
                end
                else begin
                    NEXT_STATE <= JUMP_ROW;   
                end

            WRITE_HEAD: begin 
                NEXT_STATE <= READY;
            end
            
        endcase
    end

    always @(STATE) begin
        case (STATE)
            READY: begin
                dp_ctrl <= {
                    ng_one_gen    : 'd0,
                    ng_pos_neg    : 'd0,
                    ng_one_three  : 'd0,
                    alu_x_y       : 'd0,
                    alu_pass_calc : 'd1,
                    rb_head_en    : 'd0,
                    rb_reg2_en    : 'd1,
                    rb_fifo_en    : 'd0,
                    rb_fifo_pop   : 'd0,
                    rb_out_sel    : REG2_OUT,
                    cg_sel        : BLANK,
                    mem_w_e       : 'd0
                };
                fsm_m_done <= 'd0;
            end

            RESET_ROW: begin
                dp_ctrl <= {
                    ng_one_gen    : 'd0,
                    ng_pos_neg    : 'd0,
                    ng_one_three  : 'd0,
                    alu_x_y       : 'd0,
                    alu_pass_calc : 'd1,
                    rb_head_en    : 'd0,
                    rb_reg2_en    : 'd1,
                    rb_fifo_en    : 'd0,
                    rb_fifo_pop   : 'd0,
                    rb_out_sel    : REG2_OUT,
                    cg_sel        : BLANK,
                    mem_w_e       : 'd1
                };
                fsm_m_done <= 'd0;
            end

            JUMP_ROW: begin
                dp_ctrl <= {
                    ng_one_gen    : 'd0,
                    ng_pos_neg    : 'd0,
                    ng_one_three  : 'd0,
                    alu_x_y       : 'd1,
                    alu_pass_calc : 'd1,
                    rb_head_en    : 'd0,
                    rb_reg2_en    : 'd1,
                    rb_fifo_en    : 'd0,
                    rb_fifo_pop   : 'd0,
                    rb_out_sel    : REG2_OUT,
                    cg_sel        : BLANK,
                    mem_w_e       : 'd1
                };
                fsm_m_done  <= 'd0;
            end

            WRITE_HEAD: begin
                dp_ctrl <= {
                    ng_one_gen      : 'd0,
                    ng_pos_neg      : 'd0,
                    ng_one_three    : 'd0,
                    alu_x_y         : 'd0,
                    alu_pass_calc   : 'd0,
                    rb_head_en      : 'd0,
                    rb_reg2_en      : 'd0,
                    rb_fifo_en      : 'd1,
                    rb_fifo_pop     : 'd0,
                    rb_out_sel      : HEAD_OUT,
                    cg_sel          : HEAD_RIGHT,
                    mem_w_e         : 'd1
                };
                fsm_m_done <= 'd1;
            end

        endcase
    end

endmodule

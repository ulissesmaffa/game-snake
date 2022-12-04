`timescale 1ns / 1ps

module code_gen
import game_snake_pkg::*;
(
    input CODE ctrl_code_sel,
    output logic [7:0] mem_code_w
);

    always @(ctrl_code_sel) begin
        case (ctrl_code_sel)
            BLANK: begin
                mem_code_w <= BLANK_VEC;
            end
            FOOD: begin
                mem_code_w <= FOOD_VEC;
            end
            S_BODY: begin
                mem_code_w <= BODY_VEC;
            end
            HEAD_UP: begin
                mem_code_w <= HEAD_UP_VEC;
            end
            HEAD_DOWN: begin
                mem_code_w <= HEAD_DOWN_VEC;
            end
            HEAD_LEFT: begin
                mem_code_w <= HEAD_LEFT_VEC;
            end
            HEAD_RIGHT: begin
                mem_code_w <= HEAD_RIGHT_VEC;
            end
        endcase;
    end
endmodule
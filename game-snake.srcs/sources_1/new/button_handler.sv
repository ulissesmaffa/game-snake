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


module button_handler
import game_snake_pkg::*;
(
    input  logic       clk,             
    input  logic       rst_n,           
    input  logic       load_regs,       
    input  logic [3:0] sys_direction,   
    input  logic       sys_step_jumper, 
    output direction   direction_sync,
    output logic       step_jumper_sync
);

    direction sys_direction_s, direction_sync_s;

    assign direction_sync = direction_sync_s;

    always @(sys_direction) begin
        case (sys_direction)
            4'b0001: begin
                sys_direction_s <= S_RIGHT;
            end

            4'b0010: begin
                sys_direction_s <= S_LEFT;
            end

            4'b0100: begin
                sys_direction_s <= S_UP;
            end

            4'b1000: begin
                sys_direction_s <= S_DOWN;
            end

            default: begin 
                sys_direction_s <= direction_sync_s;
            end
        endcase
    end

    always @(posedge clk) begin
        if (~rst_n) begin
            direction_sync_s <= S_RIGHT;
            step_jumper_sync <= 'd0;
        end
        else if (load_regs) begin
            if (direction_sync_s == S_RIGHT) begin
                if (sys_direction_s == S_LEFT) begin
                    direction_sync_s <= direction_sync_s;
                end
                else begin
                    direction_sync_s <= sys_direction_s;
                end
            end

            if (direction_sync_s == S_LEFT) begin
                if (sys_direction_s == S_RIGHT) begin
                    direction_sync_s <= direction_sync_s;
                end
                else begin
                    direction_sync_s <= sys_direction_s;
                end
            end

            if (direction_sync_s == S_DOWN) begin
                if (sys_direction_s == S_UP) begin
                    direction_sync_s <= direction_sync_s;
                end
                else begin
                    direction_sync_s <= sys_direction_s;
                end
            end

            if (direction_sync_s == S_UP) begin
                if (sys_direction_s == S_DOWN) begin
                    direction_sync_s <= direction_sync_s;
                end
                else begin
                    direction_sync_s <= sys_direction_s;
                end
            end

            step_jumper_sync <= sys_step_jumper;
        end
    end

endmodule

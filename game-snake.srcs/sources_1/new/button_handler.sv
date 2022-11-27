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
    input logic rst_n,
    input logic clk,
    input logic [3:0] buttons,
    input logic cnt_rdy,
    output decoded_direction_type  direction_sync
);

    decoded_direction_type press_direction;

always @(posedge clk) begin
    if (~rst_n) begin
        direction_sync <= D_RIGHT;
    end 
end

always @(buttons) begin
    case (buttons) 
        4'b0001: begin
            press_direction <= D_UP;
        end
        4'b0010: begin
            press_direction <= D_RIGHT;
        end
        4'b0100: begin
            press_direction <= D_LEFT;
        end 
        4'b1000: begin
            press_direction <= D_DOWN;
        end
    endcase
end

always @(posedge cnt_rdy) begin
    case(direction_sync)
        D_RIGHT: begin
            if(press_direction == D_LEFT) direction_sync <= D_RIGHT;
            else direction_sync <= press_direction;
        end
        
        D_LEFT: begin
            if(press_direction == D_RIGHT) direction_sync <= D_LEFT;
            else direction_sync <= press_direction;
        end
        
        D_UP: begin
            if(press_direction == D_DOWN) direction_sync <= D_UP;
            else direction_sync <= press_direction;
        end
        
        D_DOWN: begin
            if(press_direction == D_UP) direction_sync <= D_DOWN;
            else direction_sync <= press_direction;
        end
    endcase
end

endmodule

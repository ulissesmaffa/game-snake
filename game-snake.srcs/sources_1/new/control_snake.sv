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


module control_snake(
    input logic rst_n,
    input logic clk,
    input logic dp_flag,
    input logic cnt_rdy,
    input logic direction_sync,
    output logic dp_ctrl
);

    logic start_init;
    logic done_init;
    logic start_food;
    logic done_food;
    logic start_step;
    logic done_step;

    typedef enum logic [2:0] {
        INIT_ACTIVATION = 4'h0,
        FOOD_ACTIVATION = 4'h1,
        IDLE            = 4'h2,
        STEP_ACTIVATION = 4'h3,
        GAME_OVER       = 4'h4
    } state_main_type;

    typedef enum logic [1:0] {
        READY        = 4'h0,
        RESET_ROW    = 4'h1,
        JUMP_ROW     = 4'h2,
        WRITTE_HEADD = 4'h3
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
                    start_init <= 'd1;
                    state_main <= INIT_ACTIVATION;
                end
            end

            FOOD_ACTIVATION: begin
                if(done_food) begin
                    state_main <= IDLE;
                end
                else begin
                    food_init <= 'd1;
                    state_main <= FOOD_ACTIVATION;
                end
            end

            IDLE: begin
                if()
            end

        endcase 
    end // if rst
end // FSM_MAIN

endmodule

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2022 13:19:25
// Design Name: 
// Module Name: game_snake_pkg
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

package game_snake_pkg;
    typedef enum  logic [1:0] {
        D_UP, 
        D_LEFT,
        D_RIGHT,
        D_DOWN
    } decoded_direction_type;

    typedef enum logic [7:0] {
        BLANK      =  8'b0000_0000,
        FOOD       =  8'b1000_0000,
        BODY       =  8'b0000_1000,
        HEAD_UP    =  8'b0000_1001,
        HEAD_DOWN  =  8'b0000_1010,
        HEAD_LEFT  =  8'b0000_1100,
        HEAD_RIGHT =  8'b0000_1101 
    } code_gen_type;

    typedef enum logic [1:0] {
        BODY,
        FOOD,
        BLANK 
    } comparator_type;

    typedef struct packed {
        comparator_type comparator_signal;
        logic reg_bank_signal_x_finish;
        logic reg_bank_signal_y_finish;
        logic reg_bank_signal_write_head_finish;
        logic food_num_gen_finish;
        logic new_position_finish;
        logic pop_write_tail_finish;
    } dp_flag_type;

    typedef struct packed {
        logic fsm_init_signal_x_start;
        logic fsm_init_signal_write_head;
        logic fsm_food_signal_num_gen;
        logic fsm_food_signal_add_x;
        logic fsm_food_signal_add_y;
        logic fsm_step_signal_reg_bank;
        logic fsm_food_pop_write_tail;
    } dp_ctrl_type;
endpackage

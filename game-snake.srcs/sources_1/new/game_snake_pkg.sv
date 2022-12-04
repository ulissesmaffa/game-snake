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

    typedef enum logic [1:0] {
        S_LEFT,
        S_RIGHT,
        S_UP,
        S_DOWN
    } direction;

    typedef enum logic [1:0] {
        INIT_CON,
        FOOD_CON,
        STEP_CON
    } CONTROL_SELECT;

    typedef enum logic [1:0] {
        HEAD_OUT = 2'b00,
        REG2_OUT = 2'b01,
        FIFO_OUT = 2'b10
    } RB_SEL;

    typedef enum logic [2:0] {
        BLANK,
        HEAD_UP,
        HEAD_DOWN,
        HEAD_RIGHT,
        HEAD_LEFT,
        S_BODY,
        FOOD
    } CODE;

    logic [7:0] BLANK_VEC      = 8'b00000000;
    logic [7:0] HEAD_UP_VEC    = 8'b00010001;
    logic [7:0] HEAD_DOWN_VEC  = 8'b00010010;
    logic [7:0] HEAD_RIGHT_VEC = 8'b00010100;
    logic [7:0] HEAD_LEFT_VEC  = 8'b00011000;
    logic [7:0] BODY_VEC       = 8'b00010000;
    logic [7:0] FOOD_VEC       = 8'b10000000;

    typedef struct {
        logic  ng_one_gen;
        logic  ng_pos_neg;
        logic  ng_one_three;
        logic  alu_x_y;
        logic  alu_pass_calc;
        logic  rb_head_en;
        logic  rb_reg2_en;
        logic  rb_fifo_en;
        logic  rb_fifo_pop;
        RB_SEL rb_out_sel;
        CODE   cg_sel;
        logic  mem_w_e;
    } datapath_ctrl_flags;

    typedef struct {
        logic ofc_of_x;
        logic ofc_of_y;
        logic cmp_food_flag;
        logic cmp_body_flag;
    } datapath_flags;

endpackage

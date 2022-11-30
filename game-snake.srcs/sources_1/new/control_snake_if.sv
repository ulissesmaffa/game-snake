interface control_snake_if
import game_snake_pkg::*; 
();
  logic fsm_init_signal_x_start;
  logic fsm_init_signal_write_head;
  logic fsm_food_signal_num_gen;
  logic fsm_food_signal_add_x;
  logic fsm_food_signal_add_y;
  logic fsm_step_signal_reg_bank;
  logic fsm_food_pop_write_tail;
  comparator_type comparator_signal;
  logic reg_bank_signal_x_finish;
  logic reg_bank_signal_y_finish;
  logic reg_bank_signal_write_head_finish;
  logic food_num_gen_finish;
  logic new_position_finish;
  logic pop_write_tail_finish;

  modport master(
    output fsm_init_signal_x_start,
    output fsm_init_signal_write_head,
    output fsm_food_signal_num_gen,
    output fsm_food_signal_add_x,
    output fsm_food_signal_add_y,
    output fsm_step_signal_reg_bank,
    output fsm_food_pop_write_tail,
    output comparator_signal,
    input reg_bank_signal_x_finish,
    input reg_bank_signal_y_finish,
    input reg_bank_signal_write_head_finish,
    input food_num_gen_finish,
    input new_position_finish,
    input pop_write_tail_finish
  );

  modport slave(
    input fsm_init_signal_x_start,
    input fsm_init_signal_write_head,
    input fsm_food_signal_num_gen,
    input fsm_food_signal_add_x,
    input fsm_food_signal_add_y,
    input fsm_step_signal_reg_bank,
    input fsm_food_pop_write_tail,
    output comparator_signal,
    output reg_bank_signal_x_finish,
    output reg_bank_signal_y_finish,
    output reg_bank_signal_write_head_finish,
    output food_num_gen_finish,
    output new_position_finish,
    output pop_write_tail_finish
  );
endinterface : control_snake_if
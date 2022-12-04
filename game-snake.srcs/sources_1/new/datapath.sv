`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2022 11:25:07
// Design Name: 
// Module Name: datapath
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


module datapath
import game_snake_pkg::*;
#(
    parameter COR_WIDTH = 3,
    localparam WIDTH = 2 * COR_WIDTH + 2
)
(
    input  logic                       clk,
    input  logic                       rst_n,
    input  logic [2 * COR_WIDTH - 1:0] mem_b_addr,
    input  datapath_ctrl_flags         ctrl_ctrl,
    output logic [7:0]                 mem_b_data,
    output datapath_flags              ctrl_flags
);

    logic [WIDTH-1:0] ng_2_alu_s;
    logic [WIDTH-1:0] rb_2_alu_s;
    logic [WIDTH-1:0] alu_2_ofc_s;
    logic [WIDTH-1:0] ofc_2_rb_s;
    logic             mem_a_en;
    logic [7:0]       mem_a_data_w_s;
    logic [WIDTH-3:0] mem_a_addr_s;
    logic [7:0]       mem_a_read_s;

    logic [5:0]       reg1_2_reg2;
    logic [5:0]       mem_a_addr_2_s;
    logic [5:0]       mem_a_addr_2;
    logic [7:0]       mem_a_data_r_s;

    logic [7:0]       data_b_s='d0;
    logic             wren_b_s='d0;
    logic             byreena_a_s='d1;

    num_gen
    #(
        .WIDTH(WIDTH)
    )
    num_gen
    (
        .clk(clk),
        .rst_n(rst_n),
        .pos_neg(ctrl_ctrl.ng_pos_neg),
        .one_three(ctrl_ctrl.ng_one_three),
        .one_num_gen(ctrl_ctrl.ng_one_gen),
        .number(ng_2_alu_s)
    );

    reg_bank
    #(
        .WIDTH(WIDTH)
    )
    reg_bank
    (
        .clk(clk),
        .rst_n(rst_n),
        .ofc_address(ofc_2_rb_s),
        .load_head(ctrl_ctrl.rb_head_en),
        .load_reg2(ctrl_ctrl.rb_reg2_en),
        .load_fifo(ctrl_ctrl.rb_fifo_en),
        .fifo_pop(ctrl_ctrl.rb_fifo_pop),
        .out_sel(ctrl_ctrl.rb_out_sel),
        .alu_out(rb_2_alu_s)
    );

    alu
    #(
        .WIDTH(WIDTH)
    )
    alu
    (
        .op_first(ng_2_alu_s),
        .rb_op(rb_2_alu_s),
        .ctrl_x_y(ctrl_ctrl.alu_x_y),
        .ctrl_pass_calc(ctrl_ctrl.alu_pass_calc),
        .ofc_result(alu_2_ofc_s)
    );

    overflow_correction
    #(
        .WIDTH(WIDTH)
    )
    overflow_correction
    (
        .alu_result(alu_2_ofc_s),
        .rb_result(ofc_2_rb_s),
        .ctrl_of_x(ctrl_flags.ofc_of_x),
        .ctrl_of_y(ctrl_flags.ofc_of_y)
    );

    code_gen code_gen
    (
        .ctrl_code_sel(ctrl_ctrl.cg_sel),
        .mem_code_w(mem_a_data_w_s)
    );


    mem mem 
    (
        .clk(clk),
        .clr(rst_n),
        .data_a(mem_a_data_w_s),
        .data_b(data_b_s),
        .wren_a(ctrl_ctrl.mem_w_e),
        .wren_b(wren_b_s),
        .address_a(mem_a_addr_2),
        .address_b(mem_b_addr),
        .byreena_a(byreena_a_s),
        .q_a(mem_a_read_s),
        .q_b(mem_b_data)

    );
    
    comparator comparator
    (
        .mem_a_read(mem_a_read_s),
        .food_flag(ctrl_flags.cmp_food_flag),
        .body_flag(ctrl_flags.cmp_body_flag)
    );

    register
    #(
        .WIDTH(6)
    )
    reg1
    (
        .clk(clk),
        .clr(rst_n),
        .load('b1),
        .d(mem_a_addr_s),
        .q(reg1_2_reg2)
    );

    register
    #(
        .WIDTH(6)
    )
    reg2
    (
        .clk(clk),
        .clr(rst_n),
        .load('b1),
        .d(reg1_2_reg2),
        .q(mem_a_addr_2_s)
    );

    assign mem_a_addr_s = ofc_2_rb_s[5:0];

    assign mem_a_en = 'd1;

    always @(ctrl_ctrl.cg_sel, ctrl_ctrl.mem_w_e) begin
        if (ctrl_ctrl.cg_sel == FOOD & ctrl_ctrl.mem_w_e) begin
            mem_a_addr_2 <= mem_a_addr_2_s;
        end
        else begin
            mem_a_addr_2 <= mem_a_addr_s;
        end;
    end;


endmodule

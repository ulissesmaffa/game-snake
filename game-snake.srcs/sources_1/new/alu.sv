`timescale 1ns / 1ps

module alu
#(
    parameter WIDTH = 8
)
(
    input  logic [WIDTH-1:0] op_first,
    input  logic [WIDTH-1:0] rb_op,
    input  logic             ctrl_x_y,        
    input  logic             ctrl_pass_calc,
    output logic [WIDTH-1:0] ofc_result      
);

    logic [WIDTH-1:0] shift_op_s;
    logic [WIDTH-1:0] result_s;
    logic             carry_out_s;


    rc_adder
    #(
        .WIDTH(WIDTH)
    )
    rc_adder
    (
        .a_i(shift_op_s),
        .b_i(rb_op),
        .c_i('b0),
        .z_o(result_s),
        .c_o(carry_out_s)
    );

    always_comb begin
        if(ctrl_x_y) begin
            shift_op_s <= $unsigned(op_first) << (WIDTH / 2);
        end
        else if (~ctrl_x_y) begin
            shift_op_s <= $unsigned(op_first);
        end 
        else begin
            shift_op_s <= 8'bXXXXXXXX;
        end
    end

    always_comb begin
        if(~ctrl_pass_calc) begin
            ofc_result <= rb_op;
        end
        else if(ctrl_pass_calc) begin
            ofc_result <= result_s;
        end 
        else begin
            ofc_result <= 8'bXXXXXXXX;
        end
    end

endmodule
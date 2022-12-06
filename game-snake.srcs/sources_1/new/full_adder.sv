`timescale 1ns / 1ps

module full_adder
(
    input  logic a_in,
    input  logic b_in,
    input  logic c_in,
    output logic z_out,
    output logic c_out
);

    logic aux_xor, aux_and_1, aux_and_2, aux_and_3;

    assign c_out = aux_and_1 | aux_and_2 | aux_and_3;
    assign z_out = aux_xor ^ c_in;

    always_comb begin
        aux_xor   <= a_in ^ b_in;
        aux_and_1 <= a_in & b_in;
        aux_and_2 <= a_in & c_in;
        aux_and_3 <= b_in & c_in;
    end
endmodule
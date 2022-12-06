`timescale 1ns / 1ps

module rc_adder
#(
    parameter WIDTH = 32
)
(
    input  logic [WIDTH-1:0] a_i,
    input  logic [WIDTH-1:0] b_i,
    input  logic             c_i,
    output logic [WIDTH-1:0] z_o,
    output logic             c_o
);

    logic [WIDTH-1:0] cout_s;
    logic [WIDTH-1:0] z_s;
    genvar i;

    full_adder fa_init_i(
        .a_in(a_i[0]),
        .b_in(b_i[0]),
        .c_in(c_i),
        .z_out(z_s[0]),
        .c_out(cout_s[0])
    );

    generate
        for (i = 1; i <= WIDTH-2; i++) begin
            full_adder fa_i(
                .a_in(a_i[i]),
                .b_in(b_i[i]),
                .c_in(cout_s[i - 1]),
                .z_out(z_s[i]),
                .c_out(cout_s[i])
            );
        end
    endgenerate

    full_adder fa_last_i(
        .a_in(a_i[WIDTH - 1]),
        .b_in(b_i[WIDTH - 1]),
        .c_in(cout_s[WIDTH - 2]),
        .z_out(z_s[WIDTH - 1]),
        .c_out(cout_s[WIDTH - 1])
    );

    assign c_o = cout_s[WIDTH - 1];
    assign z_o = z_s;
endmodule
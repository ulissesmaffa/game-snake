`timescale 1ns / 1ps

module comparator
(
    input  logic [7:0] mem_a_read,
    output logic       food_flag,
    output logic       body_flag
);

    assign food_flag = mem_a_read[7];
    assign body_flag = mem_a_read[4];
endmodule
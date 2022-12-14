`timescale 1ns / 1ps

module overflow_correction
#(
    parameter WIDTH = 8
)
(
    input  logic [WIDTH-1:0] alu_result,
    output logic [WIDTH-1:0] rb_result,
    output logic             ctrl_of_x,
    output logic             ctrl_of_y
);

    // assign rb_result = '{'b0, '{alu_result[6]}, '{alu_result[5]}, '{alu_result[4]}, '{alu_result[4]}, '{alu_result[2]}, '{alu_result[1]}, '{alu_result[0]}};
    assign rb_result[7] = 'b0;
    assign rb_result[6] = alu_result[6];
    assign rb_result[5] = alu_result[5];
    assign rb_result[4] = alu_result[4];
    assign rb_result[3] = 'b0;
    assign rb_result[2] = alu_result[2];
    assign rb_result[1] = alu_result[1];
    assign rb_result[0] = alu_result[0];

    assign ctrl_of_y = alu_result[WIDTH - 1];
    assign ctrl_of_x = alu_result[WIDTH / 2 - 1];
endmodule
`timescale 1ns / 1ps

module lfsr
#(
  parameter WIDTH = 10,
  localparam POL = 13'b1110011011011
)
(
    input  logic clk,
    input  logic rst_n,
    output logic [7:0] o  
);

    logic [WIDTH-1:0] prev_state;
    logic [WIDTH-1:0] next_state;
    logic [WIDTH-1:0] or_signals;
    integer i;

    always @(posedge clk) begin
        prev_state <= next_state;
    end

    always @(*) begin
        for (i = 1; i < WIDTH ; i++) begin
            if(~POL[i]) begin
                next_state[i] <= prev_state[i - 1] | rst_n;
            end
            else begin
                or_signals[i] <= prev_state[i - 1] ^ prev_state[WIDTH - 1];
                next_state[i] <= or_signals[i] | rst_n;
            end
        end
    end

    assign next_state[0] = prev_state[WIDTH - 1] | rst_n;

    assign o = '{'b0, prev_state[WIDTH - 1], prev_state[WIDTH - 2], prev_state[WIDTH - 3], 'b0, prev_state[2], prev_state[1], prev_state[0]};
endmodule
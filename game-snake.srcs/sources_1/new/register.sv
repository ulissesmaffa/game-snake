`timescale 1ns / 1ps

module register
#(
    parameter WIDTH = 8
)
(
    input  logic             clk, 
    input  logic             clr,
    input  logic             load,
    input  logic [WIDTH-1:0] d,   
    output logic [WIDTH-1:0] q
);
    logic [WIDTH-1:0] q_s = '{default: 'd0}; 

    assign q = q_s;

    always @(posedge clk) begin
        if (clr) begin
            q_s <= '{default: 'd0};
            q   <= '{default: 'd0};
        end
        else if (load) begin
            q_s <= d;
        end
    end;
endmodule
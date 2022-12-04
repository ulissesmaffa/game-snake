`timescale 1ns / 1ps

module step_counter
#(
  parameter COUNT_MAX = 10
)
(
    input logic clk,  
    input logic rst_n,
    output logic cnt_rdy,
    output logic [3:0] cnt_value
);

    logic [3:0] cnt_s;

    assign cnt_rdy = (cnt_s == COUNT_MAX) ? 'd1 : 'd0;

    assign cnt_value = cnt_s;

    always @(posedge clk) begin
        if (~rst_n) begin
            cnt_s <= 'd0;
        end else begin
            if(cnt_s == COUNT_MAX) begin
                cnt_s <= 'd0;
            end
            else begin
                cnt_s <= cnt_s + 1;
            end
        end
    end

endmodule

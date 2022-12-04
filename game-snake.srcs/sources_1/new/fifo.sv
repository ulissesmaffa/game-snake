`timescale 1ns / 1ps

module fifo
#(
    parameter FIFO_DEPTH = 64,
    parameter WIDTH = 8
)
(
    input  logic       clk,
    input  logic       rst_n,  
    input  logic [7:0] data,
    input  logic       rdreq,
    input  logic       wrreq,
    output logic       empty,
    output logic [7:0] q   
);
    logic [WIDTH-1:0] memory[FIFO_DEPTH-1];
    logic [5:0] tail;
    logic [5:0] head;
    logic looped;

    always @(posedge clk) begin
            if (~rst_n) begin
                head <= 6'b000000;
                tail <= 6'b000000;
                looped <= 'b0;
                empty <= 'b1;
            end
            else begin
                if (rdreq) begin
                    if (looped | (head != tail)) begin
                        q <= memory[tail];

                        if (tail == FIFO_DEPTH - 1) begin
                            tail <= 6'b000000;
                            looped <= 'b0;
                        end
                        else begin
                            tail <= tail + 'd1;
                        end;
                    end;
                end;

                if (wrreq) begin
                    if ((~looped) | (head != tail)) begin
                        memory[head] <= data;

                        if (head == FIFO_DEPTH - 1) begin
                            head <= 6'b000000;
                            looped <= 'b1;
                        end
                        else begin
                            head <= head + 'd1;
                        end;
                    end;
                end;

                if (head == tail) begin
                    empty <= 'b1;
                end
                else begin
                    empty   <= 'b0;
                end;
            end;
    end
endmodule
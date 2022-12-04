`timescale 1ns / 1ps

module reg_bank
import game_snake_pkg::*;
#(
    parameter WIDTH = 8
)
(
    input  logic             clk,
    input  logic             rst_n,     
    input  logic [WIDTH-1:0] ofc_address,
    input  logic             load_head,
    input  logic             load_reg2,
    input  logic             load_fifo,
    input  logic             fifo_pop,
    input  RB_SEL            out_sel,
    output logic [WIDTH-1:0] alu_out
);

    logic [WIDTH-1:0] head_out_s = 8'b11111111;
    logic [WIDTH-1:0] reg2_out_s = 8'b00000000;
    logic [WIDTH-1:0] fifo_out_s = 8'b01010101;
    logic fifo_empty;

    fifo
    #(
        .FIFO_DEPTH(64),
        .WIDTH(WIDTH)
    )
    fifo
    (
        .clk(clk),    
        .rst_n(rst_n),    
        .data(ofc_address),   
        .rdreq(fifo_pop),  
        .wrreq(load_fifo),  
        .empty(fifo_empty),  
        .q(fifo_out_s)      
    );

    register
    #(
        .WIDTH(WIDTH)
    )
    head_i
    (
        .clk(clk),
        .clr(rst_n),
        .load(load_head),
        .d(ofc_address),
        .q(head_out_s) 
    );

    register
    #(
        .WIDTH(WIDTH)
    )
    reg2_i
    (
        .clk(clk),
        .clr(rst_n),
        .load(load_reg2),
        .d(ofc_address),
        .q(reg2_out_s) 
    );

    always @(out_sel, clk) begin
        if (out_sel == HEAD_OUT) begin
            alu_out <= head_out_s;
        end
        else if (out_sel == REG2_OUT) begin
            alu_out <= reg2_out_s;
        end
        else if (out_sel == FIFO_OUT) begin
            alu_out <= fifo_out_s;
        end;
    end;
endmodule
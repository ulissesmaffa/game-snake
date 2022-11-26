`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2022 11:25:07
// Design Name: 
// Module Name: step_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module step_counter
import game_snake_pkg::*;
(
    input logic rst_n,
    input logic clk,
    output logic cnt_rdy
);

//1s = 200000000 clk
    integer count;


always @(posedge clk) begin
    if(~rst_n) count <='d0;
    else begin
        if(count == 'd200000000) begin
            count <= 'd0;
            cnt_rdy <= 'd1;
        end
        else begin
            count <= count +1;
            cnt_rdy <= 'd0;
        end
    end 
end

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2022 11:25:07
// Design Name: 
// Module Name: game_snake
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


module game_snake(
    input logic rst,
    input logic clk,
    input logic [3:0] buttons
    );


    logic direction_sync_s;
    logic cnt_rdy_s;
    
    button_handler button_handler_i(
        .rst(rst),
        .clk(clk),
        .direction_sync(direction_sync_s),
        .cnt_rdy(cnt_rdy_s),
        .buttons(buttons)
    );
    
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2022 11:33:45
// Design Name: 
// Module Name: tb_game_snake
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


module tb_game_snake();
    logic rst=1'b1;
    logic clk=1'b0;
    logic buttons=1'b0;

    game_snake game_snake (.*);
    
    always #5ns clk = ~clk; 
endmodule

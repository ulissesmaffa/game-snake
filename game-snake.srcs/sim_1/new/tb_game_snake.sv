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
    logic rst_n=1'b1;
    logic clk=1'b0;
    logic [3:0] buttons='d0;

    game_snake game_snake (.*);
    
    always #5ns clk = ~clk; 
    
    always #10ns if(rst_n) rst_n <= 1'b0;
    
    initial begin
        #20ns;
        buttons <= 4'b0001; //up
        #40ns;
        buttons <= 4'b0100; //left
        #60ns;
        buttons <= 4'b0101; //left + up
        #20ns;
        buttons <= 4'b0100; //left
        #20ns;
        buttons <= 4'b0010; //right
        #20ns;
        buttons <= 4'b1000; //down
    end
    
endmodule

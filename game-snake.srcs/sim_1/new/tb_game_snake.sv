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
    logic       rst_n           = 1'b0;
    logic       clk             = 1'b0;
    logic [3:0] sys_direction   = 'd0;      
    logic       sys_step_jumper = 'd0;
    logic [5:0] test_mem_b_addr = '{default: 'd0};
    logic       test_idle_state = 'd0;
    logic       test_go_state   = 'd0;
    logic [7:0] test_mem_b_data = '{default: 'd0};

    game_snake game_snake (.*);    
    
    always #5ns clk = ~clk; 
    
    always #10ns if(~rst_n) rst_n <= 1'b1;
    
    initial begin
        #20ns;
        sys_direction <= 4'b0001; //right
        #40ns;
        sys_direction <= 4'b0100; //up
        #60ns;
        sys_direction <= 4'b0010; //left
        #20ns;
        sys_direction <= 4'b0100; //up
        #20ns;
        sys_direction <= 4'b0010; //left
        #20ns;
        sys_direction <= 4'b1000; //down
        #20ns;
        sys_direction <= 4'b0001; //right
        #700ns;
        sys_direction <= 4'b1000; //down
        #100ns;
        sys_direction <= 4'b0001; //right
        #50ns;
        sys_direction <= 4'b0100; //up
    end
    
endmodule

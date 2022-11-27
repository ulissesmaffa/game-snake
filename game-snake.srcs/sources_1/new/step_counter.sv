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
(
    input logic rst_n,
    input logic clk,
    output logic cnt_rdy
);

//1s = 200000000 clk
    logic [7:0] count;

always @(posedge clk) begin
    if (~rst_n) begin
        count <= 'd0;
    end else begin
        if(count == 'd10) begin
            count <= 'd0;
            cnt_rdy <= 'd1;
        end
        else begin
            count <= count +1;
            cnt_rdy <= 'd0;
        end
    end
    
end


/*always @(posedge clk) begin
    if(~rst_n) begin
        count <='d0;
    end else begin
        if(count == 'd10) begin
            count <= 'd0;
            cnt_rdy <= 'd1;
        end
        else begin
            count <= count +1;
            cnt_rdy <= 'd0;
        end
    end 
end*/

endmodule

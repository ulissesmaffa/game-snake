//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.11.2022 13:19:25
// Design Name: 
// Module Name: game_snake_pkg
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

package game_snake_pkg;
    typedef enum  logic [1:0] {
        D_UP, 
        D_LEFT,
        D_RIGHT,
        D_DOWN
    } decoded_direction_type;

    typedef enum logic [7:0] {
        BLANK      =  8'b0000_0000,
        FOOD       =  8'b1000_0000,
        BODY       =  8'b0000_1000,
        HEAD_UP    =  8'b0000_1001,
        HEAD_DOWN  =  8'b0000_1010,
        HEAD_LEFT  =  8'b0000_1100,
        HEAD_RIGHT =  8'b0000_1101 
    } code_gen_type;

    typedef enum logic [1:0] {
        C_BODY,
        C_FOOD,
        C_BLANK 
    } comparator_type;
endpackage

/*
O módulo Button Handler executa a função de definir o movimento da cobra a partir
dos botões existentes na placa.
*/

module button_handler
import game_snake_pkg::*;
(
    input logic clk
  , input logic rst
  , input logic up_btn
  , input logic down_btn
  , input logic right_btn
  , input logic left_btn
  , input logic direction_type
);

always @(posedge clk)
begin
    if (~rst) begin
      direction_type <= D_RIGHT; 
    end else begin
      /*intervalo de tempo*/
        /*escolhe nova posição 
        ou segue na mesma posição*/

    end

end

endmodule : button_handler

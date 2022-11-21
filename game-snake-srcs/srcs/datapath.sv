/*
O módulo Datapath realiza tdos os cálculos relativos ao movimento da cobra, ao seu
tamanho (que cresce à medida que vai alcançando a comida) e ao reposicionamento do
alimento da cobra a cada nova etapa do jogo.

Funções:
1) iniciar valores da memória (reset);
2) efetuar movimento da cobra;
3) posicionar o alimento e comparar a posição da cabeça da cobra com a de seu corpo e a do alimento;

SUBBLOCOS:
1) MEM
2) CODE GEN
3) NUM GEN
4) REG BANK
5) ULA
6) OVERFLOW CORRECTION
7) COMPARADOR

*/

module Datapath
(
    input logic clk
  , input logic rst
);

endmodule : Datapath

module num_gen
#(
    parameter WIDTH = 8
)
(
    input  logic             clk,        
    input  logic             rst_n,       
    input  logic             pos_neg,    
    input  logic             one_three,  
    input  logic             one_num_gen,
    output logic [WIDTH-1:0] number
);

    logic [WIDTH-1:0] pos_neg_s;
    logic [WIDTH-1:0] one_three_s;
    logic [WIDTH-1:0] one_gen_s;
    logic             rst_n_s; 
    logic             clk_s;       
    logic [WIDTH-1:0] random_num_s;

    assign clk_s = clk;
    assign rst_n_s = rst_n;

    lfsr
    #(
        .WIDTH(12)
    )
    lfsr
    (
        .clk(clk_s),
        .rst_n(rst_n_s),
        .o(random_num_s)
    );

    always @(clk, rst_n, pos_neg, one_three, one_num_gen) begin
        if (one_num_gen) begin
            number <= random_num_s;
        end
        else begin
            if (~pos_neg) begin
                if (~one_three) begin
                    number <= 8'b00000001;
                end
                else begin
                    number <= 8'b00000011;
                end
            end
            else begin
                if (~one_three) begin
                    number <= 8'b00000111;
                end
                else begin
                    number <= 8'b00000101;
                end;
            end;
        end;
    end
endmodule
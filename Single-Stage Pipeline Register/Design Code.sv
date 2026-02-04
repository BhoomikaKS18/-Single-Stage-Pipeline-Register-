DESIGN

module pipeline_reg (
    input  logic clk,
    input  logic rst_n,

    input  logic [7:0] in_data,
    input  logic       in_valid,
    output logic       in_ready,

    output logic [7:0] out_data,
    output logic       out_valid,
    input  logic       out_ready);

    logic [7:0] data_reg;
    logic       valid_reg;

    
    assign in_ready  = ~valid_reg || out_ready;
    assign out_valid = valid_reg;
    assign out_data  = data_reg;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_reg <= 1'b0;   // empty on reset
        end
        else begin
            // Load new data
            if (in_valid && in_ready) begin
                data_reg  <= in_data;
                valid_reg <= 1'b1;
            end
            // Remove data if downstream accepted
            else if (out_valid && out_ready) begin
                valid_reg <= 1'b0;
            end
        end
    end

endmodule

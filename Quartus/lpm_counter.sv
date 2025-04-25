module lpm_counter #(
		parameter WIDTH = 5
	)(
		input logic clk,
		input logic reset,
		output logic [WIDTH-1:0] q
	);

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            q <= 0;
        else
            q <= q + 1;
    end

endmodule
